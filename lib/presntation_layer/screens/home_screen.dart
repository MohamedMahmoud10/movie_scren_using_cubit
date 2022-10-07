import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../business_layer/characters_cubit.dart';
import '../../data_layer/models/characters.dart';
import '../widgets/character_show.dart';
import '../widgets/no_internet_connection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Character> allCharacters;
  List<Character> searchedCharacters = [];
  bool _isSearching = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildAppBarSearch() {
    return TextField(
      controller: searchController,
      style: const TextStyle(
        fontSize: 20,
      ),
      cursorColor: Colors.grey,
      decoration: const InputDecoration(
          hintText: 'Search For Character...',
          hintStyle: TextStyle(fontSize: 18),
          border: InputBorder.none),
      onChanged: (searchedCharacter) {
        addSearchedCharacterToList(searchedCharacter);
      },
    );
  }

  void addSearchedCharacterToList(String searchedCharacter) {
    searchedCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Home Screen',
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        leading: _isSearching
            ? const BackButton(
                color: Colors.white,
              )
            : Container(),
        title: _isSearching ? _buildAppBarSearch() : _buildAppBarTitle(),
        backgroundColor: Colors.black,
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BlocBuilder<CharactersCubit, CharactersState>(
              builder: (context, state) {
                if (state is CharactersLoaded) {
                  allCharacters = (state).characters;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 3,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1),
                            itemCount: searchController.text.isEmpty
                                ? allCharacters.length
                                : searchedCharacters.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return ShowCharacters(
                                character: searchController.text.isEmpty
                                    ? allCharacters[index]
                                    : searchedCharacters[index],
                              );
                            })
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return const NoInternetConnection();
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
