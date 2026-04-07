import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:yamazone/controller/forms/quill_editor_controller.dart';
import 'package:yamazone/helpers/utils/ui_mixins.dart';
import 'package:yamazone/helpers/widgets/my_breadcrumb.dart';
import 'package:yamazone/helpers/widgets/my_breadcrumb_item.dart';
import 'package:yamazone/helpers/widgets/my_flex.dart';
import 'package:yamazone/helpers/widgets/my_flex_item.dart';
import 'package:yamazone/helpers/widgets/my_spacing.dart';
import 'package:yamazone/helpers/widgets/my_text.dart';
import 'package:yamazone/helpers/widgets/my_text_style.dart';
import 'package:yamazone/helpers/widgets/responsive.dart';
import 'package:yamazone/views/layouts/layout.dart';

class QuillEditor extends StatefulWidget {
  const QuillEditor({Key? key}) : super(key: key);

  @override
  State<QuillEditor> createState() => _QuillEditorState();
}

class _QuillEditorState extends State<QuillEditor>
    with SingleTickerProviderStateMixin, UIMixin {
  late QuillHtmlEditorController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(QuillHtmlEditorController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Quill HTML Editor", fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Forms"),
                        MyBreadcrumbItem(
                          name: "Quill HTML Editor",
                          active: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(200),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyFlex(
                  children: [
                    MyFlexItem(sizes: "lg-8", child: Column(children: [])),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
