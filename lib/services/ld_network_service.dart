// Servei de coumunicacion segures de l'aplicació.
// CreatedAt: 2025/02/14 dv. GPT[JIQ]

import 'package:ld_wbench2/core/ld_service.dart';

class LdNetworkService extends LdService {
  // ESTÀTICS -------------------------
  static const className = "LdNetworkService";

  // VARIABLES ------------------------
  late final LdNetworkService _network;

  Future<LdNetworkService> init() async {
    var _ = _network;
    return this;
  }
}