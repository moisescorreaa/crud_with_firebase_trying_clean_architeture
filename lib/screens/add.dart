// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teste_agtech/controller/dao_controller.dart';
import 'package:teste_agtech/domain/models/equipment.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});

  TextEditingController nameController = TextEditingController();
  DaoController daoController = DaoController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    daoController.addEquipment(
                        equipment: Equipment(name: nameController.text));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Added')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Write an equipment')));
                  }
                },
                child: const Text("Add Equipment"))
          ],
        ),
      ),
    ));
  }
}
