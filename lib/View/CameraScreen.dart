import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription frontCamera;
  final CameraDescription rearCamera;

  const TakePictureScreen(
      {super.key, required this.frontCamera, required this.rearCamera});

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _cameraController;

  bool _isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    _initCamera(widget.rearCamera);
  }

  Future<void> _initCamera(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    setState(() {});
    await _cameraController.initialize().then((value) => setState(() {}));
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _switchCamera() async {
    if (_isFrontCamera) {
      await _initCamera(widget.rearCamera);
      setState(() {
        _isFrontCamera = false;
      });
    } else {
      await _initCamera(widget.frontCamera);
      setState(() {
        _isFrontCamera = true;
      });
    }
  }

  Future<void> _takePicture() async {
    try {
      final XFile picture = await _cameraController.takePicture();
      if (picture.path != '') {
        Get.back();
      }
      await Get.find<BaseController>().takeCameraPicture(picture.path);
      // Navigate to a new screen to display the picture.
    } catch (e) {
      log('', name: 'Take ', error: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BaseController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: double.maxFinite,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  SizedBox(
                    height: double.maxFinite,
                    child: CameraPreview(
                      _cameraController,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: 100.h,
                      width: double.maxFinite,
                      color: AppColors.transparent.withOpacity(0.2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: AppButtonWidget(
                              onPressed: () async {
                                _takePicture();
                              },
                              btnName: "",
                              borderRadius: 8.r,
                              padding: EdgeInsets.all(10.r),
                              btnColor: AppColors.white,
                              child: const Icon(
                                Icons.camera,
                                color: AppColors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _switchCamera,
          child: const Icon(Icons.switch_camera),
        ),
      ),
    );
  }
}
