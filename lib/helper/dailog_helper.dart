import 'package:flutter/material.dart';

class DialogHelper {
  static DialogHelper? _instance;

  DialogHelper._();

  static DialogHelper instance() {
    _instance ??= DialogHelper._();
    return _instance!;
  }

  BuildContext? _context;

  void injectContext(BuildContext context) => _context = context;

  bool get isPopupShowing => _context != null;

  void dismissProgress() {
    final context = _context;
    if (context == null) return;
    Navigator.pop(context);
  }

  void showQuizDialog(String content) {
    final context = _context;
    if (context == null) return;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Text(content, style: Theme.of(context).textTheme.bodySmall),
            actions: [MaterialButton(onPressed: () => Navigator.pop(context), child: Text('Close', style: Theme.of(context).textTheme.bodySmall))]));
  }

  void showProgressDialog(String text) {
    final context = _context;
    if (context == null) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              child: Dialog(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        CircularProgressIndicator(
                            color: Theme.of(context).primaryColor, backgroundColor: Theme.of(context).scaffoldBackgroundColor, strokeWidth: 3),
                        const SizedBox(width: 10),
                        Flexible(child: Text(text, style: const TextStyle(fontSize: 14)))
                      ]))),
              onWillPop: () async => false);
        });
  }
}
