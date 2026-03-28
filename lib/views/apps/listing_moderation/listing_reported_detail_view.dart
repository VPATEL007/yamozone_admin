import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webkit/controller/apps/kyc_controller.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/layouts/layout.dart';

class ListingReportedDetailView extends StatefulWidget {
  const ListingReportedDetailView({super.key});

  @override
  State<ListingReportedDetailView> createState() =>
      _ListingReportedDetailViewState();
}

class _ListingReportedDetailViewState extends State<ListingReportedDetailView>
    with SingleTickerProviderStateMixin, UIMixin {
  late KYCController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(KYCController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT CONTENT
                  Expanded(
                    flex: 2,
                    child: _listingDetailSection(),
                  ),

                  const SizedBox(width: 20),

                  // RIGHT PANEL
                  Expanded(
                    flex: 1,
                    child: _rightPanel(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listingDetailSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE BOX
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          const SizedBox(height: 12),

          // THUMBNAILS
          Row(
            children: List.generate(
              4,
              (index) => Container(
                margin: const EdgeInsets.only(right: 10),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // TITLE
          Text(
            "Sony WH-1000XM5 Wireless Noise Canceling Headphones",
            style: GoogleFonts.montserrat(
                fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
          ),

          const SizedBox(height: 10),

          // PRICE + TAGS
          Row(
            children: [
              Text("\$299.99",
                  style: GoogleFonts.montserrat(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: contentTheme.primary)),
              const SizedBox(width: 10),
              _tag("Electronics"),
              const SizedBox(width: 8),
              _tag("Like New"),
            ],
          ),

          const SizedBox(height: 20),

          // CATEGORY + CONDITION
          Row(
            children: const [
              Expanded(child: _infoTile("Category", "Audio & Electronics")),
              Expanded(child: _infoTile("Condition", "Like New")),
            ],
          ),

          const SizedBox(height: 20),

          // DESCRIPTION
          const Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Premium wireless noise-canceling headphones in excellent condition. "
            "Used only for a few months, comes with original packaging, charging cable, and carrying case.",
            style: GoogleFonts.montserrat(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          ),

          const SizedBox(height: 15),

          const Text("Specifications",
              style: TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          _specGrid(),

          const SizedBox(height: 10),

          _evidenceSection(),
        ],
      ),
    );
  }

  Widget _evidenceSection() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.photo_sharp,
                color: contentTheme.primary,
              ),
              SizedBox(width: 10),
              Text("Evidence Submitted",
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
              3,
              (i) => Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    color: Colors.black54,
                    child: Text(
                      "Evidence ${i + 1}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _specGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 10,
      children: const [
        _specItem("Movement", "Swiss Automatic"),
        _specItem("Case Diameter", "42mm"),
        _specItem("Crystal", "Sapphire"),
        _specItem("Case Material", "Stainless Steel"),
        _specItem("Water Resistance", "100m"),
        _specItem("Strap", "Leather"),
      ],
    );
  }
}

Widget _tag(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: ContentTheme.lightContentTheme.primary.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(text,
        style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: ContentTheme.lightContentTheme.primary)),
  );
}

Widget _rightPanel() {
  return Column(
    children: [
      _reportDetails(),
      const SizedBox(height: 15),
      _actionButtons(),
      const SizedBox(height: 15),
      _activityHistory(),
    ],
  );
}

Widget _reportDetails() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag_circle_rounded, size: 40),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Report Details",
                    style: GoogleFonts.montserrat(
                        fontSize: 17, fontWeight: FontWeight.w700)),
                Text("Review and take action",
                    style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "Report Reason",
          style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xff4B4B4B)),
        ),
        SizedBox(height: 5),
        _tag("Counterfeit Item"),
        SizedBox(height: 10),
        Text(
          "Reported by",
          style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xff4B4B4B)),
        ),
        Text("John D (Buyer)"),
        SizedBox(height: 10),
        Text(
          "Reported on",
          style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xff4B4B4B)),
        ),
        Text(
          "12 Mar 2024",
          style: GoogleFonts.montserrat(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(height: 10),
        Text(
          "Priority",
          style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xff4B4B4B)),
        ),
        _tag("High"),
        SizedBox(height: 10),
        Text("User Note",
            style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xff4B4B4B))),
        SizedBox(height: 10),
        _card(
          child: Text(
            "\"This product seems fake. The serial number doesn't match official records...\"",
            style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xff4B4B4B)),
          ),
        ),
      ],
    ),
  );
}

Widget _actionButtons() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Actions",
            style: GoogleFonts.montserrat(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        SizedBox(height: 10),
        _btn("Remove Listing", ContentTheme.lightContentTheme.primary,
            child: Icon(Icons.block)),
        _btn("Suspend Seller",
            LeftBarTheme.lightLeftBarTheme.activeItemBackground,
            child: Icon(Icons.person_off)),
        _btn("Contact Seller", ContentTheme.lightContentTheme.primary,
            child: Icon(Icons.email)),
        _btn("Mark as Resolved", Color(0xffE5E7EB),
            child: Icon(Icons.check_circle)),
        _btn("Dismiss Report", Colors.white,
            textColor: Colors.black, child: Icon(Icons.close)),
      ],
    ),
  );
}

Widget _btn(String text, Color color,
    {Color textColor = Colors.white, required Widget child}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        backgroundColor: color,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          SizedBox(width: 10),
          Text(text,
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color:
                      (text == "Dismiss Report") || (text == "Mark as Resolved")
                          ? Colors.black
                          : Colors.white)),
        ],
      ),
    ),
  );
}

Widget _activityHistory() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Activity History",
          style: GoogleFonts.montserrat(
              fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.flag_circle_rounded, size: 30),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Report Submitted",
                    style: GoogleFonts.montserrat(
                        fontSize: 13, fontWeight: FontWeight.w700)),
                Text("Review and take action",
                    style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B))),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.flag_circle_rounded, size: 30),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Under Review",
                    style: GoogleFonts.montserrat(
                        fontSize: 13, fontWeight: FontWeight.w700)),
                Text("12 Mar 2024, 11:20 AM",
                    style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B))),
              ],
            ),
          ],
        ).paddingSymmetric(vertical: 12),
        Row(
          children: [
            Icon(Icons.attachment, size: 30),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Evidence Added",
                    style: GoogleFonts.montserrat(
                        fontSize: 13, fontWeight: FontWeight.w700)),
                Text("12 Mar 2024, 11:20 AM",
                    style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B))),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

class _timeline extends StatelessWidget {
  final String title;

  const _timeline(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 10, color: Colors.orange),
        const SizedBox(width: 8),
        Text(title),
      ],
    );
  }
}

Widget _card({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
        )
      ],
    ),
    child: child,
  );
}

class _infoTile extends StatelessWidget {
  final String title;
  final String value;

  const _infoTile(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
      ],
    );
  }
}

class _specItem extends StatelessWidget {
  final String title;
  final String value;

  const _specItem(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle,
                color: ContentTheme.lightContentTheme.primary, size: 16)
            .paddingOnly(top: 10),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title: ",
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            Text(value,
                style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4B4B4B))),
          ],
        ),
      ],
    );
  }
}
