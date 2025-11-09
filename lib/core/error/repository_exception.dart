class RepositoryException implements Exception {
  RepositoryException(this.message);

  final String message;

  @override
  String toString() => 'RepositoryException: $message';
}
