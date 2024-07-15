import 'package:get_storage/get_storage.dart';

class Storage {
  final GetStorage _storage = GetStorage();

  void saveName(String name) => _storage.write("name", name);
}

