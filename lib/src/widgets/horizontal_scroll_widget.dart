import 'package:flutter/material.dart';

class HorizontalScroll extends StatelessWidget {
  final List items;
  final Function siguientePagina;
  final Function card;

  HorizontalScroll(
      {@required this.items, @required this.card, this.siguientePagina});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    if (siguientePagina != null) {
      _pageController.addListener(() {
        if (_pageController.position.pixels >=
            _pageController.position.maxScrollExtent - 200) {
          siguientePagina();
        }
      });
    }

    return Container(
        height: _screenSize.height * 0.25,
        child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: items.length,
          itemBuilder: (context, i) {
            final something = card(context, items[i]);
            return something;
          },
          // children: _tarjetas(context)),
        ));
  }

  // Widget _tarjeta(BuildContext context, Pelicula pelicula) {
  //   final tarjeta = Container(
  //       margin: EdgeInsets.only(right: 15),
  //       child: Column(
  //         children: <Widget>[
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20),
  //             child: FadeInImage(
  //               image: NetworkImage(pelicula.getImg()),
  //               placeholder: AssetImage('assets/img/no-image.jpg'),
  //               fit: BoxFit.cover,
  //               height: 130,
  //             ),
  //           ),
  //           SizedBox(height: 5),
  //           Text(
  //             pelicula.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           )
  //         ],
  //       ));

  //   return GestureDetector(
  //       child: tarjeta,
  //       onTap: () {
  //         Navigator.pushNamed(context, 'detalle', arguments: pelicula);
  //       });
  // }

  // List<Widget> _tarjetas(BuildContext context) {
  //   return peliculas.map((pelicula) {
  //     return Container(
  //         margin: EdgeInsets.only(right: 15),
  //         child: Column(
  //           children: <Widget>[
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(20),
  //               child: FadeInImage(
  //                 image: NetworkImage(pelicula.getImg()),
  //                 placeholder: AssetImage('assets/img/no-image.jpg'),
  //                 fit: BoxFit.cover,
  //                 height: 130,
  //               ),
  //             ),
  //             SizedBox(height: 5),
  //             Text(
  //               pelicula.title,
  //               overflow: TextOverflow.ellipsis,
  //               style: Theme.of(context).textTheme.caption,
  //             )
  //           ],
  //         ));
  //   }).toList();
  // }
}
