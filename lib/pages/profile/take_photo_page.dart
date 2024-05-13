import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/pages/profile/edit_gallery_photo_page.dart';
import 'package:ttpay/pages/profile/widgets/profile_photo_appbar.dart';

class TakePhotoPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const TakePhotoPage({super.key, required this.cameras});

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            showToastNotification(
              context,
              type: 'error',
              title: 'Access Denied',
            );
            break;
          default:
            showToastNotification(
              context,
              type: 'error',
              title: e.toString(),
            );
            break;
        }
      } else {
        showToastNotification(
          context,
          type: 'error',
          title: e.toString(),
        );
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  // ignore: override_on_non_overriding_member
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (!cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
    );
  }

  Future<XFile?> takePicture() async {
    if (!_cameraController.value.isInitialized) {
      showToastNotification(context,
          type: 'error', title: 'Error: select a camera first.');
      return null;
    }

    if (_cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await _cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    showToastNotification(context, title: e.code, description: e.description);
  }

  @override
  Widget build(BuildContext context) {
    void onTapFlip() async {
      if (widget.cameras.length > 1) {
        if (_cameraController.description == widget.cameras[0]) {
          await _cameraController.setDescription(widget.cameras[1]);
        } else {
          await _cameraController.setDescription(widget.cameras[0]);
        }
      }
    }

    void onTapCapture() {
      takePicture().then((XFile? file) async {
        if (file != null) {
          FileImage saveFile = FileImage(File(file.path));
          var decodedImage =
              await decodeImageFromList(await file.readAsBytes());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EditGalleryPhotoPage(
                    image: saveFile,
                    aspectRatio: (decodedImage.width / decodedImage.height),
                    imageWidth: decodedImage.width,
                    imageHeight: decodedImage.height),
              ));
        }
      });
    }

    return Scaffold(
      appBar: profilePhotoAppbar(context),
      extendBodyBehindAppBar: true,
      body: backgroundContainer(
          padding: EdgeInsets.symmetric(vertical: height24),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: height100 * 4,
                  width: screenWidth,
                  child: Stack(
                    children: [
                      SizedBox(
                          height: width100 * 4,
                          width: screenWidth,
                          child: CameraPreview(_cameraController)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: height24 / 2, right: width24 / 2),
                          child: flipContainer(
                            onTap: onTapFlip,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height30 * 2,
                ),
                GestureDetector(
                  onTap: onTapCapture,
                  child: Image.asset(
                    'assets/icon_image/shutter_icon.png',
                    height: height10 * 9.6,
                    fit: BoxFit.fitHeight,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

Widget flipContainer({void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset(
      'assets/icon_image/flip_camera_icon.png',
      height: height10 * 4.8,
      fit: BoxFit.fitHeight,
    ),
  );
}
