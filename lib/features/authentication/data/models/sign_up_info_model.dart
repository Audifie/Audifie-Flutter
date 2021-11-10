import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';

class SignUpInfoModel extends SignUpInfo {
  final String name;
  final String email;
  final String password;
  final String configmPassword;

  const SignUpInfoModel({
    required this.name,
    required this.email,
    required this.password,
    required this.configmPassword,
  }) : super(
          name: name,
          email: email,
          password: password,
          configmPassword: configmPassword,
        );
}
