import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/actor_widget.dart';
import 'package:peliculas/src/widgets/horizontal_scroll_widget.dart';

class PeliculaDetalle extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    peliculasProvider.getCast(pelicula.id.toString());

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(pelicula),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10,
          ),
          _posterTitulo(context, pelicula),
          _descripion(pelicula),
          _actores(context, pelicula)
        ]))
      ],
    ));
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.teal,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        background: FadeInImage(
            image: NetworkImage(pelicula.getBackgroundImg()),
            fadeInDuration: Duration(milliseconds: 10),
            placeholder: AssetImage('assets/img/loading.gif'),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(pelicula.getImg()),
                  height: 150,
                ),
              ),
            ),
            SizedBox(width: 20),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                    )
                  ],
                )
              ],
            ))
          ],
        ));
  }

  Widget _descripion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _actores(BuildContext context, pelicula) {
    return Container(
      width: double.infinity,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 15, top: 50),
                child:
                    Text('Cast', style: Theme.of(context).textTheme.subhead)),
            SizedBox(height: 15),
            FutureBuilder(
              future: peliculasProvider.getCast(pelicula.id.toString()),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                return snapshot.hasData
                    ? HorizontalScroll(items: snapshot.data, card: actorCard)
                    : Container(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()));
              },
            ),
          ]),
    );
  }
}
