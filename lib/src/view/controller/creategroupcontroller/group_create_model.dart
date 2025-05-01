import 'dart:convert';

import 'package:ayuuto_savings_app/core/api_path.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../model/firebase/firebase_service.dart';
import '../user_Id_Controller.dart';
class GroupCreateController extends GetxController{
 final FirebaseService _firebaseService = FirebaseService();


 bool isLoading = true;
  Future<void> groupCreate({
    required String adminUserId,
    required String groupName,
    required int contributionAmount,
    required String frequency,
    required int maxMembers,
    required String description,
    required BuildContext context
  }) async{
    isLoading = true;
    final url  = Uri.http(ApiPath.groupCreateUrl);

    final body = jsonEncode({
      "adminUserId": adminUserId,
      "groupName": groupName,
      "contributionAmount": contributionAmount,
      "frequency": frequency,
      "maxMembers": maxMembers,
      "description": description
    } );

    try{
       final response = await http.post(
         url,
         headers: {'content-type': 'application/json'},
         body: body,
       );
         if(response == 200 || response == 201 ){
           showSnackBarMessage(context, "Group create successfully");
         }else{
           showSnackBarMessage(context, "Group create failed ${response.body}");
         }

    }catch(e){
      showSnackBarMessage(context, "Group create failed ${e}");
    }finally{
      isLoading = true;
    }
  }
}