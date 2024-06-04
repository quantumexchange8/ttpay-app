import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/empty_image_column.dart';
import 'package:ttpay/component/two_simple_appbar.dart';
import 'package:ttpay/component/warning_dialog.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/models/group.dart';
import 'package:ttpay/pages/group/group_detail_page.dart';
import 'package:ttpay/pages/group/widgets/groups_row.dart';
import 'package:ttpay/pages/group/widgets/new_group_bottomsheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<Group> currentGroupList = [];

  @override
  Widget build(BuildContext context) {
    void onPressedNewGroup() async {
      await customShowModalBottomSheet(
        context: context,
        builder: (context) => const NewGroupBottomsheet(),
      ).then((newGroup) {
        if (newGroup != null) {
          groupController.addGroup(newGroup);
        }
      });
    }

    void onTapEdit() {}

    void onTapDeleteGroup(Group group) async {
      await showWarningDialog(
              context: context,
              title:
                  '${AppLocalizations.of(context)!.delete_comfirmation} ${group.name}?',
              redButtonText: AppLocalizations.of(context)!.delete)
          .then((yes) {
        if (yes != null && yes) {
          setState(() {
            currentGroupList.remove(group);
          });
        }
      });
    }

    return SafeArea(
      child: Obx(() {
        currentGroupList = groupController.groupList;
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width08 * 2, 0, width08 * 2, height24 / 2),
              child: twoSimpleAppbar(
                buttonText: AppLocalizations.of(context)!.new_group,
                onPressedButton: onPressedNewGroup,
                leftButtonIcon: Padding(
                  padding: EdgeInsets.only(right: width24 / 4),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: height08 * 2,
                  ),
                ),
                title: AppLocalizations.of(context)!.groups,
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
                          child: groupsRow(context, onTapEdit: onTapEdit,
                              onTapDelete: () async {
                            onTapDeleteGroup(group);
                          }, group: group),
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
                        title: AppLocalizations.of(context)!.no_groups,
                        description: AppLocalizations.of(context)!
                            .no_groups_description),
                  ),
          ],
        );
      }),
    );
  }
}
