import './http_error.dart';

class BadRequestError extends HttpError {
  final String? message;

  BadRequestError({this.message});
  @override
  List<Object?> get props => [];
}
