import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webkit/controller/extra_pages/time_line_controller.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/layouts/layout.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late TimeLineController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(TimeLineController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.black)),
                              SizedBox(width: 10),
                              Text("Order ID #ORD-2847",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _orderSummary(),
                          _amountBreakdown(),
                          const SizedBox(height: 16),
                          _deliveryProof(),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// RIGHT PANEL
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _escrowTimeline(),
                        const SizedBox(height: 16),
                        _actions(),
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }

  Widget _orderSummary() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.blinds_closed, color: contentTheme.primary),
              SizedBox(width: 10),
              Text("Order Summary",
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _infoBox("Buyer", "John Mitchell"),
              _infoBox("Seller", "Sarah's Electronics"),
              _infoBox("Driver", "Mike Rodriguez"),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------------- AMOUNT ----------------
  Widget _amountBreakdown() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.blinds_closed, color: contentTheme.primary),
              SizedBox(width: 10),
              Text("Amount Breakdown",
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ],
          ),
          const SizedBox(height: 16),
          _row("Item Price", "\$299.99"),
          _row("Platform Fee", "\$14.99").paddingSymmetric(vertical: 10),
          _row("Delivery Fee", "\$12.99"),
          const Divider(),
          _row("Total Paid", "\$327.97", isBold: true),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: contentTheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Escrow Held Amount",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "\$327.97",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: contentTheme.primary),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// ---------------- DELIVERY PROOF ----------------
  Widget _deliveryProof() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.camera_alt_outlined,
                color: contentTheme.primary,
              ),
              SizedBox(width: 10),
              Text(
                "Delivery Proof",
                style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.image),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("delivery-proof-image.jpg",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    Text("Uploaded 2 hours ago",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4B4B4B))),
                  ],
                )),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.download, color: contentTheme.primary),
                      SizedBox(width: 5),
                      Text("Download",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: contentTheme.primary)),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text("Driver Notes",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          const SizedBox(height: 6),
          Text(
              "Package delivered to front door as requested. Customer was not home.",
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4B4B4B)))
        ],
      ),
    );
  }

  /// ---------------- TIMELINE ----------------
  Widget _escrowTimeline() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.escalator_warning,
                color: contentTheme.primary,
              ),
              SizedBox(width: 5),
              Text("Escrow Timeline",
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ],
          ),
          SizedBox(height: 16),
          _timelineItem("Payment Received", true, "Jan 15, 2024 at 2:30 PM"),
          _timelineItem("Escrow Held", true, "Jan 15, 2024 at 2:30 PM")
              .paddingSymmetric(vertical: 10),
          _timelineItem("Out for Delivery", false, "Pending"),
          _timelineItem("Delivered", false, "Pending")
              .paddingSymmetric(vertical: 10),
          _timelineItem("Released / Refunded", false, "Pending"),
        ],
      ),
    );
  }

  /// ---------------- ACTIONS ----------------
  Widget _actions() {
    return _card(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: contentTheme.primary,
              ),
              SizedBox(width: 5),
              Text(" Actions",
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ],
          ),
          SizedBox(height: 16),
          _btn(" Release Escrow", ContentTheme.lightContentTheme.primary,
              child: Icon(Icons.lock_open_rounded)),
          _btn(" Partial Refund",
              LeftBarTheme.lightLeftBarTheme.activeItemBackground,
              child: Icon(Icons.percent)),
          _btn(" Full Refund", ContentTheme.lightContentTheme.primary,
              child: Icon(Icons.restart_alt_outlined)),
          _btn(" Extend Hold",
              LeftBarTheme.lightLeftBarTheme.activeItemBackground,
              child: Icon(Icons.access_time_rounded)),
        ],
      ),
    );
  }

  /// ---------------- COMMON WIDGETS ----------------

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _infoBox(String title, String value) {
    return Expanded(
      child: Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset("assets/icon/orders.png", width: 40, height: 40),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4B4B4B))),
                  Text("John Mitchell",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text.rich(TextSpan(
              text: "Order Date: ",
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4B4B4B)),
              children: [
                TextSpan(
                    text: " an 15, 2024",
                    style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))
              ]))
        ],
      ).paddingSymmetric(horizontal: 15, vertical: 12)),
    );
  }

  Widget _row(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
                color: Color(0xff4B4B4B)),
          ),
          Text(
            value,
            style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                color: Colors.black),
          ),
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
                    color: (text == "Dismiss Report") ||
                            (text == "Mark as Resolved")
                        ? Colors.black
                        : Colors.white)),
          ],
        ),
      ),
    );
  }
}

class _timelineItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isDone;

  const _timelineItem(this.title, this.isDone, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isDone ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isDone ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Text(
              subTitle,
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4B4B4B)),
            ),
          ],
        ),
      ],
    );
  }
}
