import 'package:intl/intl.dart';

import '../../config/api.dart';
import '../../config/app_request.dart';
import '../../config/session.dart';
import '../model/user.dart';

class SourceHistory {
  static Future<Map> login(String idUser, String password) async {
    String url = '${Api.user}/analysis.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'today': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    });
    if (responseBody == null) return {};
    return responseBody['success'];
  }
}
