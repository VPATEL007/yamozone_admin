import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yamazone/controller/my_controller.dart';
import 'package:yamazone/helpers/widgets/my_text_utils.dart';

class LandingController extends MyController {
  List<String> dummyTexts = List.generate(
    12,
    (index) => MyTextUtils.getDummyText(60),
  );
  int animatedCarouselSize = 3;
  int selectedAnimatedCarousel = 0;

  Timer? timerAnimation;
  var defaultIndex = 0, backgroundIndex = 0;

  final PageController animatedPageController = PageController(initialPage: 0);
  final TickerProvider tickerProvider;

  late TabController defaultTabController = TabController(
    length: 6,
    vsync: tickerProvider,
    initialIndex: defaultIndex,
  );

  LandingController(this.tickerProvider);

  @override
  void onInit() {
    super.onInit();
  }

  void onChangeAnimatedCarousel(int value) {
    selectedAnimatedCarousel = value;
    update();
  }
}
