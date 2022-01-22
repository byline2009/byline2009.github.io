import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  static int counter = 0;
  final String className;

  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    AnsiColor? color = PrettyPrinter.levelColors[event.level];
    String? emoji = PrettyPrinter.levelEmojis[event.level];
    return [color!('$emoji [$className]: ${event.message}')];
  }
}

Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}
