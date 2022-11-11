import 'package:f_logs/f_logs.dart';

class AppLog {
  static void logError({
    String? text,
    required String className,
    required String methodName,
    required dynamic exception,
    required StackTrace stack,
  }) {
    FLog.error(
      text: text ?? '',
      stacktrace: stack,
      className: className,
      methodName: methodName,
      exception: exception,
    );
  }

  static void log({
    String? text,
    required String className,
    required String methodName,
  }) {
    FLog.info(
      text: text ?? '',
      className: className,
      methodName: methodName,
    );
  }
}