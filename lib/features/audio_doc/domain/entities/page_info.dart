import 'package:equatable/equatable.dart';

class PageInfo extends Equatable {
  final String url;
  const PageInfo({required this.url});

  @override 
  List<Object?> get props => [url];
}