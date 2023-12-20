import 'package:teste_agtech/domain/models/equipment.dart';

abstract class DaoWorkflow {
  getSavedEquipments() {}

  Future<void> addEquipment({required Equipment equipment});

  Future<void> updateEquipment({required Equipment equipment});

  Future<void> removeEquipment({required Equipment equipment});
}
