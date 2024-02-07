import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:money_record/config/app_color.dart';

class IncomeOutcomePage extends StatelessWidget {
  const IncomeOutcomePage({Key? key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(type),
            Expanded(
                child: Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                onTap: () {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: AppColor.chart.withOpacity(0.5),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    hintText: "2024-08-40"),
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: Colors.white),
              ),
            ))
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.fromLTRB(
              16,
              index == 0 ? 16 : 8,
              16,
              index == 9 ? 16 : 8,
            ),
            child: Row(
              children: [
                DView.spaceWidth(),
                Text(
                  "29 Juni 2024",
                  style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Expanded(
                    child: Text(
                  "Rp 2000.000",
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.end,
                )),
                PopupMenuButton(
                  itemBuilder: (context) => [],
                  onSelected: (value) {},
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
