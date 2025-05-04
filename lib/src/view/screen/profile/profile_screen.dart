import 'package:ayuuto_savings_app/src/model/firebase/firebase_service.dart';
import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/profile/widget/payment_method_Section.dart';
import 'package:ayuuto_savings_app/src/view/screen/profile/widget/profile_header.dart';
import 'package:ayuuto_savings_app/src/view/screen/profile/widget/profile_info_card_widget.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = "John Doe";
  String email = "example@gmail.com";
  String phoneNumber = "+880123456789";

  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "profile".tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeaderCard(
              fullName: fullName,
              email: email,
              imageUrl:
                  'https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
            const SizedBox(height: 30),
            Text(
              'acount_information'.tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 10),
            _buildInfoTile(
              icon: Icons.person_outline,
              title: 'full_name'.tr,
              value: fullName,
              onEdit: () => _editField("Full Name", fullName, (newValue) {
                setState(() {
                  fullName = newValue;
                });
              }),
            ),
            _buildDivider(),
            _buildInfoTile(
              icon: Icons.email_outlined,
              title: 'email'.tr,
              value: email,
              onEdit: () => _editField("Email", email, (newValue) {
                setState(() {
                  email = newValue;
                });
              }),
            ),
            _buildDivider(),
            _buildInfoTile(
              icon: Icons.phone_outlined,
              title: 'phone_number'.tr,
              value: phoneNumber,
              onEdit: () => _editField("Phone Number", phoneNumber, (newValue) {
                setState(() {
                  phoneNumber = newValue;
                });
              }),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ProfileInfoCard(
                    title: 'group_joined'.tr,
                    count: "2",
                    icon: Icons.group_add_outlined,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ProfileInfoCard(
                    title: 'total_pay'.tr,
                    count: "\$200",
                    icon: Icons.group_add_outlined,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            PaymentMethodSection(),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.white),
              onPressed: () {
                _firebaseService.logOutUser();
                Get.back();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
                  Text(
                    'logout'.tr,
                    style: TextStyle(color: Colors.redAccent),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onEdit,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(
        value,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
      ),
      trailing: Icon(Icons.edit, color: Colors.grey),
      onTap: onEdit,
    );
  }

  Widget _buildDivider() {
    return const Divider();
  }

  void _editField(String title, String currentValue, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          "Edit $title",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter $title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onSave(controller.text.trim());
                Navigator.pop(context);
              } else {
                showSnackBarMessage(context, "Field cannot be empty!");
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
