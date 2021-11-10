import 'package:equatable/equatable.dart';

class ForgotPasswordInfo extends Equatable {
  final String email;
  
  const ForgotPasswordInfo({required this.email}); 

  @override
  List<Object?> get props => [email];
}