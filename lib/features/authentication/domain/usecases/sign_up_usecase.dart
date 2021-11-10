import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/validator_service.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';
import 'package:audifie_version_1/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SignUpUsecase {
  final ValidatorService _validatorService = sl<ValidatorService>();

  final AuthRepo _authRepo = sl<AuthRepo>();

  Future<Either<Failure, Success>> sendOtpForSignUp(SignUpInfo signUpInfo) async {
    if (!_validatorService.isEmail(signUpInfo.email)) {
      return Left(SignUpFailure(message: Strings.emailInvalid));
    } else if (!_validatorService.isPassword(signUpInfo.password)) {
      return Left(SignUpFailure(message: Strings.passwordMustContain));
    } else if (signUpInfo.password.compareTo(signUpInfo.configmPassword) != 0) {
      return Left(SignUpFailure(message: Strings.confirmPasswordPasswordShouldSame));
    } 

    return _authRepo.sendOtpForSignUp(signUpInfo);
  } 

  Future<Either<Failure, Success>> verifyOtpAndSignUp(SignUpInfo signUpInfo, String otp) {
    return _authRepo.verifyOtpAndSignUpAndStoreAccessToken(signUpInfo, otp);
  }

  Future<Either<Failure, Success>> googleSignUp() {
    return _authRepo.googleSignUp();
  } 

  Future<Either<Failure, Success>> facebookSignUp() {
    return _authRepo.facebookSignUp();
  } 
}