// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:webkit/controller/ui/nft_dashboard_controller.dart';
// import 'package:webkit/helpers/theme/admin_theme.dart';
// import 'package:webkit/helpers/utils/ui_mixins.dart';
// import 'package:webkit/views/apps/listing_moderation/listing_detail_view.dart';
// import 'package:webkit/views/apps/listing_moderation/listing_reported_detail_view.dart';
// import 'package:webkit/views/layouts/layout.dart';

// class ListingModerationView extends StatefulWidget {
//   const ListingModerationView({super.key});

//   @override
//   State<ListingModerationView> createState() => _ListingModerationViewState();
// }

// class _ListingModerationViewState extends State<ListingModerationView>
//     with SingleTickerProviderStateMixin, UIMixin {
//   late NFTDashboardController controller;
//   Timer? countdownTimer;
//   Duration myDuration = const Duration(hours: 12);

//   void startTimer() {
//     countdownTimer =
//         Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
//   }

//   void setCountDown() {
//     if (mounted) {
//       const reduceSeconds = 1;

//       final seconds = myDuration.inSeconds - reduceSeconds;
//       if (seconds < 0) {
//         countdownTimer!.cancel();
//       } else {
//         myDuration = Duration(seconds: seconds);
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(NFTDashboardController());
//     startTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String strDigits(int n) => n.toString().padLeft(2, '0');

//     final hours = strDigits(myDuration.inHours.remainder(24));
//     final minutes = strDigits(myDuration.inMinutes.remainder(60));
//     final seconds = strDigits(myDuration.inSeconds.remainder(60));
//     debugPrint("$hours : $minutes : $seconds");
//     return Layout(
//       child: GetBuilder(
//         init: controller,
//         builder: (controller) {
//           return SizedBox(
//               width: Get.width,
//               height: Get.height * 0.90,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// PAGE TITLE
//                   // const Text(
//                   //   "Listing Moderation",
//                   //   style: TextStyle(
//                   //     fontSize: 24,
//                   //     fontWeight: FontWeight.bold,
//                   //   ),
//                   // ),

//                   // const SizedBox(height: 20),

//                   /// TABS
//                   Row(
//                     children: [
//                       tabItem("Pending Listings", true, "24"),
//                       const SizedBox(width: 25),
//                       tabItem("Reported Listings", false, "8"),
//                       const SizedBox(width: 25),
//                       tabItem("Recently Approved", false, ""),
//                     ],
//                   ),

//                   /// HEADER FILTER
//                   Row(
//                     children: [
//                       Text(
//                         "Pending Approval Queue",
//                         style: GoogleFonts.montserrat(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17,
//                           color: Color(0xff1F2937),
//                         ),
//                       ),

//                       const Spacer(),

//                       /// CATEGORY DROPDOWN
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.grey.shade300)),
//                         child: Row(
//                           children: [
//                             Text("All Categories",
//                                 style: GoogleFonts.montserrat(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 13,
//                                   color: Color(0xff1F2937),
//                                 )),
//                             Icon(Icons.keyboard_arrow_down)
//                           ],
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       /// SEARCH
//                       Container(
//                         width: 250,
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.grey.shade300)),
//                         child: const TextField(
//                           decoration: InputDecoration(
//                             icon: Icon(Icons.search),
//                             hintText: "Search listings...",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),

//                   const SizedBox(height: 10),

//                   /// LIST
//                   Expanded(
//                       child: ListView.separated(
//                           physics: NeverScrollableScrollPhysics(),
//                           padding: EdgeInsets.zero,
//                           itemBuilder: (context, index) => ListingItem(),
//                           separatorBuilder: (context, index) => Divider(),
//                           itemCount: 3)),

//                   const SizedBox(height: 20),

//                   /// PAGINATION
//                   Row(
//                     children: [
//                       const Text(
//                         "Showing 1-3 of 24 listings",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       const Spacer(),
//                       paginationButton("Previous", false),
//                       const SizedBox(width: 8),
//                       paginationButton("1", true),
//                       const SizedBox(width: 8),
//                       paginationButton("2", false),
//                       const SizedBox(width: 8),
//                       paginationButton("3", false),
//                       const SizedBox(width: 8),
//                       const Text("..."),
//                       const SizedBox(width: 8),
//                       paginationButton("249", false),
//                       const SizedBox(width: 8),
//                       paginationButton("Next", false),
//                     ],
//                   )
//                 ],
//               ).paddingSymmetric(horizontal: 20));
//         },
//       ),
//     );
//   }

//   Widget tabItem(String title, bool active, String count) {
//     return Row(
//       children: [
//         Text(
//           title,
//           style: GoogleFonts.montserrat(
//             fontWeight: FontWeight.w600,
//             fontSize: 13,
//             color: active ? contentTheme.primary : Colors.black,
//           ),
//         ),
//         if (count.isNotEmpty) ...[
//           const SizedBox(width: 6),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//             decoration: BoxDecoration(
//               color: const Color(0xffF4E7C3),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               count,
//               style: GoogleFonts.montserrat(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 11,
//                 color: active ? contentTheme.primary : Colors.black,
//               ),
//             ),
//           )
//         ]
//       ],
//     );
//   }

