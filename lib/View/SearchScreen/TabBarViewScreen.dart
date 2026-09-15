// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:new_music_app/Controller/BaseController.dart';
// import 'package:new_music_app/Utils/Constants/AppAssets.dart';
// import 'package:new_music_app/Utils/Styling/AppColors.dart';
// import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
// import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
//
// class TabBarScreen extends StatelessWidget {
//   const TabBarScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           leading: InkWell(
//             onTap: (){
//               Get.back();
//             },
//             child: Icon(
//               Icons.arrow_back,
//               color: AppColors.appButton,
//             ),
//           ),
//           backgroundColor: AppColors.black,
//           title: AppTextWidget(
//             txtTitle: "Search Screen",
//             txtColor: AppColors.appButton,
//             fontSize: 18,
//           ),
//           bottom: const TabBar(
//             indicatorColor: AppColors.appButton,
//             labelColor: AppColors.appButton,
//             unselectedLabelColor: AppColors.white,
//             tabs: [
//               Tab(icon: Icon(Icons.music_note), text: "Music"),
//               Tab(icon: Icon(Icons.album), text: "Album"),
//               Tab(icon: Icon(Icons.video_library), text: "Videos"),
//             ],
//           ),
//         ),
//         body: Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.symmetric(horizontal: 5.w),
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(
//                     AppAssets.blackBackgroundScreen,
//                   ),
//                   fit: BoxFit.cover)),
//           child: const TabBarView(
//             children: [
//               MusicScreen(),
//               AlbumScreen(),
//               VideoScreen(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Screens
//
// class MusicScreen extends GetView<BaseController> {
//   const MusicScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       GetBuilder<BaseController>(
//         init: controller,
//         builder: (controller) {
//           return controller.searchDataModel?.data?.musics?.isNotEmpty??false? ListView.builder(
//               shrinkWrap: true,
//               itemCount: controller.searchDataModel?.data?.musics?.length ?? 0,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   onTap: () {},
//                   leading: CachedNetworkImageWidget(
//                       image: controller
//                           .searchDataModel?.data?.musics?[index].songImage),
//                   title: AppTextWidget(
//                     txtColor: AppColors.error,
//                     txtTitle: controller
//                             .searchDataModel?.data?.musics?[index].songName ??
//                         "",
//                   ),
//                   subtitle: AppTextWidget(
//                     txtColor: AppColors.error,
//                     txtTitle: controller
//                             .searchDataModel?.data?.musics?[index].songArtist ??
//                         "",
//                   ),
//                 );
//               }): Center(
//             child: AppTextWidget(txtTitle: "No Data Found", fontSize: 24,txtColor: AppColors.appButton,),
//           );
//         });
//   }
// }
//
// class AlbumScreen extends StatelessWidget {
//   const AlbumScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("Album Screen", style: TextStyle(fontSize: 24)),
//     );
//   }
// }
//
// class VideoScreen extends StatelessWidget {
//   const VideoScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("Video Screen", style: TextStyle(fontSize: 24)),
//     );
//   }
// }
