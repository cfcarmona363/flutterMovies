import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

Widget movieCard(BuildContext context, Pelicula pelicula) {
  pelicula.uniqueId = '${pelicula.id}-footer';
  final tarjeta = Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(pelicula.getImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 130,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ));

  return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      });
}
