import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class AddHistoryPage extends StatelessWidget {
  const AddHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Tambah baru'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("Tanggal", style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text('2022-01-01'),
              DView.spaceWidth(),
              ElevatedButton.icon(
                label: Text("Pilih"),
                onPressed: () {},
                icon: Icon(Icons.event),
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
            onChanged: (value) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          DView.spaceHeight(16),
          DInput(
            controller: TextEditingController(),
            hint: 'Jualan',
            title: 'Sumber/Objek Pengeluaran',
          ),
          DView.spaceHeight(16),
          DInput(
            controller: TextEditingController(),
            hint: '30000',
            title: 'Harga',
            inputType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
