import 'package:logger/logger.dart';

class TheLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // TODO: implement this when needed
    // if (event.level == Level.warning || event.level == Level.error) {
    //   return true;
    // }

    return true;
  }
}

Logger? logger;

Logger getLogger() {
  logger ??= Logger(filter: TheLogFilter());

  return logger!;
}
