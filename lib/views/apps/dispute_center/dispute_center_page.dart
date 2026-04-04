// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:webkit/controller/apps/shopping_customer/shopping_customer_controller.dart';
// import 'package:webkit/helpers/utils/ui_mixins.dart';
// import 'package:webkit/views/layouts/layout.dart';
// import 'package:webkit/views/other/sfmap_page.dart';

// class DisputeCenterPage extends StatefulWidget {
//   const DisputeCenterPage({super.key});

//   @override
//   State<DisputeCenterPage> createState() => _DisputeCenterPageState();
// }

// class _DisputeCenterPageState extends State<DisputeCenterPage>
//     with SingleTickerProviderStateMixin, UIMixin {
//   late ShoppingController controller;

//   @override
//   void initState() {
//     controller = Get.put(ShoppingController());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       child: GetBuilder<ShoppingController>(
//         init: controller,
//         builder: (controller) {
//           return SizedBox(
//             width: Get.width,
//             height: Get.height,
//             child: Row(
//               children: [
//                 /// LEFT PANEL (DISPUTE LIST)
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Active Disputes",
//                           style: GoogleFonts.montserrat(
//                             color: Colors.black,
//                             fontSize: 17,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 12),

//                         /// Search
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: "Search disputes...",
//                             prefixIcon: const Icon(Icons.search),
//                             filled: true,
//                             fillColor: Colors.white,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 12),

//                         /// LIST
//                         Expanded(
//                           child: ListView(
//                             children: [
//                               _disputeTile(
//                                 id: "#DP-2024-001",
//                                 title: "Damaged Product - Electronics",
//                                 status: "In Review",
//                                 priority: "High",
//                               ),
//                               _disputeTile(
//                                 id: "#DP-2024-002",
//                                 title: "Wrong Item Delivered",
//                                 status: "New",
//                                 priority: "Medium",
//                               ),
//                               _disputeTile(
//                                 id: "#DP-2024-003",
//                                 title: "Late Delivery Complaint",
//                                 status: "Evidence Req.",
//                                 priority: "Low",
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 /// RIGHT PANEL (DETAILS)
//                 Expanded(
//                   flex: 4,
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           /// HEADER
//                           Row(
//                             children: [
//                               Text(
//                                 "Case #DP-2024-001",
//                                 style: GoogleFonts.montserrat(
//                                   color: Colors.black,
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Spacer(),
//                               _badge("High Priority", Colors.orange),
//                               SizedBox(width: 10),
//                               _badge("In Review", Colors.orange),
//                             ],
//                           ),

//                           const SizedBox(height: 16),

//                           /// INFO ROW
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: const [
//                               Text("Order ID:\n#ORD-5547"),
//                               Text("Dispute Type:\nDamaged Product"),
//                               Text("Amount:\n\$299.99"),
//                             ],
//                           ),

//                           const SizedBox(height: 20),

//                           /// BUYER CLAIM
//                           _card(
//                             title: "Buyer Claim",
//                             content:
//                                 "The wireless headphones I ordered arrived with visible damage to the left speaker. The packaging was also torn, suggesting ",
//                           ),

//                           /// SELLER RESPONSE
//                           _card(
//                             title: "Seller Response",
//                             content:
//                                 "Item was shipped in perfect condition. Damage likely occurred in transit. Offering partial refund.",
//                           ),

//                           /// INTERNAL NOTES
//                           _card(
//                             title: "Internal Notes",
//                             content:
//                                 "Buyer photos confirm damage. Shipping records look fine. Likely transit issue.",
//                             isInput: true,
//                           ),

//                           const SizedBox(height: 20),

//                           /// RESOLUTION
//                           Text(
//                             "Resolution Decision",
//                             style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                           ),

//                           const SizedBox(height: 12),

//                           Row(
//                             children: [
//                               _decisionCard("Full Refund", true),
//                               const SizedBox(width: 10),
//                               _decisionCard("Partial Refund", false),
//                               const SizedBox(width: 10),
//                               _decisionCard("Reject Claim", false),
//                             ],
//                           ),

//                           const SizedBox(height: 20),
//                           Text(
//                             "Refund Amount",
//                             style: GoogleFonts.montserrat(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 5),

//                           /// INPUTS
//                           TextField(
//                             readOnly: true,
//                             controller: TextEditingController(text: '\$299.99'),
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 12),
//                           Text(
//                             "Resolution Note",
//                             style: GoogleFonts.montserrat(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 5),

