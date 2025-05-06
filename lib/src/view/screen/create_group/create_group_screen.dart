import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/manage_group/manage_group_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/creategroupcontroller/group_create_controller.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final GroupCreateController _groupCreateController =
  Get.put(GroupCreateController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _groupNameTEController = TextEditingController();
  final TextEditingController _amountTEController = TextEditingController();
  final TextEditingController _frequencyTEController = TextEditingController();
  final TextEditingController _maximumTEController = TextEditingController();
  final TextEditingController _descriptionNameTEController =
  TextEditingController();
  final TextEditingController _acceptCodeTEController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final List<String> _frequencies = [
    "  WEEKLY",
    "BI_WEEKLY",
    "MONTHLY",
  ];

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
                Text(
                  'group_name'.tr,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                      child: Text(
                        "contrubution_amount".tr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "frequency".tr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
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
                Text(
                  "maximum_members".tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                ),
                TextFormField(
                  controller: _maximumTEController,
                  decoration: InputDecoration(
                    hintText: "enter_maximum_members".tr,
                  ),
                  validator: (value) =>
                      validateField(value: value, fieldType: "member"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                Text(
                  "description".tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                ),
                TextFormField(
                  controller: _descriptionNameTEController,
                  decoration: InputDecoration(
                    hintText: "group_description (optional)".tr,
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 15),
                Text(
                  "accept_code".tr, // New Field for Accept Code
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                ),
                TextFormField(
                  controller: _acceptCodeTEController,
                  decoration: InputDecoration(
                    hintText: "enter_accept_code".tr,
                  ),
                  validator: (value) =>
                      validateField(value: value, fieldType: "Accept Code"),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                        () {
                      if (_groupCreateController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
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
                                acceptCode: _acceptCodeTEController.text.trim(),  // Sending acceptCode here
                                context: context,
                              )
                                  .then((_) {
                                Get.to(() => ManageGroupScreen());
                              });
                            }
                          },
                          child: Text('create_group'.tr),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateField({
    required String? value,
    required String fieldType,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldType';
    }

    if (fieldType == 'email') {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email address';
      }
    }

    if (fieldType == 'password') {
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
    }

    return null;
  }

  @override
  void dispose() {
    _descriptionNameTEController.dispose();
    _maximumTEController.dispose();
    _amountTEController.dispose();
    _groupNameTEController.dispose();
    _frequencyTEController.dispose();
    _acceptCodeTEController.dispose(); // Disposing the acceptCode controller
    super.dispose();
  }
}
