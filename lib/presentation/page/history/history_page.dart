import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app.format.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/data/model/history.dart';
import 'package:money_record/data/source/source_history.dart';
import 'package:money_record/presentation/controller/c_user.dart';
import 'package:money_record/presentation/controller/history/c_history.dart';
import 'package:money_record/presentation/controller/history/c_income_outcome.dart';
import 'package:money_record/presentation/page/history/detail_history_page.dart';
import 'package:money_record/presentation/page/history/update_hisory_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final cHistory = Get.put(CHistory());
  final cUser = Get.put(CUser());
  final controllerSearch = TextEditingController();

  refresh() {
    cHistory.getList(cUser.data.idUser);
  }

  delete(String id_history) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Hapus?', 'Kamu yakin ingin menghapusnya?',
        textNo: 'Batal', textYes: "ya");
    if (yes == true) {
      bool success = await SourceHistory.delete(id_history);
      if (success) refresh();
    } else {}
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Text("Riwayat"),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.all(16),
                child: TextField(
                  controller: controllerSearch,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (result != null) {
                      controllerSearch.text =
                          DateFormat('yyyy-MM-dd').format(result);
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColor.chart.withOpacity(0.5),
                    suffixIcon: IconButton(
                      onPressed: () {
                        cHistory.search(
                          cUser.data.idUser,
                          controllerSearch.text,
                        );
                      },
                      icon: const Icon(Icons.search, color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    hintText: '2022-06-01',
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<CHistory>(builder: (_) {
        if (_.loading) return DView.loadingCircle();
        if (_.list.isEmpty) return DView.empty('Kosong');
        return RefreshIndicator(
          onRefresh: () async => refresh(),
          child: ListView.builder(
            itemCount: _.list.length,
            itemBuilder: (context, index) {
              History history = _.list[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.fromLTRB(
                  16,
                  index == 0 ? 16 : 8,
                  16,
                  index == _.list.length - 1 ? 16 : 8,
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(() => DetailHistoryPage(
                          date: history.date,
                          idUser: cUser.data.idUser,
                          Type: history.type,
                        ));
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Row(
                    children: [
                      DView.spaceWidth(),
                      history.type == 'Pemasukan'
                          ? Icon(
                              Icons.south_west,
                              color: Colors.green[300],
                            )
                          : Icon(
                              Icons.north_east,
                              color: Colors.red[300],
                            ),
                      Text(
                        Appformat.date(history.date!),
                        style: const TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Appformat.currency(history.total!),
                          style: const TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      IconButton(
                          onPressed: () => delete(history.idHistory!),
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.red[300],
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
