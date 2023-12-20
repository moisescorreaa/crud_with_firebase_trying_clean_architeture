// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teste_agtech/domain/business/dao_workflow.dart';
import 'package:teste_agtech/domain/models/equipment.dart';

class DaoController implements DaoWorkflow {
  FirebaseFirestore database = FirebaseFirestore.instance;

  CollectionReference equipmentsDatabase =
      FirebaseFirestore.instance.collection('equipment');

  @override
  Future<void> addEquipment({required Equipment equipment}) {
    return equipmentsDatabase
        .add({
          'name': equipment.name,
        })
        .then((value) => print("Equipment Added"))
        .catchError((error) => print("Failed to add equipment: $error"));
  }

  @override
  Future<void> removeEquipment({required Equipment equipment}) {
    return equipmentsDatabase
        .doc(equipment.id)
        .delete()
        .then((value) => print("Equipment Deleted ${equipment.id}"))
        .catchError((error) => print("Failed to delete equipment: $error"));
  }

  @override
  getSavedEquipments() {
    Stream<QuerySnapshot> equipmentsStream =
        FirebaseFirestore.instance.collection('equipment').snapshots();
    return equipmentsStream;
  }

  @override
  Future<void> updateEquipment({required Equipment equipment}) {
    return equipmentsDatabase
        .doc(equipment.id)
        .update({'name': equipment.name})
        .then((value) => print("Equipment Updated"))
        .catchError((error) => print("Failed to update equipment: $error"));
  }
}
