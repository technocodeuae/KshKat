import './http_error.dart';

class ForbiddenError extends HttpError {
  final String? message;

  ForbiddenError({this.message});

  @override
  List<Object?> get props => [];
}
