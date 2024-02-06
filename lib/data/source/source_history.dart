import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/api.dart';
import '../../config/app_request.dart';

class SourceHistory {
  static Future<Map> analysis(String idUser) async {
    try {
      String url = '${Api.history}/analysis.php';
      Map? responseBody = await AppRequest.post(url, {
        'id_user': idUser,
        'today': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      });

      if (responseBody == null || responseBody.isEmpty) {
        // Handle the case where responseBody is null or empty
        return {
          'today': 0.0,
          'yesterday': 0.0,                                                              
          'week': [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
          'month': {
            'income': 0.0,
            'outcome': 0.0,
          }
        };
      }

      return responseBody;
    } catch (error) {
      print("Error in analysis: $error");
      return {
        'today': 0.0,
        'yesterday': 0.0,
        'week': [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        'month': {
          'income': 0.0,
          'outcome': 0.0,
        }
      };
    }
  }

  static Future<bool> add(String idUser, String date, String type,
      String details, String total, BuildContext context) async {
    String url = '${Api.history}/add.php';
    Map? responseBody = await AppRequest.post(
      url,
      {
        'id_user': idUser,
        'date': date,
        'type': type,
        'details': details,
        'total': total,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
    );

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess(context, "Berhasil Tambah History");
      DInfo.closeDialog(context);
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.dialogError(
            context, "history dengan tanggal tersebut sudah perbah dibuat");
      } else {
        DInfo.dialogError(context, "Gagal Tambah History");
      }
      DInfo.closeDialog(context);
    }
    return responseBody['success'];
  }
}
