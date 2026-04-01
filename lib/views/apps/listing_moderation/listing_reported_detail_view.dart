// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:webkit/controller/apps/kyc_controller.dart';
// import 'package:webkit/helpers/theme/admin_theme.dart';
// import 'package:webkit/helpers/utils/ui_mixins.dart';
// import 'package:webkit/views/apps/listing_moderation/widget/listing_dialog.dart';
// import 'package:webkit/views/layouts/layout.dart';

// class ListingReportedDetailView extends StatefulWidget {
//   const ListingReportedDetailView({super.key});

//   @override
//   State<ListingReportedDetailView> createState() =>
//       _ListingReportedDetailViewState();
// }

// class _ListingReportedDetailViewState extends State<ListingReportedDetailView>
//     with SingleTickerProviderStateMixin, UIMixin {
//   late KYCController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(KYCController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       child: GetBuilder(
//         init: controller,
//         builder: (controller) {
//           return SizedBox(
//             width: Get.width,
//             height: Get.height,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // LEFT CONTENT
//                   Expanded(
//                     flex: 2,
//                     child: _listingDetailSection(),
//                   ),

//                   const SizedBox(width: 20),

//                   // RIGHT PANEL
//                   Expanded(
//                     flex: 1,
//                     child: _rightPanel(),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _listingDetailSection() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // IMAGE BOX
//           Container(
//             height: 300,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),

//           const SizedBox(height: 12),

//           // THUMBNAILS
//           Row(
//             children: List.generate(
//               4,
//               (index) => Container(
//                 margin: const EdgeInsets.only(right: 10),
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // TITLE
//           Text(
//             "Sony WH-1000XM5 Wireless Noise Canceling Headphones",
//             style: GoogleFonts.montserrat(
//                 fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
//           ),

//           const SizedBox(height: 10),

//           // PRICE + TAGS
//           Row(
//             children: [
//               Text("\$299.99",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 26,
//                       fontWeight: FontWeight.w700,
//                       color: contentTheme.primary)),
//               const SizedBox(width: 10),
//               _tag("Electronics"),
//               const SizedBox(width: 8),
//               _tag("Like New"),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // CATEGORY + CONDITION
//           Row(
//             children: const [
//               Expanded(child: _infoTile("Category", "Audio & Electronics")),
//               Expanded(child: _infoTile("Condition", "Like New")),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // DESCRIPTION
//           const Text(
//             "Description",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "Premium wireless noise-canceling headphones in excellent condition. "
//             "Used only for a few months, comes with original packaging, charging cable, and carrying case.",
//             style: GoogleFonts.montserrat(
//                 fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
//           ),

//           const SizedBox(height: 15),

//           const Text("Specifications",
//               style: TextStyle(fontWeight: FontWeight.bold)),

//           const SizedBox(height: 10),

//           _specGrid(),

//           const SizedBox(height: 10),

//           _evidenceSection(),
//         ],
//       ),
//     );
//   }

//   Widget _evidenceSection() {
//     return _card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.photo_sharp,
//                 color: contentTheme.primary,
//               ),
//               SizedBox(width: 10),
//               Text("Evidence Submitted",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 17,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700)),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: List.generate(
//               3,
//               (i) => Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 10),
//                   height: 200,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(6),
//                     color: Colors.black54,
//                     child: Text(
//                       "Evidence ${i + 1}",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _specGrid() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       childAspectRatio: 10,
//       children: const [
//         _specItem("Movement", "Swiss Automatic"),
//         _specItem("Case Diameter", "42mm"),
//         _specItem("Crystal", "Sapphire"),
//         _specItem("Case Material", "Stainless Steel"),
//         _specItem("Water Resistance", "100m"),
//         _specItem("Strap", "Leather"),
//       ],
//     );
//   }
// }

// Widget _tag(String text) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//     decoration: BoxDecoration(
//       color: ContentTheme.lightContentTheme.primary.withValues(alpha: 0.10),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: Text(text,
//         style: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//             color: ContentTheme.lightContentTheme.primary)),
//   );
// }

// Widget _rightPanel() {
//   return Column(
//     children: [
//       _reportDetails(),
//       const SizedBox(height: 15),
//       _actionButtons(),
//       const SizedBox(height: 15),
//       _activityHistory(),
//     ],
//   );
// }

