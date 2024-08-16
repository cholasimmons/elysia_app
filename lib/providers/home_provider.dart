import 'package:elysia_app/models/province_model.dart';
import 'package:elysia_app/models/response_model.dart';
import 'package:elysia_app/repositories/api_repository.dart';
import 'package:elysia_app/services/hive_service.dart';
import 'package:elysia_app/services/toast_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeProvider with ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  final HiveService _hive = HiveService();

  bool _isLoading = true;
  bool _hasError = false;
  bool _isGridView = true;
  int _currentIndex = 0;
  List<Province> _provinces = [];

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isGridView => _isGridView;
  int get currentIndex => _currentIndex;
  List<Province> get provinces => _provinces;


  HomeProvider() {
    fetchProvinces();
  }

  Future<void> fetchProvinces() async {
    try {
      _isLoading = true;
      _hasError = false;
      notifyListeners();

      late ApiResponse<List<dynamic>> apiResponse;

      final isStale = await _hive.isDataStale('provincesBox', 'provinces');

      if (isStale) {
        apiResponse = await _apiRepository.fetchData('/provinces');

        if(apiResponse.data != null && apiResponse.success == true){
          _provinces = (apiResponse.data!).map((json) => Province.fromJson(json)).toList();
          await _hive.putData<List<Province>>('provincesBox', 'provinces', _provinces);
        } else {
          _hasError = true;
          ToastService().showToast(apiResponse.error ?? apiResponse.message ?? 'Could no'
              't fetch data');
        }

      } else {
        ToastService().showToast('Displaying data from cache');
        _provinces = await _hive.getData<List<Province>>('provincesBox', 'provinces') as List<Province>;
      }

    } catch (e) {
      _hasError = true;
      kDebugMode ? print(e) : null;
      if(e is HiveError){
        ToastService().showToast('A local storage issue occurred');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}