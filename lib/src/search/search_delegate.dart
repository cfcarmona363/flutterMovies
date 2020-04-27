import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions del appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: peliculasProvider.buscarPelicula(query),
            builder:
                (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              final peliculas = snapshot.data;
              return snapshot.hasData
                  ? ListView(
                      children: peliculas.map((pelicula) {
                        return ListTile(
                          leading: FadeInImage(
                            image: NetworkImage(pelicula.getImg()),
                            placeholder: AssetImage('assets/img/loading.gif'),
                          ),
                          title: Text(
                              pelicula.title != null ? pelicula.title : ''),
                          subtitle: Text(pelicula.releaseDate != null
                              ? pelicula.releaseDate
                              : ''),
                          onTap: () {
                            close(context, null);
                            pelicula.uniqueId = '${pelicula.id}-search';
                            Navigator.pushNamed(context, 'detalle',
                                arguments: pelicula);
                          },
                        );
                      }).toList(),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          );
  }
}
