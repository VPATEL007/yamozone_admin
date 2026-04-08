// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:yamazone/controller/apps/kyc_controller.dart';
// import 'package:yamazone/helpers/theme/admin_theme.dart';
// import 'package:yamazone/helpers/utils/ui_mixins.dart';
// import 'package:yamazone/images.dart';
// import 'package:yamazone/views/apps/kyc/widget/kyc_dialog.dart';
// import 'package:yamazone/views/layouts/layout.dart';

// class KycApprovalPage extends StatefulWidget {
//   const KycApprovalPage({super.key});

//   @override
//   State<KycApprovalPage> createState() => _KycApprovalPageState();
// }

// class _KycApprovalPageState extends State<KycApprovalPage>
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
//           return SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "KYC Approvals",
//                       style: GoogleFonts.inter(
//                           fontSize: 23,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xff111827)),
//                     ),
//                     SizedBox(
//                       width: 260,
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: "Search...",
//                           prefixIcon: const Icon(Icons.search),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),

//                 /// STATS
//                 const Row(
//                   children: [
//                     Expanded(
//                         child: KycStatCard("Pending Review", "24", "+12%")),
//                     SizedBox(width: 16),
//                     Expanded(child: KycStatCard("Approved Today", "47", "+8%")),
//                     SizedBox(width: 16),
//                     Expanded(child: KycStatCard("Rejected Today", "8", "-3%")),
//                     SizedBox(width: 16),
//                     Expanded(child: KycStatCard("Need More Info", "12", "-5%")),
//                   ],
//                 ),

//                 const SizedBox(height: 10),

//                 /// TABS
//                 kycTbas(),

//                 /// FILTER BAR
//                 const KycFilterBar(),

//                 const SizedBox(height: 20),

//                 /// KYC LIST
//                 Obx(
//                   () => controller.selectedTab.value == 0
//                       ? Column(
//                           children: const [
//                             KycUserCard(),
//                             SizedBox(height: 16),
//                             KycUserCard(),
//                             SizedBox(height: 16),
//                             KycUserCard(),
//                           ],
//                         )
//                       : Column(
//                           children: const [
//                             KycUserCard(),
//                             SizedBox(height: 16),
//                             KycUserCard(),
//                             SizedBox(height: 16),
//                             KycUserCard(),
//                           ],
//                         ),
//                 ),

//                 const SizedBox(height: 30),

//                 /// PAGINATION
//                 const KycPagination(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget kycTbas() {
//     return Row(
//       children: [
//         InkWell(
//             onTap: () {
//               controller.selectedTab(0);
//             },
//             child: Obx(
//               () => Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.store,
//                       size: 16,
//                       color: controller.selectedTab.value == 0
//                           ? ContentTheme.lightContentTheme.primary
//                           : Colors.black,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       "Seller KYC Queue",
//                       style: GoogleFonts.inter(
//                           color: controller.selectedTab.value == 0
//                               ? ContentTheme.lightContentTheme.primary
//                               : Colors.black,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(width: 8),
//                     CircleAvatar(
//                       radius: 11,
//                       backgroundColor: controller.selectedTab.value == 0
//                           ? ContentTheme.lightContentTheme.primary
//                           : ContentTheme.lightContentTheme.primary
//                               .withValues(alpha: 0.20),
//                       child: Text("15",
//                           style: GoogleFonts.inter(
//                               fontSize: 11, fontWeight: FontWeight.w600)),
//                     )
//                   ],
//                 ),
//               ),
//             )),
//         const SizedBox(width: 16),
//         InkWell(
//             onTap: () {
//               controller.selectedTab(1);
//             },
//             child: Obx(
//               () => Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.store,
//                       size: 16,
//                       color: controller.selectedTab.value == 1
//                           ? ContentTheme.lightContentTheme.primary
//                           : Colors.black,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       "Driver KYC Queue",
//                       style: GoogleFonts.inter(
//                           color: controller.selectedTab.value == 1
//                               ? ContentTheme.lightContentTheme.primary
//                               : Colors.black,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(width: 8),
//                     CircleAvatar(
//                       radius: 11,
//                       backgroundColor: controller.selectedTab.value == 1
//                           ? ContentTheme.lightContentTheme.primary
//                           : ContentTheme.lightContentTheme.primary
//                               .withValues(alpha: 0.20),
//                       child: Text("9",
//                           style: GoogleFonts.inter(
//                               fontSize: 11, fontWeight: FontWeight.w600)),
//                     )
//                   ],
//                 ),
//               ),
//             )),
//       ],
//     );
//   }
// }

