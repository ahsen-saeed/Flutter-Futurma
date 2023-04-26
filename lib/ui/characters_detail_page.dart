import 'package:flutter/material.dart';
import 'package:flutter_futurama/backend/server_response.dart';
import 'package:flutter_futurama/extension/context_extension.dart';

class CharactersDetailPage extends StatelessWidget {
  final CharactersModel charactersModel;

  const CharactersDetailPage({required this.charactersModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('${charactersModel.name.first} ${charactersModel.name.middle} ${charactersModel.name.last}')),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(alignment: Alignment.center, child: Image.network(charactersModel.images)),
              20.ph,
              _SingleRowWidget(title: 'Name', value: '${charactersModel.name.first} ${charactersModel.name.middle} ${charactersModel.name.last}'),
              _SingleRowWidget(title: 'Gender', value: charactersModel.gender),
              _SingleRowWidget(title: 'Species', value: charactersModel.species),
              _SingleRowWidget(title: 'HomePlanet', value: charactersModel.homePlanet),
              _SingleRowWidget(title: 'Occupation', value: charactersModel.occupation),
              _SingleRowWidget(title: 'Age', value: charactersModel.age),
              10.ph,
              Text('Sayings : ', style: Theme.of(context).textTheme.titleMedium),
              5.ph,
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: charactersModel.sayings
                      .map((e) => Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                            Container(
                              margin: const EdgeInsets.only(right: 4, top: 4),
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                            ),
                            Expanded(child: Text(e, style: Theme.of(context).textTheme.bodySmall))
                          ])))
                      .toList())
            ])));
  }
}

class _SingleRowWidget extends StatelessWidget {
  const _SingleRowWidget({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(children: [Text('$title : ', style: Theme.of(context).textTheme.titleMedium), Text(value, style: Theme.of(context).textTheme.bodySmall)]));
  }
}
