import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ParallaxImage extends StatelessWidget {
  final ImageProvider image;
  final ScrollController scrollController;
  final double extent;
  final Color color;
  final Widget child;

  ParallaxImage({
    Key key,
    @required this.image,
    @required this.extent,
    this.scrollController,
    this.color,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollPosition = scrollController != null
        ? scrollController.position
        : Scrollable.of(context).position;
    return new RepaintBoundary(
      child: new ConstrainedBox(
          constraints: (scrollPosition.axis == Axis.horizontal)
              ? new BoxConstraints(minWidth: extent)
              : new BoxConstraints(minHeight: extent),
          child: new _Parallax(
              image: image,
              scrollPosition: scrollPosition,
              screenSize: MediaQuery.of(context).size)),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);

    description.add(new DoubleProperty('extent', extent));
    description.add(new DiagnosticsProperty<ImageProvider>('image', image));
    description.add(new DiagnosticsProperty<Color>('color', color));
  }
}

class _Parallax extends SingleChildRenderObjectWidget {
  _Parallax({
    Key key,
    @required this.image,
    @required this.scrollPosition,
    @required this.screenSize,
    this.color,
    Widget child,
  }) : super(key: key, child: child);
  final ImageProvider image;
  final ScrollPosition scrollPosition;
  final Size screenSize;
  final Color color;

  @override
  _RenderParallax createRenderObject(BuildContext context) {
    return new _RenderParallax(
        image: image,
        scrollPosition: scrollPosition,
        screenSize: screenSize,
        color: color);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderParallax renderObject) {
    renderObject
      ..image = image
      ..scrollPosition = scrollPosition
      ..screenSize = screenSize
      ..color = color;
  }
}

class _RenderParallax extends RenderProxyBox {
  _RenderParallax(
      {@required ImageProvider image,
      @required ScrollPosition scrollPosition,
      @required Size screenSize,
      Color color,
      ImageConfiguration configuration: ImageConfiguration.empty,
      RenderBox child})
      : _image = image,
        _scrollPosition = scrollPosition,
        _screenSize = screenSize,
        _color = color,
        _imageConfiguration = configuration,
        super(child);

  Decoration _decoration;

  Decoration get decoration {
    if (_decoration != null) return _decoration;

    Alignment alignment;
    if (_scrollPosition.axis == Axis.vertical) {
      double value = (_position.dy / _screenSize.height - 0.5).clamp(-1.0, 1.0);
      alignment = Alignment(0.0, value);
    } else if (_scrollPosition.axis == Axis.horizontal) {
      double value = (_position.dx / _screenSize.width - 0.5).clamp(-1.0, 1.0);
      alignment = Alignment(value, 0.0);
    }

    _decoration = new BoxDecoration(
        color: _color,
        image:
            new DecorationImage(image: _image, alignment: alignment, fit: fit));

    return _decoration;
  }

  BoxFit get fit {
    return _scrollPosition.axis == Axis.horizontal
        ? BoxFit.fitHeight
        : BoxFit.fitWidth;
  }

  ImageProvider _image;

  set image(ImageProvider value) {
    if (value == _image) return;
    _image = value;
    _painter?.dispose();
    _painter = null;
    _decoration = null;
    markNeedsPaint();
  }

  ScrollPosition _scrollPosition;

  set scrollPosition(ScrollPosition value) {
    if (value == _scrollPosition) return;
    if (attached) _scrollPosition.removeListener(markNeedsPaint);
    _scrollPosition = value;
    if (attached) _scrollPosition.addListener(markNeedsPaint);
    markNeedsPaint();
  }

  Size _screenSize;

  set screenSize(Size value) {
    if (value == _screenSize) return;
    _screenSize = value;
    markNeedsPaint();
  }

  Color _color;

  set color(Color value) {
    if (value == _color) return;
    _color = value;
    _painter?.dispose();
    _painter = null;
    _decoration = null;
    markNeedsPaint();
  }

  ImageConfiguration _imageConfiguration;

  ImageConfiguration get imageConfiguration => _imageConfiguration;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scrollPosition.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _painter?.dispose();
    _painter = null;
    _scrollPosition.removeListener(markNeedsPaint);
    super.detach();
    markNeedsPaint();
  }

  BoxPainter _painter;
  Offset _position;

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(size.width != null);
    assert(size.height != null);
    var pos = localToGlobal(new Offset(size.width / 2, size.height / 2));
    if (_position != pos) {
      _painter?.dispose();
      _painter = null;
      _decoration = null;
      _position = pos;
    }
    _painter ??= decoration.createBoxPainter(markNeedsPaint);
    final ImageConfiguration filledConfiguration =
        imageConfiguration.copyWith(size: size);
    int debugSaveCount;
    assert(() {
      debugSaveCount = context.canvas.getSaveCount();
      return true;
    }());
    _painter.paint(context.canvas, offset, filledConfiguration);

    if (decoration.isComplex) context.setIsComplexHint();
    super.paint(context, offset);
  }

  void clean() {
    _painter?.dispose();
    _painter = null;
    _decoration = null;
    markNeedsPaint();
  }

@override
  bool hitTestSelf(Offset position) => true;
}
