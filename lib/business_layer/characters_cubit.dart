import 'package:bloc/bloc.dart';
import '../data_layer/models/aute.dart';
import '../data_layer/models/characters.dart';
import '../data_layer/repositry/characters_repositry.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  List<Character> characters = [];
  final CharactersRepositry charactersRepositry;

  CharactersCubit(this.charactersRepositry) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepositry.getAllCharactersData().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters == characters;
    });
    return characters;
  }

  void getAllQuotes(String characterQuote) {
    charactersRepositry.getCharactersQuote(characterQuote).then((quote) {
      emit(CharactersQuotes(quote));
    });
  }
}
