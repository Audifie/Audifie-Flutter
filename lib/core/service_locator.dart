import 'package:audifie_version_1/core/services/audio_player_service.dart';
import 'package:audifie_version_1/core/services/email_sender_service.dart';
import 'package:audifie_version_1/core/services/file_picker_service.dart';
import 'package:audifie_version_1/core/services/validator_service.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/features/audio_doc/data/data_sources/audio_doc_remote_data_source.dart';
import 'package:audifie_version_1/features/audio_doc/data/repositories/audio_doc_repo_impl.dart';
import 'package:audifie_version_1/features/audio_doc/domain/repositories/audio_doc_repo.dart';
import 'package:audifie_version_1/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:audifie_version_1/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:audifie_version_1/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:audifie_version_1/features/authentication/domain/repositories/auth_repo.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_remote_data_source.dart';
import 'package:audifie_version_1/features/settings/data/repositories/settings_repo_impl.dart';
import 'package:audifie_version_1/features/settings/domain/repositories/settings_repo.dart';
import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServices() async {
  sl.registerSingleton<SizeConfig>(SizeConfig());

  // External dependencies
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  sl.registerSingleton<AudioPlayer>(AudioPlayer());
  sl.registerSingleton<AudioHandler>(await initAudioService());
  sl.registerSingleton<FilePicker>(FilePicker.platform);
  sl.registerSingleton<GoogleSignIn>(GoogleSignIn());

  // Services
  sl.registerSingleton<AudioPlayerService>(AudioPlayerServiceImpl());
  sl.registerSingleton<FilePickerService>(FilePickerServiceImpl());
  sl.registerSingleton<EmailSenderService>(EmailSenderServiceImpl());
  sl.registerSingleton<ValidatorService>(ValidatorServiceImpl());
  
  // Data sources
  sl.registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl());
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  sl.registerSingleton<AudioDocRemoteDataSource>(AudioDocRemoteDataSourceImpl());
  sl.registerSingleton<SettingsLocalDataSource>(SettingsLocalDataSourceImpl());
  sl.registerSingleton<SettingsRemoteDataSource>(SettingsRemoteDataSourceImpl());

  // Repos
  sl.registerSingleton<AuthRepo>(AuthRepoImpl());
  sl.registerSingleton<AudioDocRepo>(AudioDocRepoImpl());
  sl.registerSingleton<SettingsRepo>(SettingsRepoImpl());
}