import 'package:flutter/material.dart';

import '../utils/app_strings.dart';

class ErrorTryAgain extends StatelessWidget {
  final EdgeInsets margin;
  final Function positiveClickListener;

  const ErrorTryAgain({required this.margin, required this.positiveClickListener});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        margin: margin,
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 20),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text(AppStrings.LIMITED_NETWORK_CONNECTION, style: TextStyle(fontSize: 20))),
          const SizedBox(height: 10),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(AppStrings.LIMITED_NETWORK_CONNECTION_CONTENT, textAlign: TextAlign.center, style: TextStyle(fontSize: 14))),
          const SizedBox(height: 30),
          const Divider(thickness: 0.8, height: 0),
          SizedBox(
              width: size.width - margin.left + margin.right,
              child: InkWell(
                onTap: () {
                  positiveClickListener();
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Text(AppStrings.TRY_AGAIN.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 14))),
              ))
        ]));
  }
}
