import 'package:audifie_version_1/features/authentication/domain/entities/forgot_password_info.dart';

class ForgotPasswordInfoModel extends ForgotPasswordInfo {
  final String email;
  
  const ForgotPasswordInfoModel({required this.email}) : super(email: email); 
}