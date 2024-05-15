import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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
      try {
        final Directory tempDir = await getTemporaryDirectory();

        await getCurrentCropImageBytes(zoomController).then((cropBytes) {
          if (cropBytes != null) {
            File file = File(
                '${tempDir.path}/IMG${DateFormat('yyMMddHHmmss').format(DateTime.now())}.png');
            file.writeAsBytesSync(cropBytes);
            Navigator.pop(context);
            Navigator.pop(context, file);
          } else {
            showToastNotification(
              context,
              type: 'error',
              title: 'Image format is not supported',
            );
          }
        });
      } on Exception catch (e) {
        print(e.toString());
        showToastNotification(context,
            type: 'error', title: 'Error', description: e.toString());
        return;
      }
    }

    void onChooseAnotherPhoto() async {
      try {
        final imageFiles = await GalleryPicker.pickMedia(
            context: context, startWithRecent: true, singleMedia: true);
        final imageFile = await imageFiles?.first.getFile();
        if (imageFile != null) {
          var decodedImage =
              await decodeImageFromList(await imageFile.readAsBytes());
          setState(() {
            zoomController = ZoomableImageCropperController(
              image: FileImage(imageFile),
              aspectRatio: decodedImage.width / decodedImage.height,
              imageWidth: decodedImage.width,
              imageHeight: decodedImage.height,
              containerHeight: height100 * 3.6,
              containerWidth: screenWidth,
            );
          });
        } else {
          showToastNotification(context,
              type: 'error', title: 'No Image selected!');
        }
      } on Exception catch (e) {
        showToastNotification(context, type: 'error', title: e.toString());
        return;
      }
    }

    return Scaffold(
      appBar: profilePhotoAppbar(context),
      extendBodyBehindAppBar: true,
      body: backgroundContainer(
          padding: EdgeInsets.symmetric(vertical: height24),
          child: SafeArea(
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

Future<Uint8List?> getCurrentCropImageBytes(
    ZoomableImageCropperController zoomController) async {
  final bytes = await zoomController.image.file.readAsBytes();
  img.Image? image = img.decodeImage(bytes);
  final transformations = zoomController.mediaTransformer
      .getImageTransformations(zoomController.transformationController);
  final x = transformations.cropPosition.left.toInt();
  final y = transformations.cropPosition.top.toInt();
  final height = transformations.height.toInt();
  final width = transformations.width.toInt();

  if (image != null) {
    img.Image cropped =
        img.copyCrop(image, x: x, y: y, height: height, width: width);

    final encoder = img.JpegEncoder();

    return encoder.encode(cropped);
  } else {
    return null;
  }
}
