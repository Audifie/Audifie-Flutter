import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SignOutUsecase {
  final AuthRepo _authRepo = sl<AuthRepo>();

  Future<Either<Failure, Success>> signOut() {
    return _authRepo.signOut();
  }
}