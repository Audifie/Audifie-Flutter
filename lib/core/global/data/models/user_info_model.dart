import 'package:audifie_version_1/core/global/domain/entities/user_info.dart';

class UserInfoModel extends UserInfo {
  const UserInfoModel({
    required String id,
    required String email,
    required String name,
  }) : super(
          id: id,
          email: email,
          name: name,
        );
  
  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      id: map['email'].toString(),
      email: map['email'].toString(),
      name: map['name'].toString(),
    );
  }

  Map<String, dynamic> toMap(UserInfoModel userInfoModel) {
    return {
      'id': userInfoModel.id,
      'email': userInfoModel.email,
      'name': userInfoModel.name,
    };
  }
}
