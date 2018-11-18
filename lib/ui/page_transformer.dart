import 'package:flutter/material.dart';

class PageTransformer extends StatefulWidget {
  PageViewBuilder pageViewBuilder;

  PageTransformer({@required this.pageViewBuilder});

  @override
  _PageTransformerState createState() => _PageTransformerState();
}

class _PageTransformerState extends State<PageTransformer> {
  PageVisibilityResolver _visibilityResolver;

  @override
  Widget build(BuildContext context) {
    var pageView =
        widget.pageViewBuilder(_visibilityResolver ?? PageVisibilityResolver());

    return NotificationListener<ScrollNotification>(
        child: pageView,
        onNotification: (ScrollNotification notification) {
          setState(() {
            _visibilityResolver = PageVisibilityResolver(
                metrics: notification.metrics,
                viewPortFraction: pageView.controller.viewportFraction);
          });
        });
  }
}

typedef PageView PageViewBuilder(PageVisibilityResolver resolver);

class PageVisibilityResolver {
  ScrollMetrics _pageMetrics;
  double _viewPortFraction;

  PageVisibilityResolver({ScrollMetrics metrics, double viewPortFraction})
      : this._pageMetrics = metrics,
        this._viewPortFraction = viewPortFraction;

  PageVisibility resolvePageVisibility(int pageIndex) {
    double pagePosition = _calculatePagePosition(pageIndex);

    return PageVisibility(
        visibleFraction: _calculatePageVisibleFraction(pagePosition),
        pagePosition: pagePosition);
  }

  double _calculatePageVisibleFraction(double pagePosition) {
    return 1.0 - pagePosition.abs();
  }

  double _calculatePagePosition(int index) {
    double viewPortFraction = _viewPortFraction ?? 1.0;
    double pageWidth =
        (_pageMetrics?.viewportDimension ?? 1.0) * viewPortFraction;

    /// scrolled pixels of [PageView]
    double scrollX = _pageMetrics?.pixels ?? 0.0;

    /// total extend pixels of current page from start of [PageView]
    double pageX = pageWidth * index;

    //[-1.0, 1.0]
    double pagePosition = (pageX - scrollX) / pageWidth;
    double safePagePosition = !pagePosition.isNaN ? pagePosition : 0.0;

    return safePagePosition.clamp(-1.0, 1.0);
  }
}

class PageVisibility {
  /// How much of the page is currently visible, between 0.0 and 1.0.
  double visibleFraction;

  /// For example, if the page is fully visible, this value equals 0.0.
  ///
  /// If the page is fully out of view on the right, this value is
  /// going to be 1.0.
  ///
  /// Likewise, if the page is fully out of view, on the left, this
  /// value is going to be -1.0.
  double pagePosition;

  PageVisibility({@required this.visibleFraction, @required this.pagePosition});
}
