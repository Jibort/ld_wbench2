// Servei d'accés al registre xifrat de dades del dispositiu.
// CreatedAt: 2025/02/14 dv. GPT[JIQ]

import 'package:ld_wbench2/core/ld_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LdSecureStorageService extends LdService {
// ESTÀTICS -------------------------
static LdSecureStorageService inst = LdSecureStorageService();
static const className = "LdSecureStorageService";

  // MEMBRES --------------------------
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

// CONSTRUCTORS ---------------------
  LdSecureStorageService(): super(pTag: className);

  Future<LdSecureStorageService> init() async {
    // _storage = const FlutterSecureStorage();
    return this;
  }

  // 🔹 Escriure i llegir Strings
  Future<void> writeString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readString(String key) async {
    return await _storage.read(key: key);
  }

  // 🔹 Escriure i llegir Int
  Future<void> writeInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<int?> readInt(String key) async {
    String? value = await _storage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  // 🔹 Escriure i llegir Double
  Future<void> writeDouble(String key, double value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<double?> readDouble(String key) async {
    String? value = await _storage.read(key: key);
    return value != null ? double.tryParse(value) : null;
  }

  // 🔹 Escriure i llegir Bool
  Future<void> writeBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<bool?> readBool(String key) async {
    String? value = await _storage.read(key: key);
    return value != null ? value.toLowerCase() == 'true' : null;
  }

  // 🔹 Escriure i llegir DateTime
  Future<void> writeDateTime(String key, DateTime value) async {
    await _storage.write(key: key, value: value.toIso8601String());
  }

  Future<DateTime?> readDateTime(String key) async {
    String? value = await _storage.read(key: key);
    return value != null ? DateTime.tryParse(value) : null;
  }

  // 🔹 Eliminar una clau
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // 🔹 Esborrar tot
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
