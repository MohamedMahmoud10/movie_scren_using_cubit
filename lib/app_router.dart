import 'package:blok_project/business_layer/characters_cubit.dart';
import 'package:blok_project/data_layer/api_services/api_services.dart';
import 'package:blok_project/data_layer/models/characters.dart';
import 'package:blok_project/data_layer/repositry/characters_repositry.dart';
import 'package:blok_project/presntation_layer/screens/detail_screen.dart';
import 'package:blok_project/presntation_layer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constans/strings.dart';

class AppRouter {
  late CharactersRepositry charactersRepositry;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepositry = CharactersRepositry(ApiServices());
    charactersCubit = CharactersCubit(
      charactersRepositry,
    );
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext ctx) => charactersCubit,
            child: const HomeScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharactersCubit(charactersRepositry),
                  child: DetailsScreen(
                    character: character,
                  ),
                ));
    }
    return null;
  }
}
