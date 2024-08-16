import 'package:elysia_app/models/profile_model.dart';

abstract class IProfileRepository {
  Future<Profile> getProfile();
  Future<Profile> update(Profile profile);
  Future<String> delete(String userId);
}