import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> storeAccessToken(String accessToken);
  Future<String> getAccessToken();
  Future<void> deleteAccessToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences = sl<SharedPreferences>();

  @override 
  Future<void> storeAccessToken(String accessToken) async {
    print('Access token: $accessToken');
    try {
      final bool isStored = await _sharedPreferences.setString(Strings.keyAccessToken, accessToken);
      if (!isStored) {
        throw WriteException(message: 'There was some problem in storing the access token. Please try again');
      }
    } on WriteException catch (e) {
      print('Error in [AuthLocalDataSourceImpl] [storeAccessToken]: ${e.message}');
      throw e;
    } catch (e) {
      print('Error in [AuthLocalDataSourceImpl] [storeAccessToken]: $e');
      throw WriteException(message: 'There was some problem in storing the access token. Please try again');
    }
  }

  @override
  Future<String> getAccessToken() async {
    try {
      final String? accessToken = _sharedPreferences.getString(Strings.keyAccessToken);
      if (accessToken != null) {
        return accessToken;
      }
      throw ReadException(message: 'There is no access token');
    } on ReadException catch (e) {
      print('Error in [AuthLocalDataSourceImpl] [getAccessToken]: ${e.message}');
      throw e;
    } catch (e) {
      print('Error in [AuthLocalDataSourceImpl] [getAccessToken]: $e');
      throw ReadException(message: 'There was some problem in storing the access token. Please try again');
    }
  }

  @override
  Future<void> deleteAccessToken() async {
    try {
      final bool isDeleted = await _sharedPreferences.remove(Strings.keyAccessToken);
      if (!isDeleted) {
        throw WriteException(message: 'Failed to delete access token');
      }
    } on WriteException catch (e) {
      rethrow;
    } catch (e) {
      throw WriteException(message: 'Failed to delete access token');
    }
  }
}