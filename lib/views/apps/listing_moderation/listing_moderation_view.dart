import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webkit/controller/ui/nft_dashboard_controller.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/apps/listing_moderation/listing_detail_view.dart';
import 'package:webkit/views/apps/listing_moderation/listing_reported_detail_view.dart';
import 'package:webkit/views/layouts/layout.dart';

class ListingModerationView extends StatefulWidget {
  const ListingModerationView({super.key});

  @override
  State<ListingModerationView> createState() => _ListingModerationViewState();
}

class _ListingModerationViewState extends State<ListingModerationView>
    with SingleTickerProviderStateMixin, UIMixin {
  late NFTDashboardController controller;
  Timer? countdownTimer;
  Duration myDuration = const Duration(hours: 12);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    if (mounted) {
      const reduceSeconds = 1;

      final seconds = myDuration.inSeconds - reduceSeconds;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(NFTDashboardController());
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    debugPrint("$hours : $minutes : $seconds");
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return SizedBox(
              width: Get.width,
              height: Get.height * 0.90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// PAGE TITLE
                  // const Text(
                  //   "Listing Moderation",
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),

                  // const SizedBox(height: 20),

                  /// TABS
                  Row(
                    children: [
                      tabItem("Pending Listings", true, "24"),
                      const SizedBox(width: 25),
                      tabItem("Reported Listings", false, "8"),
                      const SizedBox(width: 25),
                      tabItem("Recently Approved", false, ""),
                    ],
                  ),

                  /// HEADER FILTER
                  Row(
                    children: [
                      Text(
                        "Pending Approval Queue",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Color(0xff1F2937),
                        ),
                      ),

                      const Spacer(),

                      /// CATEGORY DROPDOWN
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Row(
                          children: [
                            Text("All Categories",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff1F2937),
                                )),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// SEARCH
                      Container(
                        width: 250,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: const TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            hintText: "Search listings...",
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// LIST
                  Expanded(
                      child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => ListingItem(),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: 3)),

                  const SizedBox(height: 20),

                  /// PAGINATION
                  Row(
                    children: [
                      const Text(
                        "Showing 1-3 of 24 listings",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      paginationButton("Previous", false),
                      const SizedBox(width: 8),
                      paginationButton("1", true),
                      const SizedBox(width: 8),
                      paginationButton("2", false),
                      const SizedBox(width: 8),
                      paginationButton("3", false),
                      const SizedBox(width: 8),
                      const Text("..."),
                      const SizedBox(width: 8),
                      paginationButton("249", false),
                      const SizedBox(width: 8),
                      paginationButton("Next", false),
                    ],
                  )
                ],
              ).paddingSymmetric(horizontal: 20));
        },
      ),
    );
  }

  Widget tabItem(String title, bool active, String count) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: active ? contentTheme.primary : Colors.black,
          ),
        ),
        if (count.isNotEmpty) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xffF4E7C3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              count,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: active ? contentTheme.primary : Colors.black,
              ),
            ),
          )
        ]
      ],
    );
  }

  Widget paginationButton(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class ListingItem extends StatelessWidget {
  const ListingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// PRODUCT IMAGE
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.phone_iphone),
          ),

          const SizedBox(width: 16),

          /// PRODUCT DETAILS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("iPhone 15 Pro Max 256GB",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black)),
              SizedBox(height: 6),
              Text("Unlocked • Like New • Original Box",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xff4B4B4B))),
              SizedBox(height: 6),
              Text("\$1,100",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: ContentTheme.lightContentTheme.primary)),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.person, size: 20),
                  SizedBox(width: 4),
                  Text("Sarah Wilson",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xff4B4B4B))),
                  SizedBox(width: 10),
                  Icon(Icons.access_time, size: 20),
                  SizedBox(width: 4),
                  Text("6 hours ago",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xff4B4B4B))),
                  SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xffF4E7C3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Pending Review",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: ContentTheme.lightContentTheme.primary)),
                  ),
                ],
              )
            ],
          ),

          const Spacer(),
          InkWell(
            onTap: () {
              Get.to(() => ListingDetailView());
            },
            child: Icon(Icons.remove_red_eye_outlined,
                    size: 20, color: ContentTheme.lightContentTheme.primary)
                .paddingSymmetric(vertical: 5),
          ),
          SizedBox(width: 30),

          /// ACTION BUTTONS
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor:
                      LeftBarTheme.lightLeftBarTheme.activeItemBackground,
                ),
                onPressed: () {
                  Get.to(() => ListingReportedDetailView());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.done,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Approve",
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: ContentTheme.lightContentTheme.primary
                      .withValues(alpha: .14),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.close,
                      size: 20,
                      color: ContentTheme.lightContentTheme.primary,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Reject",
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: ContentTheme.lightContentTheme.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: ContentTheme.lightContentTheme.primary),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_square,
                      size: 18,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Edit",
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget actionButton(String title, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      onPressed: () {},
      child: Text(title),
    );
  }
}
