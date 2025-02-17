// Servei de base de dades segura de l'aplicació.
// CreatedAt: 2025/02/14 dv. GPT[JIQ]

import 'package:ld_wbench2/core/ld_service.dart';

class LdDatabaseService extends LdService {
  // ESTÀTICS -------------------------
  static const className = "LdDatabaseService";

  // CONSTRUCTORS ---------------------
  LdDatabaseService(): super(pTag: className);

  Future<LdDatabaseService> init() async {
    return this;
  }
}