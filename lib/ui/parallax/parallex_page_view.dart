import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/parallax/parallex_item.dart';
import 'package:flutter_movie/ui/parallax/parallex_page_item.dart';

class ParallexPageView extends StatelessWidget {
  final List<ParallexItem> list;

  ParallexPageView(this.list);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.fromHeight(150.0),
      child: PageView.builder(
          controller: PageController(
            viewportFraction: 0.75,
          ),
          itemBuilder: (context, index) => ParallexPageItem(
              imageUrl: list[index].imageUrl, imagePath: list[index].imagePath),
          itemCount: list.length),
    );
  }
}
