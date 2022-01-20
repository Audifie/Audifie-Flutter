import 'dart:async';
import 'dart:io';

import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/audio_doc/data/models/audio_doc_model.dart';
import 'package:dio/dio.dart';

abstract class AudioDocRemoteDataSource {
  Future<List<AudioDocModel>> getAllAudioDocs();
  Future<AudioDocModel> getAudioDoc(AudioDocModel audioDocModel);
  Future<Stream<int>> uploadDoc(String accessToken, File doc);
  Future<void> changeFavouriteTo(String fileId, bool favourite);
  Future<void> deleteAudioDoc(String fileId);
}

class AudioDocRemoteDataSourceImpl implements AudioDocRemoteDataSource {
  final Dio _dio = sl<Dio>();

  @override
  Future<List<AudioDocModel>> getAllAudioDocs() async {
    try {
      final List<AudioDocModel> audioDocModels = [];
      final Response result = await _dio.get(Strings.apiGetAllDocs);
      final List list = result.data;
      for (int i = 0; i < list.length; i++) {
        Map<String, dynamic> map = list[i] as Map<String, dynamic>;
        audioDocModels.add(AudioDocModel.fromMap(map));
      }
      return audioDocModels;
    } catch (e) {
      throw GetException(message: 'There was an error. Please try again');
    }
  }

  // ** This new function is added to get details of each audio doc **
  @override
  Future<AudioDocModel> getAudioDoc(AudioDocModel audioDocModel) async {
    try {
      final String fileId = audioDocModel.fileId;
      final Response result = await _dio.get(Strings.apiGetDoc + fileId);
      final Map<String, dynamic> map = result.data as Map<String, dynamic>;
      final AudioDocModel updatedAudioDocModel = AudioDocModel.fromMapToGetAudioDoc(audioDocModel, map);
      return updatedAudioDocModel;
    } on DioError catch (e) {
      print('Error in [AudioDocRemoteDataSource] [getAudioDoc] [DioError]: $e');
      print('Dio error message: ${e.response!.data['message']}');
      throw GetException(message: 'There was some error. Please try again');
    } catch (e) {
      print('Error in [AudioDocRemoteDataSource] [getAudioDoc]: $e');
      throw GetException(message: 'There was some error. Please try again');
    }
  }

  Stream<int> generateTestStream() {
    return Stream<int>.periodic(const Duration(milliseconds: 10), (x) {
      print('X: $x');
      return x + 1;
    }).take(100);
  }

  @override
  Future<Stream<int>> uploadDoc(String accessToken, File doc) async {
    return generateTestStream();
    // try {
    //   final http.MultipartFile multipartFile =
    //       await http.MultipartFile.fromPath('document', doc.path,
    //           filename: basename(doc.path));
    //   final Uri uri = Uri.parse(Strings.apiUploadDoc);
    //   final request = http.MultipartRequest('POST', uri);
    //   request.headers['cookie'] = accessToken;
    //   request.files.add(multipartFile);
    //   final response = await request.send();
    //   response.stream.transform(utf8.decoder).listen((event) {
    //     print('upload doc: $event');
    //     final Map<String, dynamic> res = jsonDecode(event);
    //     if (!res['success']) {
    //       throw PostException(
    //           message: 'There was some error. Please try again');
    //     }
    //   });
    // } on PostException catch (e) {
    //   print(
    //       'Error in [AudioDocRemoteDataSource] [uploadDoc] [PostException]: ${e.message}');
    //   rethrow;
    // } catch (e) {
    //   print('Error in [AudioDocRemoteDataSource] [uploadDoc]: $e');
    //   throw PostException(message: 'There was some error. Please try again');
    // }
  }

  @override
  Future<void> changeFavouriteTo(String fileId, bool favourite) async {
    try {
      await _dio.post(
        Strings.apiFavourite + fileId,
        data: {
          'isFavourite': favourite,
        },
        // queryParameters: {
        //   'id': fileId,
        // },
      );
    } catch (e) {
      print('Error in [AudioDocRemoteDataSource] [changeFavouriteTo]: $e');
      throw PostException(message: 'There was a problem. Please try again');
    }
  }

  @override
  Future<void> deleteAudioDoc(String fileId) async {
    try {
      await _dio.post(
        Strings.apiDeleteDoc + fileId,
      );
    } catch (e) {
      print('Error in [AudioDocRemoteDataSource] [deleteAudioDoc]: $e');
      throw PostException(message: 'There was a problem. Please try again');
    }
  }
}
