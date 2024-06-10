import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_if22c/config/asset.dart';

import '../../config/asset.dart';
import '../../event/event_db.dart';
import '../../model/mahasiswa.dart';
import 'add_update_mahasiswa.dart';

class ListMahasiswa extends StatefulWidget {
  const ListMahasiswa({super.key});

  @override
  State<ListMahasiswa> createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  List<Mahasiswa> _listMahasiswa = [];

  void getMahasiswa() async {
    _listMahasiswa = await EventDb.getMahasiswa();
    setState(() {});
  }

  @override
  void initState() {
    getMahasiswa();
    super.initState();
  }

  void showOption(Mahasiswa? mahasiswa) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'update'),
              title: Text('Update'),
            ),
            ListTile(
              onTap: () => Get.back(result: 'delete'),
              title: Text('Delete'),
            ),
            ListTile(
              onTap: () => Get.back(),
              title: Text('Close'),
            )
          ],
        ),
        barrierDismissible: false);
    switch (result) {
      case 'update':
        Get.to(AddUpdateMahasiswa(mahasiswa: mahasiswa))
            ?.then((value) => getMahasiswa());
        break;
      case 'delete':
        EventDb.deleteMahasiswa(mahasiswa!.npm!)
            .then((value) => getMahasiswa());
        break;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Mahasiswa"),
        backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          _listMahasiswa.length > 0
              ? ListView.builder(
                  itemCount: _listMahasiswa.length,
                  itemBuilder: (context, index) {
                    Mahasiswa mahasiswa = _listMahasiswa[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(mahasiswa.nama ?? ''),
                      subtitle: Text(mahasiswa.npm ?? ''),
                      trailing: IconButton(
                          onPressed: () {
                            showOption(mahasiswa);
                          },
                          icon: Icon(Icons.more_vert)),
                    );
                  },
                )
              : Center(
                  child: Text("Data Kosong"),
                ),
          Positioned(
            child: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Asset.colorPrimaryDark,
              onPressed: () {
                Get.to(AddUpdateMahasiswa())?.then((value) => getMahasiswa());
              },
            ),
            bottom: 16,
            right: 16,
          )
        ],
      ),
    );
  }
}
