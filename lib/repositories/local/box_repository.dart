import 'package:hive/hive.dart';

import '../../models/surah.dart';

class BoxRepository<T> {
  late Box<T> _box;

  BoxRepository(String boxName) {
    _box = Hive.box<T>(boxName);
    print("BoxRepository<$T> initialized: ${box.values.length}");
  }

  Box<T> get box => _box;

  void add(T surah) => _box.add(surah);

  Future<void> addAll(List<T> list) async => await _box.addAll(list);

  List<T> getAll() {
    final list = _box.values.toList();
    print("<$T> in box: ${list.length}");
    return list;
  }

  void removeAll() => _box.clear();

  // destructor
  void close() => _box.close();
}
