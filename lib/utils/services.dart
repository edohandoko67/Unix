import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wallfram/model/cars.dart';
import 'package:wallfram/utils/dio.client.dart';

class ApiService {
  final DioClient dio = DioClient();

  Future<List<Cars>> fetchCars() async {
    EasyLoading.show(
      status: 'mohon tunggu...',
      maskType: EasyLoadingMaskType.black,
    );
    try {
      final response = await dio.dio.get('https://mocki.io/v1/e5092fdb-acbf-4631-a10d-389e62639a7b');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print('response data : ${response.data}');
        return data.map((json) => Cars.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      print('Failed to load cars: $e');
      print('stackTrace: $stackTrace');
      return [];
    } finally {
      EasyLoading.dismiss();
    }
  }
}