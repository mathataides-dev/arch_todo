abstract class MainException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  MainException(this.message, [this.stackTrace]);

  @override
  String toString() {
    if (stackTrace != null) return '$runtimeType: $message\n$stackTrace';
    return '$runtimeType: $message';
  }
}

class LocalStorageException extends MainException {
  LocalStorageException(super.message, [super.stackTrace]);
}

class ToDoException extends MainException {
  ToDoException(super.message, [super.stackTrace]);
}
