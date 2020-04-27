import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Swiper(
        itemCount: peliculas.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.55,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-cine';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'detalle',
                  arguments: peliculas[index]),
              child: ClipRRect(
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/loading.gif'),
                    fit: BoxFit.cover,
                    image: NetworkImage(peliculas[index].getImg()),
                  ),
                  borderRadius: BorderRadius.circular(20)),
            ),
          );
        },
      ),
    );
  }
}
