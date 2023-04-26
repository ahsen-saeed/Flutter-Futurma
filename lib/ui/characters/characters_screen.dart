import 'package:flutter/material.dart';
import 'package:flutter_futurama/backend/server_response.dart';
import 'package:flutter_futurama/data/meta_data.dart';
import 'package:flutter_futurama/ui/characters/characters_provider.dart';
import 'package:flutter_futurama/ui/characters_detail_page.dart';
import 'package:flutter_futurama/utils/app_strings.dart';
import 'package:provider/provider.dart';

import '../../common/error_try_again.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharactersProvider>(
        create: (BuildContext context) => CharactersProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
              appBar: AppBar(title: const Text(AppStrings.CHARACTERS), centerTitle: true),
              body: Consumer<CharactersProvider>(builder: (context, provider, child) {
                final state = provider.charactersEvent;
                if (state is Error) {
                  return Center(
                      child: ErrorTryAgain(margin: const EdgeInsets.symmetric(horizontal: 20), positiveClickListener: () => provider.getCharacter()));
                } else if (state is Data) {
                  final List<CharactersModel> characterList = state.data;
                  return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemBuilder: (_, i) => Material(
                          borderRadius: BorderRadius.circular(6),
                          elevation: 5,
                          child: ListTile(
                              minVerticalPadding: 25,
                              onTap: () =>
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => CharactersDetailPage(charactersModel: characterList[i]))),
                              leading: Container(
                                  height: 60,
                                  width: 60,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(characterList[i].images)))),
                              title: Text('${characterList[i].name.first} ${characterList[i].name.middle} ${characterList[i].name.last}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black)))),
                      separatorBuilder: (_, i) => const SizedBox(height: 15),
                      itemCount: characterList.length);
                }
                return const Center(child: CircularProgressIndicator.adaptive());
              }));
        }));
  }
}
