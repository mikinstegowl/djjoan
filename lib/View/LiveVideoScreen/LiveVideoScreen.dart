import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/LiveVideoController.dart';
import 'package:new_music_app/CoreImage.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/TestVideo.dart';

class LiveVideoScreen extends GetView<LiveVideoController> {
  const LiveVideoScreen({super.key});

  void _onBack(BuildContext context) {
    AppConst.currentTabIndex = 0;
    AppConst.bottomDisplay = BottomDisplay.video;
    Get.find<BaseController>().playLiveVideo(
      url: controller.liveMediaModel.value?.data?.url ?? AppConst.LiveUrl,
      title: controller.liveMediaModel.value?.data?.title ?? 'Live TV',
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onBack(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.smokeBlack,
          leadingWidth: 80.w,
          bottom: PreferredSize(
            preferredSize: Size(double.maxFinite, 10.h),
            child: const Divider(
              color: AppColors.appButton,
            ),
          ),
          leading: InkWell(
            onTap: () => _onBack(context),
            child: Row(
              children: [
                10.horizontalSpace,
                Icon(
                  Icons.arrow_back_ios,
                  size: 20.r,
                  color: AppColors.white,
                ),
                const AppTextWidget(
                  txtTitle: "Back",
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  txtColor: AppColors.white,
                )
              ],
            ),
          ),
        centerTitle: true,
        title: AppTextWidget(
          txtTitle: controller.liveMediaModel.value?.data?.title ?? '',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          txtColor: AppColors.white,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(
              AppAssets.liveIcon,
              width: 50.w,
              height: 25.h,
              color: AppColors.appButton,
            ),
          )
        ],
      ),
      floatingActionButton:
          // controller.subscriptionStatusModel?.value?.data?.isActive ?? false
          // UserPreference.getValue(key: PrefKeys.email) != null
          //     ?
          Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.sp)),
              child: TextFormField(
                controller: controller.postMessageController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    hintText: 'post a message',
                    suffixIcon: AppButtonWidget(
                      borderRadius: 14.sp,
                      btnColor: AppColors.appButton,
                      width: 70.w,
                      onPressed: () {
                        controller.sendMessage(context);
                      },
                      btnName: 'Post',
                    )),
              )),
        ),
      ),
      // : UserPreference.getValue(key: PrefKeys.email) != null
      //     ? SizedBox.shrink()
      //     : SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AppAssets.blackBackgroundScreen,
                  ),
                  fit: BoxFit.cover)),
          child:
              // controller.subscriptionStatusModel?.value?.data?.isActive ??
              //         false
              //     ?

              // UserPreference.getValue(key: PrefKeys.email) != null
              //     ?
              GetBuilder<LiveVideoController>(
                  init: controller,
                  initState: (state) {
                    controller.firebaseLogin();
                    FirebaseFirestore.instance
                        .collection('liveChat')
                        .orderBy('timestamp', descending: false)
                        .snapshots()
                        .listen((data) {
                      print("data is every $data");
                      Future.delayed(const Duration(seconds: 3), () {
                        if (controller.scrollController.hasClients) {
                          controller.scrollController.animateTo(
                              controller
                                  .scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeInOut);
                        }
                      });
                    });
                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (controller.scrollController.hasClients) {
                        controller.scrollController.animateTo(
                            controller.scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeInOut);
                      }
                    });
                  },
                  builder: (controller) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: 175.h,
                              child: const TestViewWidget(),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.likeLiveVideoAPi(
                                        liveVideoId: controller.liveMediaModel
                                                .value?.data?.id ??
                                            0);
                                  },
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppAssets.likeIcon,
                                          color: controller.liveMediaModel.value
                                                      ?.data?.isLiked ??
                                                  false
                                              ? AppColors.appButton
                                              : AppColors.white,
                                          height: 25.h,
                                          width: 25.h,
                                        ),
                                        10.horizontalSpace,
                                        AppTextWidget(
                                          txtTitle: controller.liveMediaModel
                                                  .value?.data?.likesCount
                                                  .toString() ??
                                              '0',
                                          txtColor: AppColors.white,
                                          fontSize: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.shareUrl(controller
                                            .liveMediaModel.value?.data?.url ??
                                        '');
                                  },
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppAssets.shareIcon,
                                          height: 25.h,
                                          width: 25.h,
                                        ),
                                        10.horizontalSpace,
                                        const AppTextWidget(
                                          fontSize: 16,
                                          txtTitle: 'Share',
                                          txtColor: AppColors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                height: 100.h,
                                child: CarouselSlider.builder(
                                    itemCount:
                                        controller.banner.value?.data?.length ??
                                            1,
                                    options: CarouselOptions(
                                      initialPage: 0,
                                      padEnds: false,
                                      enlargeCenterPage: false,
                                      viewportFraction: 1,
                                      // autoPlayInterval: const Duration(seconds: 3),
                                      autoPlay: true,
                                    ),
                                    itemBuilder: (context, index, realIndex) =>
                                        InkWell(
                                          onTap: () {
                                            controller.shareBanner(
                                                url: controller.banner.value
                                                        ?.data?[index].link ??
                                                    '');
                                          },
                                          child: CoreImage(
                                            width: double.maxFinite,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(0)),
                                            url: controller.banner.value
                                                    ?.data?[index].image ??
                                                '',
                                            height: 50,
                                            boxFit: BoxFit.contain,
                                            isPlaceHolder: false,
                                          ),
                                        )),
                              ),
                            ),
                            Flexible(
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('liveChat')
                                    .orderBy('timestamp', descending: false)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  // Future.delayed(const Duration(milliseconds: 1000), () {
                                  //   controller.scrollController.animateTo(
                                  //       controller.scrollController.position.maxScrollExtent,
                                  //       duration: Duration(milliseconds: 200),
                                  //       curve: Curves.easeInOut
                                  //   );
                                  // });
                                  return ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      controller: controller.scrollController,
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data?.docs.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              trailing:
                                                  (snapshot.data?.docs[index]
                                                                      .data()[
                                                                  'role'])
                                                              .toString()
                                                              .toLowerCase() !=
                                                          'user'
                                                      ? Container(
                                                          height: 170.h,
                                                          width: 90.w,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Container(
                                                                height: 30.h,
                                                                width: 40.h,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                child: (snapshot.data?.docs[index].data()['image'] != null && snapshot.data?.docs[index].data()['image'].toString().isNotEmpty == true && snapshot.data?.docs[index].data()['image'].toString() != 'null')
                                                                    ? CachedNetworkImageWidget(
                                                                        image: (snapshot
                                                                            .data
                                                                            ?.docs[index]
                                                                            .data()['image']),
                                                                        height:
                                                                            30.h,
                                                                        width:
                                                                            30.h,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      )
                                                                    : Image.asset(
                                                                        AppAssets
                                                                            .alajazaLogo),
                                                              ),
                                                              Flexible(
                                                                flex: 4,
                                                                child: AppTextWidget(
                                                                    maxLine: 2,
                                                                    txtTitle: ((snapshot.data?.docs[index].data()['userName']) ??
                                                                            'user')
                                                                        .toString(),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    txtColor:
                                                                        AppColors
                                                                            .appButton,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .arrow_back_ios_outlined,
                                                              color: AppColors
                                                                  .white,
                                                              size: 20,
                                                            ),
                                                            Text(
                                                              snapshot.data?.docs[index]
                                                                              .data()[
                                                                          'timestamp'] !=
                                                                      null
                                                                  ? Timestamp.fromDate((snapshot
                                                                              .data
                                                                              ?.docs[index]
                                                                              .data()['timestamp'] as Timestamp)
                                                                          .toDate())
                                                                      .toDate()
                                                                      .toLocal()
                                                                      .toString()
                                                                      .toFormattedTime()
                                                                  : '',
                                                              style: const TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                              leading:
                                                  snapshot.data?.docs[index]
                                                              .data()['role']
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'user'
                                                      ? SizedBox(
                                                          height: 90.h,
                                                          width: 50.w,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Container(
                                                                height: 30.h,
                                                                width: 30.h,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                child: (snapshot.data?.docs[index].data()['image'] != null && snapshot.data?.docs[index].data()['image'].toString().isNotEmpty == true && snapshot.data?.docs[index].data()['image'].toString() != 'null')
                                                                    ? CachedNetworkImageWidget(
                                                                        image: snapshot
                                                                            .data
                                                                            ?.docs[index]
                                                                            .data()['image'],
                                                                        height:
                                                                            30.h,
                                                                        width:
                                                                            30.h,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      )
                                                                    : Image.asset(
                                                                        AppAssets
                                                                            .alajazaLogo),
                                                              ),
                                                              Flexible(
                                                                flex: 3,
                                                                child: AppTextWidget(
                                                                    txtTitle: snapshot.data?.docs[index].data()[
                                                                            'userName'] ??
                                                                        'user',
                                                                    txtColor:
                                                                        AppColors
                                                                            .appButton,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              snapshot.data?.docs[index]
                                                                              .data()[
                                                                          'timestamp'] !=
                                                                      null
                                                                  ? Timestamp.fromDate((snapshot
                                                                              .data
                                                                              ?.docs[index]
                                                                              .data()['timestamp'] as Timestamp)
                                                                          .toDate())
                                                                      .toDate()
                                                                      .toLocal()
                                                                      .toString()
                                                                      .toFormattedTime()
                                                                  : '',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontSize: 12),
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .arrow_forward_ios_outlined,
                                                              color: AppColors
                                                                  .white,
                                                              size: 20,
                                                            ),
                                                          ],
                                                        ),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  snapshot.data?.docs[index]
                                                              .data()['role']
                                                              .toString()
                                                              .toLowerCase() !=
                                                          'user'
                                                      ? Flexible(
                                                          flex: 3,
                                                          child: Text(
                                                            snapshot
                                                                    .data
                                                                    ?.docs[
                                                                        index]
                                                                    .data()[
                                                                        'text']
                                                                    .toString() ??
                                                                '',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13),
                                                          ),
                                                        )
                                                      : const Spacer(),
                                                  snapshot.data?.docs[index]
                                                              .data()['role']
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'user'
                                                      ? Flexible(
                                                          flex: 3,
                                                          child: Text(
                                                            snapshot
                                                                    .data
                                                                    ?.docs[
                                                                        index]
                                                                    .data()[
                                                                        'text']
                                                                    .toString() ??
                                                                '',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13),
                                                          ),
                                                        )
                                                      : const Spacer(),
                                                ],
                                              ),
                                            ),
                                            5.verticalSpace,
                                            const Divider()
                                          ],
                                        );
                                      });
                                },
                              ),
                            ),
                            60.verticalSpace,
                          ],
                        ),
                        Visibility(
                            visible: controller.loader.value,
                            child: const AppLoder()),
                      ],
                    );
                  })
          // ? AlertDialog.adaptive(
          //     elevation: 10,
          //     surfaceTintColor: AppColors.white,
          //     backgroundColor: AppColors.black,
          //     content: AppTextWidget(
          //       txtTitle:
          //           'Welcome to Jay Lyrics Live Stream. Please Subscribe to watch our Live Stream',
          //       txtColor: AppColors.appButton,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     actionsAlignment: MainAxisAlignment.center,
          //     actions: [
          //       AppButtonWidget(
          //         padding: EdgeInsets.symmetric(
          //             horizontal: 30.w, vertical: 10.h),
          //         onPressed: () {
          //           controller.subscriptionTokenAPi().then((_) {
          //             if (UserPreference.getValue(key: PrefKeys.userId) !=
          //                     null &&
          //                 (controller.subscriptionTokenModel?.value?.data
          //                         ?.token?.isNotEmpty ??
          //                     false)) {
          //               launchUrl(
          //                 Uri.parse(
          //                   "http://35.154.69.160/subscription-plan?token=${controller.subscriptionTokenModel?.value?.data?.token}",
          //                 ),
          //                 mode: LaunchMode.inAppWebView,
          //               );
          //             }
          //           });
          //         },
          //         btnName: "Get Your Plan",
          //         btnColor: AppColors.appButton,
          //       )
          //     ],
          //   )
          // : AlertDialog.adaptive(
          //     elevation: 10,
          //     surfaceTintColor: AppColors.white,
          //     backgroundColor: AppColors.black,
          //     content: const AppTextWidget(
          //       txtColor: AppColors.appButton,
          //       fontWeight: FontWeight.w500,
          //       txtTitle: 'Please Login',
          //     ),
          //     actionsAlignment: MainAxisAlignment.center,
          //     actions: [
          //       AppButtonWidget(
          //           padding: EdgeInsets.symmetric(
          //               horizontal: 30.w, vertical: 10.h),
          //           onPressed: () {
          //             Get.toNamed(RoutesName.loginScreen);
          //           },
          //           btnColor: AppColors.appButton,
          //           btnName: "Login")
          //     ],
          ),
        ),
    );
  }
}
