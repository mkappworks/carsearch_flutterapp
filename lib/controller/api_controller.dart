import 'package:carsearch_flutterapp/model/car.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:http/http.dart' as http;

enum ListStatus { loading, loaded, empty }

class ApiController extends GetxController {
  Rx<ListStatus> _status = ListStatus.empty.obs;
  RxList<Car> _carList = <Car>[].obs;

  @override
  Future<void> onInit() async {
    _setData();
    super.onInit();
  }

  Future<void> _setData() async {
    _status.value = ListStatus.loading;

    List<Car> _list = await _apiFetchData();

    if (_list.isEmpty) {
      _status.value = ListStatus.empty;
    } else {
      _status.value = ListStatus.loaded;
      _carList.assignAll(_list);
    }
  }

  Future _apiFetchData() async {
    try {
      final _response = await http.get(Uri.parse(
          'https://vpic.nhtsa.dot.gov/api/vehicles/getallmakes?format=json#'));

      // if (_response.statusCode == 200) {
        List<Car> _carList = carsFromJson(_response.body).cars;

        return _carList;
      // }
    } catch (error) {
      throw ('failed to load data');
    }
  }

  Rx<ListStatus> get getStatus => _status;

  RxList<Car> get getCatList => _carList;
}
