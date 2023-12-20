import 'package:teste_agtech/domain/models/equipment.dart';

abstract class EquipmentDao {
  Future<List<Equipment>> getAllEquipments();

  Future<void> addEquipments();

  Future<void> updateEquipments();

  Future<void> removeEquipments();
}
