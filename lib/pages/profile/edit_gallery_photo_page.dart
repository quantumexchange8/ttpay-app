import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/pages/profile/widgets/profile_photo_appbar.dart';
import 'package:zoomable_image_cropper/zoomable_image_cropper.dart';

class EditGalleryPhotoPage extends StatefulWidget {
  final FileImage image;
  final double aspectRatio;
  final int imageWidth;
  final int imageHeight;
  const EditGalleryPhotoPage(
      {super.key,
      required this.image,
      required this.aspectRatio,
      required this.imageWidth,
      required this.imageHeight});

  @override
  State<EditGalleryPhotoPage> createState() => _EditGalleryPhotoPageState();
}

class _EditGalleryPhotoPageState extends State<EditGalleryPhotoPage> {
  late ZoomableImageCropperController zoomController;

  @override
  void initState() {
    super.initState();
    zoomController = ZoomableImageCropperController(
      image: widget.image,
      aspectRatio: widget.aspectRatio,
      imageWidth: widget.imageWidth,
      imageHeight: widget.imageHeight,
      containerHeight: height100 * 3.6,
      containerWidth: screenWidth,
      // onInteractionUpdate: (details) {
      //   /*
      //       *  You can use the details to get the scale and translation values
      //       *  to do something with it
      //       */
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    void onPressedDone() async {
      final Directory tempDir = await getTemporaryDirectory();

      await zoomController.getCurrentCropImageBytes().then((value) {
        File file = File(
            '${tempDir.path}/${DateFormat('ddMMyy').format(DateTime.now())}.png');
        file.writeAsBytesSync(value);
        Navigator.pop(context, file);
      });
    }

    void onChooseAnotherPhoto() async {
      final permitted = await PhotoManager.requestPermissionExtend();
      if (permitted != PermissionState.authorized) {
        showToastNotification(context,
            type: 'error', title: 'Permission is not granted');
        return;
      }
      try {
        final albums = await PhotoManager.getAssetPathList();
        final recentAlbum = albums.first;
        final recentAlbumAssets =
            await recentAlbum.getAssetListRange(start: 0, end: 5);
        final recentAsset = recentAlbumAssets.first;
        final file = await recentAsset.file;

        setState(() {
          zoomController = ZoomableImageCropperController(
            image: FileImage(file!),
            aspectRatio: recentAsset.width / recentAsset.height,
            imageWidth: recentAsset.width,
            imageHeight: recentAsset.height,
            containerHeight: height100 * 3.6,
            containerWidth: screenWidth,
          );
        });
      } on Exception catch (e) {
        showToastNotification(context, type: 'error', title: e.toString());
        return;
      }
    }

    return Scaffold(
      appBar: profilePhotoAppbar,
      extendBodyBehindAppBar: true,
      body: backgroundContainer(
          padding: EdgeInsets.symmetric(vertical: height24),
          child: SizedBox(
            width: screenWidth,
            child: Column(
              children: [
                ZoomableImageCropper(controller: zoomController),
                SizedBox(
                  height: height20 * 2,
                ),
                ctaButton(
                    onPressed: onPressedDone, isGradient: true, text: 'Done'),
                SizedBox(
                  height: height24 / 2,
                ),
                ctaButton(
                    onPressed: onChooseAnotherPhoto,
                    text: 'Choose another photo')
              ],
            ),
          )),
    );
  }
}