// Widget _reportDetails() {
//   return _card(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(Icons.flag_circle_rounded, size: 40),
//             SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Report Details",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 17, fontWeight: FontWeight.w700)),
//                 Text("Review and take action",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B))),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 10),
//         Text(
//           "Report Reason",
//           style: GoogleFonts.montserrat(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff4B4B4B)),
//         ),
//         SizedBox(height: 5),
//         _tag("Counterfeit Item"),
//         SizedBox(height: 10),
//         Text(
//           "Reported by",
//           style: GoogleFonts.montserrat(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff4B4B4B)),
//         ),
//         Text("John D (Buyer)"),
//         SizedBox(height: 10),
//         Text(
//           "Reported on",
//           style: GoogleFonts.montserrat(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff4B4B4B)),
//         ),
//         Text(
//           "12 Mar 2024",
//           style: GoogleFonts.montserrat(
//               fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
//         ),
//         SizedBox(height: 10),
//         Text(
//           "Priority",
//           style: GoogleFonts.montserrat(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff4B4B4B)),
//         ),
//         _tag("High"),
//         SizedBox(height: 10),
//         Text("User Note",
//             style: GoogleFonts.montserrat(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff4B4B4B))),
//         SizedBox(height: 10),
//         _card(
//           child: Text(
//             "\"This product seems fake. The serial number doesn't match official records...\"",
//             style: GoogleFonts.montserrat(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff4B4B4B)),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget _actionButtons() {
//   return _card(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Actions",
//             style: GoogleFonts.montserrat(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black)),
//         SizedBox(height: 10),
//         _btn("Remove Listing", onPressed: () {
//           showDialog(
//             context: Get.context!,
//             builder: (_) => RejectListingDialog(
//               onCancel: () => Navigator.pop(Get.context!),
//               onSubmit: (category, subReason, reason, sendEmail) {
//                 Navigator.pop(Get.context!);
//               },
//             ),
//           );
//         }, ContentTheme.lightContentTheme.primary, child: Icon(Icons.block)),
//         _btn("Suspend Seller",
//             LeftBarTheme.lightLeftBarTheme.activeItemBackground,
//             child: Icon(Icons.person_off)),
//         _btn("Contact Seller", ContentTheme.lightContentTheme.primary,
//             child: Icon(Icons.email)),
//         _btn("Mark as Resolved", Color(0xffE5E7EB),
//             child: Icon(Icons.check_circle)),
//         _btn("Dismiss Report", Colors.white,
//             textColor: Colors.black, child: Icon(Icons.close)),
//       ],
//     ),
//   );
// }

// Widget _btn(String text, Color color,
//     {Color textColor = Colors.white,
//     required Widget child,
//     Function()? onPressed}) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 10),
//     width: double.infinity,
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
//         backgroundColor: color,
//         foregroundColor: textColor,
//         padding: const EdgeInsets.symmetric(vertical: 16),
//       ),
//       onPressed: onPressed,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           child,
//           SizedBox(width: 10),
//           Text(text,
//               style: GoogleFonts.montserrat(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color:
//                       (text == "Dismiss Report") || (text == "Mark as Resolved")
//                           ? Colors.black
//                           : Colors.white)),
//         ],
//       ),
//     ),
//   );
// }

// Widget _activityHistory() {
//   return _card(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Activity History",
//           style: GoogleFonts.montserrat(
//               fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black),
//         ),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Icon(Icons.flag_circle_rounded, size: 30),
//             SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Report Submitted",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 13, fontWeight: FontWeight.w700)),
//                 Text("Review and take action",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B))),
//               ],
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Icon(Icons.flag_circle_rounded, size: 30),
//             SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Under Review",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 13, fontWeight: FontWeight.w700)),
//                 Text("12 Mar 2024, 11:20 AM",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B))),
//               ],
//             ),
//           ],
//         ).paddingSymmetric(vertical: 12),
//         Row(
//           children: [
//             Icon(Icons.attachment, size: 30),
//             SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Evidence Added",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 13, fontWeight: FontWeight.w700)),
//                 Text("12 Mar 2024, 11:20 AM",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B))),
//               ],
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// class _timeline extends StatelessWidget {
//   final String title;

