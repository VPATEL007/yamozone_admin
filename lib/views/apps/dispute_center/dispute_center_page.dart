import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webkit/controller/apps/shopping_customer/shopping_customer_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/layouts/layout.dart';
import 'package:webkit/views/other/sfmap_page.dart';

class DisputeCenterPage extends StatefulWidget {
  const DisputeCenterPage({super.key});

  @override
  State<DisputeCenterPage> createState() => _DisputeCenterPageState();
}

class _DisputeCenterPageState extends State<DisputeCenterPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ShoppingController controller;

  @override
  void initState() {
    controller = Get.put(ShoppingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<ShoppingController>(
        init: controller,
        builder: (controller) {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: Row(
              children: [
                /// LEFT PANEL (DISPUTE LIST)
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Active Disputes",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),

                        /// Search
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Search disputes...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// LIST
                        Expanded(
                          child: ListView(
                            children: [
                              _disputeTile(
                                id: "#DP-2024-001",
                                title: "Damaged Product - Electronics",
                                status: "In Review",
                                priority: "High",
                              ),
                              _disputeTile(
                                id: "#DP-2024-002",
                                title: "Wrong Item Delivered",
                                status: "New",
                                priority: "Medium",
                              ),
                              _disputeTile(
                                id: "#DP-2024-003",
                                title: "Late Delivery Complaint",
                                status: "Evidence Req.",
                                priority: "Low",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// RIGHT PANEL (DETAILS)
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// HEADER
                          Row(
                            children: [
                              Text(
                                "Case #DP-2024-001",
                                style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              _badge("High Priority", Colors.orange),
                              SizedBox(width: 10),
                              _badge("In Review", Colors.orange),
                            ],
                          ),

                          const SizedBox(height: 16),

                          /// INFO ROW
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Order ID:\n#ORD-5547"),
                              Text("Dispute Type:\nDamaged Product"),
                              Text("Amount:\n\$299.99"),
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// BUYER CLAIM
                          _card(
                            title: "Buyer Claim",
                            content:
                                "The wireless headphones I ordered arrived with visible damage to the left speaker. The packaging was also torn, suggesting ",
                          ),

                          /// SELLER RESPONSE
                          _card(
                            title: "Seller Response",
                            content:
                                "Item was shipped in perfect condition. Damage likely occurred in transit. Offering partial refund.",
                          ),

                          /// INTERNAL NOTES
                          _card(
                            title: "Internal Notes",
                            content:
                                "Buyer photos confirm damage. Shipping records look fine. Likely transit issue.",
                            isInput: true,
                          ),

                          const SizedBox(height: 20),

                          /// RESOLUTION
                          Text(
                            "Resolution Decision",
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                              _decisionCard("Full Refund", true),
                              const SizedBox(width: 10),
                              _decisionCard("Partial Refund", false),
                              const SizedBox(width: 10),
                              _decisionCard("Reject Claim", false),
                            ],
                          ),

                          const SizedBox(height: 20),
                          Text(
                            "Refund Amount",
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 5),

                          /// INPUTS
                          TextField(
                            readOnly: true,
                            controller: TextEditingController(text: '\$299.99'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),

                          const SizedBox(height: 12),
                          Text(
                            "Resolution Note",
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 5),

                          TextField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),

                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      backgroundColor:
                                          leftBarTheme.activeItemBackground),
                                  onPressed: () {},
                                  child: Text(
                                    "Process Resolution",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    backgroundColor: Colors.white),
                                onPressed: () {},
                                child: Text(
                                  "Save Draft",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ================= COMPONENTS =================

  Widget _disputeTile({
    required String id,
    required String title,
    required String status,
    required String priority,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                id,
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10),
              _badge("High Priority", Colors.orange),
              Spacer(),
              _badge("In Review", Colors.orange)
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.montserrat(
                color: Color(0xff4B4B4B),
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                "Order: #ORD-5547",
                style: GoogleFonts.montserrat(
                    color: Color(0xff4B4B4B),
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "2 hours ago",
                style: GoogleFonts.montserrat(
                    color: Color(0xff4B4B4B),
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )
          // Row(
          //   children: [
          //     _badge(priority, Colors.orange),
          //     const SizedBox(width: 6),
          //     _badge(status, Colors.green),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text,
          style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: contentTheme.primary)),
    );
  }

  Widget _card({
    required String title,
    required String content,
    bool isInput = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black)),
          Text('John Smith • 2 hours ago',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xff4B4B4B))),
          const SizedBox(height: 8),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: contentTheme.primary.withValues(alpha: 0.10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(content,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xff4B4B4B))),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Evidence Attached",
                                style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff073B25)))
                            .paddingSymmetric(horizontal: 10, vertical: 5),
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("3 Photos",
                                style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff073B25)))
                            .paddingSymmetric(horizontal: 10, vertical: 5),
                      )
                    ],
                  )
                ],
              )),
          if (isInput) ...[
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Add internal note...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: leftBarTheme.activeItemBackground),
              onPressed: () {
                Get.toNamed("/kyc-review");
              },
              child: Text(
                "Add Notes",
                style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget _decisionCard(String title, bool selected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? contentTheme.primary.withValues(alpha: 0.14)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.check_circle,
              color: selected ? contentTheme.primary : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff166534)),
            ),
            const SizedBox(height: 2),
            Text(
              "\$299.99",
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff166534)),
            ),
          ],
        ),
      ),
    );
  }
}
