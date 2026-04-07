import 'package:yamazone/controller/my_controller.dart';
import 'package:yamazone/helpers/widgets/my_form_validator.dart';
import 'package:yamazone/models/discover.dart';
import 'package:yamazone/models/opportunities.dart';

class MemberListController extends MyController {
  List<Discover> discover = [];
  List<Opportunities> opportunities = [];

  MyFormValidator basicValidator = MyFormValidator();
  bool loading = false;

  @override
  void onInit() {
    super.onInit();

    Discover.dummyList.then((value) {
      discover = value.sublist(0, 7);
      update();
    });
    Opportunities.dummyList.then((value) {
      opportunities = value.sublist(0, 7);
      update();
    });
  }
}
