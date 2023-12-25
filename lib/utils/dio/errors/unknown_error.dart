import 'connection_error.dart';

class UnknownError extends ConnectionError {
  final String? message;

  UnknownError({this.message});

  @override
  List<Object> get props => [];
}
