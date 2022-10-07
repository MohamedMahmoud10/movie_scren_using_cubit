part of 'characters_cubit.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  CharactersLoaded(this.characters);
}

class CharactersQuotes extends CharactersState {
  final List<Quote> quotes;
  CharactersQuotes(this.quotes);
}