//   Widget paginationButton(String text, bool active) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: active ? Colors.black : Colors.white,
//         borderRadius: BorderRadius.circular(6),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: active ? Colors.white : Colors.black,
//         ),
//       ),
//     );
//   }
// }

// class ListingItem extends StatelessWidget {
//   const ListingItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// PRODUCT IMAGE
//           Container(
//             width: 55,
//             height: 55,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.phone_iphone),
//           ),

//           const SizedBox(width: 16),

//           /// PRODUCT DETAILS
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("iPhone 15 Pro Max 256GB",
//                   style: GoogleFonts.montserrat(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17,
//                       color: Colors.black)),
//               SizedBox(height: 6),
//               Text("Unlocked • Like New • Original Box",
//                   style: GoogleFonts.montserrat(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15,
//                       color: Color(0xff4B4B4B))),
//               SizedBox(height: 6),
//               Text("\$1,100",
//                   style: GoogleFonts.montserrat(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 23,
//                       color: ContentTheme.lightContentTheme.primary)),
//               SizedBox(height: 6),
//               Row(
//                 children: [
//                   Icon(Icons.person, size: 20),
//                   SizedBox(width: 4),
//                   Text("Sarah Wilson",
//                       style: GoogleFonts.montserrat(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 13,
//                           color: Color(0xff4B4B4B))),
//                   SizedBox(width: 10),
//                   Icon(Icons.access_time, size: 20),
//                   SizedBox(width: 4),
//                   Text("6 hours ago",
//                       style: GoogleFonts.montserrat(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 13,
//                           color: Color(0xff4B4B4B))),
//                   SizedBox(width: 10),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                     decoration: BoxDecoration(
//                       color: const Color(0xffF4E7C3),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text("Pending Review",
//                         style: GoogleFonts.montserrat(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 13,
//                             color: ContentTheme.lightContentTheme.primary)),
//                   ),
//                 ],
//               )
//             ],
//           ),

//           const Spacer(),
//           InkWell(
//             onTap: () {
//               Get.to(() => ListingDetailView());
//             },
//             child: Icon(Icons.remove_red_eye_outlined,
//                     size: 20, color: ContentTheme.lightContentTheme.primary)
//                 .paddingSymmetric(vertical: 5),
//           ),
//           SizedBox(width: 30),

//           /// ACTION BUTTONS
//           Row(
//             children: [
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                   backgroundColor:
//                       LeftBarTheme.lightLeftBarTheme.activeItemBackground,
//                 ),
//                 onPressed: () {
//                   Get.to(() => ListingReportedDetailView());
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
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 8),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                   backgroundColor: ContentTheme.lightContentTheme.primary
//                       .withValues(alpha: .14),
//                 ),
//                 onPressed: () {},
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.close,
//                       size: 20,
//                       color: ContentTheme.lightContentTheme.primary,
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       "Reject",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                           color: ContentTheme.lightContentTheme.primary),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 8),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     elevation: 0,
//                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                     backgroundColor: ContentTheme.lightContentTheme.primary),
//                 onPressed: () {},
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.edit_square,
//                       size: 18,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       "Edit",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
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

//   Widget actionButton(String title, Color color) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       ),
//       onPressed: () {},
//       child: Text(title),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:webkit/views/apps/listing_moderation/listing_detail_view.dart';
import 'package:webkit/views/apps/listing_moderation/listing_reported_detail_view.dart';
import 'package:webkit/views/apps/orders_escrow/widget/order_dialog.dart';
import 'package:webkit/views/layouts/layout.dart';

// ─────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────

class ListingItem {
  final String title;
  final String subtitle;
  final double price;
  final String seller;
  final String timeAgo;
  final String status;

  const ListingItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.seller,
    required this.timeAgo,
    required this.status,
  });
}

// ─────────────────────────────────────────────
// PAGE
// ─────────────────────────────────────────────

class ListingModerationPage extends StatefulWidget {
  const ListingModerationPage({super.key});

  @override
  State<ListingModerationPage> createState() => _ListingModerationPageState();
}

class _ListingModerationPageState extends State<ListingModerationPage> {
  int _selectedTab = 0;
  String _selectedCategory = 'All Categories';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _tabs = [
    {'label': 'Pending Listings', 'count': 24},
    {'label': 'Reported Listings', 'count': 8},
    {'label': 'Recently Approved', 'count': null},
  ];

