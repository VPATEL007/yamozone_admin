import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webkit/controller/apps/kyc_controller.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/images.dart';
import 'package:webkit/views/apps/kyc/widget/kyc_dialog.dart';
import 'package:webkit/views/layouts/layout.dart';

class KycApprovalPage extends StatefulWidget {
  const KycApprovalPage({super.key});

  @override
  State<KycApprovalPage> createState() => _KycApprovalPageState();
}

class _KycApprovalPageState extends State<KycApprovalPage>
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
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "KYC Approvals",
                      style: GoogleFonts.inter(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff111827)),
                    ),
                    SizedBox(
                      width: 260,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                /// STATS
                const Row(
                  children: [
                    Expanded(
                        child: KycStatCard("Pending Review", "24", "+12%")),
                    SizedBox(width: 16),
                    Expanded(child: KycStatCard("Approved Today", "47", "+8%")),
                    SizedBox(width: 16),
                    Expanded(child: KycStatCard("Rejected Today", "8", "-3%")),
                    SizedBox(width: 16),
                    Expanded(child: KycStatCard("Need More Info", "12", "-5%")),
                  ],
                ),

                const SizedBox(height: 10),

                /// TABS
                kycTbas(),

                /// FILTER BAR
                const KycFilterBar(),

                const SizedBox(height: 20),

                /// KYC LIST
                Obx(
                  () => controller.selectedTab.value == 0
                      ? Column(
                          children: const [
                            KycUserCard(),
                            SizedBox(height: 16),
                            KycUserCard(),
                            SizedBox(height: 16),
                            KycUserCard(),
                          ],
                        )
                      : Column(
                          children: const [
                            KycUserCard(),
                            SizedBox(height: 16),
                            KycUserCard(),
                            SizedBox(height: 16),
                            KycUserCard(),
                          ],
                        ),
                ),

                const SizedBox(height: 30),

                /// PAGINATION
                const KycPagination(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget kycTbas() {
    return Row(
      children: [
        InkWell(
            onTap: () {
              controller.selectedTab(0);
            },
            child: Obx(
              () => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.store,
                      size: 16,
                      color: controller.selectedTab.value == 0
                          ? ContentTheme.lightContentTheme.primary
                          : Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Seller KYC Queue",
                      style: GoogleFonts.inter(
                          color: controller.selectedTab.value == 0
                              ? ContentTheme.lightContentTheme.primary
                              : Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: controller.selectedTab.value == 0
                          ? ContentTheme.lightContentTheme.primary
                          : ContentTheme.lightContentTheme.primary
                              .withValues(alpha: 0.20),
                      child: Text("15",
                          style: GoogleFonts.inter(
                              fontSize: 11, fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              ),
            )),
        const SizedBox(width: 16),
        InkWell(
            onTap: () {
              controller.selectedTab(1);
            },
            child: Obx(
              () => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.store,
                      size: 16,
                      color: controller.selectedTab.value == 1
                          ? ContentTheme.lightContentTheme.primary
                          : Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Driver KYC Queue",
                      style: GoogleFonts.inter(
                          color: controller.selectedTab.value == 1
                              ? ContentTheme.lightContentTheme.primary
                              : Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: controller.selectedTab.value == 1
                          ? ContentTheme.lightContentTheme.primary
                          : ContentTheme.lightContentTheme.primary
                              .withValues(alpha: 0.20),
                      child: Text("9",
                          style: GoogleFonts.inter(
                              fontSize: 11, fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

class KycStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String percent;

  const KycStatCard(this.title, this.value, this.percent, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (percent.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/icon/orders.png", width: 48, height: 48),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xfff6f0dd),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      percent,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ContentTheme.lightContentTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xff4B4B4B)),
          ),
          Text(
            value,
            style: GoogleFonts.montserrat(
                fontSize: 34, fontWeight: FontWeight.w600, color: Colors.black),
          )
        ],
      ),
    );
  }
}

class KycFilterBar extends StatelessWidget {
  const KycFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// STATUS
        SizedBox(
          width: 200,
          child: DropdownButtonFormField(
            dropdownColor: Colors.white,
            items: [
              DropdownMenuItem(
                  value: "Approve",
                  child: Text(
                    "Approve",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  )),
              DropdownMenuItem(
                  value: "Reject",
                  child: Text(
                    "Reject",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ))
            ],
            onChanged: (v) {},
            decoration: InputDecoration(
                labelText: "All Status",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xffD1D5DB), width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xffD1D5DB), width: 1)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color(0xffD1D5DB), width: 1))),
          ),
        ),

        const SizedBox(width: 12),

        /// SORT
        SizedBox(
          width: 200,
          child: DropdownButtonFormField(
            dropdownColor: Colors.white,
            items: [
              DropdownMenuItem(
                  value: "Newest",
                  child: Text(
                    "Newest",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  )),
              DropdownMenuItem(
                  value: "Oldest",
                  child: Text(
                    "Oldest",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ))
            ],
            onChanged: (v) {},
            decoration: InputDecoration(
                labelText: "Sort by: Newest",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xffD1D5DB), width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xffD1D5DB), width: 1)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color(0xffD1D5DB), width: 1))),
          ),
        ),
      ],
    );
  }
}

class KycUserCard extends StatelessWidget {
  const KycUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// USER IMAGE
          CircleAvatar(
              radius: 26, backgroundImage: AssetImage(Images.avatars.first)),

          const SizedBox(width: 16),

          /// USER DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Michael Johnson",
                        style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ContentTheme.lightContentTheme.primary
                            .withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("Pending Review",
                          style: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: ContentTheme.lightContentTheme.primary)),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: ContentTheme.lightContentTheme.primary,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text("michael.j@email.com",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4B4B4B))),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.table_chart,
                      color: ContentTheme.lightContentTheme.primary,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text("Tech Store LLC",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4B4B4B))),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    _tag("ID Verified"),
                    _tag("Business License"),
                    _tag("Tax Documents"),
                  ],
                )
              ],
            ),
          ),

          /// PHONE + DATE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.call,
                      size: 20, color: ContentTheme.lightContentTheme.primary),
                  SizedBox(width: 8),
                  Text(
                    "+1 (555) 123-4567",
                    style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B)),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.calendar_month,
                      size: 20, color: ContentTheme.lightContentTheme.primary),
                  SizedBox(width: 8),
                  Text(
                    " Submitted: Dec 15, 2024",
                    style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B)),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(width: 30),

          /// ACTION BUTTONS
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: const Color(0xffd4a32b),
                ),
                onPressed: () {
                  Get.toNamed("/kyc-review");
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
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor:
                      LeftBarTheme.lightLeftBarTheme.activeItemBackground,
                ),
                onPressed: () {
                  showRejectKycDialog(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Reject",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: const Color(0xffd4a32b),
                ),
                onPressed: () {
                  showRequestMoreInfoDialog(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.question_mark_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Request Info",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
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
}

Widget _tag(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: ContentTheme.lightContentTheme.primary.withValues(alpha: .14),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(text,
        style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ContentTheme.lightContentTheme.primary)),
  );
}

class KycPagination extends StatelessWidget {
  const KycPagination({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Showing 1 to 5 of 1,247 results"),
        Row(
          children: [
            const Text("Previous"),
            const SizedBox(width: 12),
            _pageNumber("1", true),
            _pageNumber("2", false),
            _pageNumber("3", false),
            const Text("..."),
            _pageNumber("249", false),
            const SizedBox(width: 12),
            const Text("Next"),
          ],
        )
      ],
    );
  }

  Widget _pageNumber(String text, bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: active ? Colors.white : Colors.black),
      ),
    );
  }
}
