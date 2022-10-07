import 'package:blok_project/data_layer/models/characters.dart';
import 'package:flutter/material.dart';

import '../../constans/strings.dart';

class ShowCharacters extends StatelessWidget {
  final Character character;

  const ShowCharacters({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
      padding: const EdgeInsetsDirectional.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap:()=>Navigator.of(context).pushNamed(characterDetailsScreen,arguments: character) ,
        child: GridTile(
          footer: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            color: Colors.black45,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: character.charId,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: character.imageUrl.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: character.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Image.asset('assets/images/OIP.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
