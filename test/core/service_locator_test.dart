import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/email_sender_service.dart';
import 'package:audifie_version_1/core/services/file_picker_service.dart';
import 'package:audifie_version_1/core/services/validator_service.dart';
import 'package:audifie_version_1/features/authentication/domain/repositories/auth_repo.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_remote_data_source.dart';
import 'package:audifie_version_1/features/settings/domain/repositories/settings_repo.dart';
import 'package:file_picker/file_picker.dart';

import '../features/authentication/domain/usecases/sign_up_usecase_test.mocks.dart';
import '../features/settings/data/data_source/local_data_source_test.mocks.dart';
import '../features/settings/data/data_source/remote_data_source_test.mocks.dart';
import '../features/settings/data/repositories/settings_repo_impl_test.mocks.dart';
import '../features/settings/domain/usecases/file_picker_usecase_test.mocks.dart';
import 'services/file_picker_service_test.mocks.dart';

void setUpServicesForTest() {
  // External dependencies
  sl.registerSingleton<FilePicker>(MockFilePicker());
  
  // Services
  sl.registerSingleton<FilePickerService>(MockFilePickerService());
  sl.registerSingleton<EmailSenderService>(MockEmailSenderService());
  sl.registerSingleton<ValidatorService>(MockValidatorService());

  // Data sources
  sl.registerSingleton<SettingsLocalDataSource>(MockSettingsLocalDataSource());
  sl.registerSingleton<SettingsRemoteDataSource>(MockSettingsRemoteDataSource());
  
  // Repos
  sl.registerSingleton<SettingsRepo>(MockSettingsRepo());
  sl.registerSingleton<AuthRepo>(MockAuthRepo());
}

void main() {}