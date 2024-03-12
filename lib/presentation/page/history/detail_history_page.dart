import 'dart:convert';

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app.format.dart';
import 'package:money_record/config/app_color.dart';

import '../../controller/c_user.dart';
import '../../controller/history/c_detail_history.dart';

class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage(
      {super.key,
      required this.date,
      required this.idUser,
      required this.Type});
  final idUser;
  final date;
  final Type;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final cDetailHistory = Get.put(CDetailHistory());

  @override
  void initState() {
    cDetailHistory.getData(widget.idUser, widget.date, widget.Type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Obx(() {
          return Text(cDetailHistory.data.date!);
        }),
        actions: [
          Icon(
            Icons.south_west,
            color: Colors.green,
          )
        ],
      ),
      body: GetBuilder<CDetailHistory>(builder: (_) {
        if (_.data.date == null) {
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
          if (widget.date == today && widget.Type == 'Pengeluaran') {
            return DView.empty('Belum Ada Pengeluaran');
          }
          DView.nothing();
        }
        List details = jsonDecode(_.data.details!);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total",
              style: TextStyle(
                  color: AppColor.primary.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            DView.spaceHeight(8),
            Text(
              Appformat.currency(_.data.total!),
              style: TextStyle(
                  color: AppColor.primary.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            DView.spaceHeight(20),
            Center(
              child: Container(
                height: 5,
                width: 100,
                decoration: BoxDecoration(
                    color: AppColor.bg,
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            DView.spaceHeight(20),
            Expanded(
                child: ListView.separated(
              itemCount: details.length,
              separatorBuilder: (context, index) => Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Colors.grey,
                  thickness: 0.5),
              itemBuilder: (context, index) {
                Map item = details[index];
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        "${index + 1}.",
                        style: TextStyle(fontSize: 20),
                      ),
                      DView.spaceWidth(8),
                      Expanded(
                          child: Text(
                        item['name'],
                        style: TextStyle(fontSize: 20),
                      )),
                      Text(
                        Appformat.currency(item['price']),
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
            ))
          ],
        );
      }),
    );
  }
}
