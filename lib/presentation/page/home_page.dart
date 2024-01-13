import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/presentation/controller/c_user.dart';
import 'package:money_record/presentation/page/auth/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(AppAsset.profile),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                cUser.data.name ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Obx(
                              () => Text(
                                cUser.data.email ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Session.clearUser();
                      Get.off(() => LoginPage());
                    },
                    child: Text("Logout"),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: AppColor.primary),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.add),
              horizontalTitleGap: 0,
              title: Text("Tambah Baru"),
              trailing: Icon(Icons.navigate_next),
            ),
            Divider(height: 2),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.south_west),
              horizontalTitleGap: 0,
              title: Text("Pemasukan"),
              trailing: Icon(Icons.navigate_next),
            ),
            Divider(height: 2),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.north_east),
              horizontalTitleGap: 0,
              title: Text("Pengeluaran"),
              trailing: Icon(Icons.navigate_next),
            ),
            Divider(height: 2),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.history),
              horizontalTitleGap: 0,
              title: Text("Riwayat"),
              trailing: Icon(Icons.navigate_next),
            ),
            Divider(height: 2),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.add),
              horizontalTitleGap: 0,
              title: Text(" Tambah Baru"),
              trailing: Icon(Icons.navigate_next),
            ),
            Divider(height: 2),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Row(
              children: [
                Image.asset(AppAsset.profile),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi,",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Obx(
                      () => Text(
                        cUser.data.name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Builder(builder: (ctx) {
                  return Material(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.chart,
                    child: SizedBox(
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(ctx).openEndDrawer();
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.menu,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
            children: [
              Text(
                "Pengeluaran Hari Ini",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              DView.spaceHeight(),
              cardToday(context),
              DView.spaceHeight(30),
              Center(
                child: Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                      color: AppColor.chart,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              DView.spaceHeight(30),
              Text(
                "Pengeluaran Minggu Ini",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              DView.spaceHeight(),
              weekly(),
              DView.spaceHeight(30),
              Text(
                "Pengeluaran Bulan Ini",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              DView.spaceHeight(),
              monthly(context),
            ],
          ))
        ],
      ),
    );
  }

  AspectRatio weekly() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartBarO(
        groupList: [
          OrdinalGroup(
            id: '1',
            data: [
              OrdinalData(domain: 'Mon', measure: 2),
              OrdinalData(domain: 'Tue', measure: 6),
              OrdinalData(domain: 'Wed', measure: 3),
              OrdinalData(domain: 'Thu', measure: 7),
            ],
          ),
        ],
      ),
    );
  }

  Row monthly(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Stack(
            children: [
              DChartPieO(
                data: [
                  OrdinalData(domain: 'Mon', measure: 2),
                  OrdinalData(domain: 'Tue', measure: 6),
                ],
                configRenderPie: ConfigRenderPie(
                  arcWidth: 30,
                ),
              ),
              Center(
                  child: Text(
                "60%",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: AppColor.primary),
              ))
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  color: AppColor.primary,
                ),
                DView.spaceWidth(8),
                Text("Pemasukan")
              ],
            ),
            DView.spaceHeight(8),
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  color: AppColor.chart,
                ),
                DView.spaceWidth(8),
                Text("Pengeluaran")
              ],
            ),
            DView.spaceHeight(20),
            Text("Pemasukan"),
            Text("Lebih besar 20%"),
            Text("dari pengeluaran"),
            DView.spaceHeight(10),
            Text("Atau setara:"),
            Text(
              "Rp 20.0000,00",
              style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }

  Material cardToday(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      color: AppColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Text(
              "Rp.500.000,00",
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondary,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Text(
              "+20% dibanding kemarin",
              style: TextStyle(
                color: AppColor.bg,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 0, 16),
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Selengkapnya',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.navigate_next, color: AppColor.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
