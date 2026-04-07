import 'package:yamazone/controller/my_controller.dart';
import 'package:yamazone/models/discover.dart';

class TimeLineController extends MyController {
  List<Discover> discover = [];

  @override
  void onInit() {
    super.onInit();
    Discover.dummyList.then((value) {
      discover = value.sublist(0, 10);
      update();
    });
  }
}
