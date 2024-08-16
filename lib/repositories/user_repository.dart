import 'package:elysia_app/models/response_model.dart';
import 'package:elysia_app/models/user_model.dart';
import 'package:elysia_app/repositories/api_repository.dart';
import 'package:elysia_app/services/toast_service.dart';

abstract class IUserRepository {
  Future<User> getAccount();
  Future<User> update(User user);
  Future<void> delete(String userId);
}

class UserRepository implements IUserRepository {
  UserRepository();

  // GET
  @override
  Future<User> getAccount() async {
    ApiResponse response = await ApiRepository().fetchData('/users/user');

    return response.data;
  }


  // PATCH
  @override
  Future<User> update(user) async {
    ApiResponse response = await ApiRepository().fetchData('/users/user');

    return response.data;
  }


  // DELETE
  @override
  Future<void> delete(userId) async {
    ApiResponse response = await ApiRepository().deleteData('/users/user', userId);

    // Display toast on successful delete
    ToastService().showToast(response.message ?? 'User Deleted');
    // return response.message ?? 'User Deleted';
  }
}