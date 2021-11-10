import 'package:equatable/equatable.dart';

class SignUpInfo extends Equatable {
  final String name;
  final String email;
  final String password;
  final String configmPassword;

  const SignUpInfo({
    required this.name,
    required this.email,
    required this.password,
    required this.configmPassword,
  });

  @override
  List<Object?> get props => [name, email, password, configmPassword];
}
