import 'package:flutter/material.dart';
import 'package:ttpay/component/empty_image_column.dart';
import 'package:ttpay/component/two_simple_appbar.dart';
import 'package:ttpay/component/warning_dialog.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/dummyData/groups.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/models/group.dart';
import 'package:ttpay/pages/group/group_detail_page.dart';
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

    void onTapEdit() {}

    void onTapDeleteGroup(Group group) async {
      await showWarningDialog(
              context: context,
              title: 'Are you sure you want to delete ${group.name}',
              redButtonText: 'Delete')
          .then((yes) {
        if (yes != null && yes) {
          setState(() {
            currentGroupList.remove(group);
          });
        }
      });
    }

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(width08 * 2, 0, width08 * 2, height24 / 2),
            child: twoSimpleAppbar(
              buttonText: 'New Group',
              onPressedButton: onPressedNewGroup,
              leftButtonIcon: Padding(
                padding: EdgeInsets.only(right: width24 / 4),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: height08 * 2,
                ),
              ),
              title: 'Groups',
            ),
          ),
          currentGroupList.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: currentGroupList.length,
                    itemBuilder: (context, index) {
                      final group = currentGroupList[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GroupDetailPage(group: group),
                              ));
                        },
                        child: groupsRow(
                            onTapEdit: onTapEdit,
                            onTapDelete: () async {
                              onTapDeleteGroup(group);
                            },
                            group: group),
                      );
                    },
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height30 * 2, horizontal: width08 * 2),
                  child: emptyImageColumn(
                      imageAddress: 'assets/images/empty.png',
                      title: 'No Groups Created Yet!',
                      description:
                          'It seems like you haven\'t created any groups yet. Start by creating your first one now! 🌟'),
                ),
        ],
      ),
    );
  }
}
