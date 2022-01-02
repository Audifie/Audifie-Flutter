import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  final String message;
  const Success({required this.message});
}

class GetSuccess extends Success {
  final String message;
  const GetSuccess({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class PostSuccess extends Success {
  final String message;
  const PostSuccess({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class SendEmailSuccess extends Success {
  final String message;
  const SendEmailSuccess({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class SignUpSuccess extends Success {
  final String message;
  const SignUpSuccess({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class SignInSuccess extends Success {
  final String message;
  const SignInSuccess({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class SignOutSuccess extends Success {
  final String message;
  const SignOutSuccess({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class ReadSuccess extends Success {
  final String message;
  const ReadSuccess({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class WriteSuccess extends Success {
  final String message;
  const WriteSuccess({required this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}