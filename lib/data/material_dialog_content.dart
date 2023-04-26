import '../utils/app_strings.dart';

class MaterialDialogContent {
  final String title;
  final String message;
  final String positiveText;
  final String negativeText;

  MaterialDialogContent({required this.title, required this.message, this.positiveText = AppStrings.TRY_AGAIN, this.negativeText = AppStrings.CANCEL});

  MaterialDialogContent.networkError() : this(title: AppStrings.LIMITED_NETWORK_CONNECTION, message: AppStrings.LIMITED_NETWORK_CONNECTION_CONTENT);

  @override
  String toString() {
    return 'MaterialDialogContent{title: $title, message: $message, positiveText: $positiveText, negativeText: $negativeText}';
  }
}
