import 'dart:convert';
import 'package:ayuuto_savings_app/core/api_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../model/get_group_model/get_group_model.dart';

class ActiveServiceController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  var isLoading = false.obs;
  var groups = <GetGroupModel>[].obs;
  var isActiveGroupSelected = true.obs;

  late String adminUserId;

  @override
  void onInit() {
    super.onInit();

    adminUserId = _auth.currentUser!.uid;
  }


  List<GetGroupModel> get activeGroups =>
      groups.where((group) => group.status.toLowerCase() != "completed").toList();

  List<GetGroupModel> get completedGroups =>
      groups.where((group) => group.status.toLowerCase() == "completed").toList();



  void toggleGroupView(bool isActive) {
    isActiveGroupSelected.value = isActive;
  }

  Future<void> fetchGroups() async {
    try {
      isLoading.value = true;

      Map<String, dynamic> requestBody = {
        'userId': adminUserId,
      };

      final response = await http.post(
        Uri.parse(ApiPath.activeFetchUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        print("Response Body: ${response.body}");

        List<dynamic> groupJsonList = data["data"]["group"];

        if (groupJsonList != null) {
          groups.value = groupJsonList.map((groupJson) {
            return GetGroupModel.fromJson(groupJson);
          }).toList();
        } else {
          throw Exception("No groups found in the response.");
        }
      } else {
        throw Exception("Failed to load groups. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching groups: $e");
      throw Exception('Error fetching groups: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