//   const _timeline(this.title);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Icon(Icons.circle, size: 10, color: Colors.orange),
//         const SizedBox(width: 8),
//         Text(title),
//       ],
//     );
//   }
// }

// Widget _card({required Widget child}) {
//   return Container(
//     width: double.infinity,
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.05),
//           blurRadius: 10,
//         )
//       ],
//     ),
//     child: child,
//   );
// }

// class _infoTile extends StatelessWidget {
//   final String title;
//   final String value;

//   const _infoTile(this.title, this.value);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title,
//             style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black)),
//         const SizedBox(height: 4),
//         Text(value,
//             style: GoogleFonts.montserrat(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black)),
//       ],
//     );
//   }
// }

// class _specItem extends StatelessWidget {
//   final String title;
//   final String value;

//   const _specItem(this.title, this.value);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(Icons.check_circle,
//                 color: ContentTheme.lightContentTheme.primary, size: 16)
//             .paddingOnly(top: 10),
//         const SizedBox(width: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("$title: ",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black)),
//             Text(value,
//                 style: GoogleFonts.montserrat(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff4B4B4B))),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/views/apps/listing_moderation/widget/listing_dialog.dart';
import 'package:webkit/views/layouts/layout.dart';

class ReportedListingReviewScreen extends StatefulWidget {
  const ReportedListingReviewScreen({super.key});

  @override
  State<ReportedListingReviewScreen> createState() =>
      _ReportedListingReviewScreenState();
}

