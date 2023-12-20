import 'package:flutter/material.dart';
import 'package:teste_agtech/controller/dao_controller.dart';

import '../domain/models/equipment.dart';

class UpdateScreen extends StatefulWidget {
  final String document;

  const UpdateScreen({super.key, required this.document});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController nameController = TextEditingController();
  DaoController daoController = DaoController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Update"),
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
                    daoController.updateEquipment(
                        equipment: Equipment(
                            id: widget.document, name: nameController.text));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Updated')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Write an equipment')));
                  }
                },
                child: const Text("Update Equipment"))
          ],
        ),
      ),
    ));
  }
}
