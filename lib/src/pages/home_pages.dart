import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/horizontal_scroll_widget.dart';
import 'package:peliculas/src/widgets/movie_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulars();

    return Scaffold(
        appBar: AppBar(
          title: Text('Movies on theaters'),
          backgroundColor: Colors.teal,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ),
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[_swiperTarjetas(), _footer(context)])));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        return snapshot.hasData
            ? CardSwiper(peliculas: snapshot.data)
            : Container(
                height: 200, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 15),
                child: Text('Popular movies',
                    style: Theme.of(context).textTheme.subhead)),
            SizedBox(height: 15),
            StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                return snapshot.hasData
                    ? HorizontalScroll(
                        items: snapshot.data,
                        siguientePagina: peliculasProvider.getPopulars,
                        card: movieCard)
                    : Container(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()));
              },
            ),
          ]),
    );
  }
}
