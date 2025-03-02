// Classe per a la gestió de cues FiFo.
// createdAt: 25/02/15 ds. JIQ

// ignore_for_file: unused_field

class FiFo<T> {
  // 🧩 MEMBRES --------------------------
  final List<T> _list = <T>[];
  
  // 🛠️ CONSTRUCTORS ---------------------
  FiFo();

  // GETTERS i SETTERS ----------------
  int get length => _list.length;
  List<T> get list => _list.toList(growable: false);

  // GESTIÓ DE LA CUA -----------------
  void push(T pItem) => _list.add(pItem);
  T? pop() => (_list.isEmpty) ? null : _list.removeAt(0);
  T? peek() => (_list.isEmpty) ? null : _list[0];

  void sneak(T pItem) => _list.insert(0, pItem);
  T? heap() => _list.removeLast();

  void clear() {
    _list.clear();
  }
}
