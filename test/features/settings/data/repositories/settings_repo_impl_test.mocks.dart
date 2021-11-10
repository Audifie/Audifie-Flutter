// Mocks generated by Mockito 5.0.15 from annotations
// in audifie_version_1/test/features/settings/data/repositories/settings_repo_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;
import 'dart:io' as _i4;

import 'package:audifie_version_1/features/settings/data/data_sources/settings_local_data_source.dart'
    as _i2;
import 'package:audifie_version_1/features/settings/data/data_sources/settings_remote_data_source.dart'
    as _i5;
import 'package:audifie_version_1/features/settings/data/models/email_info_model.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [SettingsLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsLocalDataSource extends _i1.Mock
    implements _i2.SettingsLocalDataSource {
  MockSettingsLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.File>> pickFiles() =>
      (super.noSuchMethod(Invocation.method(#pickFiles, []),
              returnValue: Future<List<_i4.File>>.value(<_i4.File>[]))
          as _i3.Future<List<_i4.File>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SettingsRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsRemoteDataSource extends _i1.Mock
    implements _i5.SettingsRemoteDataSource {
  MockSettingsRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> sendEmail(_i6.EmailInfoModel? emailInfoModel) =>
      (super.noSuchMethod(Invocation.method(#sendEmail, [emailInfoModel]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}
