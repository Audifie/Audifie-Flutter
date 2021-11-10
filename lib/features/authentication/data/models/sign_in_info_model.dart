import 'package:audifie_version_1/features/authentication/domain/entities/sign_in_info.dart';

class SignInInfoModel extends SignInInfo {
  final String email;
  final String password;

  const SignInInfoModel({
    required this.email,
    required this.password,
  }) : super(
          email: email,
          password: password,
        );
}