// class KycStatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String percent;

//   const KycStatCard(this.title, this.value, this.percent, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(.05),
//             blurRadius: 10,
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (percent.isNotEmpty)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset("assets/icon/orders.png", width: 48, height: 48),
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: const Color(0xfff6f0dd),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       percent,
//                       style: GoogleFonts.montserrat(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: ContentTheme.lightContentTheme.primary),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           SizedBox(height: 10),
//           Text(
//             title,
//             style: GoogleFonts.montserrat(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xff4B4B4B)),
//           ),
//           Text(
//             value,
//             style: GoogleFonts.montserrat(
//                 fontSize: 34, fontWeight: FontWeight.w600, color: Colors.black),
//           )
//         ],
//       ),
//     );
//   }
// }

// class KycFilterBar extends StatelessWidget {
//   const KycFilterBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         /// STATUS
//         SizedBox(
//           width: 200,
//           child: DropdownButtonFormField(
//             dropdownColor: Colors.white,
//             items: [
//               DropdownMenuItem(
//                   value: "Approve",
//                   child: Text(
//                     "Approve",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black),
//                   )),
//               DropdownMenuItem(
//                   value: "Reject",
//                   child: Text(
//                     "Reject",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black),
//                   ))
//             ],
//             onChanged: (v) {},
//             decoration: InputDecoration(
//                 labelText: "All Status",
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Color(0xffD1D5DB), width: 1)),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Color(0xffD1D5DB), width: 1)),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide:
//                         BorderSide(color: Color(0xffD1D5DB), width: 1))),
//           ),
//         ),

//         const SizedBox(width: 12),

//         /// SORT
//         SizedBox(
//           width: 200,
//           child: DropdownButtonFormField(
//             dropdownColor: Colors.white,
//             items: [
//               DropdownMenuItem(
//                   value: "Newest",
//                   child: Text(
//                     "Newest",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black),
//                   )),
//               DropdownMenuItem(
//                   value: "Oldest",
//                   child: Text(
//                     "Oldest",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black),
//                   ))
//             ],
//             onChanged: (v) {},
//             decoration: InputDecoration(
//                 labelText: "Sort by: Newest",
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Color(0xffD1D5DB), width: 1)),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Color(0xffD1D5DB), width: 1)),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide:
//                         BorderSide(color: Color(0xffD1D5DB), width: 1))),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class KycUserCard extends StatelessWidget {
//   const KycUserCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(.05),
//             blurRadius: 10,
//           )
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// USER IMAGE
//           CircleAvatar(
//               radius: 26, backgroundImage: AssetImage(Images.avatars.first)),

//           const SizedBox(width: 16),

//           /// USER DETAILS
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text("Michael Johnson",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black)),
//                     const SizedBox(width: 10),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: ContentTheme.lightContentTheme.primary
//                             .withValues(alpha: .10),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text("Pending Review",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w600,
//                               color: ContentTheme.lightContentTheme.primary)),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.email,
//                       color: ContentTheme.lightContentTheme.primary,
//                       size: 20,
//                     ),
//                     SizedBox(width: 10),
//                     Text("michael.j@email.com",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff4B4B4B))),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.table_chart,
//                       color: ContentTheme.lightContentTheme.primary,
//                       size: 20,
//                     ),
//                     SizedBox(width: 10),
//                     Text("Tech Store LLC",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff4B4B4B))),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Wrap(
//                   spacing: 8,
//                   children: [
//                     _tag("ID Verified"),
//                     _tag("Business License"),
//                     _tag("Tax Documents"),
//                   ],
//                 )
//               ],
//             ),
//           ),

//           /// PHONE + DATE
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.call,
//                       size: 20, color: ContentTheme.lightContentTheme.primary),
//                   SizedBox(width: 8),
//                   Text(
//                     "+1 (555) 123-4567",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B)),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),
//               Row(
//                 children: [
//                   Icon(Icons.calendar_month,
//                       size: 20, color: ContentTheme.lightContentTheme.primary),
//                   SizedBox(width: 8),
//                   Text(
//                     " Submitted: Dec 15, 2024",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B)),
//                   ),
//                 ],
//               )
//             ],
//           ),

//           const SizedBox(width: 30),

