import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/parallax/parallax_image.dart';
import 'package:transparent_image/transparent_image.dart';
//import 'package:image/image.dart';

class PhotoCard extends StatelessWidget {
  List<String> photoUrls;
  int index;

  PhotoCard({this.photoUrls, this.index});

  @override
  Widget build(BuildContext context) {
    void pushFullScreenWidget() {
      final TransitionRoute<void> route = PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => _buildFullScreenPhotos());

      Navigator.push(context, route);
    }

    return GestureDetector(
        child: _buildInLinePhoto(), onTap: pushFullScreenWidget);
  }

  Widget _buildInLinePhoto() {
    return Hero(
        tag: 'photocard-${index}',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: FadeInImage.memoryNetwork(
              fadeInDuration: Duration(milliseconds: 200),
              placeholder: kTransparentImage,
              image: photoUrls[index],
              width: 160.0,
              height: 120.0,
              fit: BoxFit.cover),
        ));
  }

  Widget _buildFullScreenPhotos() {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Colors.black,
      body: Center(
        child: PageView.builder(
            controller: PageController(initialPage: index),
            itemCount: photoUrls.length,
            itemBuilder: (context, index) => Hero(
                  tag: 'photocard-${index}',
                  child: GestureDetector(
                    child: FadeInImage.memoryNetwork(
                        fadeInDuration: Duration(milliseconds: 200),
                        placeholder: kTransparentImage,
                        image: photoUrls[index],
                        fit: BoxFit.contain),
                    onTap: () => Navigator.of(context).pop(),
                    onVerticalDragEnd: (detail) => Navigator.of(context).pop(),
                  ),
                )),
      ),
    );
  }
}

class PhotoScroller extends StatelessWidget {
  final List<String> photoUrls;

  PhotoScroller(this.photoUrls);

  Widget _buildHorizontalChild(BuildContext context, int index) {
    return new Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: new ParallaxImage(
              extent: 160.0,
              image: Image.network(photoUrls[index],
                      width: 160.0, height: 120.0, fit: BoxFit.cover)
                  .image)),
    );
  }

  Widget _buildPhoto(index) {
    return Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: PhotoCard(photoUrls: photoUrls, index: index));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Stage Photos',
            style: textTheme.subhead.copyWith(fontSize: 18.0),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(100.0),
          child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8.0, left: 20.0),
            itemBuilder: (context, index) => _buildPhoto(index),
            itemCount: photoUrls.length,
          ),
        )
      ],
    );
  }
}
