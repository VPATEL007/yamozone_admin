import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yamazone/controller/apps/kyc_controller.dart';
import 'package:yamazone/helpers/theme/admin_theme.dart';
import 'package:yamazone/helpers/utils/ui_mixins.dart';
import 'package:yamazone/views/apps/listing_moderation/widget/listing_dialog.dart';
import 'package:yamazone/views/apps/orders_escrow/order_detail_page.dart';
import 'package:yamazone/views/layouts/layout.dart';

class ListingDetailView extends StatefulWidget {
  const ListingDetailView({super.key});

  @override
  State<ListingDetailView> createState() => _ListingDetailViewState();
}

class _ListingDetailViewState extends State<ListingDetailView>
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
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: kBg,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: kBorder),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 18,
                            color: kTextPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Listing Detail',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: kTextPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT CONTENT
                      Expanded(flex: 2, child: _listingDetailSection()),

                      const SizedBox(width: 20),

                      // RIGHT PANEL
                      Expanded(flex: 1, child: _rightPanel()),
                    ],
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
    return Column(
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
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 10),

        // PRICE + TAGS
        Row(
          children: [
            Text(
              "\$299.99",
              style: GoogleFonts.montserrat(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: contentTheme.primary,
              ),
            ),
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 15),

        const Text(
          "Features include:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Industry-leading noise cancellation"),
            Text("• 30-hour battery life"),
            Text("• Quick charge (3 min = 3 hours playback)"),
            Text("• Touch controls"),
            Text("• Speak-to-chat technology"),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          "No visible wear or damage. Selling due to upgrade to newer model.",
        ),
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
    child: Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ContentTheme.lightContentTheme.primary,
      ),
    ),
  );
}

Widget _rightPanel() {
  return Column(
    children: [
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Seller Information",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Alex Johnson",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text("⭐⭐⭐⭐⭐ 4.9"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Listings",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B),
                      ),
                    ),
                    Text(
                      "47",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Account Age",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B),
                      ),
                    ),
                    Text(
                      "2.5 years",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 15),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Seller History",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Approved Listings",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "45",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff073B25),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rejected Listings",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "2",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ContentTheme.lightContentTheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Reports",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "0",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff073B25),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.check_circle, size: 18, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  "Verified Email",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4B4B4B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.check_circle, size: 18, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  "Verified Phone",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4B4B4B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 15),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Listing History",
              style: GoogleFonts.montserrat(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Created Date",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "January 8, 2024",
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Last Edited",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "January 10, 2024",
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Status",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text("Pending Review"),
            SizedBox(height: 10),
            Text(
              "Reports",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "No reports filed",
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xffd4a32b),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.done, size: 20, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        "Approve",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor:
                        LeftBarTheme.lightLeftBarTheme.activeItemBackground,
                  ),
                  onPressed: () {
                    showDialog(
                      context: Get.context!,
                      builder:
                          (_) => RejectListingDialog(
                            onCancel: () => Navigator.pop(Get.context!),
                            onSubmit: (category, subReason, reason, sendEmail) {
                              Navigator.pop(Get.context!);
                            },
                          ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.close, size: 20, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        "Reject",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xffd4a32b),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.question_mark_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Edit",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _card({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
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
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
