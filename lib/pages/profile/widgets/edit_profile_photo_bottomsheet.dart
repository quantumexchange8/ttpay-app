import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/transaction/widgets/pin_under_bottomsheet.dart';

class EditProfilePhotoBottomsheet extends StatelessWidget {
  const EditProfilePhotoBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> profilePhotoEditOption = [
      {
        'on_tap': () {},
        'icon_address': 'assets/icon_image/Icon=camera.png',
        'option': 'Take Photo'
      },
      {
        'on_tap': () {},
        'icon_address': 'assets/icon_image/Icon=photo.png',
        'option': 'Import from Gallery'
      },
      {
        'on_tap': () {},
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
                  .map(
                    (e) => InkWell(
                      onTap: e['on_tap'],
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height10 * 1.4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1, color: neutralGrayScale.shade800),
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
          ],
        ),
      ),
    );
  }
}
