// Servei d'autenticació segura d'usuaris de l'aplicació.
// CreatedAt: 2025/02/14 dv. GPT[JIQ]

import 'package:ld_wbench2/core/ld_service.dart';


class LdAuthService extends LdService {
  // ESTÀTICS -------------------------
  static const className = "LdDatabaseService";

  // VARIABLES ------------------------
  // late final LdAuthService _auth;

  // 🛠️ CONSTRUCTORS ---------------------
  LdAuthService(): super(pTag: className);

  Future<LdAuthService> init() async {
    return this;
  }
}