import 'package:flutter/material.dart';
import 'package:flutter_futurama/backend/server_response.dart';
import 'package:flutter_futurama/common/app_button.dart';
import 'package:flutter_futurama/common/error_try_again.dart';
import 'package:flutter_futurama/data/meta_data.dart';
import 'package:flutter_futurama/extension/context_extension.dart';
import 'package:flutter_futurama/ui/characters/characters_screen.dart';
import 'package:flutter_futurama/ui/home/home_provider.dart';
import 'package:flutter_futurama/ui/quiz/quiz_screen.dart';
import 'package:flutter_futurama/utils/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
        create: (BuildContext context) => HomeProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
              appBar: AppBar(title: const Text(AppStrings.HOME), centerTitle: true),
              body: Consumer<HomeProvider>(builder: (context, provider, child) {
                final state = provider.homeEvent;
                if (state is Error) {
                  return Center(
                      child: ErrorTryAgain(margin: const EdgeInsets.symmetric(horizontal: 20), positiveClickListener: () => provider.getHome()));
                } else if (state is Data) {
                  final List<InfoModel> infoList = state.data;
                  return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      itemBuilder: (_, i) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('Synopsis :', style: Theme.of(context).textTheme.titleMedium),
                            5.ph,
                            Text(infoList[i].synopsis, style: Theme.of(context).textTheme.bodySmall),
                            10.ph,
                            Row(children: [
                              Text('Years Aired :', style: Theme.of(context).textTheme.titleMedium),
                              5.pw,
                              Text(infoList[i].yearsAired, style: Theme.of(context).textTheme.bodySmall)
                            ]),
                            10.ph,
                            Text('Creators :', style: Theme.of(context).textTheme.titleMedium),
                            if (infoList[i].creators != null)
                              Column(
                                  children: infoList[i]
                                      .creators!
                                      .map((e) => GestureDetector(
                                          onTap: () => launchUrl(Uri.parse(e.url)),
                                          child: Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(e.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(decoration: TextDecoration.underline, fontSize: 14)))))
                                      .toList()),
                            20.ph,
                            Row(children: [
                              Expanded(
                                  child: AppButton(
                                      text: AppStrings.CHARACTARS,
                                      textColor: Theme.of(context).scaffoldBackgroundColor,
                                      color: Theme.of(context).primaryColor,
                                      onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CharacterScreen())))),
                              30.pw,
                              Expanded(
                                  child: AppButton(
                                      text: AppStrings.QUIZ,
                                      color: Theme.of(context).primaryColor,
                                      textColor: Theme.of(context).scaffoldBackgroundColor,
                                      onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()))))
                            ])
                          ]),
                      separatorBuilder: (_, i) => const SizedBox(height: 10),
                      itemCount: infoList.length);
                }
                return const Center(child: CircularProgressIndicator.adaptive());
              }));
        }));
  }
}
