import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app.format.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/presentation/controller/history/c_add_history.dart';

class AddHistoryPage extends StatelessWidget {
  const AddHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cAddHistory = Get.put(CAddHistory());
    final contorollerName = TextEditingController();
    final contorollerPrice = TextEditingController();
    return Scaffold(
      appBar: DView.appBarLeft('Tambah baru'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("Tanggal", style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Obx(() {
                return Text(cAddHistory.date);
              }),
              DView.spaceWidth(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                label: Text(
                  "Pilih",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1));
                  if (result != null) {
                    cAddHistory
                        .setDate(DateFormat('yyyy-MM-dd').format(result));
                  }
                },
                icon: Icon(
                  Icons.event,
                  color: Colors.white,
                ),
              )
            ],
          ),
          DView.spaceHeight(),
          Text("Tipe", style: const TextStyle(fontWeight: FontWeight.bold)),
          DView.spaceHeight(8),
          DropdownButtonFormField<String>(
            value: 'Pemasukan',
            items: ['Pemasukan', 'Pengeluaran'].map((e) {
              return DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              );
            }).toList(),
            onChanged: (value) {
              cAddHistory.settype(value);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          DView.spaceHeight(16),
          DInput(
            controller: contorollerName,
            hint: 'Jualan',
            title: 'Sumber/Objek Pengeluaran',
          ),
          DView.spaceHeight(16),
          DInput(
            controller: contorollerPrice,
            hint: '30000',
            title: 'Harga',
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),
          ElevatedButton(
            onPressed: () {
              cAddHistory.addItem({
                'name': contorollerName.text,
                'price': contorollerPrice.text,
              });
              contorollerName.clear();
              contorollerPrice.clear();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: Text(
              "Tambah Ke Items",
              style: TextStyle(color: Colors.white),
            ),
          ),
          DView.spaceHeight(),
          Center(
            child: Container(
              height: 4,
              width: 80,
              decoration: BoxDecoration(
                color: AppColor.bg,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          DView.spaceHeight(),
          Text("Items", style: const TextStyle(fontWeight: FontWeight.bold)),
          DView.spaceHeight(4),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4)),
            child: GetBuilder<CAddHistory>(builder: (_) {
              return Wrap(
                runSpacing: 8,
                spacing: 8,
                children: List.generate(
                    _.items.length,
                    (index) => Chip(
                          label: Text(
                            cAddHistory.items[index]['name'],
                          ),
                          deleteIcon: Icon(Icons.clear),
                          onDeleted: () {},
                        )),
              );
            }),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              Text("Total:",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              DView.spaceWidth(8),
              Text(
                Appformat.currency('300000'),
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.primary),
              ),
            ],
          ),
          DView.spaceHeight(30),
          Material(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                    child: Text(
                  'SUBMIT',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
