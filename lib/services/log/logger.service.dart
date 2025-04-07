import 'package:logger/logger.dart';

class LoggerService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static void debug(dynamic message) {
    _logger.d(message);
  }

  static void info(dynamic message) {
    _logger.i(message);
  }

  static void warning(dynamic message) {
    _logger.w(message);
  }

  static void error(dynamic message, [StackTrace? stackTrace]) {
    _logger.e(message, error: message, stackTrace: stackTrace);
  }
}
