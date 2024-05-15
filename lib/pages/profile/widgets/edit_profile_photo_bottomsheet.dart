import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/profile/edit_gallery_photo_page.dart';
import 'package:ttpay/pages/profile/take_photo_page.dart';
import 'package:ttpay/pages/transaction/widgets/pin_under_bottomsheet.dart';

Future<void> editImageFromGallery({
  required BuildContext context,
}) async {
  try {
    await GalleryPicker.pickMedia(
            startWithRecent: true, context: context, singleMedia: true)
        .then((mediaList) async {
      if (mediaList != null && mediaList.isNotEmpty) {
        await mediaList.first.getFile().then((photo) async {
          await decodeImageFromList(await photo.readAsBytes())
              .then((decodedImage) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditGalleryPhotoPage(
                    image: FileImage(photo),
                    aspectRatio: decodedImage.width / decodedImage.height,
                    imageWidth: decodedImage.width,
                    imageHeight: decodedImage.height,
                  ),
                ));
          });
        });
      } else {
        showToastNotification(context, title: 'No Image picked!');
      }
    });
  } on Exception catch (e) {
    showToastNotification(context, title: e.toString());
  }
}

class EditProfilePhotoBottomsheet extends StatelessWidget {
  const EditProfilePhotoBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> profilePhotoEditOption = [
      {
        'on_tap': () async {
          await availableCameras().then((cameras) {
            if (cameras.isNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePhotoPage(cameras: cameras),
                  ));
            } else {
              showToastNotification(context,
                  type: 'error', title: 'No camera found');
            }
          });
        },
        'icon_address': 'assets/icon_image/Icon=camera.png',
        'option': 'Take Photo'
      },
      {
        'on_tap': () async {
          await Permission.photos.status.then((status) async {
            print(status.toString());
            if (status.isGranted) {
              await editImageFromGallery(context: context);
            } else {
              if (status.isPermanentlyDenied) {
                await openAppSettings();
              } else {
                final status = await Permission.photos.request();
                if (status.isGranted) {
                  await editImageFromGallery(context: context);
                } else {
                  showToastNotification(context, title: 'Permission Denied');
                }
              }
            }
          });
        },
        'icon_address': 'assets/icon_image/Icon=photo.png',
        'option': 'Import from Gallery'
      },
      {
        'on_tap': () async {
          await GalleryPicker.pickMedia(
                  startWithRecent: true, context: context, singleMedia: true)
              .then((mediaList) async {
            if (mediaList != null && mediaList.isNotEmpty) {
              await mediaList.first.getFile().then((photo) {
                Navigator.pop(context, photo);
              });
            }
          });
        },
        'icon_address': 'assets/icon_image/Icon=file.png',
        'option': 'Browse'
      },
    ];

    return backgroundContainer(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width24,
          vertical: height08 * 2,
        ),
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            topBottomsheet(context, 'Profile Photo'),
            SizedBox(height: height24),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: profilePhotoEditOption
                  .mapIndexed(
                    (i, e) => InkWell(
                      onTap: e['on_tap'],
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height10 * 1.4),
                        decoration: BoxDecoration(
                          border: isLast(i, profilePhotoEditOption)
                              ? null
                              : Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: neutralGrayScale.shade800),
                                ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              e['icon_address'],
                              height: height20,
                              fit: BoxFit.fitHeight,
                            ),
                            SizedBox(width: width24 / 2),
                            Text(
                              e['option'],
                              style: textSm.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              height: height30,
            )
          ],
        ),
      ),
    );
  }
}