  final List<ListingItem> _listings = const [
    ListingItem(
      title: 'iPhone 15 Pro Max 256GB',
      subtitle: 'Unlocked · Like New · Original Box',
      price: 1100,
      seller: 'Sarah Wilson',
      timeAgo: '6 hours ago',
      status: 'Pending Review',
    ),
    ListingItem(
      title: 'iPhone 15 Pro Max 256GB',
      subtitle: 'Unlocked · Like New · Original Box',
      price: 1100,
      seller: 'Sarah Wilson',
      timeAgo: '6 hours ago',
      status: 'Pending Review',
    ),
    ListingItem(
      title: 'iPhone 15 Pro Max 256GB',
      subtitle: 'Unlocked · Like New · Original Box',
      price: 1100,
      seller: 'Sarah Wilson',
      timeAgo: '6 hours ago',
      status: 'Pending Review',
    ),
  ];

  final Color _primaryGreen = const Color(0xFF2D5A27);
  final Color _accentGold = const Color(0xFFB8860B);
  final Color _bgColor = const Color(0xFFFAF8F0);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              _buildHeader(),
              _buildTabs(),
              const SizedBox(height: 16),
              _buildQueueToolbar(),
              const SizedBox(height: 12),
              Expanded(child: _buildListings()),
              _buildPagination(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Text(
        'Listing Moderation',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade900,
          letterSpacing: -0.3,
        ),
      ),
    );
  }

  // ── Tabs ─────────────────────────────────────
  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final tab = _tabs[i];
          final isSelected = _selectedTab == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
              margin: const EdgeInsets.only(right: 28),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? const Color(0xFFB8860B)
                        : Colors.transparent,
                    width: 2.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    tab['label'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? const Color(0xFFB8860B)
                          : Colors.grey.shade600,
                    ),
                  ),
                  if (tab['count'] != null) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFB8860B)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${tab['count']}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color:
                              isSelected ? Colors.white : Colors.grey.shade700,
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

  // ── Queue Toolbar ─────────────────────────────
  Widget _buildQueueToolbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            'Pending Approval Queue',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const Spacer(),
          // Category Dropdown
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                dropdownColor: Colors.white,
                icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
                items: [
                  'All Categories',
                  'Electronics',
                  'Clothing',
                  'Furniture'
                ]
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Search Field
          SizedBox(
            width: 200,
            height: 38,
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search listings...',
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                prefixIcon:
                    Icon(Icons.search, size: 18, color: Colors.grey.shade400),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: _primaryGreen, width: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Listings ──────────────────────────────────
  Widget _buildListings() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _listings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 0),
      itemBuilder: (context, index) =>
          _buildListingCard(_listings[index], index),
    );
  }

  Widget _buildListingCard(ListingItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 64,
              height: 64,
              color: Colors.grey.shade100,
              child: Icon(Icons.phone_iphone,
                  size: 36, color: Colors.grey.shade500),
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${item.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _accentGold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.person_outline,
                        size: 13, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(item.seller,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600)),
                    const SizedBox(width: 12),
                    Icon(Icons.access_time,
                        size: 13, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(item.timeAgo,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600)),
                    const SizedBox(width: 12),
                    _buildStatusBadge(item.status),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Action Buttons
          Row(
            children: [
              // Eye
              _buildIconBtn(
                icon: Icons.visibility_outlined,
                color: Colors.grey.shade600,
                bgColor: Colors.grey.shade100,
                onTap: () {
                  Get.toNamed("/listing-detail");
                },
              ),
              const SizedBox(width: 8),
              // Approve
              _buildActionBtn(
                label: 'Approve',
                icon: Icons.check,
                bgColor: _primaryGreen,
                textColor: Colors.white,
                onTap: () {
                  Get.toNamed("/reported/listing-detail");
                },
              ),
              const SizedBox(width: 6),
              // Reject
              _buildActionBtn(
                label: 'Reject',
                icon: Icons.close,
                bgColor: Colors.white,
                textColor: Colors.red.shade600,
                borderColor: Colors.red.shade300,
                onTap: () {},
              ),
              const SizedBox(width: 6),
              // Edit
              _buildActionBtn(
                label: 'Edit',
                icon: Icons.edit_outlined,
                bgColor: const Color(0xFFB8860B),
                textColor: Colors.white,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        border: Border.all(color: const Color(0xFFB8860B).withOpacity(0.4)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFFB8860B),
        ),
      ),
    );
  }

  Widget _buildIconBtn({
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Widget _buildActionBtn({
    required String label,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor ?? bgColor,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Pagination ────────────────────────────────
  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Text(
            'Showing 1-3 of 24 listings',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const Spacer(),
          _buildPageBtn('Previous', isText: true),
          const SizedBox(width: 6),
          ...[1, 2, 3].map((n) => _buildPageNum(n, isActive: n == 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text('–',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
          ),
          _buildPageNum(249, isActive: false),
          const SizedBox(width: 6),
          _buildPageBtn('Next', isText: true),
        ],
      ),
    );
  }

  Widget _buildPageNum(int num, {required bool isActive}) {
    return Container(
      width: 34,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isActive ? _primaryGreen : Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: isActive ? _primaryGreen : Colors.grey.shade300,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '$num',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : Colors.grey.shade700,
        ),
      ),
    );
  }

  Widget _buildPageBtn(String label, {bool isText = false}) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(7),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
