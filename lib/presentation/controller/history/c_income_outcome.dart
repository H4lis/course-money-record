import 'package:get/get.dart';
import 'package:money_record/data/model/history.dart';
import 'package:money_record/data/source/source_history.dart';

class CIncomeOutcome extends GetxController {
  final _list = <History>[].obs;
  List<History> get list => _list.value;

  getList(idUser, type) async {
    _list.value = await SourceHistory.incomeOutcome(idUser, type);
    update();
  }
}
