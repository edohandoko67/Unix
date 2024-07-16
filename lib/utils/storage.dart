import 'package:get_storage/get_storage.dart';

class Storage {
  final GetStorage _storage = GetStorage();

  void saveName(String name) => _storage.write("name", name);
  void login() => _storage.write("isLoggedIn", true);

  bool isLogin() => _storage.read<bool>("isLoggedIn") ?? false;
  String? getName() => _storage.read<String>("name");


}

