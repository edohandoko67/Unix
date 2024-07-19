import 'package:get_storage/get_storage.dart';

class Storage {
  final GetStorage _storage = GetStorage();

  void saveName(String name) => _storage.write("name", name);
  void login() => _storage.write("isLoggedIn", true);
  void logout() => _storage.write('isLoggedIn', false);

  bool isLogin() => _storage.read<bool>("isLoggedIn") ?? false;
  String? getName() => _storage.read<String>("name");


}

