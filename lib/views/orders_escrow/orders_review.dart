import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamazone/controller/extra_pages/time_line_controller.dart';
import 'package:yamazone/helpers/utils/ui_mixins.dart';
import 'package:yamazone/views/layouts/layout.dart';

class OrdersReview extends StatefulWidget {
  const OrdersReview({super.key});

  @override
  State<OrdersReview> createState() => _OrdersReviewState();
}

class _OrdersReviewState extends State<OrdersReview>
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
            padding: const EdgeInsets.all(20),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: leftContent()),
                    SizedBox(width: 20),
                    Expanded(flex: 1, child: rightPanel()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget pageHeader() {
    return Row(
      children: [
        Icon(Icons.arrow_back),
        SizedBox(width: 10),
        Text(
          "Order ID #ORD-2847",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget leftContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pageHeader(),
          SizedBox(height: 25),
          orderSummary(),
          SizedBox(height: 20),
          amountBreakdown(),
          SizedBox(height: 20),
          deliveryProof(),
        ],
      ),
    );
  }

  Widget orderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: summaryCard(
                Icons.person,
                "Buyer",
                "John Mitchell",
                "Order Date: Jan 15, 2024",
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: summaryCard(
                Icons.store,
                "Seller",
                "Sarah's Electronics",
                "",
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: summaryCard(
                Icons.local_shipping,
                "Driver",
                "Mike Rodriguez",
                "Delivery Date: Jan 18, 2024",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget summaryCard(
    IconData icon,
    String title,
    String name,
    String subtitle,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            child: Icon(icon, color: Colors.orange),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey, fontSize: 13)),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget amountBreakdown() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Amount Breakdown",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 20),
          priceRow("Item Price", "\$299.99"),
          priceRow("Platform Fee", "\$14.99"),
          priceRow("Delivery Fee", "\$12.99"),
          Divider(height: 30),
          priceRow("Total Paid", "\$327.97", bold: true),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Escrow Held Amount"),
                Text(
                  "\$327.97",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget priceRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveryProof() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Proof",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.image, color: Colors.orange),
              SizedBox(width: 10),
              Expanded(child: Text("delivery-proof-image.jpg")),
              TextButton(onPressed: () {}, child: Text("Download")),
            ],
          ),
          SizedBox(height: 20),
          Text("Driver Notes", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            "Package delivered to front door as requested. Customer was not home but delivery confirmed.",
          ),
        ],
      ),
    );
  }

  Widget rightPanel() {
    return Column(
      children: [escrowTimeline(), SizedBox(height: 20), actionsPanel()],
    );
  }

  Widget escrowTimeline() {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Escrow Timeline",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          timelineItem("Payment Received", true),
          timelineItem("Escrow Held", true),
          timelineItem("Out for Delivery", false),
          timelineItem("Delivered", false),
          timelineItem("Released / Refunded", false),
        ],
      ),
    );
  }

  Widget timelineItem(String title, bool completed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? Colors.green : Colors.grey,
            size: 18,
          ),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }

  Widget actionsPanel() {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          actionButton("Release Escrow", Colors.orange),
          actionButton("Partial Refund", Colors.green),
          actionButton("Full Refund", Colors.orange),
          actionButton("Extend Hold", Colors.green),
        ],
      ),
    );
  }

  Widget actionButton(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: Text(title),
        ),
      ),
    );
  }
}
