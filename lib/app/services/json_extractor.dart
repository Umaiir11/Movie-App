import 'dart:convert';
import '../config/global_variables.dart';
import 'logger_service.dart';

/// Extracts and stores error messages from API responses.
class MessageExtractor {
  void extractAndStoreMessage(String endPoint, String responseBody) {
    LoggerService.i('📤 Extracting message → API: $endPoint');
    LoggerService.i('📩 Response Body: $responseBody');

    GlobalVariables.errorMessages.clear();

    try {
      final jsonMap = jsonDecode(responseBody);

      if (jsonMap['errors'] is List) {
        GlobalVariables.errorMessages = List<String>.from(jsonMap['errors']);
      } else if (jsonMap['message'] != null) {
        GlobalVariables.errorMessages.add(jsonMap['message']);
      } else {
        GlobalVariables.errorMessages.add('Unknown error occurred.');
      }

      LoggerService.i('💬 Stored Error Messages: ${GlobalVariables.errorMessages}');
    } on FormatException catch (e) {
      LoggerService.w('📝 Response is not JSON: storing plain text message');
      GlobalVariables.errorMessages.add(responseBody.trim().isEmpty
          ? 'No error message received.'
          : responseBody.trim());
    } catch (e, stack) {
      LoggerService.e('❌ Error extracting/storing message', error: e, stackTrace: stack);
      GlobalVariables.errorMessages.add('Error extracting message.');
    }
  }
}
