class AppError implements Exception {
  final String message;
  final Object? cause;

  const AppError(this.message, [this.cause]);

  @override
  String toString() => message;
}

class NetworkError extends AppError {
  const NetworkError(super.message, [super.cause]);
}

class ServerError extends AppError {
  final int statusCode;

  const ServerError(this.statusCode, {String? message, Object? cause})
      : super(message ?? 'HTTP $statusCode', cause);
}

class ParsingError extends AppError {
  const ParsingError(super.message, [super.cause]);
}

class StorageError extends AppError {
  const StorageError(super.message, [super.cause]);
}