//           /// ACTION BUTTONS
//           Column(
//             children: [
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                   backgroundColor: const Color(0xffd4a32b),
//                 ),
//                 onPressed: () {
//                   Get.toNamed("/kyc-review");
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.done,
//                       size: 20,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       "Approve",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                   backgroundColor:
//                       LeftBarTheme.lightLeftBarTheme.activeItemBackground,
//                 ),
//                 onPressed: () {
//                   showRejectKycDialog(context);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.close,
//                       size: 20,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       "Reject",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                   backgroundColor: const Color(0xffd4a32b),
//                 ),
//                 onPressed: () {
//                   showRequestMoreInfoDialog(context);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.question_mark_rounded,
//                       size: 20,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       "Request Info",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// Widget _tag(String text) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//     decoration: BoxDecoration(
//       color: ContentTheme.lightContentTheme.primary.withValues(alpha: .14),
//       borderRadius: BorderRadius.circular(5),
//     ),
//     child: Text(text,
//         style: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//             color: ContentTheme.lightContentTheme.primary)),
//   );
// }

// class KycPagination extends StatelessWidget {
//   const KycPagination({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text("Showing 1 to 5 of 1,247 results"),
//         Row(
//           children: [
//             const Text("Previous"),
//             const SizedBox(width: 12),
//             _pageNumber("1", true),
//             _pageNumber("2", false),
//             _pageNumber("3", false),
//             const Text("..."),
//             _pageNumber("249", false),
//             const SizedBox(width: 12),
//             const Text("Next"),
//           ],
//         )
//       ],
//     );
//   }

//   Widget _pageNumber(String text, bool active) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: active ? Colors.black : Colors.transparent,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: active ? Colors.white : Colors.black),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:yamazone/views/apps/kyc/widget/kyc_dialog.dart';
import 'package:yamazone/views/layouts/layout.dart';

// ─── Data Models ────────────────────────────────────────────────────────────

enum KYCStatus { pendingReview, underReview, moreInfoNeeded }

class KYCApplicant {
  final String name;
  final String email;
  final String company;
  final String phone;
  final String submittedDate;
  final KYCStatus status;
  final List<String> tags;
  final String avatarInitials;

  const KYCApplicant({
    required this.name,
    required this.email,
    required this.company,
    required this.phone,
    required this.submittedDate,
    required this.status,
    required this.tags,
    required this.avatarInitials,
  });
}

// ─── Constants ───────────────────────────────────────────────────────────────

class AppColors {
  static const Color primary = Color(0xFF2D5016); // dark green
  static const Color accent = Color(0xFFB8960C); // golden yellow
  static const Color accentLight = Color(0xFFF0C040); // light gold
  static const Color background = Color(0xFFF5F5F0);
  static const Color cardBg = Colors.white;
  static const Color approveBtn = Color(0xFFB8960C);
  static const Color rejectBtn = Color(0xFF2D5016);
  static const Color requestBtn = Color(0xFFB8960C);
  static const Color tagBg = Color(0xFFF0F0E8);
  static const Color tagText = Color(0xFF555544);
  static const Color statChange = Color(0xFF2D5016);
  static const Color statChangeBad = Color(0xFFCC3333);
}

// ─── Main Screen ─────────────────────────────────────────────────────────────

class KYCApprovalsScreen extends StatefulWidget {
  const KYCApprovalsScreen({super.key});

  @override
  State<KYCApprovalsScreen> createState() => _KYCApprovalsScreenState();
}

class _KYCApprovalsScreenState extends State<KYCApprovalsScreen> {
  int _selectedTab = 0; // 0 = Seller, 1 = Driver
  String _selectedStatus = 'All Status';
  String _selectedSort = 'Sort by: Newest';

