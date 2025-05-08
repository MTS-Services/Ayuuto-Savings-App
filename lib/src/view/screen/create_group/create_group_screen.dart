import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/manage_group/manage_group_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_colors.dart';
import '../../controller/creategroupcontroller/group_create_controller.dart';
import '../../controller/groupservice/active_service_controller.dart';
import '../../controller/groupservice/complete_service_controller.dart';
import '../../widget/snack_bar_message.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final GroupCreateController _groupCreateController =
      Get.put(GroupCreateController());
  final ActiveServiceController _activeController =
      Get.put(ActiveServiceController());
  final CompleteServiceController _completeController =
      Get.put(CompleteServiceController());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _groupNameTEController = TextEditingController();
  final TextEditingController _amountTEController = TextEditingController();
  final TextEditingController _frequencyTEController = TextEditingController();
  final TextEditingController _maximumTEController = TextEditingController();
  final TextEditingController _descriptionNameTEController =
      TextEditingController();
  final TextEditingController _acceptCodeTEController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final List<String> _frequencies = ["WEEKLY", "BI_WEEKLY", "MONTHLY"];

  final RxBool isActiveSelected = true.obs;
  final RxnString userRole = RxnString();

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  void getUserRole() async {
    final uid = _auth.currentUser!.uid;
    final snapshot =
        await FirebaseDatabase.instance.ref('users/$uid/role').get();
    if (snapshot.exists) {
      userRole.value = snapshot.value.toString();
    } else {
      userRole.value = 'member';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'create_group'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text('group_name'.tr, style: _titleStyle(context)),
                TextFormField(
                  controller: _groupNameTEController,
                  decoration: InputDecoration(hintText: 'enter_group_name'.tr),
                  validator: (value) =>
                      validateField(value: value, fieldType: "Group"),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                        child: Text("contrubution_amount".tr,
                            style: _titleStyle(context))),
                    const SizedBox(width: 20),
                    Expanded(
                        child:
                            Text("frequency".tr, style: _titleStyle(context))),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _amountTEController,
                        decoration: InputDecoration(hintText: "\$ amount".tr),
                        validator: (value) =>
                            validateField(value: value, fieldType: "amount"),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _frequencyTEController.text.isEmpty
                            ? null
                            : _frequencyTEController.text,
                        decoration:
                            InputDecoration(hintText: "select_frequency".tr),
                        items: _frequencies
                            .map((frequency) => DropdownMenuItem(
                                  value: frequency,
                                  child: Text(frequency),
                                ))
                            .toList(),
                        validator: (value) =>
                            validateField(value: value, fieldType: "Frequency"),
                        onChanged: (value) {
                          setState(() {
                            _frequencyTEController.text = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text("maximum_members".tr, style: _titleStyle(context)),
                TextFormField(
                  controller: _maximumTEController,
                  decoration:
                      InputDecoration(hintText: "enter_maximum_members".tr),
                  validator: (value) =>
                      validateField(value: value, fieldType: "member"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                Text("description".tr, style: _titleStyle(context)),
                TextFormField(
                  controller: _descriptionNameTEController,
                  decoration: InputDecoration(
                      hintText: "group_description (optional)".tr),
                  maxLines: 4,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: Obx(() {
                    if (_groupCreateController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          if (_globalKey.currentState!.validate()) {
                            _groupCreateController
                                .groupCreate(
                              adminUserId: _auth.currentUser!.uid,
                              groupName: _groupNameTEController.text.trim(),
                              contributionAmount:
                                  int.parse(_amountTEController.text.trim()),
                              frequency: _frequencyTEController.text.trim(),
                              maxMembers:
                                  int.parse(_maximumTEController.text.trim()),
                              description:
                                  _descriptionNameTEController.text.trim(),
                              context: context,
                            )
                                .then((_) {
                              Get.to(() => const ManageGroupScreen());
                            });
                          }
                        },
                        child: Text('create_group'.tr),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(() {
        final role = userRole.value?.toLowerCase();
        const List<String> adminRoles = ['admin', 'superboss', 'head_of_dept'];

        if (role == null || adminRoles.contains(role)) {
          return const SizedBox();
        }

        return ElevatedButton.icon(
          onPressed: () {
            showGroupAcceptCodeDialog(
              context: context,
              onSubmit: (code) {
                final allGroups = [
                  ..._activeController.activeGroups,
                  ..._completeController.completedGroups,
                ];

                final matchedGroup = allGroups.firstWhereOrNull(
                  (group) => group == code,
                );

                if (matchedGroup != null) {
                  final isActive =
                      matchedGroup.status.toLowerCase() == 'active';
                  isActiveSelected.value = isActive;

                  if (isActive) {
                    _activeController.activeGroups.assignAll([matchedGroup]);
                  } else {
                    _completeController.completedGroups
                        .assignAll([matchedGroup]);
                  }

                  showSnackBarMessage(context, "Group found!");
                } else {
                  showSnackBarMessage(context, "Invalid code!");
                }
              },
            );
          },
          icon: const Icon(Icons.check),
          label: const Text(
            "Accept",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.buttonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }),
    );
  }

  TextStyle _titleStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        );
  }

  String? validateField({required String? value, required String fieldType}) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldType';
    }
    if (fieldType == 'email') {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email address';
      }
    }
    if (fieldType == 'password' && value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<void> showGroupAcceptCodeDialog({
    required BuildContext context,
    required void Function(String code) onSubmit,
  }) {
    final TextEditingController codeController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Accept Code"),
          content: TextField(
            controller: codeController,
            decoration: const InputDecoration(hintText: "Accept Code"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final code = codeController.text.trim();
                Navigator.pop(context);
                onSubmit(code);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _descriptionNameTEController.dispose();
    _maximumTEController.dispose();
    _amountTEController.dispose();
    _groupNameTEController.dispose();
    _frequencyTEController.dispose();
    _acceptCodeTEController.dispose();
    super.dispose();
  }
}
