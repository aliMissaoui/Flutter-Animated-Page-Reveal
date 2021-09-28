import 'package:flutter/material.dart';

final pages = [
  PageViewModel(
    const Color(0xff195932),
    'assets/images/trip.png',
    'Choose your place',
    'Pick the right destination according to the season because it is a key factor for a successful trip',
    'assets/images/placeicon.png',
  ),
  PageViewModel(
    const Color(0xff19594E),
    'assets/images/flight.png',
    'Book your flight',
    'Found a flight that matches your destination and schedule? \nBook it just a few taps',
    'assets/images/planicon.png',
  ),
  PageViewModel(
    const Color(0xff193A59),
    'assets/images/explore.png',
    'Explore the world',
    'Easily discover new places and share them with your friends. \nMaybe you will plan together your next trip?',
    'assets/images/searchicon.png',
  ),
];

class PageContent extends StatelessWidget {
  const PageContent(
      {Key? key, required this.viewModel, this.percentVisible = 1.0})
      : super(key: key);

  final PageViewModel viewModel;
  final double percentVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: viewModel.color,
      child: Opacity(
        opacity: percentVisible,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 50.0 * (1 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Image.asset(
                  viewModel.heroAssetPath,
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Text(
                  viewModel.title,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 75.0, right: 20.0, left: 20.0),
                child: Text(
                  viewModel.body,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.iconAssetPath,
  );
}
