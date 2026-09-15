import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/FIrebaseAuthModel.dart';
import 'package:new_music_app/Utils/Models/LiveMediaModel.dart';
import 'package:new_music_app/Utils/Models/LiveVideoLikeModel.dart';
import 'package:new_music_app/Utils/Models/LiveVideoModel.dart';
import 'package:new_music_app/Utils/Models/SponsorBannerDataModel.dart';
import 'package:new_music_app/Utils/Models/SubscriptionStatusModel.dart';
import 'package:new_music_app/Utils/Models/SubscriptionTokenModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveVideoController extends BaseController {
  // late VideoPlayerController videoPlayerController;
  ScrollController scrollController = ScrollController();

  // ChewieController? chewieController;
  late DatabaseReference messagesRef;
  late FirebaseFirestore firebaseFirestore;

  StreamSubscription<DatabaseEvent>? messagesSubscription;
  late HomeChopperService _homeChopperService;
  TextEditingController postMessageController = TextEditingController();
  String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String time = DateFormat('h:mm a').format(DateTime.now());

  LiveVideoController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  @override
  void onInit() async {
    super.onInit();

    await liveVideoApi();

    await getBannerSliders(
        sliderType: 'live-video', homeChopperService: _homeChopperService);
    // initializePlayer();
    await databaseInit();
    await subscriptionStatusAPi();
    scrollController = ScrollController();
  }

  Future<void> sendMessage(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (postMessageController.text.isEmpty ||
        postMessageController.text == "") {
      Utility.showSnackBar("Please enter message first", isError: true);
    } else {
      await FirebaseFirestore.instance.collection('liveChat').add({
        'image': UserPreference.getValue(key: PrefKeys.userImage),
        'userName': UserPreference.getValue(key: PrefKeys.userName),
        'userId': UserPreference.getValue(key: PrefKeys.userId).toString(),
        'timestamp': Timestamp.now(),
        'role': 'user',
        'text': postMessageController.text,
      });
      // await messagesRef.push().set(<String, String>{
      //   "comment": postMessageController.text,
      //   "commentByName": 'user',
      //   "commentImageURL": '',
      //   "type": 'user',
      //   "time": time,
      //   "commentDate": date
      // });
      postMessageController.clear();
      update();
    }
  }

  Rxn<SponsorBannerDataModel> sponsorBannerData = Rxn<SponsorBannerDataModel>();

  Future<void> sponsorBannerApi() async {
    try {
      final response = await _homeChopperService.sponsorBannerApi();
      if (response.isSuccessful) {
        sponsorBannerData.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'sponsor banner Api error');
    }
  }

  Future<void> shareBanner({required String url}) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } catch (e) {
      log('', name: 'url luncher error', error: e.toString());
    }
  }

  Future<void> likeLiveVideo() async {
    try {
      final queryParameters = {"type": "AddRemoveFavouriteVideos"};
      final param = {
        "menu_id": 31,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "videos_id": liveVideoModel.value?.data?[0].videosId ?? 0,
      };
      final response = await _homeChopperService.addRemoveFavouritesVideoApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        Utility.showSnackBar(response.body?.message);
        print(
            "this is video count ${liveVideoModel.value?.data?[0].videoLikeCount}");
        liveVideoModel.value?.data?[0].favouritesStatus =
            response.body?.favouritesStatus;
        liveVideoModel.value?.data?[0].videoLikeCount =
            response.body?.favouritesStatus ?? false
                ? (liveVideoModel.value?.data?[0].videoLikeCount)!.toInt() + 1
                : (liveVideoModel.value?.data?[0].videoLikeCount)!.toInt() - 1;
        print(liveVideoModel.value?.data?[0].favouritesStatus);
        print(
            "bajdc abkslc lnca ${liveVideoModel.value?.data?[0].videoLikeCount}");
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Add Favorate Live Video');
    }
  }

  Future<void> likeLiveVideoAPi({required int liveVideoId}) async {
    try {
      final param = {
        "id": liveVideoId,
      };
      final response = await _homeChopperService.liveVideoLikeAPi(param: param);
      if (response.body?.success == true) {
        liveMediaModel.value?.data?.likesCount = response.body?.likesCount;
        // liveMediaModel.value?.data;
        liveMediaModel.value?.data?.isLiked = true;
        // Utility.showSnackBar(response.body?.message);
        // liveVideoApi();

        update();
      } else {
        liveMediaModel.value?.data?.likesCount = response.body?.likesCount;
        // liveMediaModel.value?.data;
        liveMediaModel.value?.data?.isLiked = false;

        // Utility.showSnackBar(response.body?.message);
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Add Favorate Live Video');
    }
  }

  Future<void> databaseInit() async {
    final FirebaseDatabase database =
        FirebaseDatabase.instanceFor(app: Firebase.app());
    messagesRef = database.ref('User');

    // final  a = FirebaseFirestore.instance.collection('liveChat').snapshots();
    // print("this is a ${a.first}");
    // firebaseFirestore =
    // DatabaseEvent event = await messagesRef.once();
    // DataSnapshot snapshot = event.snapshot;

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    print("this is message ${messagesRef.ref.onValue.first}");
    messagesSubscription =
        messagesRef.limitToLast(10).onChildAdded.listen((DatabaseEvent event) {
      print('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      final FirebaseException error = o as FirebaseException;
      print('Error fire: ${error.code} ${error.message}');
    });
    print("this is a$messagesSubscription");

    // print("this is message ${messagesSubscription}");
    // print("this is message ${  snapshot!.value}");
  }

  Rxn<LiveVideoModel> liveVideoModel = Rxn<LiveVideoModel>();
  Rxn<LiveMediaModel> liveMediaModel = Rxn<LiveMediaModel>();
  Rxn<LiveVideoLikeModel> liveVideoLikeModel = Rxn<LiveVideoLikeModel>();
  RxString liveVideoUrl = ''.obs;

  Future<void> liveVideoApi() async {
    try {
      final response =
          await _homeChopperService.liveMediaAPi(liveMediaType: 'video');
      if (response.isSuccessful) {
        liveMediaModel.value = response.body;
        AppConst.LiveUrl = liveMediaModel.value?.data?.url ?? '';
        await sponsorBannerApi();
        update();
      }
    } catch (e) {
      log("", name: 'Live Video Api', error: e.toString());
    }
  }

  shareUrl(String url) async {
    await Share.share("Video Url:\n$url \n App Name: Jay Lyrics");
  }

  FirebaseAuthModel? firebaseAuthModel;

  Future<void> firebaseLogin() async {
    try {
      final response = await _homeChopperService.firebaseAuth();
      if (response.body?.data?.token?.isNotEmpty ?? false) {
        // const auth = getAuth();
        await FirebaseAuth.instance
            .signInWithCustomToken(response.body?.data?.token ?? '');
        log('Firebase authentication successful');
      }
    } catch (e) {
      log("", name: 'Live Video Api', error: e.toString());
    }
  }

  Rxn<SubscriptionStatusModel>? subscriptionStatusModel =
      Rxn<SubscriptionStatusModel>();

  Future<void> subscriptionStatusAPi() async {
    try {
      final response = await _homeChopperService.subscriptionStatusAPi();
      if (response.isSuccessful) {
        subscriptionStatusModel?.value = response.body;
        // const auth = getAuth();
        // await FirebaseAuth.instance.signInWithCustomToken(response.body?.data?.token??'');
        update();
      }
    } catch (e) {
      log("", name: 'Live Video Api', error: e.toString());
    }
  }

  Rxn<SubscriptionTokenModel>? subscriptionTokenModel =
      Rxn<SubscriptionTokenModel>();

  Future<void> subscriptionTokenAPi() async {
    try {
      final response = await _homeChopperService.subscriptionTokenAPi();
      if (response.isSuccessful) {
        subscriptionTokenModel?.value = response.body;
        // const auth = getAuth();
        // await FirebaseAuth.instance.signInWithCustomToken(response.body?.data?.token??'');
        update();
      }
    } catch (e) {
      log("", name: 'Live Video Api', error: e.toString());
    }
  }
}
