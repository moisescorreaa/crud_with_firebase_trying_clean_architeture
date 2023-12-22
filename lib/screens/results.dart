import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste_agtech/controller/dao_controller.dart';
import 'package:teste_agtech/domain/models/equipment.dart';
import 'package:teste_agtech/screens/add.dart';
import 'package:teste_agtech/screens/update.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  DaoController daoController = DaoController();
  Equipment? equipment;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Equipments'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: daoController.getSavedEquipments(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            if (snapshot.hasData) {
              return Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Center(
                              child: TextButton(
                            child: Text(data['name']),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateScreen(
                                          document: document.id,
                                        )),
                              );
                            },
                          )),
                        ),
                        Flexible(
                            flex: 1,
                            child: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                daoController.removeEquipment(
                                    equipment: Equipment(id: document.id));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Deleted')));
                              },
                            ))
                      ],
                    ));
              }).toList());
            }
            return const Text('Error');
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
