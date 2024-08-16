import 'package:elysia_app/repositories/api_repository.dart';
import 'package:elysia_app/services/toast_service.dart';
import 'package:flutter/foundation.dart';

class ConnectProvider with ChangeNotifier {
  final ApiRepository apiRepository = ApiRepository();
  bool _isConnecting = false;
  bool _connectionSuccessful = false;
  Map<String, dynamic>? _data;

  ConnectProvider();

  bool get isConnecting => _isConnecting;
  bool get connectionSuccessful => _connectionSuccessful;
  Map<String, dynamic>? get data => _data;

  Future<void> connect() async {
    _isConnecting = true;
    notifyListeners();

    try {
      final response = await apiRepository.fetchData('/init');

      if (response.success) {
        // Handle successful data processing here if needed
        _connectionSuccessful = true;
      } else {
        // Handle API-specific errors here using apiResponse.error
        _connectionSuccessful = false;

        if (kDebugMode) {
          print('[PROVIDER] Error: ${response.error}');
          print('[PROVIDER] Code: ${response.code}');
        }
      }
      _data = response.data;
      // ToastService().showToast(response.error != null ? response.error.toString() : response.message.toString());

      // You can handle a successful connection here
    } on Exception catch (e) {
      // Handle the error here
      _connectionSuccessful = false;

      ToastService().showToast(e.toString());

      if (kDebugMode) {
        print('[PROVIDER] $e');
      }
    } finally {
      _isConnecting = false;
      notifyListeners();
    }
  }

  void resetConnectionState() {
    _connectionSuccessful = false;
    _data = null;
    notifyListeners();
  }
}

