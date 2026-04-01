// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:webkit/controller/extra_pages/time_line_controller.dart';
// import 'package:webkit/helpers/theme/admin_theme.dart';
// import 'package:webkit/helpers/utils/ui_mixins.dart';
// import 'package:webkit/views/apps/orders_escrow/order_detail_page.dart';
// import 'package:webkit/views/layouts/layout.dart';
// import 'package:webkit/views/orders_escrow/orders_review.dart';

// class OrdersEscrowPage extends StatefulWidget {
//   const OrdersEscrowPage({Key? key}) : super(key: key);

//   @override
//   State<OrdersEscrowPage> createState() => _OrdersEscrowPageState();
// }

// class _OrdersEscrowPageState extends State<OrdersEscrowPage>
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
//           return SizedBox(
//             width: Get.width,
//             height: Get.height,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// PAGE TITLE
//                   Text(
//                     "Orders & Escrow Management",
//                     style: GoogleFonts.montserrat(
//                       color: Color(0xff1F2937),
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   /// TOP STATS
//                   Row(
//                     children: [
//                       Expanded(
//                           child: InkWell(
//                               onTap: () {
//                                 Get.to(() => OrdersReview());
//                               },
//                               child:
//                                   StatCard("Total Orders", "2,847", "+12%"))),
//                       SizedBox(width: 16),
//                       Expanded(
//                           child: StatCard(
//                               "Escrow On Hold", "\$124,500", "On Hold")),
//                       SizedBox(width: 16),
//                       Expanded(
//                           child: StatCard(
//                               "Escrow Released", "\$892,340", "Released")),
//                       SizedBox(width: 16),
//                       Expanded(
//                           child: StatCard(
//                               "Total Refunded", "\$18,920", "Refunded")),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   /// FILTERS
//                   const FilterSection(),

//                   /// TABLE
//                   OrdersTable()
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String percent;

//   const StatCard(this.title, this.value, this.percent, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(15),
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
//                 fontSize: 19,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xff4B4B4B)),
//           ),
//           Text(
//             value,
//             style: GoogleFonts.montserrat(
//                 fontSize: 29, fontWeight: FontWeight.w600, color: Colors.black),
//           )
//         ],
//       ),
//     );
//   }
// }

// class FilterSection extends StatelessWidget {
//   const FilterSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           dropdown("All Statuses"),
//           const SizedBox(width: 15),

//           dropdown("All Users"),
//           const SizedBox(width: 15),

//           dropdown("Last 7 days"),
//           const SizedBox(width: 15),

//           /// SEARCH
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: "Search...",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: const Color(0xffF5F5F5),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(width: 15),

//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               elevation: 0,
//               padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//               backgroundColor:
//                   LeftBarTheme.lightLeftBarTheme.activeItemBackground,
//             ),
//             onPressed: () {},
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.filter_alt,
//                   size: 20,
//                   color: Colors.white,
//                 ),
//                 SizedBox(width: 6),
//                 Text(
//                   "Apply Filters",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget dropdown(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButton<String>(
//         value: text,
//         underline: const SizedBox(),
//         icon: Icon(Icons.keyboard_arrow_down_sharp),
//         items: [
//           DropdownMenuItem(
//               value: text,
//               child: Text(
//                 text,
//                 style: GoogleFonts.montserrat(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black),
//               )),
//         ],
//         onChanged: (v) {},
//       ),
//     );
//   }
// }

