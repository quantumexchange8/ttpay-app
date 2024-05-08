import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/empty_image_column.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/dummyData/groups.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/group.dart';
import 'package:ttpay/pages/group/widgets/delete_group_warning_dialog.dart';
import 'package:ttpay/pages/group/widgets/group_action.dart';
import 'package:ttpay/pages/group/widgets/groups_row.dart';
import 'package:ttpay/pages/group/widgets/new_group_bottomsheet.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final List<Group> groupListData = listGroupFromListMap(groups);
  List<Group> currentGroupList = [];

  @override
  void initState() {
    super.initState();
    currentGroupList = groupListData;
  }

  @override
  Widget build(BuildContext context) {
    void onPressedNewGroup() async {
      await customShowModalBottomSheet(
        context: context,
        builder: (context) => const NewGroupBottomsheet(),
      ).then((value) {
        Group? group = value;
        if (group != null) {
          setState(() {
            currentGroupList.add(group);
          });
        }
      });
    }

    return Scaffold(
      body: backgroundContainer(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height24 / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Groups',
                  style: textLg.copyWith(fontWeight: FontWeight.w700),
                ),
                ctaButton(
                    onPressed: onPressedNewGroup,
                    bgColor: Colors.white.withOpacity(0.1),
                    leftIcon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: height08 * 2,
                    ),
                    textStyle: textXS.copyWith(fontWeight: FontWeight.w700),
                    text: 'New Group')
              ],
            ),
          ),
          currentGroupList.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: currentGroupList
                      .map((e) => groupsRow(
                          onTapMore: () async {
                            await showGroupAction(context: context)
                                .then((isDelete) async {
                              if (isDelete != null && isDelete) {
                                await showGroupDeleteWarningDialog(
                                        context: context, groupName: e.name)
                                    .then((canDelete) {
                                  if (canDelete != null && canDelete) {
                                    setState(() {
                                      currentGroupList.remove(e);
                                    });
                                  }
                                });
                              }
                            });
                          },
                          group: e))
                      .toList(),
                )
              : emptyImageColumn(
                  imageAddress: 'assets/images/empty.png',
                  title: 'No Groups Created Yet!',
                  description:
                      'It seems like you haven\'t created any groups yet. Start by creating your first one now! 🌟')
        ],
      )),
    );
  }
}