  final List<KYCApplicant> _applicants = const [
    KYCApplicant(
      name: 'Michael Johnson',
      email: 'michael.j@email.com',
      company: 'Tech Store LLC',
      phone: '+1 (555) 123-4567',
      submittedDate: ' Jan 10, 2024 at 2:35 PM',
      status: KYCStatus.pendingReview,
      tags: ['ID Verified', 'Business License', 'Tax Documents', '+3 more'],
      avatarInitials: 'MJ',
    ),
    KYCApplicant(
      name: 'Sarah Williams',
      email: 'sarah.w@fashionstore.com',
      company: 'Fashion Hub Co.',
      phone: '+1 (555) 987-6543',
      submittedDate: ' Jan 10, 2024 at 2:35 PM',
      status: KYCStatus.underReview,
      tags: ['ID Verified', 'Business License', 'Tax Pending'],
      avatarInitials: 'SW',
    ),
    KYCApplicant(
      name: 'David Chen',
      email: 'david.chen@electronics.com',
      company: 'Electronics Plus',
      phone: '+1 (555) 456-7890',
      submittedDate: ' Jan 10, 2024 at 2:35 PM',
      status: KYCStatus.moreInfoNeeded,
      tags: ['ID Verified', 'License Expired'],
      avatarInitials: 'DC',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatCards(),
                      const SizedBox(height: 24),
                      _buildQueueTabs(),
                      const SizedBox(height: 16),
                      _buildFiltersRow(),
                      const SizedBox(height: 16),
                      ..._applicants.map((a) => _buildApplicantCard(a)),
                      const SizedBox(height: 16),
                      _buildPagination(),
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

  // ── Top Bar ────────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      height: 60,
      // decoration: const BoxDecoration(
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //         color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 2))
      //   ],
      // ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          const Text(
            'KYC Approvals',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          Container(
            width: 240,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFDDDDCC)),
            ),
            child: Row(
              children: const [
                SizedBox(width: 10),
                Icon(Icons.search, size: 18, color: Color(0xFF999988)),
                SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Color(0xFF999988),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Stat Cards ─────────────────────────────────────────────────────────────

  Widget _buildStatCards() {
    final stats = [
      _StatData(
        icon: Icons.access_time_rounded,
        iconColor: AppColors.accent,
        label: 'Pending Review',
        value: '24',
        change: '+12%',
        positive: true,
      ),
      _StatData(
        icon: Icons.check_circle_outline,
        iconColor: AppColors.primary,
        label: 'Approved Today',
        value: '47',
        change: '+8%',
        positive: true,
      ),
      _StatData(
        icon: Icons.cancel_outlined,
        iconColor: Colors.redAccent,
        label: 'Rejected Today',
        value: '8',
        change: '-3%',
        positive: false,
      ),
      _StatData(
        icon: Icons.info_outline_rounded,
        iconColor: AppColors.accent,
        label: 'Need More Info',
        value: '12',
        change: '5',
        positive: true,
      ),
    ];

    return Row(
      children:
          stats
              .map(
                (s) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _buildStatCard(s),
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildStatCard(_StatData data) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: data.iconColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(data.icon, color: data.iconColor, size: 18),
              ),
              const Spacer(),
              Text(
                data.change,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color:
                      data.positive
                          ? AppColors.statChange
                          : AppColors.statChangeBad,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            data.label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF888877)),
          ),
          const SizedBox(height: 4),
          Text(
            data.value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A1A),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  // ── Queue Tabs ─────────────────────────────────────────────────────────────

  Widget _buildQueueTabs() {
    return Row(
      children: [
        _buildTab(
          icon: Icons.storefront_outlined,
          label: 'Seller KYC Queue',
          count: 15,
          isSelected: _selectedTab == 0,
          onTap: () => setState(() => _selectedTab = 0),
        ),
        const SizedBox(width: 8),
        _buildTab(
          icon: Icons.local_shipping_outlined,
          label: 'Driver KYC Queue',
          count: 9,
          isSelected: _selectedTab == 1,
          onTap: () => setState(() => _selectedTab = 1),
        ),
      ],
    );
  }

  Widget _buildTab({
    required IconData icon,
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.accent.withOpacity(0.12)
                  : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.accent : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppColors.accent : const Color(0xFF888877),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.accent : const Color(0xFF888877),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent : const Color(0xFFDDDDCC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xFF666655),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Filters Row ────────────────────────────────────────────────────────────

  Widget _buildFiltersRow() {
    return Row(
      children: [
        _buildDropdown(
          value: _selectedStatus,
          items: [
            'All Status',
            'Pending Review',
            'Under Review',
            'More Info Needed',
          ],
          onChanged: (v) => setState(() => _selectedStatus = v!),
        ),
        const SizedBox(width: 10),
        _buildDropdown(
          value: _selectedSort,
          items: ['Sort by: Newest', 'Sort by: Oldest', 'Sort by: Name'],
          onChanged: (v) => setState(() => _selectedSort = v!),
        ),
        // const Spacer(),
        // ElevatedButton.icon(
        //   onPressed: () {},
        //   icon: const Icon(Icons.filter_list, size: 16),
        //   label: const Text('More Filters'),
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: AppColors.primary,
        //     foregroundColor: Colors.white,
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        //     textStyle: const TextStyle(
        //       fontSize: 13,
        //       fontWeight: FontWeight.w600,
        //     ),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //     elevation: 0,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDDDDCC)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items:
              items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(fontSize: 13)),
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(color: Color(0xFF333322), fontSize: 13),
        ),
      ),
    );
  }

  // ── Applicant Card ─────────────────────────────────────────────────────────

  Widget _buildApplicantCard(KYCApplicant applicant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          _buildAvatar(applicant.avatarInitials),
          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      applicant.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusBadge(applicant.status),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _infoChip(Icons.email_outlined, applicant.email),
                    const SizedBox(width: 16),
                    _infoChip(Icons.storefront_outlined, applicant.company),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: applicant.tags.map((t) => _buildTag(t)).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // Contact info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoChip(Icons.phone_outlined, applicant.phone),
              const SizedBox(height: 8),
              _infoChip(
                Icons.calendar_today_outlined,
                'Submitted: ${applicant.submittedDate}',
              ),
            ],
          ),
          const SizedBox(width: 24),

          // Action buttons
          Column(
            children: [
              _actionButton(
                label: 'Approve',
                icon: Icons.check,
                bgColor: AppColors.approveBtn,
                textColor: Colors.white,
                onPressed: () {
                  Get.toNamed("/kyc-review");
                },
              ),
              const SizedBox(height: 6),
              _actionButton(
                label: 'Reject',
                icon: Icons.close,
                bgColor: AppColors.primary,
                textColor: Colors.white,
                onPressed: () {
                  showRejectKycDialog(context);
                },
              ),
              const SizedBox(height: 6),
              _actionButton(
                label: 'Request Info',
                icon: Icons.help_outline,
                bgColor: AppColors.accentLight,
                textColor: AppColors.primary,
                onPressed: () {
                  showRequestMoreInfoDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String initials) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3A6B1F), Color(0xFF2D5016)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(KYCStatus status) {
    late String label;
    late Color bg;
    late Color text;

    switch (status) {
      case KYCStatus.pendingReview:
        label = 'Pending Review';
        bg = const Color(0xFFFFF3CD);
        text = const Color(0xFF856404);
        break;
      case KYCStatus.underReview:
        label = 'Under Review';
        bg = const Color(0xFFD1ECF1);
        text = const Color(0xFF0C5460);
        break;
      case KYCStatus.moreInfoNeeded:
        label = 'More Info Needed';
        bg = const Color(0xFFFFE0B2);
        text = const Color(0xFFE65100);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: const Color(0xFF888877)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Color(0xFF666655)),
        ),
      ],
    );
  }

