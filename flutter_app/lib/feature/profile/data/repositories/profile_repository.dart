import 'package:Krishivani/feature/profile/data/models/profile_model.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepository {
  final ProfileRemoteDatasource _datasource;

  ProfileRepository(this._datasource);

  Future<ProfileModel> getProfile(String userId) {
    return _datasource.getProfile(userId);
  }

  Future<ProfileModel> updateProfile({
    required String userId,
    required String column,
    required dynamic value,
  }) {
    return _datasource.updateProfile(
      userId: userId,
      column: column,
      value: value,
    );
  }
}