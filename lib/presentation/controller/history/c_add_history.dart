import 'package:get/get.dart';

class CAddHistory extends GetxController {
  final _date = ''.obs;
  String get date => _date.value;
  setDate(n) => _date.value;

  final _type = 'Pemasukan'.obs;
  String get type => _type.value;
  settype(n) => _date.value;

  final _items = [].obs;
  List get items => _items.value;
  addItem(n) {
    _items.value.add(n);
    update();
  }

  deleteItem(i) {
    _items.value.removeAt(i);
    update();
  }

  final _total = 0.0.obs;
  double get total => _total.value;
  setTotal(n) {
    _total.value = n;
  }

  count() {
    items
        .map((e) => e['price'])
        .toList()
        .fold<double>(0.0, (previousValue, element) => previousValue + element);
  }
}
