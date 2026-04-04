// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:webkit/controller/extra_pages/time_line_controller.dart';
// import 'package:webkit/helpers/theme/admin_theme.dart';
// import 'package:webkit/helpers/utils/ui_mixins.dart';
// import 'package:webkit/views/apps/orders_escrow/widget/order_dialog.dart';
// import 'package:webkit/views/layouts/layout.dart';

// class OrderDetailPage extends StatefulWidget {
//   const OrderDetailPage({super.key});

//   @override
//   State<OrderDetailPage> createState() => _OrderDetailPageState();
// }

// class _OrderDetailPageState extends State<OrderDetailPage>
//     with SingleTickerProviderStateMixin, UIMixin {
//   late TimeLineController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(TimeLineController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       child: GetBuilder(
//         init: controller,
//         builder: (controller) {
//           return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               InkWell(
//                                   onTap: () {
//                                     Get.back();
//                                   },
//                                   child: Icon(Icons.arrow_back,
//                                       color: Colors.black)),
//                               SizedBox(width: 10),
//                               Text("Order ID #ORD-2847",
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black)),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           _orderSummary(),
//                           _amountBreakdown(),
//                           const SizedBox(height: 16),
//                           _deliveryProof(),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 16),

//                   /// RIGHT PANEL
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       children: [
//                         _escrowTimeline(),
//                         const SizedBox(height: 16),
//                         _actions(),
//                       ],
//                     ),
//                   )
//                 ],
//               ));
//         },
//       ),
//     );
//   }

//   Widget _orderSummary() {
//     return _card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.blinds_closed, color: contentTheme.primary),
//               SizedBox(width: 10),
//               Text("Order Summary",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               _infoBox("Buyer", "John Mitchell"),
//               _infoBox("Seller", "Sarah's Electronics"),
//               _infoBox("Driver", "Mike Rodriguez"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   /// ---------------- AMOUNT ----------------
//   Widget _amountBreakdown() {
//     return _card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.blinds_closed, color: contentTheme.primary),
//               SizedBox(width: 10),
//               Text("Amount Breakdown",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _row("Item Price", "\$299.99"),
//           _row("Platform Fee", "\$14.99").paddingSymmetric(vertical: 10),
//           _row("Delivery Fee", "\$12.99"),
//           const Divider(),
//           _row("Total Paid", "\$327.97", isBold: true),
//           const SizedBox(height: 12),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: contentTheme.primary.withValues(alpha: 0.10),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Escrow Held Amount",
//                   style: GoogleFonts.montserrat(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   "\$327.97",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: contentTheme.primary),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   /// ---------------- DELIVERY PROOF ----------------
//   Widget _deliveryProof() {
//     return _card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.camera_alt_outlined,
//                 color: contentTheme.primary,
//               ),
//               SizedBox(width: 10),
//               Text(
//                 "Delivery Proof",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.image),
//                 const SizedBox(width: 10),
//                 Expanded(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("delivery-proof-image.jpg",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black)),
//                     Text("Uploaded 2 hours ago",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff4B4B4B))),
//                   ],
//                 )),
//                 TextButton(
//                   onPressed: () {},
//                   child: Row(
//                     children: [
//                       Icon(Icons.download, color: contentTheme.primary),
//                       SizedBox(width: 5),
//                       Text("Download",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: contentTheme.primary)),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text("Driver Notes",
//               style: GoogleFonts.montserrat(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black)),
//           const SizedBox(height: 6),
//           Text(
//               "Package delivered to front door as requested. Customer was not home.",
//               style: GoogleFonts.montserrat(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff4B4B4B)))
//         ],
//       ),
//     );
//   }

//   /// ---------------- TIMELINE ----------------
//   Widget _escrowTimeline() {
//     return _card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.escalator_warning,
//                 color: contentTheme.primary,
//               ),
//               SizedBox(width: 5),
//               Text("Escrow Timeline",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//             ],
//           ),
//           SizedBox(height: 16),
//           _timelineItem("Payment Received", true, "Jan 15, 2024 at 2:30 PM"),
//           _timelineItem("Escrow Held", true, "Jan 15, 2024 at 2:30 PM")
//               .paddingSymmetric(vertical: 10),
//           _timelineItem("Out for Delivery", false, "Pending"),
//           _timelineItem("Delivered", false, "Pending")
//               .paddingSymmetric(vertical: 10),
//           _timelineItem("Released / Refunded", false, "Pending"),
//         ],
//       ),
//     );
//   }

//   /// ---------------- ACTIONS ----------------
//   Widget _actions() {
//     return _card(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.settings,
//                 color: contentTheme.primary,
//               ),
//               SizedBox(width: 5),
//               Text(" Actions",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//             ],
//           ),
//           SizedBox(height: 16),
//           _btn(" Release Escrow", ContentTheme.lightContentTheme.primary,
//               child: Icon(Icons.lock_open_rounded)),
//           _btn(" Partial Refund", onPressed: () {
//             showDialog(
//               context: context,
//               builder: (_) => PartialRefundDialog(
//                 escrowAmount: 2450,
//                 onCancel: () => Navigator.pop(context),
//                 onProcess: (amount, reason) {
//                   print('Refund \$amount | reason: \$reason');
//                   Navigator.pop(context);
//                 },
//               ),
//             );
//           }, LeftBarTheme.lightLeftBarTheme.activeItemBackground,
//               child: Icon(Icons.percent)),
//           _btn(" Full Refund", onPressed: () {
//             showDialog(
//               context: context,
//               builder: (_) => FullRefundConfirmationDialog(
//                 escrowAmount: 2450,
//                 onCancel: () => Navigator.pop(context),
//                 onConfirm: (reason) {
//                   print('Full refund confirmed | reason: \$reason');
//                   Navigator.pop(context);
//                 },
//               ),
//             );
//           }, ContentTheme.lightContentTheme.primary,
//               child: Icon(Icons.restart_alt_outlined)),
//           _btn(" Extend Hold", onPressed: () {
//             showDialog(
//               context: context,
//               builder: (_) => ExtendEscrowHoldDialog(
//                 currentHoldDays: 7,
//                 onCancel: () => Navigator.pop(context),
//                 onExtend: (days, reason) {
//                   print('Extend \$days days | reason: \$reason');
//                   Navigator.pop(context);
//                 },
//               ),
//             );
//           }, LeftBarTheme.lightLeftBarTheme.activeItemBackground,
//               child: Icon(Icons.access_time_rounded)),
//         ],
//       ),
//     );
//   }

//   /// ---------------- COMMON WIDGETS ----------------

//   Widget _card({required Widget child}) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: child,
//     );
//   }

//   Widget _infoBox(String title, String value) {
//     return Expanded(
//       child: Card(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Image.asset("assets/icon/orders.png", width: 40, height: 40),
//               SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       style: GoogleFonts.montserrat(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff4B4B4B))),
//                   Text("John Mitchell",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black)),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text.rich(TextSpan(
//               text: "Order Date: ",
//               style: GoogleFonts.montserrat(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff4B4B4B)),
//               children: [
//                 TextSpan(
//                     text: " an 15, 2024",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black))
//               ]))
//         ],
//       ).paddingSymmetric(horizontal: 15, vertical: 12)),
//     );
//   }

//   Widget _row(String title, String value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.montserrat(
//                 fontSize: 15,
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
//                 color: Color(0xff4B4B4B)),
//           ),
//           Text(
//             value,
//             style: GoogleFonts.montserrat(
//                 fontSize: 15,
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
//                 color: Colors.black),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _btn(String text, Color color,
//       {Color textColor = Colors.white,
//       required Widget child,
//       Function()? onPressed}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
//           backgroundColor: color,
//           foregroundColor: textColor,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             child,
//             SizedBox(width: 10),
//             Text(text,
//                 style: GoogleFonts.montserrat(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: (text == "Dismiss Report") ||
//                             (text == "Mark as Resolved")
//                         ? Colors.black
//                         : Colors.white)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _timelineItem extends StatelessWidget {
//   final String title;
//   final String subTitle;
//   final bool isDone;

//   const _timelineItem(this.title, this.isDone, this.subTitle);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           isDone ? Icons.check_circle : Icons.radio_button_unchecked,
//           color: isDone ? Colors.green : Colors.grey,
//         ),
//         const SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: GoogleFonts.montserrat(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black),
//             ),
//             Text(
//               subTitle,
//               style: GoogleFonts.montserrat(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff4B4B4B)),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webkit/views/apps/orders_escrow/widget/order_dialog.dart';
import 'package:webkit/views/layouts/layout.dart';

// ─────────────────────────────────────────────
// COLORS & CONSTANTS
// ─────────────────────────────────────────────
const kGold = Color(0xFFB8960C);
const kDarkGreen = Color(0xFF1B4332);
const kBg = Color(0xFFF9F6F0);
const kCard = Color(0xFFFFFFFF);
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF6B6B6B);
const kBorder = Color(0xFFE8E0D0);
const kGoldLight = Color(0xFFFFF8E7);
const kGoldAccent = Color(0xFFD4A017);