// class OrdersTable extends StatelessWidget {
//   const OrdersTable({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width,
//       height: Get.height * 0.60,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           /// HEADER
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("All Orders",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 23,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       elevation: 0,
//                       padding:
//                           EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                       backgroundColor:
//                           LeftBarTheme.lightLeftBarTheme.activeItemBackground,
//                     ),
//                     onPressed: () {},
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.download,
//                           size: 20,
//                           color: Colors.white,
//                         ),
//                         SizedBox(width: 6),
//                         Text(
//                           "Export",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       elevation: 0,
//                       padding:
//                           EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                       backgroundColor:
//                           LeftBarTheme.lightLeftBarTheme.activeItemBackground,
//                     ),
//                     onPressed: () {},
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.refresh,
//                           size: 20,
//                           color: Colors.white,
//                         ),
//                         SizedBox(width: 6),
//                         Text(
//                           "Refresh",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),

//           /// DATA TABLE
//           Expanded(
//             child: SingleChildScrollView(
//               child: DataTable(
//                 columnSpacing: 100,
//                 columns: [
//                   DataColumn(
//                       label: Text(
//                     "Order ID",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   )),
//                   DataColumn(
//                       label: Text(
//                     "Buyer",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   )),
//                   DataColumn(
//                       label: Text(
//                     "Seller",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   )),
//                   DataColumn(
//                       label: Text(
//                     "Driver",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   )),
//                   DataColumn(
//                       label: Text(
//                     "Amount",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   )),
//                   DataColumn(
//                       label: Text(
//                     "Escrow Status",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   )),
//                   DataColumn(
//                       label: Text(
//                     "Date",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   )),
//                   DataColumn(
//                       label: Text(
//                     "Actions",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   )),
//                 ],
//                 rows: List.generate(
//                   5,
//                   (index) => DataRow(
//                     cells: [
//                       DataCell(Text(
//                         "#ORD-2847",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: ContentTheme.lightContentTheme.primary),
//                       )),
//                       DataCell(Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Sarah Johnson",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             "sarah.j@email.com",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xff4B4B4B)),
//                           )
//                         ],
//                       )),
//                       DataCell(Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Sarah Johnson",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             "sarah.j@email.com",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xff4B4B4B)),
//                           )
//                         ],
//                       )),
//                       DataCell(Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Sarah Johnson",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             "sarah.j@email.com",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xff4B4B4B)),
//                           )
//                         ],
//                       )),
//                       DataCell(Text(
//                         "\$2,450",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black),
//                       )),
//                       DataCell(
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.orange.shade100,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: const Text("On Hold"),
//                         ),
//                       ),
//                       DataCell(Text(
//                         "Dec 28, 2024",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff4B4B4B)),
//                       )),
//                       DataCell(
//                         IconButton(
//                           onPressed: () {
//                             Get.to(() => OrderDetailPage());
//                           },
//                           icon: const Icon(Icons.remove_red_eye, size: 20),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:webkit/views/apps/orders_escrow/order_detail_page.dart';
import 'package:webkit/views/layouts/layout.dart';

// ─────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────

enum EscrowStatus { onHold, released, refunded }

class OrderItem {
  final String orderId;
  final String buyerName;
  final String buyerEmail;
  final String sellerName;
  final String sellerEmail;
  final String? driverName;
  final String? driverEmail;
  final double amount;
  final EscrowStatus status;
  final String date;

  const OrderItem({
    required this.orderId,
    required this.buyerName,
    required this.buyerEmail,
    required this.sellerName,
    required this.sellerEmail,
    this.driverName,
    this.driverEmail,
    required this.amount,
    required this.status,
    required this.date,
  });
}

// ─────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────

class OrdersEscrowScreen extends StatefulWidget {
  const OrdersEscrowScreen({super.key});

  @override
  State<OrdersEscrowScreen> createState() => _OrdersEscrowScreenState();
}

class _OrdersEscrowScreenState extends State<OrdersEscrowScreen> {
  String _escrowStatusFilter = 'All Statuses';
  String _userTypeFilter = 'All Users';
  String _dateRangeFilter = 'Last 7 days';
  final TextEditingController _searchController = TextEditingController();

  static const Color _primaryGreen = Color(0xFF2D5016);
  static const Color _accentGold = Color(0xFFD4A017);
  static const Color _bgColor = Color(0xFFFDF8EE);
  static const Color _cardBg = Color(0xFFFFFFFF);

  final List<OrderItem> _orders = const [
    OrderItem(
      orderId: '#ORD-2847',
      buyerName: 'Sarah Johnson',
      buyerEmail: 'sarah.j@email.com',
      sellerName: 'Mike Store',
      sellerEmail: 'mike.store@email.com',
      driverName: 'Tom Driver',
      driverEmail: 'tom.d@email.com',
      amount: 2450.00,
      status: EscrowStatus.onHold,
      date: 'Dec 28, 2024',
    ),
    OrderItem(
      orderId: '#ORD-2846',
      buyerName: 'John Smith',
      buyerEmail: 'john.s@email.com',
      sellerName: 'Alex Shop',
      sellerEmail: 'alex.shop@email.com',
      driverName: 'Jake Wilson',
      driverEmail: 'jake.w@email.com',
      amount: 1850.00,
      status: EscrowStatus.released,
      date: 'Dec 27, 2024',
    ),
    OrderItem(
      orderId: '#ORD-2845',
      buyerName: 'Emma Davis',
      buyerEmail: 'emma.d@email.com',
      sellerName: 'David Market',
      sellerEmail: 'david.m@email.com',
      driverName: 'Chris Lane',
      driverEmail: 'chris.l@email.com',
      amount: 890.00,
      status: EscrowStatus.refunded,
      date: 'Dec 26, 2024',
    ),
    OrderItem(
      orderId: '#ORD-2844',
      buyerName: 'Lisa Brown',
      buyerEmail: 'lisa.b@email.com',
      sellerName: 'Ryan Goods',
      sellerEmail: 'ryan.g@email.com',
      driverName: 'Sam Transport',
      driverEmail: 'sam.t@email.com',
      amount: 3200.00,
      status: EscrowStatus.onHold,
      date: 'Dec 28, 2024',
    ),
    OrderItem(
      orderId: '#ORD-2843',
      buyerName: 'Mark Wilson',
      buyerEmail: 'mark.w@email.com',
      sellerName: 'Tech Store',
      sellerEmail: '',
      amount: 0.00,
      status: EscrowStatus.onHold,
      date: 'Dec 28, 2024',
    ),
  ];

  // ── helpers ──────────────────────────────────

  Color _statusColor(EscrowStatus s) {
    switch (s) {
      case EscrowStatus.onHold:
        return const Color(0xFFE6A817);
      case EscrowStatus.released:
        return const Color(0xFF2D7D32);
      case EscrowStatus.refunded:
        return const Color(0xFF6D4C41);
    }
  }

  Color _statusBg(EscrowStatus s) {
    switch (s) {
      case EscrowStatus.onHold:
        return const Color(0xFFFFF3CD);
      case EscrowStatus.released:
        return const Color(0xFFE8F5E9);
      case EscrowStatus.refunded:
        return const Color(0xFFF3E5DC);
    }
  }

  IconData _statusIcon(EscrowStatus s) {
    switch (s) {
      case EscrowStatus.onHold:
        return Icons.access_time_rounded;
      case EscrowStatus.released:
        return Icons.check_circle_rounded;
      case EscrowStatus.refunded:
        return Icons.replay_rounded;
    }
  }

  String _statusLabel(EscrowStatus s) {
    switch (s) {
      case EscrowStatus.onHold:
        return 'On Hold';
      case EscrowStatus.released:
        return 'Released';
      case EscrowStatus.refunded:
        return 'Refunded';
    }
  }

  // ── build ─────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Layout(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildStatCards(),
              const SizedBox(height: 24),
              _buildFilterRow(),
              const SizedBox(height: 20),
              _buildOrdersTable(),
            ],
          ),
        ),
      ),
    ));
  }

  // ── header ────────────────────────────────────

  Widget _buildHeader() {
    return const Text(
      'Orders & Escrow Management',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A1A),
        letterSpacing: -0.3,
      ),
    );
  }

  // ── stat cards ────────────────────────────────

  Widget _buildStatCards() {
    return LayoutBuilder(builder: (context, constraints) {
      final double cardWidth = (constraints.maxWidth - 48) / 4;
      return Row(
        children: [
          _StatCard(
            width: cardWidth,
            icon: Icons.shopping_bag_rounded,
            iconColor: _accentGold,
            iconBg: const Color(0xFFFFF3CD),
            badge: '+12%',
            badgeColor: _accentGold,
            label: 'Total Orders',
            value: '2,847',
            valueColor: const Color(0xFF1A1A1A),
          ),
          const SizedBox(width: 16),
          _StatCard(
            width: cardWidth,
            icon: Icons.access_time_rounded,
            iconColor: _accentGold,
            iconBg: const Color(0xFFFFF3CD),
            badge: 'On Hold',
            badgeColor: _accentGold,
            label: 'Escrow On Hold',
            value: '\$124,500',
            valueColor: const Color(0xFF1A1A1A),
          ),
          const SizedBox(width: 16),
          _StatCard(
            width: cardWidth,
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF2D7D32),
            iconBg: const Color(0xFFE8F5E9),
            badge: 'Released',
            badgeColor: const Color(0xFF2D7D32),
            label: 'Escrow Released',
            value: '\$892,340',
            valueColor: const Color(0xFF1A1A1A),
          ),
          const SizedBox(width: 16),
          _StatCard(
            width: cardWidth,
            icon: Icons.replay_rounded,
            iconColor: const Color(0xFF8B4513),
            iconBg: const Color(0xFFF3E5DC),
            badge: 'Refunded',
            badgeColor: const Color(0xFF8B4513),
            label: 'Total Refunded',
            value: '\$18,920',
            valueColor: const Color(0xFF1A1A1A),
          ),
        ],
      );
    });
  }

  // ── filter row ────────────────────────────────

  Widget _buildFilterRow() {
    return Row(
      children: [
        _DropdownFilter(
          label: 'Escrow Status',
          value: _escrowStatusFilter,
          items: const ['All Statuses', 'On Hold', 'Released', 'Refunded'],
          onChanged: (v) => setState(() => _escrowStatusFilter = v!),
        ),
        const SizedBox(width: 12),
        _DropdownFilter(
          label: 'User Type',
          value: _userTypeFilter,
          items: const ['All Users', 'Buyer', 'Seller', 'Driver'],
          onChanged: (v) => setState(() => _userTypeFilter = v!),
        ),
        const SizedBox(width: 12),
        _DropdownFilter(
          label: 'Date Range',
          value: _dateRangeFilter,
          items: const [
            'Last 7 days',
            'Last 30 days',
            'Last 90 days',
            'Custom'
          ],
          onChanged: (v) => setState(() => _dateRangeFilter = v!),
        ),
        const SizedBox(width: 12),
        // search
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE0D9CC)),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
                prefixIcon:
                    Icon(Icons.search, color: Color(0xFFAAAAAA), size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Apply Filters button
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_list_rounded, size: 16),
          label: const Text('Apply Filters',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  // ── orders table ──────────────────────────────

  Widget _buildOrdersTable() {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // table header bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                const Text(
                  'All Orders',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded, size: 16),
                  label: const Text('Export', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _primaryGreen,
                    side: const BorderSide(color: Color(0xFF2D5016)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh_rounded, size: 16),
                  label: const Text('Refresh', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF555555),
                    side: const BorderSide(color: Color(0xFFDDD6C8)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0EBE0)),
          // column headers
          _buildColumnHeaders(),
          const Divider(height: 1, color: Color(0xFFF0EBE0)),
          // rows
          ...List.generate(_orders.length, (i) {
            final order = _orders[i];
            return Column(
              children: [
                _OrderRow(
                  order: order,
                  statusColor: _statusColor(order.status),
                  statusBg: _statusBg(order.status),
                  statusIcon: _statusIcon(order.status),
                  statusLabel: _statusLabel(order.status),
                  isEven: i.isEven,
                ),
                if (i < _orders.length - 1)
                  const Divider(height: 1, color: Color(0xFFF5F0E8)),
              ],
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildColumnHeaders() {
    const style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Color(0xFF888888),
      letterSpacing: 0.3,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: const [
          SizedBox(width: 110, child: Text('ORDER ID', style: style)),
          Expanded(flex: 2, child: Text('BUYER', style: style)),
          Expanded(flex: 2, child: Text('SELLER', style: style)),
          Expanded(flex: 2, child: Text('DRIVER', style: style)),
          SizedBox(width: 100, child: Text('AMOUNT', style: style)),
          SizedBox(width: 110, child: Text('ESCROW STATUS', style: style)),
          SizedBox(width: 110, child: Text('DATE', style: style)),
          SizedBox(width: 80, child: Text('ACTIONS', style: style)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// STAT CARD WIDGET
// ─────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String badge;
  final Color badgeColor;
  final String label;
  final String value;
  final Color valueColor;

  const _StatCard({
    required this.width,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.badge,
    required this.badgeColor,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF888888),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: valueColor,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DROPDOWN FILTER WIDGET
// ─────────────────────────────────────────────

class _DropdownFilter extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownFilter({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF888888),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE0D9CC)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              dropdownColor: Colors.white,
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF333333))),
                      ))
                  .toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: Color(0xFF555555)),
              style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// ORDER ROW WIDGET
// ─────────────────────────────────────────────

class _OrderRow extends StatelessWidget {
  final OrderItem order;
  final Color statusColor;
  final Color statusBg;
  final IconData statusIcon;
  final String statusLabel;
  final bool isEven;

  const _OrderRow({
    required this.order,
    required this.statusColor,
    required this.statusBg,
    required this.statusIcon,
    required this.statusLabel,
    required this.isEven,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isEven ? Colors.white : const Color(0xFFFDFBF7),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          // Order ID
          SizedBox(
            width: 100,
            child: Text(
              order.orderId,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFD4A017),
              ),
            ),
          ),
          // Buyer
          Expanded(
            flex: 2,
            child: _PersonCell(name: order.buyerName, email: order.buyerEmail),
          ),
          // Seller
          Expanded(
            flex: 2,
            child:
                _PersonCell(name: order.sellerName, email: order.sellerEmail),
          ),
          // Driver
          Expanded(
            flex: 2,
            child: order.driverName != null
                ? _PersonCell(
                    name: order.driverName!, email: order.driverEmail ?? '')
                : const SizedBox.shrink(),
          ),
          // Amount
          SizedBox(
            width: 100,
            child: order.amount > 0
                ? Text(
                    '\$${order.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          // Escrow Status
          SizedBox(
            width: 100,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(statusIcon, size: 13, color: statusColor),
                  const SizedBox(width: 5),
                  Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Date
          SizedBox(
            width: 100,
            child: Align(
              child: Text(
                order.date,
                style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
              ),
            ),
          ),
          // Actions
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed("/orders/detail");
                  },
                  child: Icon(Icons.remove_red_eye,
                      size: 15, color: Color(0xFF555555)),
                ),
                // const SizedBox(width: 8),
                // GestureDetector(
                //   onTap: () {},
                //   child: const Icon(Icons.more_vert_rounded,
                //       size: 16, color: Color(0xFF999999)),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PERSON CELL
// ─────────────────────────────────────────────

class _PersonCell extends StatelessWidget {
  final String name;
  final String email;

  const _PersonCell({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
          ),
        ),
        if (email.isNotEmpty)
          Text(
            email,
            style: const TextStyle(fontSize: 11, color: Color(0xFF999999)),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// BACKGROUND PATTERN (honeycomb-style tiling)
// ─────────────────────────────────────────────

class _BackgroundPattern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _HoneycombPainter());
  }
}

class _HoneycombPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE8DFC8).withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const double r = 28.0; // hex radius
    final double w = r * 2;
    final double h = r * 1.732; // sqrt(3) * r

    for (double y = 0; y < size.height + h; y += h) {
      for (double x = 0; x < size.width + w; x += w * 1.5) {
        _drawHex(canvas, paint, Offset(x, y), r);
        _drawHex(canvas, paint, Offset(x + w * 0.75, y + h * 0.5), r);
      }
    }
  }

  void _drawHex(Canvas canvas, Paint paint, Offset center, double r) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (60 * i - 30) * 3.14159265 / 180;
      final pt = Offset(center.dx + r * cos(angle), center.dy + r * sin(angle));
      i == 0 ? path.moveTo(pt.dx, pt.dy) : path.lineTo(pt.dx, pt.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  double cos(double rad) => _cos(rad);
  double sin(double rad) => _sin(rad);

  double _cos(double x) {
    // Taylor series approximation
    double result = 1;
    double term = 1;
    int sign = -1;
    for (int i = 2; i <= 16; i += 2) {
      term *= x * x / (i * (i - 1));
      result += sign * term;
      sign = -sign;
    }
    return result;
  }

  double _sin(double x) {
    double result = x;
    double term = x;
    int sign = -1;
    for (int i = 3; i <= 17; i += 2) {
      term *= x * x / (i * (i - 1));
      result += sign * term;
      sign = -sign;
    }
    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
