import 'package:blok_project/data_layer/api_services/api_services.dart';
import 'package:blok_project/data_layer/models/aute.dart';

import '../models/characters.dart';

class CharactersRepositry {
  final ApiServices apiServices;

  CharactersRepositry(this.apiServices);

  Future<List<Character>> getAllCharactersData() async {
    final charactersData = await apiServices.getAllCharactersData();
    final mapingData = charactersData
        .map((characters) => Character.fromJson(characters))
        .toList();
    return mapingData;
  }

  Future<List<Quote>> getCharactersQuote(String charName) async {
    final characterQuotes =
        await apiServices.getCharactersQuote(charName);
    final mapingData =
        characterQuotes.map((quote) => Quote.fromJson(quote)).toList();
    return mapingData;
  }
}