// ─────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────
class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              _TopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT CONTENT
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _OrderSummaryCard(),
                            const SizedBox(height: 20),
                            _AmountBreakdownCard(),
                            const SizedBox(height: 20),
                            _DeliveryProofCard(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      // RIGHT SIDEBAR
                      SizedBox(
                        width: 280,
                        child: Column(
                          children: [
                            _EscrowTimelineCard(),
                            const SizedBox(height: 20),
                            _ActionsCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TOP BAR
// ─────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: kCard,
        border: Border(bottom: BorderSide(color: kBorder)),
      ),
      child: Row(
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
            'Order ID #ORD-2847',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kTextPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ORDER SUMMARY CARD
// ─────────────────────────────────────────────
class _OrderSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.receipt_long_outlined,
            label: 'Order Summary',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _PartyTile(
                  icon: Icons.person_outline,
                  role: 'Buyer',
                  name: 'John Mitchell',
                  sub: 'Order Date: Jan 15, 2024',
                ),
              ),
              _VerticalDivider(),
              Expanded(
                child: _PartyTile(
                  icon: Icons.storefront_outlined,
                  role: 'Seller',
                  name: "Sarah's Electronics",
                  sub: '',
                ),
              ),
              _VerticalDivider(),
              Expanded(
                child: _PartyTile(
                  icon: Icons.local_shipping_outlined,
                  role: 'Driver',
                  name: 'Mike Rodriguez',
                  sub: 'Delivery Date: Jan 18, 2024',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PartyTile extends StatelessWidget {
  final IconData icon;
  final String role;
  final String name;
  final String sub;

  const _PartyTile({
    required this.icon,
    required this.role,
    required this.name,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: kGoldLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: kGold),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 11,
                    color: kTextSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: kTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (sub.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    sub,
                    style: const TextStyle(fontSize: 11, color: kTextSecondary),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 60, color: kBorder);
  }
}

// ─────────────────────────────────────────────
// AMOUNT BREAKDOWN CARD
// ─────────────────────────────────────────────
class _AmountBreakdownCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.receipt_outlined,
            label: 'Amount Breakdown',
          ),
          const SizedBox(height: 20),
          _AmountRow(label: 'Item Price', amount: '\$299.99'),
          const SizedBox(height: 12),
          _AmountRow(label: 'Platform Fee', amount: '\$14.99'),
          const SizedBox(height: 12),
          _AmountRow(label: 'Delivery Fee', amount: '\$12.99'),
          const SizedBox(height: 16),
          Divider(color: kBorder, thickness: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Paid',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              const Text(
                '\$327.97',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: kGoldLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kGold.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Escrow Held Amount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary,
                  ),
                ),
                Text(
                  '\$327.97',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: kGoldAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  final String label;
  final String amount;
  const _AmountRow({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: kTextSecondary),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 14,
            color: kTextPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// DELIVERY PROOF CARD
// ─────────────────────────────────────────────
class _DeliveryProofCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.camera_alt_outlined,
            label: 'Delivery Proof',
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: kBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kGoldLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.image_outlined,
                    size: 20,
                    color: kGold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'delivery-proof-image.jpg',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kTextPrimary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Uploaded 2 hours ago',
                        style: TextStyle(fontSize: 11, color: kTextSecondary),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.download_outlined, size: 16, color: kGold),
                  label: Text(
                    'Download',
                    style: TextStyle(
                      fontSize: 13,
                      color: kGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Driver Notes',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: kTextPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '"Package delivered to front door as requested. Customer was not home, but delivery was confirmed via doorbell camera."',
            style: TextStyle(fontSize: 13, color: kTextSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ESCROW TIMELINE CARD
// ─────────────────────────────────────────────
class _EscrowTimelineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.timeline_outlined,
            label: 'Escrow Timeline',
          ),
          const SizedBox(height: 20),
          _TimelineItem(
            status: TimelineStatus.done,
            label: 'Payment Received',
            sub: 'Jan 15, 2024 at 2:30 PM',
            isLast: false,
          ),
          _TimelineItem(
            status: TimelineStatus.active,
            label: 'Escrow Held',
            sub: 'Jan 15, 2024 at 2:31 PM',
            isLast: false,
          ),
          _TimelineItem(
            status: TimelineStatus.pending,
            label: 'Out for Delivery',
            sub: 'Pending',
            isLast: false,
          ),
          _TimelineItem(
            status: TimelineStatus.pending,
            label: 'Delivered',
            sub: 'Pending',
            isLast: false,
          ),
          _TimelineItem(
            status: TimelineStatus.pending,
            label: 'Released / Refunded',
            sub: 'Pending',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

enum TimelineStatus { done, active, pending }

class _TimelineItem extends StatelessWidget {
  final TimelineStatus status;
  final String label;
  final String sub;
  final bool isLast;

  const _TimelineItem({
    required this.status,
    required this.label,
    required this.sub,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    Color dotColor;
    IconData dotIcon;
    switch (status) {
      case TimelineStatus.done:
        dotColor = Colors.green;
        dotIcon = Icons.check;
        break;
      case TimelineStatus.active:
        dotColor = kGold;
        dotIcon = Icons.pause;
        break;
      case TimelineStatus.pending:
        dotColor = const Color(0xFFD0C8B8);
        dotIcon = Icons.lock_outline;
        break;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: dotColor.withOpacity(
                      status == TimelineStatus.pending ? 0.15 : 1.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    dotIcon,
                    size: 13,
                    color:
                        status == TimelineStatus.pending
                            ? const Color(0xFFAA9977)
                            : Colors.white,
                  ),
                ),
                if (!isLast)
                  Expanded(child: Container(width: 2, color: kBorder)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color:
                          status == TimelineStatus.pending
                              ? kTextSecondary
                              : kTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sub,
                    style: const TextStyle(fontSize: 11, color: kTextSecondary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ACTIONS CARD
// ─────────────────────────────────────────────
class _ActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(icon: Icons.settings_outlined, label: 'Actions'),
          const SizedBox(height: 16),
          _ActionButton(
            label: 'Release Escrow',
            icon: Icons.lock_open_outlined,
            style: _ActionStyle.gold,
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (_) => PartialRefundDialog(
                      escrowAmount: 2450,
                      onCancel: () => Navigator.pop(context),
                      onProcess: (amount, reason) {
                        print('Refund \$amount | reason: \$reason');
                        Navigator.pop(context);
                      },
                    ),
              );
            },
          ),
          const SizedBox(height: 10),
          _ActionButton(
            label: 'Partial Refund',
            icon: Icons.percent_outlined,
            style: _ActionStyle.darkGreen,
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (_) => PartialRefundDialog(
                      escrowAmount: 2450,
                      onCancel: () => Navigator.pop(context),
                      onProcess: (amount, reason) {
                        Navigator.pop(context);
                      },
                    ),
              );
            },
          ),
          const SizedBox(height: 10),
          _ActionButton(
            label: 'Full Refund',
            icon: Icons.refresh_outlined,
            style: _ActionStyle.gold,
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (_) => FullRefundConfirmationDialog(
                      escrowAmount: 2450,
                      onCancel: () => Navigator.pop(context),
                      onConfirm: (reason) {
                        Navigator.pop(context);
                      },
                    ),
              );
            },
          ),
          const SizedBox(height: 10),
          _ActionButton(
            label: 'Extend Hold',
            icon: Icons.access_time_outlined,
            style: _ActionStyle.darkGreen,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

enum _ActionStyle { gold, darkGreen }

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final _ActionStyle style;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.style,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = style == _ActionStyle.gold ? kGold : kDarkGreen;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SHARED WIDGETS
// ─────────────────────────────────────────────
class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionTitle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: kGold),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: kTextPrimary,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}