  Widget _buildTag(String label) {
    final bool isWarning =
        label.contains('Expired') || label.contains('Pending');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isWarning ? const Color(0xFFFFEBEE) : AppColors.tagBg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isWarning ? const Color(0xFFFFCDD2) : const Color(0xFFDDDDCC),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isWarning ? const Color(0xFFC62828) : AppColors.tagText,
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 130,
      height: 34,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 14, color: textColor),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  // ── Pagination ─────────────────────────────────────────────────────────────

  Widget _buildPagination() {
    return Row(
      children: [
        const Text(
          'Showing 1 to 5 of 1,247 results',
          style: TextStyle(fontSize: 13, color: Color(0xFF888877)),
        ),
        const Spacer(),
        Row(
          children: [
            _pageBtn('Previous', isText: true, onTap: () {}),
            const SizedBox(width: 4),
            _pageBtn('1', isSelected: true, onTap: () {}),
            _pageBtn('2', onTap: () {}),
            _pageBtn('3', onTap: () {}),
            _pageBtn('...', isText: true, onTap: () {}),
            _pageBtn('249', onTap: () {}),
            const SizedBox(width: 4),
            _pageBtn('Next', isText: true, onTap: () {}),
          ],
        ),
      ],
    );
  }

  Widget _pageBtn(
    String label, {
    bool isSelected = false,
    bool isText = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: isText ? null : 34,
        height: 34,
        padding:
            isText
                ? const EdgeInsets.symmetric(horizontal: 10)
                : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border:
              isSelected || isText
                  ? null
                  : Border.all(color: const Color(0xFFDDDDCC)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color:
                  isSelected
                      ? Colors.white
                      : isText
                      ? AppColors.primary
                      : const Color(0xFF444433),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Helper ──────────────────────────────────────────────────────────────────

class _StatData {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String change;
  final bool positive;

  const _StatData({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.change,
    required this.positive,
  });
}
