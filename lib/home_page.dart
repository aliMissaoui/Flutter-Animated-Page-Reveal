import 'dart:async';

import 'package:flutter/material.dart';
import 'package:on_boarding_screen/page_dragger.dart';
import 'package:on_boarding_screen/page_reveal.dart';
import 'package:on_boarding_screen/pager_indicator.dart';
import 'package:on_boarding_screen/pages.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger? animatedPageDragger;

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  _MyHomePageState() : slideUpdateStream = StreamController<SlideUpdate>() {
    //slideUpdateStream = StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }

          //nextPageIndex.clamp(0.0, pages.length -1);

        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = AnimatedPageDragger(slideDirection,
                TransitionGoal.open, slidePercent, slideUpdateStream, this);
          } else {
            animatedPageDragger = AnimatedPageDragger(slideDirection,
                TransitionGoal.close, slidePercent, slideUpdateStream, this);

            nextPageIndex = activeIndex;
          }
          animatedPageDragger!.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger!.dispose();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageContent(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          PageReveal(
            revealPercent: slidePercent,
            child: PageContent(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          PagerIndicator(
            viewModel: PagerIndicatorViewModel(
                pages, activeIndex, slideDirection, slidePercent),
          ),
          PageDragger(
            slideUpdateStream: this.slideUpdateStream,
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
          ),
        ],
      ),
    );
  }
}
