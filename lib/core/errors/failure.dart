import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
}

class GetFailure extends Failure {
  final String message;
  const GetFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class PickFilesFailure extends Failure {
  final String message;
  const PickFilesFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class SendEmailFailure extends Failure {
  final String message;
  const SendEmailFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class SignUpFailure extends Failure {
  final String message;
  const SignUpFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class SignInFailure extends Failure {
  final String message;
  const SignInFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class SignOutFailure extends Failure {
  final String message;
  const SignOutFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class ReadFailure extends Failure {
  final String message;
  const ReadFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class WriteFailure extends Failure {
  final String message;
  const WriteFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}