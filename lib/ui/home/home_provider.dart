import 'package:flutter/cupertino.dart';
import 'package:flutter_futurama/backend/shared_web_service.dart';
import 'package:flutter_futurama/data/meta_data.dart';

class HomeProvider extends ChangeNotifier {
  final SharedWebService _sharedWebService = SharedWebService.instance();
  DataEvent homeEvent = const Loading();

  HomeProvider() {
    getHome();
  }

  Future<void> getHome() async {
    try {
      final res = await _sharedWebService.getHome();

      if (res.isEmpty) {
        homeEvent = const Empty(message: '');
        notifyListeners();
        return;
      }

      homeEvent = Data(data: res);
      notifyListeners();
    } catch (_) {
      homeEvent = Error(exception: Exception());
      notifyListeners();
    }
  }
}
