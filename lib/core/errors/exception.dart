class ServerException implements Exception {}

class CacheException implements Exception {}

class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);

  @override
  String toString() {
    return 'Validation Error: $message';
  }
}
