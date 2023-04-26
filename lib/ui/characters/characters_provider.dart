import 'package:flutter/cupertino.dart';
import 'package:flutter_futurama/backend/shared_web_service.dart';
import 'package:flutter_futurama/data/meta_data.dart';

class CharactersProvider extends ChangeNotifier {
  final SharedWebService _sharedWebService = SharedWebService.instance();
  DataEvent charactersEvent = const Loading();

  CharactersProvider() {
    getCharacter();
  }

  Future<void> getCharacter() async {

    try {
      final res = await _sharedWebService.getCharacters();

      if (res.isEmpty) {
        charactersEvent = const Empty(message: '');
        notifyListeners();

        return;
      }
      charactersEvent = Data(data: res);
      notifyListeners();
    } catch (_) {
      charactersEvent = Error(exception: Exception());
      notifyListeners();
    }
  }
}
