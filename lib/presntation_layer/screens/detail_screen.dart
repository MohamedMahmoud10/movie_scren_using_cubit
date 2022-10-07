import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blok_project/business_layer/characters_cubit.dart';
import 'package:blok_project/data_layer/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/character_info.dart';
import '../widgets/divider.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;

  const DetailsScreen({Key? key, required this.character}) : super(key: key);

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is CharactersQuotes) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.yellow,
          strokeWidth: 4,
        ),
      );
    }
  }
  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 20, color: Colors.white, shadows: [
              Shadow(blurRadius: 10, offset: Offset(0, 0), color: Colors.yellow)
            ]),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText(quotes[randomQuoteIndex].quote)
              ],
            ),
          ));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getAllQuotes(character.name);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 600,
            stretch: true,
            backgroundColor: Colors.grey,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                character.nickname,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              background: Hero(
                tag: character.charId,
                child: Image.network(
                  character.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CharacterInfo(
                        title: 'name : ',
                        value: character.portrayed,
                      ),
                      const CharacterDivider(
                        endIndent: 320,
                      ),
                      CharacterInfo(
                        title: 'Birthday : ',
                        value: character.birthday,
                      ),
                      const CharacterDivider(
                        endIndent: 295,
                      ),
                      CharacterInfo(
                        title: 'Jop : ',
                        value: character.occupation.join('/'),
                      ),
                      const CharacterDivider(
                        endIndent: 335,
                      ),
                      CharacterInfo(
                        title: 'Appearance : ',
                        value: character.appearance.join('/'),
                      ),
                      const CharacterDivider(
                        endIndent: 270,
                      ),
                      CharacterInfo(
                        title: 'Appeared in : ',
                        value: character.category,
                      ),
                      const CharacterDivider(
                        endIndent: 265,
                      ),
                      CharacterInfo(
                        title: 'Status : ',
                        value: character.status,
                      ),
                      const CharacterDivider(
                        endIndent: 315,
                      ),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : CharacterInfo(
                              title: 'Better call saul appearance : ',
                              value:
                                  character.betterCallSaulAppearance.join('/'),
                            ),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : const CharacterDivider(
                              endIndent: 145,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                          builder: (context, state) {
                        return checkIfQuotesAreLoaded(state);
                      }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
