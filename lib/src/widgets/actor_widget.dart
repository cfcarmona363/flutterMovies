import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';

Widget actorCard(BuildContext context, Actor actor) {
  return Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(actor.getImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 130,
            ),
          ),
          SizedBox(height: 5),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subhead,
          ),
          SizedBox(height: 5),
          Text(
            actor.character,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ));
}
