import 'package:elysia_app/constants/constants.dart';
import 'package:elysia_app/models/auth_model.dart';
import 'package:elysia_app/models/profile_model.dart';
import 'package:elysia_app/models/response_model.dart';
import 'package:elysia_app/models/user_model.dart';
import 'package:elysia_app/repositories/api_repository.dart';
import 'package:elysia_app/services/hive_service.dart';
import 'package:elysia_app/services/toast_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider with ChangeNotifier {
  late ApiRepository apiRepository;
  final HiveService _hive = HiveService();

  bool _isLoggingIn = false;
  bool _isRegistering = false;
  bool _hasLoginError = false;
  bool _hasSignupError = false;
  bool _isLeaving = false;
  final PageController pageController = PageController(initialPage: 0, keepPage: true);
  int currentPage = 0;

  // User data
  Login? _loginData;
  Signup? _signupData;
  User? _userData;
  Profile? _profileData;

  // Token
  final _storage = const FlutterSecureStorage();
  Map<String, dynamic>? _decodedToken;
  String? _token;

  AuthProvider(){
    apiRepository = ApiRepository();
  }

  bool get isLoggingIn => _isLoggingIn;
  bool get isRegistering => _isRegistering;
  bool get hasLoginError => _hasLoginError;
  bool get hasSignupError => _hasSignupError;
  bool get isLeaving => _isLeaving;
  String? get token => _token;
  Map<String, dynamic>? get decodedToken => _decodedToken;

  // User data
  Login? get loginData => _loginData;
  Signup? get signupData => _signupData;
  User? get userData => _userData;
  Profile? get profileData => _profileData;

  // Check Authentication via JWT token
  bool get isAuthenticated {
    if (_token == null) return false;
    final expiryDate = JwtDecoder.getExpirationDate(_token!);
    return expiryDate.isAfter(DateTime.now());
  }

  List<String> get userRoles {
    return _decodedToken?['roles']?.cast<String>() ?? [];
  }

  bool hasRole(String role) {
    return userRoles.contains(role);
  }

  bool hasAnyRole(List<String> roles) {
    return roles.any((role) => userRoles.contains(role));
  }

  // Load token from storage when app starts or user logs in
  Future<void> loadToken() async {
    _token = await _storage.read(key: 'lucia_auth_token');
    if (_token != null) {
      _decodedToken = decodeToken(_token!);
      notifyListeners();
    }
  }

  // Set the token (e.g., after login)
  void setToken(String token) async {
    _token = token;
    await _storage.write(key: 'lucia_auth_token', value: token);
    _decodedToken = decodeToken(token);
    notifyListeners();
  }

  // Clear the token (e.g., on logout)
  void clearToken() async {
    _token = null;
    _decodedToken = null;
    await _storage.delete(key: 'lucia_auth_token');
    notifyListeners();
  }

  // Decode JWT token using package
  Map<String, dynamic> decodeToken(String token) {
    Map<String, dynamic> payload = JwtDecoder.decode(token);

    // Example of extracting data
    // String firstName = payload['firstname'];
    // List<String> roles = List<String>.from(payload['roles']);

    return payload;
  }




  void setCurrentPage(int index){
    currentPage = index;
    notifyListeners();
  }

  void goToLogin() {
    pageController.animateToPage(0, duration: const Duration(milliseconds: AppConstants.pageAnimDuration), curve: Curves.easeInOut);
  }

  void goToSignup() {
    pageController.animateToPage(1, duration: const Duration(milliseconds: AppConstants.pageAnimDuration), curve: Curves.easeInOut);
  }


  Future<void> login(Login login) async {
    _isLoggingIn = true;
    _hasLoginError = false;
    _isLeaving = false;
    notifyListeners();

    try {
      final ApiResponse apiResponse = await apiRepository.postData<Login>('/auth/login', login);
      print(apiResponse.data);
      if(apiResponse.data != null && apiResponse.success == true){
        _userData = apiResponse.data as User;

        //_userData = (apiResponse.data!).map((json) => User.fromJson(json));

        // _provinces = (apiResponse.data!).map((json) => Province.fromJson(json)).toList();
        await _hive.putData<User>('authBox', 'user', _userData!);
        _isLeaving = true;
        ToastService().showToast(apiResponse.message.toString());
      } else {
        _hasLoginError = true;
        ToastService().showToast(apiResponse.message ?? apiResponse.error ?? 'Could no'
            't sign you in');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[AUTH PROVIDER] $e');
      }
      _hasLoginError = true;
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }



  Future<void> register(Signup signup) async {
    _isRegistering = true;
    _hasSignupError = false;
    _isLeaving = false;
    notifyListeners();

    try {
      final ApiResponse apiResponse = await apiRepository.postData<Signup>('/auth/register', signup);

      if(apiResponse.data != null && apiResponse.success == true){
        _userData = apiResponse.data as User;

        ToastService().showToast(apiResponse.message ?? 'Your new Account awaits');

        Future.delayed(const Duration(seconds: 2), () { goToLogin(); });

        // await _hive.putData<User>('authBox', 'user', _userData!);
      } else {
        _hasSignupError = true;
        ToastService().showToast(apiResponse.message ?? apiResponse.error ?? 'Could no'
            't create a new Account');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[AUTH PROVIDER] $e');
      }
      _hasSignupError = true;
    } finally {
      _isRegistering = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLeaving = true;
    notifyListeners();

    try {
      final response = await apiRepository.postData('/auth/logout', null);

      if (response.success) {
        _signupData = null;
        _loginData = null;
        _userData = null;
        _profileData = null;
        clearToken();
      } else {
        ToastService().showToast(response.error.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print('[AUTH PROVIDER] $e');
      }
    } finally {
      _isLeaving = false;
      notifyListeners();
    }
  }

}

