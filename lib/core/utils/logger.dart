//Global logger can be used throughout the app by importing this file or the global imports. (see global.dart)
// Logger Example usage:
  // logger.d('Log message with 2 methods');
  // logger.e('Error! Something bad happened', error: 'Test Error');

// Logger without stack trace example usage:
  // loggerNoStack.i('Info message');
  // loggerNoStack.w('Just a warning!');
  // loggerNoStack.t({'key': 5, 'value': 'something'});
  
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
);

final loggerNoStack = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 0,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
);
