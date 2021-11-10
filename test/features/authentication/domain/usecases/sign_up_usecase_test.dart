import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/validator_service.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';
import 'package:audifie_version_1/features/authentication/domain/repositories/auth_repo.dart';
import 'package:audifie_version_1/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/service_locator_test.dart';

@GenerateMocks([AuthRepo, ValidatorService])
void main() {
  setUpServicesForTest();

  final AuthRepo mockAuthRepo = sl<AuthRepo>();
  final ValidatorService mockValidatorService = sl<ValidatorService>();
  final SignUpUsecase signUpUsecase = SignUpUsecase();

  group('sign up usecase', () {
    group('sign up', () {
      test('should return sign up failure when email not correct', () async {
        final SignUpInfo tSignUpInfo = SignUpInfo(
          name: 'name',
          email: 'not_correct_email',
          password: 'password',
          configmPassword: 'password',
        );

        when(mockValidatorService.isEmail(tSignUpInfo.email)).thenAnswer((realInvocation) => false);
        final Either<Failure, Success> result = await signUpUsecase.sendOtpForSignUp(tSignUpInfo);

        verify(mockValidatorService.isEmail(tSignUpInfo.email));
        expect(result, Left(SignUpFailure(message: Strings.emailInvalid)));
      });

      test('should return sign up failure when password not correct', () async {
        final SignUpInfo tSignUpInfo = SignUpInfo(
          name: 'name',
          email: 'email@domain.com',
          password: 'not_p',
          configmPassword: 'password',
        );

        when(mockValidatorService.isEmail(tSignUpInfo.email)).thenAnswer((realInvocation) => true);
        when(mockValidatorService.isPassword(tSignUpInfo.password)).thenAnswer((realInvocation) => false);
        final Either<Failure, Success> result = await signUpUsecase.sendOtpForSignUp(tSignUpInfo);

        verify(mockValidatorService.isPassword(tSignUpInfo.password));
        expect(result, Left(SignUpFailure(message: Strings.passwordMustContain)));
      });

      test('should return sign up failure when confirm password and password not same', () async {
        final SignUpInfo tSignUpInfo = SignUpInfo(
          name: 'name',
          email: 'email@domain.com',
          password: 'password',
          configmPassword: 'password_not_same',
        );

        when(mockValidatorService.isEmail(tSignUpInfo.email)).thenAnswer((realInvocation) => true);
        when(mockValidatorService.isPassword(tSignUpInfo.password)).thenAnswer((realInvocation) => true);
        final Either<Failure, Success> result = await signUpUsecase.sendOtpForSignUp(tSignUpInfo);

        expect(result, Left(SignUpFailure(message: Strings.confirmPasswordPasswordShouldSame)));
      });

      test('should return sign up failure when failed', () async {
        final SignUpInfo tSignUpInfo = SignUpInfo(
          name: 'name',
          email: 'email@domain.com',
          password: 'password',
          configmPassword: 'password',
        );

        when(mockValidatorService.isEmail(tSignUpInfo.email)).thenAnswer((realInvocation) => true);
        when(mockValidatorService.isPassword(tSignUpInfo.password)).thenAnswer((realInvocation) => true);
        when(mockAuthRepo.sendOtpForSignUp(tSignUpInfo)).thenAnswer((realInvocation) async => Left(SignUpFailure(message: 'error')));
        final Either<Failure, Success> result = await signUpUsecase.sendOtpForSignUp(tSignUpInfo);

        verify(mockAuthRepo.sendOtpForSignUp(tSignUpInfo));
        expect(result, Left(SignUpFailure(message: 'error')));
      });

      test('should return sign up success when succeeded', () async {
        final SignUpInfo tSignUpInfo = SignUpInfo(
          name: 'name',
          email: 'email@domain.com',
          password: 'password',
          configmPassword: 'password',
        );

        when(mockValidatorService.isEmail(tSignUpInfo.email)).thenAnswer((realInvocation) => true);
        when(mockValidatorService.isPassword(tSignUpInfo.password)).thenAnswer((realInvocation) => true);
        when(mockAuthRepo.sendOtpForSignUp(tSignUpInfo)).thenAnswer((realInvocation) async => Right(SignUpSuccess(message: Strings.otpSent + '. ' + Strings.enterOtp)));
        final Either<Failure, Success> result = await signUpUsecase.sendOtpForSignUp(tSignUpInfo);

        verify(mockAuthRepo.sendOtpForSignUp(tSignUpInfo));
        expect(result, Right(SignUpSuccess(message: Strings.otpSent + '. ' + Strings.enterOtp)));
      });
    });
  });
}
