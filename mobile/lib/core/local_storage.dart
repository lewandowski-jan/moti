import 'package:hive/hive.dart';
import 'package:moti/core/storable.dart';

typedef FromJson<T> = T Function(Json json);
typedef Json = Map<dynamic, dynamic>;

class LocalStorage {
  LocalStorage._({required Box<Json> box}) : _box = box;

  final Box<Json> _box;

  static Future<LocalStorage> init({required String id}) async {
    final box = await Hive.openBox<Json>(id);
    return LocalStorage._(box: box);
  }

  Future<void> add(IStorable value, [String? key]) async {
    if (key != null) {
      return _box.put(key, value.toJson());
    }

    await _box.add(value.toJson());
  }

  T? get<T>(String key, FromJson<T> fromJson) {
    final json = _box.get(key);
    if (json != null) {
      return fromJson(json);
    }

    return null;
  }

  Map<int, T> getAllWithKeys<T>(FromJson<T> fromJson) {
    return _box.toMap().map((key, value) {
      return MapEntry(key, fromJson(value));
    });
  }

  Future<void> update(int key, IStorable value) async {
    return _box.put(key, value.toJson());
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
