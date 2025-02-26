// Classe per a la gestió de cues LiFo amb gestió de mapa.
// createdAt: 2025/02/13 dj. GPT

class LiFoMap<T> {
  final Map<String, T> _map = {};
  final List<T> _list = <T>[];
  final int _maxLength;

  LiFoMap({int? pMaxLength}) : _maxLength = (pMaxLength ?? -1);

  int get length => _list.length;
  List<T> get list => List.unmodifiable(_list);

  T? push(String key, T pItem) {
    T? res;
    _map[key] = pItem;
    _list.add(pItem);
    if (_maxLength > 0 && length > _maxLength) {
      res = heap();
    }
    return res;
  }

  T? pop() => (_list.isEmpty) ? null : _list.removeLast();
  T? peek() => (_list.isEmpty) ? null : _list.last;
  void sneak(T pItem) => _list.insert(0, pItem);
  T? heap() {
    if (_list.isNotEmpty) {
      T item = _list.removeAt(0);
      _map.removeWhere((key, value) => value == item);
      return item;
    }
    return null;
  }

  bool remove(String pTag) {
    return (contains(pTag))
      ? (_map.remove(pTag) != null)
      : false;
  }

  void clear() {
    _map.clear();
    _list.clear();
  }

  T? find(String key) => _map[key];

  bool contains(String pTag) => _map.containsKey(pTag);
}