//                           TextField(
//                             maxLines: 3,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 20),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     elevation: 0,
//                                     padding: EdgeInsets.symmetric(
//                                       vertical: 15,
//                                       horizontal: 20,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     backgroundColor:
//                                         leftBarTheme.activeItemBackground,
//                                   ),
//                                   onPressed: () {},
//                                   child: Text(
//                                     "Process Resolution",
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 15),
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   elevation: 2,
//                                   padding: EdgeInsets.symmetric(
//                                     vertical: 15,
//                                     horizontal: 20,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   backgroundColor: Colors.white,
//                                 ),
//                                 onPressed: () {},
//                                 child: Text(
//                                   "Save Draft",
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   /// ================= COMPONENTS =================

//   Widget _disputeTile({
//     required String id,
//     required String title,
//     required String status,
//     required String priority,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 id,
//                 style: GoogleFonts.montserrat(
//                   color: Colors.black,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(width: 10),
//               _badge("High Priority", Colors.orange),
//               Spacer(),
//               _badge("In Review", Colors.orange),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text(
//             title,
//             style: GoogleFonts.montserrat(
//               color: Color(0xff4B4B4B),
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Row(
//             children: [
//               Text(
//                 "Order: #ORD-5547",
//                 style: GoogleFonts.montserrat(
//                   color: Color(0xff4B4B4B),
//                   fontSize: 11,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Text(
//                 "2 hours ago",
//                 style: GoogleFonts.montserrat(
//                   color: Color(0xff4B4B4B),
//                   fontSize: 11,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//           // Row(
//           //   children: [
//           //     _badge(priority, Colors.orange),
//           //     const SizedBox(width: 6),
//           //     _badge(status, Colors.green),
//           //   ],
//           // )
//         ],
//       ),
//     );
//   }

//   Widget _badge(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.montserrat(
//           fontSize: 11,
//           fontWeight: FontWeight.w500,
//           color: contentTheme.primary,
//         ),
//       ),
//     );
//   }

//   Widget _card({
//     required String title,
//     required String content,
//     bool isInput = false,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.montserrat(
//               fontWeight: FontWeight.w600,
//               fontSize: 15,
//               color: Colors.black,
//             ),
//           ),
//           Text(
//             'John Smith • 2 hours ago',
//             style: GoogleFonts.montserrat(
//               fontWeight: FontWeight.w400,
//               fontSize: 13,
//               color: Color(0xff4B4B4B),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             color: contentTheme.primary.withValues(alpha: 0.10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   content,
//                   style: GoogleFonts.montserrat(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 13,
//                     color: Color(0xff4B4B4B),
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Row(
//                   children: [
//                     Card(
//                       elevation: 1,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         "Evidence Attached",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff073B25),
//                         ),
//                       ).paddingSymmetric(horizontal: 10, vertical: 5),
//                     ),
//                     Card(
//                       elevation: 1,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         "3 Photos",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff073B25),
//                         ),
//                       ).paddingSymmetric(horizontal: 10, vertical: 5),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (isInput) ...[
//             const SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Add internal note...",
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 elevation: 0,
//                 padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 backgroundColor: leftBarTheme.activeItemBackground,
//               ),
//               onPressed: () {
//                 Get.toNamed("/kyc-review");
//               },
//               child: Text(
//                 "Add Notes",
//                 style: GoogleFonts.montserrat(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _decisionCard(String title, bool selected) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color:
//               selected
//                   ? contentTheme.primary.withValues(alpha: 0.14)
//                   : Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: selected ? Colors.transparent : Colors.grey.shade300,
//           ),
//         ),
//         child: Column(
//           children: [
//             Icon(
//               Icons.check_circle,
//               color: selected ? contentTheme.primary : Colors.grey,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: GoogleFonts.montserrat(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xff166534),
//               ),
//             ),
//             const SizedBox(height: 2),
//             Text(
//               "\$299.99",
//               style: GoogleFonts.montserrat(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xff166534),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:webkit/views/layouts/layout.dart';

// ─── Data Models ──────────────────────────────────────────────────────────────

enum Priority { high, medium, low }

enum DisputeStatus { inReview, newCase, evidenceReq, resolved }

enum ResolutionType { fullRefund, partialRefund, rejectClaim }

class DisputeItem {
  final String id;
  final String title;
  final String orderId;
  final String timeAgo;
  final Priority priority;
  final DisputeStatus status;
  final String amount;
  final String disputeType;
  final String buyerName;
  final String buyerClaim;
  final String sellerName;
  final String sellerResponse;
  final List<String> buyerEvidence;
  final List<String> sellerEvidence;
  final String internalNote;
  final String internalNoteAuthor;
  final String internalNoteTime;

  const DisputeItem({
    required this.id,
    required this.title,
    required this.orderId,
    required this.timeAgo,
    required this.priority,
    required this.status,
    required this.amount,
    required this.disputeType,
    required this.buyerName,
    required this.buyerClaim,
    required this.sellerName,
    required this.sellerResponse,
    required this.buyerEvidence,
    required this.sellerEvidence,
    required this.internalNote,
    required this.internalNoteAuthor,
    required this.internalNoteTime,
  });
}

final List<DisputeItem> mockDisputes = [
  const DisputeItem(
    id: '#DP-2024-001',
    title: 'Damaged Product - Electronics',
    orderId: '#ORD-5547',
    timeAgo: '2 hours ago',
    priority: Priority.high,
    status: DisputeStatus.inReview,
    amount: '\$299.99',
    disputeType: 'Damaged Product',
    buyerName: 'John Smith',
    buyerClaim:
        'The wireless headphones I ordered arrived with visible damage to the left speaker. The packaging was also torn, suggesting mishandling during shipping. The product doesn\'t work properly and I\'m requesting a full refund.',
    sellerName: 'TechStore Electronics',
    sellerResponse:
        'We acknowledge the damage reported by the customer. Our warehouse team has confirmed that the item was in perfect condition when shipped. We believe this damage occurred during transit. We\'re willing to offer a replacement or partial refund of 50% as a goodwill gesture.',
    buyerEvidence: ['Evidence Attached', '3 Photos'],
    sellerEvidence: ['Shipping Records', 'Quality Check Photos'],
    internalNote:
        'Reviewed evidence from both parties. Buyer photos clearly show damage. Seller\'s shipping records indicate proper handling. Likely transit damage.',
    internalNoteAuthor: 'Sarah Johnson',
    internalNoteTime: '30 min ago',
  ),
  const DisputeItem(
    id: '#DP-2024-002',
    title: 'Wrong Item Delivered',
    orderId: '#ORD-5548',
    timeAgo: '4 hours ago',
    priority: Priority.medium,
    status: DisputeStatus.newCase,
    amount: '\$149.99',
    disputeType: 'Wrong Item',
    buyerName: 'Emily Davis',
    buyerClaim:
        'I ordered a blue jacket size M but received a red shirt size L. This is completely wrong. I need the correct item or a full refund immediately.',
    sellerName: 'Fashion Hub',
    sellerResponse:
        'We apologize for the mix-up. Our packing team made an error. We will send the correct item within 2 business days and arrange a pickup for the wrong item.',
    buyerEvidence: ['Order Screenshot', '2 Photos'],
    sellerEvidence: ['Packing Slip', 'Inventory Log'],
    internalNote: 'Clear seller error. Recommend full refund or replacement.',
    internalNoteAuthor: 'Mike Torres',
    internalNoteTime: '1 hour ago',
  ),
  const DisputeItem(
    id: '#DP-2024-003',
    title: 'Late Delivery Complaint',
    orderId: '#ORD-5549',
    timeAgo: '6 hours ago',
    priority: Priority.low,
    status: DisputeStatus.evidenceReq,
    amount: '\$59.99',
    disputeType: 'Late Delivery',
    buyerName: 'Raj Patel',
    buyerClaim:
        'My order was supposed to arrive in 3 days but it took 12 days. This caused significant inconvenience as it was a birthday gift.',
    sellerName: 'QuickShip Store',
    sellerResponse:
        'The delay was due to an unexpected logistics issue with our courier partner. We sincerely apologize and are willing to offer a 20% discount on the next order.',
    buyerEvidence: ['Order Confirmation'],
    sellerEvidence: ['Tracking History'],
    internalNote: 'Need more evidence from both parties before deciding.',
    internalNoteAuthor: 'Anna Lee',
    internalNoteTime: '3 hours ago',
  ),
];

class DisputeCenterPage extends StatefulWidget {
  const DisputeCenterPage({super.key});

  @override
  State<DisputeCenterPage> createState() => _DisputeCenterPageState();
}

class _DisputeCenterPageState extends State<DisputeCenterPage> {
  DisputeItem? _selected;

  @override
  void initState() {
    super.initState();
    _selected = mockDisputes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              // Top bar
              Row(
                children: [
                  const Text(
                    'Dispute Center',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_rounded, size: 16),
                    label: const Text('Export Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D5016),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              // Body: list + detail
              Expanded(
                child: Row(
                  children: [
                    // Dispute list panel
                    SizedBox(
                      width: 360,
                      child: _DisputeListPanel(
                        disputes: mockDisputes,
                        selected: _selected,
                        onSelect: (d) => setState(() => _selected = d),
                      ),
                    ),
                    const VerticalDivider(width: 1, color: Color(0xFFEEEEEE)),

                    // Detail panel
                    Expanded(
                      child:
                          _selected != null
                              ? _DisputeDetailPanel(dispute: _selected!)
                              : const Center(
                                child: Text('Select a dispute to view details'),
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}

// ─── Dispute List Panel ────────────────────────────────────────────────────────

class _DisputeListPanel extends StatefulWidget {
  final List<DisputeItem> disputes;
  final DisputeItem? selected;
  final ValueChanged<DisputeItem> onSelect;

  const _DisputeListPanel({
    required this.disputes,
    required this.selected,
    required this.onSelect,
  });

  @override
  State<_DisputeListPanel> createState() => _DisputeListPanelState();
}

class _DisputeListPanelState extends State<_DisputeListPanel> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header + filter
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            children: [
              const Text(
                'Active Disputes',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDDDDDD)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Text(
                      'All Status',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Search
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: TextField(
            controller: _searchCtrl,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search disputes...',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 18,
                color: Colors.grey[400],
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF2D5016)),
              ),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
            ),
          ),
        ),

        const Divider(height: 1, color: Color(0xFFEEEEEE)),

        // List
        Expanded(
          child: ListView.separated(
            itemCount: widget.disputes.length,
            separatorBuilder:
                (_, __) => const Divider(height: 1, color: Color(0xFFEEEEEE)),
            itemBuilder: (context, i) {
              final d = widget.disputes[i];
              final isSelected = widget.selected?.id == d.id;
              return _DisputeListTile(
                dispute: d,
                isSelected: isSelected,
                onTap: () => widget.onSelect(d),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DisputeListTile extends StatelessWidget {
  final DisputeItem dispute;
  final bool isSelected;
  final VoidCallback onTap;

  const _DisputeListTile({
    required this.dispute,
    required this.isSelected,
    required this.onTap,
  });

  Color get _priorityColor {
    switch (dispute.priority) {
      case Priority.high:
        return const Color(0xFFE53935);
      case Priority.medium:
        return const Color(0xFFF57C00);
      case Priority.low:
        return const Color(0xFF43A047);
    }
  }

  String get _priorityLabel {
    switch (dispute.priority) {
      case Priority.high:
        return 'High Priority';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
    }
  }

  Color get _statusColor {
    switch (dispute.status) {
      case DisputeStatus.inReview:
        return const Color(0xFFF57C00);
      case DisputeStatus.newCase:
        return const Color(0xFF1565C0);
      case DisputeStatus.evidenceReq:
        return const Color(0xFF6A1B9A);
      case DisputeStatus.resolved:
        return const Color(0xFF2E7D32);
    }
  }

  String get _statusLabel {
    switch (dispute.status) {
      case DisputeStatus.inReview:
        return 'In Review';
      case DisputeStatus.newCase:
        return 'New';
      case DisputeStatus.evidenceReq:
        return 'Evidence Req';
      case DisputeStatus.resolved:
        return 'Resolved';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSelected ? const Color(0xFFF0F4EC) : Colors.white,
        child: Container(
          decoration: BoxDecoration(
            border:
                isSelected
                    ? const Border(
                      left: BorderSide(color: Color(0xFF2D5016), width: 3),
                    )
                    : const Border(
                      left: BorderSide(color: Colors.transparent, width: 3),
                    ),
          ),
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    dispute.id,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _Badge(
                    label: _priorityLabel,
                    color: _priorityColor,
                    bg: _priorityColor.withOpacity(0.1),
                  ),
                  const Spacer(),
                  _Badge(
                    label: _statusLabel,
                    color: _statusColor,
                    bg: _statusColor.withOpacity(0.1),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                dispute.title,
                style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Order: ${dispute.orderId}',
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    dispute.timeAgo,
                    style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Dispute Detail Panel ──────────────────────────────────────────────────────

class _DisputeDetailPanel extends StatefulWidget {
  final DisputeItem dispute;
  const _DisputeDetailPanel({required this.dispute});

  @override
  State<_DisputeDetailPanel> createState() => _DisputeDetailPanelState();
}

class _DisputeDetailPanelState extends State<_DisputeDetailPanel> {
  ResolutionType _resolution = ResolutionType.fullRefund;
  final TextEditingController _noteCtrl = TextEditingController();
  final TextEditingController _resolutionNoteCtrl = TextEditingController();

  Color get _priorityColor {
    switch (widget.dispute.priority) {
      case Priority.high:
        return const Color(0xFFE53935);
      case Priority.medium:
        return const Color(0xFFF57C00);
      case Priority.low:
        return const Color(0xFF43A047);
    }
  }

  String get _priorityLabel {
    switch (widget.dispute.priority) {
      case Priority.high:
        return 'High Priority';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Case header
          _buildCaseHeader(),
          const SizedBox(height: 20),

          // Buyer claim
          _buildClaimCard(
            title: 'Buyer Claim',
            subtitle: '${widget.dispute.buyerName} • ${widget.dispute.timeAgo}',
            content: widget.dispute.buyerClaim,
            tags: widget.dispute.buyerEvidence,
            color: const Color(0xFFFFF8E1),
          ),
          const SizedBox(height: 16),

          // Seller response
          _buildClaimCard(
            title: 'Seller Response',
            subtitle: '${widget.dispute.sellerName} • 1 hour ago',
            content: widget.dispute.sellerResponse,
            tags: widget.dispute.sellerEvidence,
            color: const Color(0xFFFFF8E1),
          ),
          const SizedBox(height: 16),

          // Internal notes
          _buildInternalNotes(),
          const SizedBox(height: 16),

          // Resolution
          _buildResolutionSection(),
        ],
      ),
    );
  }

  Widget _buildCaseHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Case ${widget.dispute.id}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const Spacer(),
              _Badge(
                label: _priorityLabel,
                color: _priorityColor,
                bg: _priorityColor.withOpacity(0.1),
              ),
              const SizedBox(width: 8),
              _Badge(
                label: 'In Review',
                color: const Color(0xFFF57C00),
                bg: const Color(0xFFFFF3E0),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _InfoColumn(label: 'Order ID', value: widget.dispute.orderId),
              const SizedBox(width: 40),
              _InfoColumn(
                label: 'Dispute Type',
                value: widget.dispute.disputeType,
              ),
              const SizedBox(width: 40),
              _InfoColumn(label: 'Amount', value: widget.dispute.amount),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClaimCard({
    required String title,
    required String subtitle,
    required String content,
    required List<String> tags,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: tags.map((t) => _EvidenceTag(t)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInternalNotes() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Internal Notes',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),

          // Existing note
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.dispute.internalNoteAuthor,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.dispute.internalNoteTime,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.dispute.internalNote,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF444444),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(color: Color(0xFFEEEEEE)),
          const SizedBox(height: 10),

          // Add note input
          TextField(
            controller: _noteCtrl,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Add internal note...',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF2D5016)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D5016),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(fontSize: 13),
            ),
            child: const Text('Add Note'),
          ),
        ],
      ),
    );
  }

  Widget _buildResolutionSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resolution Decision',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),

          // Resolution options
          Row(
            children: [
              _ResolutionOption(
                icon: Icons.check_circle_rounded,
                label: 'Full Refund',
                sub: widget.dispute.amount,
                type: ResolutionType.fullRefund,
                selected: _resolution,
                onTap:
                    () =>
                        setState(() => _resolution = ResolutionType.fullRefund),
              ),
              const SizedBox(width: 12),
              _ResolutionOption(
                icon: Icons.percent_rounded,
                label: 'Partial Refund',
                sub: 'Custom Amount',
                type: ResolutionType.partialRefund,
                selected: _resolution,
                onTap:
                    () => setState(
                      () => _resolution = ResolutionType.partialRefund,
                    ),
              ),
              const SizedBox(width: 12),
              _ResolutionOption(
                icon: Icons.cancel_rounded,
                label: 'Reject Claim',
                sub: 'No Refund',
                type: ResolutionType.rejectClaim,
                selected: _resolution,
                onTap:
                    () => setState(
                      () => _resolution = ResolutionType.rejectClaim,
                    ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Refund amount
          const Text(
            'Refund Amount',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFDDDDDD)),
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFFAFAFA),
            ),
            child: Text(
              widget.dispute.amount,
              style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
            ),
          ),

          const SizedBox(height: 16),

          // Resolution note
          const Text(
            'Resolution Note',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _resolutionNoteCtrl,
            maxLines: 3,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Explain the reasoning for this decision...',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF2D5016)),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D5016),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Process Resolution'),
                ),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  foregroundColor: const Color(0xFF555555),
                ),
                child: const Text('Save Draft', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Resolution Option Card ────────────────────────────────────────────────────

class _ResolutionOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  final ResolutionType type;
  final ResolutionType selected;
  final VoidCallback onTap;

  const _ResolutionOption({
    required this.icon,
    required this.label,
    required this.sub,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  bool get _isSelected => selected == type;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color:
                _isSelected ? const Color(0xFFF0F4EC) : const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  _isSelected
                      ? const Color(0xFF2D5016)
                      : const Color(0xFFDDDDDD),
              width: _isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 24,
                color: _isSelected ? const Color(0xFF2D5016) : Colors.grey[400],
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color:
                      _isSelected
                          ? const Color(0xFF2D5016)
                          : const Color(0xFF555555),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                sub,
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Shared Widgets ────────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final Color bg;

  const _Badge({required this.label, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _EvidenceTag extends StatelessWidget {
  final String label;
  const _EvidenceTag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFF444444),
        ),
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String label;
  final String value;

  const _InfoColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}
