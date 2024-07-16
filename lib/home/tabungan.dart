import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import 'home.controller.dart';

class Tabungan extends StatefulWidget {
  Tabungan({super.key});

  @override
  State<Tabungan> createState() => _TabunganState();

}

class _TabunganState extends State<Tabungan> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<QuerySnapshot<Object?>>(
          future: homeController.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data!.docs);
              final item = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    final doc = item[index];
                    //konversi Map<String, dynamic>
                    final data = doc.data() as Map<String, dynamic>;

                    final userId = data['userId'] ?? 'No User ID';
                    final name = data['name'] ?? 'No Name';
                    final money = data['money']?.toString() ?? '0.0';
                    final createDate = data['createAt'] as Timestamp;
                    final date = createDate != null
                        ? DateFormat('yyyy-MM-dd').format(createDate.toDate())
                        : 'No Date';
                    return ListTile(
                      title: Text(name),
                      subtitle: Text(money),
                      trailing: Text(date),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator(),);
          });
  }
}