class _ReportedListingReviewScreenState
    extends State<ReportedListingReviewScreen> {
  int _selectedTab = 1; // 0: Pending, 1: Reported, 2: Recently Approved
  int _currentImageIndex = 0;

  final List<String> _tabs = [
    'Pending Listings',
    'Reported Listings',
    'Recently Approved'
  ];
  final List<int> _tabCounts = [24, 8, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              _buildTopBar(),
              _buildTabBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 800;
                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: _buildLeftContent()),
                            const SizedBox(width: 16),
                            SizedBox(width: 320, child: _buildRightPanel()),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildLeftContent(),
                            const SizedBox(height: 16),
                            _buildRightPanel(),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────────── TOP BAR ──────────────────────────────
  Widget _buildTopBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          const Text(
            'Reported Listing Review',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3F3),
              border:
                  Border.all(color: const Color(0xFFFF4444).withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF4444),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Status: Reported',
                  style: TextStyle(
                    color: Color(0xFFFF4444),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────── TAB BAR ──────────────────────────────
  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final selected = _selectedTab == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        selected ? const Color(0xFFD4A017) : Colors.transparent,
                    width: 2.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    _tabs[i],
                    style: TextStyle(
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                      color: selected
                          ? const Color(0xFF1A1A1A)
                          : const Color(0xFF888888),
                      fontSize: 14,
                    ),
                  ),
                  if (_tabCounts[i] > 0) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFFD4A017)
                            : const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_tabCounts[i]}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color:
                              selected ? Colors.white : const Color(0xFF666666),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─────────────────────────── LEFT CONTENT ───────────────────────────
  Widget _buildLeftContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageCarousel(),
        const SizedBox(height: 16),
        _buildListingDetails(),
        const SizedBox(height: 16),
        _buildSpecifications(),
        const SizedBox(height: 16),
        _buildEvidenceSection(),
      ],
    );
  }

  Widget _buildImageCarousel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Main image area
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 260,
                color: const Color(0xFFF8F8F8),
                child: Center(
                  child: Icon(Icons.image_outlined,
                      size: 64, color: Colors.grey[300]),
                ),
              ),
              Positioned(
                left: 12,
                child: _carouselButton(Icons.chevron_left, () {
                  setState(() {
                    _currentImageIndex = (_currentImageIndex - 1 + 5) % 5;
                  });
                }),
              ),
              Positioned(
                right: 12,
                child: _carouselButton(Icons.chevron_right, () {
                  setState(() {
                    _currentImageIndex = (_currentImageIndex + 1) % 5;
                  });
                }),
              ),
              Positioned(
                bottom: 12,
                child: Row(
                  children: List.generate(5, (i) {
                    return Container(
                      width: i == _currentImageIndex ? 20 : 7,
                      height: 7,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: i == _currentImageIndex
                            ? const Color(0xFFD4A017)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          // Thumbnail strip
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: List.generate(5, (i) {
                return Container(
                  width: 70,
                  height: 55,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(8),
                    border: i == _currentImageIndex
                        ? Border.all(color: const Color(0xFFD4A017), width: 2)
                        : null,
                  ),
                  child: Icon(Icons.image_outlined,
                      size: 24, color: Colors.grey[400]),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _carouselButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF333333)),
      ),
    );
  }

  Widget _buildListingDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Premium Luxury Swiss Automatic Watch',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                '\$2,499.00',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD4A017),
                ),
              ),
              const SizedBox(width: 10),
              _tag('Watches & Accessories', const Color(0xFFF0F0F0),
                  const Color(0xFF555555)),
              const SizedBox(width: 6),
              _tag('Brand New', const Color(0xFFE8F5E9),
                  const Color(0xFF2E7D32)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, size: 16, color: Colors.grey),
              ),
              const SizedBox(width: 8),
              const Text(
                'Michael Thompson',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.open_in_new, size: 14, color: Color(0xFFD4A017)),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          const Text(
            'Authentic Swiss-made automatic watch featuring a 42mm stainless steel case, sapphire crystal glass, and premium leather strap. This timepiece combines traditional craftsmanship with modern design elements. Water-resistant up to 100 meters, perfect for everyday wear and special occasions. Comes with original box, warranty card, and authenticity certificate.',
            style: TextStyle(
              fontSize: 13.5,
              color: Color(0xFF555555),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 12, color: fg, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildSpecifications() {
    final specs = [
      ['Movement', 'Swiss Automatic', false],
      ['Case Material', 'Stainless Steel', true],
      ['Case Diameter', '42mm', false],
      ['Water Resistance', '100m / 10 ATM', true],
      ['Crystal', 'Sapphire', false],
      ['Strap', 'Genuine Leather', true],
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Specifications',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 10,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: specs.map((s) {
              final hasWarning = s[2] as bool;
              return Row(
                children: [
                  Icon(
                    hasWarning
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle,
                    size: 16,
                    color: hasWarning
                        ? const Color(0xFFFF9800)
                        : const Color(0xFF4CAF50),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(s[0] as String,
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF888888),
                              fontWeight: FontWeight.w500)),
                      Text(s[1] as String,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF1A1A1A),
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenceSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.folder_open_outlined,
                  size: 18, color: Color(0xFFD4A017)),
              const SizedBox(width: 8),
              const Text(
                'Evidence Submitted',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: List.generate(3, (i) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i < 2 ? 10 : 0),
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(Icons.image_outlined,
                            size: 32, color: Colors.grey[400]),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(8)),
                          ),
                          child: Text(
                            'Evidence ${i + 1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────── RIGHT PANEL ────────────────────────────
  Widget _buildRightPanel() {
    return Column(
      children: [
        _buildReportDetails(),
        const SizedBox(height: 16),
        _buildActions(),
        const SizedBox(height: 16),
        _buildActivityHistory(),
      ],
    );
  }

  Widget _buildReportDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    const Icon(Icons.flag, color: Color(0xFFFF4444), size: 18),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Report Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('Review and take action',
                      style: TextStyle(fontSize: 12, color: Color(0xFF888888))),
                ],
              ),
            ],
          ),
          const Divider(height: 24),
          _detailRow('Report Reason', null,
              chip: _tag('Counterfeit Item', const Color(0xFFFFF8E1),
                  const Color(0xFFC9941A))),
          const SizedBox(height: 14),
          _detailRow('Reported by', null,
              custom: Row(
                children: [
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.grey[300],
                    child:
                        const Icon(Icons.person, size: 14, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  const Text('John D',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(width: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Buyer',
                        style:
                            TextStyle(fontSize: 10, color: Color(0xFF666666))),
                  ),
                ],
              )),
          const SizedBox(height: 14),
          _detailRow('Reported on', '12 Mar 2024'),
          const SizedBox(height: 14),
          _detailRow('Priority', null, chip: _priorityBadge()),
          const SizedBox(height: 14),
          const Text('User Note',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF888888),
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE8E8E8)),
            ),
            child: const Text(
              '"This product seems fake. The serial number doesn\'t match official records, and the packaging looks different from genuine products. The quality of materials also feels inferior to authentic items."',
              style: TextStyle(
                fontSize: 12.5,
                color: Color(0xFF555555),
                fontStyle: FontStyle.italic,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String? value,
      {Widget? chip, Widget? custom}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF888888),
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        if (value != null)
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF1A1A1A)))
        else if (chip != null)
          chip
        else if (custom != null)
          custom,
      ],
    );
  }

  Widget _priorityBadge() {
    return Row(
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: const BoxDecoration(
              color: Color(0xFFFF9800), shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        const Text('High',
            style: TextStyle(
                color: Color(0xFFFF9800),
                fontWeight: FontWeight.bold,
                fontSize: 13)),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Actions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 14),
          _actionButton(
            onTap: () {
              showDialog(
                context: Get.context!,
                builder: (_) => RejectListingDialog(
                  onCancel: () => Navigator.pop(Get.context!),
                  onSubmit: (category, subReason, reason, sendEmail) {
                    Navigator.pop(Get.context!);
                  },
                ),
              );
            },
            Icons.delete_outline,
            'Remove Listing',
            const Color(0xFFD4A017),
            Colors.white,
          ),
          const SizedBox(height: 10),
          _actionButton(
            Icons.person_off_outlined,
            'Suspend Seller',
            onTap: () {
              showDialog(
                context: Get.context!,
                builder: (_) => RejectListingDialog(
                  onCancel: () => Navigator.pop(Get.context!),
                  onSubmit: (category, subReason, reason, sendEmail) {
                    Navigator.pop(Get.context!);
                  },
                ),
              );
            },
            const Color(0xFF1A3A2A),
            Colors.white,
          ),
          const SizedBox(height: 10),
          _actionButton(
            Icons.mail_outline,
            'Contact Seller',
            const Color(0xFFD4A017),
            Colors.white,
          ),
          const SizedBox(height: 10),
          _actionButton(
            Icons.check_circle_outline,
            'Mark as Resolved',
            Colors.white,
            const Color(0xFF1A1A1A),
            bordered: true,
          ),
          const SizedBox(height: 10),
          _actionButton(
            Icons.close,
            'Dismiss Report',
            Colors.white,
            const Color(0xFF888888),
            bordered: true,
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
      IconData icon, String label, Color bgColor, Color textColor,
      {bool bordered = false, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: bordered ? Border.all(color: const Color(0xFFDDDDDD)) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 17, color: textColor),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityHistory() {
    final events = [
      {
        'icon': Icons.flag,
        'color': const Color(0xFFFF4444),
        'bg': const Color(0xFFFFF3F3),
        'title': 'Report Submitted',
        'time': '12 Mar 2024, 10:45 AM',
      },
      {
        'icon': Icons.visibility_outlined,
        'color': const Color(0xFFD4A017),
        'bg': const Color(0xFFFFF8E1),
        'title': 'Under Review',
        'time': '12 Mar 2024, 11:20 AM',
      },
      {
        'icon': Icons.folder_open_outlined,
        'color': const Color(0xFF888888),
        'bg': const Color(0xFFF0F0F0),
        'title': 'Evidence Added',
        'time': '12 Mar 2024, 2:15 PM',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.history, size: 18, color: Color(0xFFD4A017)),
              const SizedBox(width: 8),
              const Text('Activity History',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 14),
          ...events.asMap().entries.map((e) {
            final item = e.value;
            final isLast = e.key == events.length - 1;
            return _timelineItem(
              icon: item['icon'] as IconData,
              color: item['color'] as Color,
              bg: item['bg'] as Color,
              title: item['title'] as String,
              time: item['time'] as String,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }

  Widget _timelineItem({
    required IconData icon,
    required Color color,
    required Color bg,
    required String title,
    required String time,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                child: Icon(icon, size: 15, color: color),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFFEEEEEE),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Color(0xFF1A1A1A))),
                  const SizedBox(height: 3),
                  Text(time,
                      style: const TextStyle(
                          fontSize: 11.5, color: Color(0xFF888888))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
