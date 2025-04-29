import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/manage_group/manage_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {

  final TextEditingController _groupNameTEController = TextEditingController();
  final TextEditingController _amountTEController = TextEditingController();
  final TextEditingController _maximumTEController = TextEditingController();
  final TextEditingController _descriptionNameTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create Group", onTap: (){
        Get.back();
      },),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Group Name",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14 , fontWeight: FontWeight.w600
                  ),
                ),
                TextFormField(
                  controller: _groupNameTEController,
                  decoration: InputDecoration(hintText: "Enter Group name"),
                  validator: (value)=>validateField(value: value , fieldType: "Group"),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Contribution Amount",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14 , fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        "Frequency",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14 , fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _amountTEController,
                        decoration: InputDecoration(hintText: "\$ amount"),
                        validator: (value)=>validateField(value: value , fieldType: "amount"),
                      ),
        
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField<String>(
                          validator: (value)=>validateField(value: value , fieldType: "Frequency"),
                          hint:Text("Select Frequency",style:Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12
                          ),),
                          items: ["Daily", "Weekly", "Monthly", "Yearly"]
                              .map((frequency) => DropdownMenuItem(
                                    value: frequency,
                                    child: Text(frequency),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            print("Selected: $value");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Maximum Members",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                ),
                TextFormField(
                  controller: _maximumTEController,
                  decoration: const InputDecoration(
                    hintText: "Enter maximum members",
                  ),
                  validator: (value)=>validateField(value: value , fieldType: "member"),
                ),
                Text(
                  "Description",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                ),
                TextFormField(
                  controller: _descriptionNameTEController,
                  decoration: InputDecoration(
                    hintText: "Group description (Optional)",
                  ),
                  maxLines: 4,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // if(_globalKey.currentState!.validate()){
                      //
                      // }

                      Get.to(()=>ManageGroupScreen());
                    },
                    child: Text("Create Group"),
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
    super.dispose();
  }
}
