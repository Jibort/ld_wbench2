// Classe per a la gestió de cues LiFo.
// createdAt: 2025/02/13 dj. JIQ

class LiFo<T> {
  // 🧩 MEMBRES --------------------------
  final List<T> _list = <T>[];
  final int _maxLength;

  // 🛠️ CONSTRUCTORS ---------------------
  LiFo({int? pMaxLength}): _maxLength = (pMaxLength?? -1);

  // GETTERS i SETTERS ----------------
  int get length => _list.length;
  List<T> get list => _list.toList(growable: false);

  // GESTIÓ DE LA CUA -----------------
  T? push(T pItem) {
    T? res;

    _list.add(pItem);
    if (length > _maxLength && length != -1) { 
      res = heap();
    }
    return res;

  }

  T? pop() => (_list.isEmpty) ? null : _list.removeLast();
  T? peek() => (_list.isEmpty) ? null : _list.last;

  void sneak(T pItem) => _list.insert(0, pItem);
  T? heap() => _list.removeAt(0);

  bool remove(T pItem) {
    bool exists = _list.contains(pItem);
    if (exists) { _list.remove(pItem); }
    return exists;
  }
  void clear() {
    _list.clear();
  }
}
