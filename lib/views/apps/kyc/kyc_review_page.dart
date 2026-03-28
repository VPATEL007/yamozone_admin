import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webkit/controller/apps/ecommerce/invoice_controller.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/apps/kyc/widget/kyc_dialog.dart';
import 'package:webkit/views/layouts/layout.dart';

class KycReviewPage extends StatefulWidget {
  const KycReviewPage({super.key});

  @override
  State<KycReviewPage> createState() => _KycReviewPageState();
}

class _KycReviewPageState extends State<KycReviewPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late InvoiceController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(InvoiceController());
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
              child: Column(
                children: [
                  /// HEADER
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "KYC Review",
                        style: GoogleFonts.montserrat(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// USER CARD
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xffE4C98A),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Michael Anderson",
                              style: GoogleFonts.montserrat(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              "User ID: USR-2024-00847",
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff4B4B4B)),
                            ),
                            Text(
                              "Submitted: Jan 10, 2024 at 2:35 PM",
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff4B4B4B)),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                              color:
                                  contentTheme.primary.withValues(alpha: .14),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timelapse_rounded,
                                size: 20,
                                color: contentTheme.primary,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Pending Review",
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: contentTheme.primary,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// MAIN CONTENT
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// DOCUMENT VIEWER
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Document Viewer",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    chip("ID Card"),
                                    const SizedBox(width: 8),
                                    chip("Business License"),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                /// DOCUMENT AREA
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                /// ACTION BUTTONS
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                        child: Column(
                                      children: [
                                        Icon(
                                          Icons.zoom_in,
                                          color: contentTheme.primary,
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "Zoom In",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff4B4B4B)),
                                        ),
                                      ],
                                    ).paddingSymmetric(
                                            horizontal: 20, vertical: 10)),
                                    Card(
                                        child: Column(
                                      children: [
                                        Icon(
                                          Icons.rotate_right_rounded,
                                          color: contentTheme.primary,
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "Rotate",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff4B4B4B)),
                                        ),
                                      ],
                                    ).paddingSymmetric(
                                            horizontal: 20, vertical: 10)),
                                    Card(
                                        child: Column(
                                      children: [
                                        Icon(
                                          Icons.download_outlined,
                                          color: contentTheme.primary,
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "Download",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff4B4B4B)),
                                        ),
                                      ],
                                    ).paddingSymmetric(
                                            horizontal: 20, vertical: 10)),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon:
                                              const Icon(Icons.arrow_back_ios),
                                        ),
                                        Text(
                                          "1 / 3",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff4B4B4B)),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.arrow_forward_ios),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        /// EXTRACTED INFO
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Extracted Information",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 20),
                                infoRow("Full Name", "Michael James Anderson"),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    infoRow("Date of Birth", "March 15, 1985"),
                                    SizedBox(width: 150),
                                    infoRow("ID Number", "DL-8473629"),
                                  ],
                                ),
                                SizedBox(height: 10),
                                infoRow("Address",
                                    "2847 Oak Street, San Francisco, CA 94102"),
                                SizedBox(height: 10),
                                Divider(),
                                SizedBox(height: 10),
                                Text(
                                  "Business Information",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                infoRow("Business Name",
                                    "Anderson Tech Solutions LLC"),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    infoRow("Tax ID (EIN)", "45-8392847"),
                                    SizedBox(width: 150),
                                    infoRow("Registration Date", "Jan 2020"),
                                  ],
                                ),
                                SizedBox(height: 10),
                                infoRow("Business Address",
                                    "1250 Market St, Suite 400, San Francisco, CA 94102"),
                                SizedBox(height: 10),
                                Divider(),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// BOTTOM BUTTONS
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
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
                              "Approve KYC",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 35),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: LeftBarTheme
                              .lightLeftBarTheme.activeItemBackground,
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Reject KYC",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
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
                              "Request Info",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: () {
                          showKycHistoryDialog(context);
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Color(0xffF3F4F6)),
                        icon: const Icon(Icons.history),
                        label: Text(
                          "View History",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4B4B4B)),
                        ),
                      )
                    ],
                  )
                ],
              ).paddingSymmetric(horizontal: 20));
        },
      ),
    );
  }

  void showRequestInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 600,
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  const Text(
                    "Request More Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Request additional documents from the user",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  /// MESSAGE FIELD
                  const Text(
                    "Message to User *",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText:
                          "Please provide a detailed message explaining why these documents are required.",
                      filled: true,
                      fillColor: const Color(0xffF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Provide clear instructions for the user",
                    style: TextStyle(fontSize: 12, color: Colors.orange),
                  ),

                  const SizedBox(height: 25),

                  /// REQUIRED DOCUMENTS
                  const Text(
                    "Required Documents *",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 12),

                  documentTile(
                      icon: Icons.badge,
                      title: "New ID",
                      subtitle: "Government-issued identification document"),

                  documentTile(
                      icon: Icons.home,
                      title: "Address Proof",
                      subtitle:
                          "Utility bill or bank statement (within 3 months)"),

                  documentTile(
                      icon: Icons.business_center,
                      title: "Business License",
                      subtitle: "Valid business registration certificate"),

                  const SizedBox(height: 25),

                  /// DEADLINE
                  const Text(
                    "Submission Deadline *",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    decoration: InputDecoration(
                      hintText: "mm/dd/yyyy",
                      filled: true,
                      fillColor: const Color(0xffF6F6F6),
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "User will be notified of the deadline",
                    style: TextStyle(fontSize: 12, color: Colors.orange),
                  ),

                  const SizedBox(height: 30),

                  /// BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0B4D3A),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                        label: const Text("Send Request"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget documentTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (v) {},
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xffEAD8A6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget chip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: contentTheme.primary.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: contentTheme.primary),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xff4B4B4B)),
        ),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
      ],
    );
  }
}
