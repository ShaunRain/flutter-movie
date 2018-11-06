import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/parallax/parallax_image.dart';
import 'package:transparent_image/transparent_image.dart';
//import 'package:image/image.dart';

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

  Widget _buildPhoto(String photo) {
    return Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: FadeInImage.memoryNetwork(
              fadeInDuration: Duration(milliseconds: 200),
              placeholder: kTransparentImage,
              image: photo,
              width: 160.0,
              height: 120.0,
              fit: BoxFit.cover),
        ));
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
            itemBuilder: (context, index) =>
                _buildPhoto(photoUrls[index]),
            itemCount: photoUrls.length,
          ),
        )
      ],
    );
  }
}
