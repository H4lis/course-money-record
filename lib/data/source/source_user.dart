import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:money_record/config/app_request.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/data/model/user.dart';

import '../../config/api.dart';

class SourceUser {
  static Future<bool> login(String email, String password) async {
    String url = '${Api.user}/login.php';
    Map? responseBody = await AppRequest.post(url, {
      'email': email,
      'password': password,
    });
    if (responseBody == null) return false;
    if (responseBody['success']) {
      var mapUser = responseBody['data'];
      Session.saveUser(User.fromJson(mapUser));
    }
    return responseBody['success'];
  }

  static Future<bool> register(
      String name, String email, String password, BuildContext context) async {
    String url = '${Api.user}/register.php';
    Map? responseBody = await AppRequest.post(url, {
      'name': name,
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
    print("=========   kopii    ==========");
    print(responseBody);
    print("=========   jjjjjjjjjjjjjjjjjjjjjjj    ==========");

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess(context, "Berhasil Register");
      DInfo.closeDialog(context);
    } else {
      print("===================");
      print("masukji");
      print("===================");
      print(responseBody);
      print("===================");
      if (responseBody['message'] == 'email') {
        DInfo.dialogError(context, "Email Sudah Terdaftar");
      } else {
        DInfo.dialogError(context, "Gagal Register");
      }
      DInfo.closeDialog(context);
    }
    return responseBody['success'];
  }
}
