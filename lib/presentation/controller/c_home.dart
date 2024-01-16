import 'package:get/get.dart';
import 'package:money_record/data/source/source_history.dart';

class CHome extends GetxController {
  final _today = 0.0.obs;
  double get today => _today.value;

  final _todayPercent = '0'.obs;
  String get todayPercent => _todayPercent.value;

  final _week = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ].obs;
  List<double> get week => _week.value;

  List<String> get days => ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
  List<String> weekText() {
    DateTime today = DateTime.now();
    return [
      days[today.subtract(Duration(days: 6)).weekday - 1],
      days[today.subtract(Duration(days: 5)).weekday - 1],
      days[today.subtract(Duration(days: 4)).weekday - 1],
      days[today.subtract(Duration(days: 3)).weekday - 1],
      days[today.subtract(Duration(days: 2)).weekday - 1],
      days[today.subtract(Duration(days: 1)).weekday - 1],
      days[today.weekday - 1],
    ];
  }

  getAnalysis(String idUser) async {
    Map data = await SourceHistory.analysis(idUser);
    _today.value = data['today'];
    double yesterday = data['yesterday'];
    double different = (today - yesterday).abs();
    bool isSame = today.isEqual(yesterday);
    bool isPlus = today.isGreaterThan(yesterday);
    double byYesterday = yesterday == 0 ? 1 : yesterday;
    double percent = (different / byYesterday) * 100;
    _todayPercent.value = isSame
        ? '100% sama dengan kemarin'
        : isPlus
            ? '+${percent.toStringAsFixed(1)}% di banding kemarin'
            : '-${percent.toStringAsFixed(1)}% di banding kemarin';

    _week.value = data['yesterday'].map((e) => e.toDouble()).toList();
  }
}
