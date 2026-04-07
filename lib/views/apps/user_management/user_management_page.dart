// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get_utils/src/extensions/widget_extensions.dart';
// import 'package:get/instance_manager.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:yamazone/controller/apps/ecommerce/customers_controller.dart';
// import 'package:yamazone/helpers/utils/ui_mixins.dart';
// import 'package:yamazone/helpers/utils/utils.dart';
// import 'package:yamazone/helpers/widgets/my_container.dart';
// import 'package:yamazone/helpers/widgets/my_spacing.dart';
// import 'package:yamazone/helpers/widgets/my_text.dart';
// import 'package:yamazone/images.dart';
// import 'package:yamazone/models/customer.dart';
// import 'package:yamazone/views/layouts/layout.dart';

// class UserManagementPage extends StatefulWidget {
//   const UserManagementPage({super.key});

//   @override
//   State<UserManagementPage> createState() => _UserManagementPageState();
// }

// class _UserManagementPageState extends State<UserManagementPage>
//     with SingleTickerProviderStateMixin, UIMixin {
//   late CustomersController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(CustomersController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       child: GetBuilder(
//         init: controller,
//         builder: (controller) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 headerSection(),
//                 const SizedBox(height: 20),
//                 filterSection(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Users List",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black)),
//                     Text("1,247 total users",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black)),
//                   ],
//                 ).paddingSymmetric(vertical: 10),
//                 userTable(),
//                 const SizedBox(height: 10),
//                 paginationSection()
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget headerSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text("User Management",
//             style: GoogleFonts.inter(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff111827))),
//         ElevatedButton.icon(
//           onPressed: () {},
//           icon: const Icon(Icons.add, color: Colors.white),
//           label: Text("Add User",
//               style: GoogleFonts.inter(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: leftBarTheme.activeItemBackground,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           ),
//         )
//       ],
//     );
//   }

//   Widget filterSection() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(
//           sigmaX: 15,
//           sigmaY: 15,
//         ),
//         child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white, // glass transparency
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.2),
//                 width: 1.2,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 20,
//                   spreadRadius: 5,
//                 ),
//               ],
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     blurRadius: 6,
//                   )
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Search users...",
//                         prefixIcon: const Icon(Icons.search),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide.none),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   dropdown("All User Types"),
//                   const SizedBox(width: 10),
//                   dropdown("All Status"),
//                   const SizedBox(width: 10),
//                   dropdown("Sort by Date"),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }

//   Widget dropdown(String hint) {
//     return ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//             filter: ImageFilter.blur(
//               sigmaX: 15,
//               sigmaY: 15,
//             ),
//             child: Container(
//                 width: 150,
//                 height: 50,
//                 alignment: Alignment.center,
//                 color: Colors.white,
//                 child: DropdownButtonFormField(
//                   dropdownColor: Colors.white,
//                   focusColor: Colors.white,
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.zero),
//                   items: [
//                     DropdownMenuItem(
//                       value: "Buyer",
//                       child: Text("Buyer"),
//                     ),
//                     DropdownMenuItem(
//                       value: "Seller",
//                       child: Text("Seller"),
//                     ),
//                     DropdownMenuItem(
//                       value: "Driver",
//                       child: Text("Driver"),
//                     ),
//                   ],
//                   onChanged: (value) {},
//                 ))));
//     // return Stack(
//     //   alignment: Alignment.center,
//     //   children: [
//     //     Image.asset(
//     //       "assets/images/logo/backdrop.png",
//     //       height: 42,
//     //       width: 150,
//     //     ),
//     //     SizedBox(
//     //       width: 150,
//     //       child: DropdownButtonFormField(
//     //         dropdownColor: Colors.white,
//     //         focusColor: Colors.white,
//     //         decoration: InputDecoration(
//     //             border: InputBorder.none, contentPadding: EdgeInsets.zero),
//     //         items: [
//     //           DropdownMenuItem(
//     //             value: "Buyer",
//     //             child: Text("Buyer"),
//     //           ),
//     //           DropdownMenuItem(
//     //             value: "Seller",
//     //             child: Text("Seller"),
//     //           ),
//     //           DropdownMenuItem(
//     //             value: "Driver",
//     //             child: Text("Driver"),
//     //           ),
//     //         ],
//     //         onChanged: (value) {},
//     //       ).paddingSymmetric(horizontal: 15, vertical: 10),
//     //     ),
//     //   ],
//     // );
//   }

//   Widget userTable() {
//     return ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//             filter: ImageFilter.blur(
//               sigmaX: 15,
//               sigmaY: 15,
//             ),
//             child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.white, // glass transparency
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.2),
//                     width: 1.2,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       spreadRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         blurRadius: 6,
//                       )
//                     ],
//                   ),
//                   child: Container(
//                     width: Get.width,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: DataTable(
//                       dataRowMinHeight: 65,
//                       dataRowMaxHeight: 65,
//                       columnSpacing: 100,
//                       columns: [
//                         DataColumn(
//                             label: Checkbox(
//                           value: false,
//                           side: BorderSide(),
//                           focusColor: contentTheme.primary,
//                           fillColor: WidgetStateProperty.resolveWith<Color>(
//                               (Set<WidgetState> states) {
//                             if (states.contains(WidgetState.disabled)) {
//                               return Colors.transparent;
//                             }
//                             return Colors.transparent;
//                           }),
//                           onChanged: (value) {},
//                         )),
//                         DataColumn(
//                             label: Text(
//                           "User",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         )),
//                         DataColumn(
//                             label: Text(
//                           "Type",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         )),
//                         DataColumn(
//                             label: Text(
//                           "Status",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         )),
//                         DataColumn(
//                             label: Text(
//                           "Last Login",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         )),
//                         DataColumn(
//                             label: Text(
//                           "Actions",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         )),
//                       ],
//                       rows: [
//                         userRow(
//                             "Sarah Johnson", "Buyer", "Active", "2 hours ago"),
//                         userRow("Mike Chen", "Seller", "Blocked", "5 days ago"),
//                         userRow(
//                             "David Rodriguez", "Driver", "Active", "1 day ago"),
//                         userRow("Emma Wilson", "Buyer", "Pending", "Never"),
//                         userRow("Emma Wilson", "Buyer", "Pending", "Never"),
//                         userRow("Emma Wilson", "Buyer", "Pending", "Never"),
//                         userRow("Emma Wilson", "Buyer", "Pending", "Never"),
//                         userRow("Emma Wilson", "Buyer", "Pending", "Never"),
//                       ],
//                     ),
//                   ),
//                 ))));
//   }

//   DataRow userRow(String name, String type, String status, String login) {
//     return DataRow(
//       cells: [
//         DataCell(Checkbox(
//           value: false,
//           side: BorderSide(),
//           focusColor: contentTheme.primary,
//           fillColor:
//               WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
//             if (states.contains(WidgetState.disabled)) {
//               return Colors.transparent;
//             }
//             return Colors.transparent;
//           }),
//           onChanged: (value) {},
//         )),
//         DataCell(
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 18,
//                 backgroundImage: AssetImage(Images.avatars.first),
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     name,
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black),
//                   ),
//                   Text(
//                     "Last Login",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B)),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         DataCell(typeBadge(type)),
//         DataCell(statusBadge(status)),
//         DataCell(Text(
//           login,
//           style: GoogleFonts.inter(
//               fontSize: 15,
//               fontWeight: FontWeight.w400,
//               color: Color(0xff4B4B4B)),
//         )),
//         DataCell(
//           Row(
//             children: [
//               InkWell(
//                   onTap: () {
//                     Get.toNamed("/user/userdetail");
//                   },
//                   child: Icon(Icons.visibility, size: 18)),
//               SizedBox(width: 10),
//               Icon(Icons.edit, size: 18),
//               SizedBox(width: 10),
//               Icon(Icons.block, size: 18, color: Colors.red),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget typeBadge(String type) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: contentTheme.primary.withValues(alpha: 0.10),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(
//             "assets/icon/dashboard.png",
//             width: 10,
//             color: contentTheme.primary,
//             height: 15,
//           ),
//           SizedBox(width: 10),
//           Text(
//             type,
//             style: GoogleFonts.inter(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 color: contentTheme.primary),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget statusBadge(String status) {
//     Color color;

//     switch (status) {
//       case "Active":
//         color = Colors.green;
//         break;
//       case "Blocked":
//         color = Colors.red;
//         break;
//       case "Pending":
//         color = Colors.orange;
//         break;
//       default:
//         color = Colors.grey;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         status,
//         style: GoogleFonts.inter(
//             fontSize: 15, fontWeight: FontWeight.w600, color: color),
//       ),
//     );
//   }

//   Widget paginationSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text("Showing 1 to 5 of 1247 results"),
//         Row(
//           children: [
//             pageButton("Previous"),
//             pageButton("1", selected: true),
//             pageButton("2"),
//             pageButton("3"),
//             pageButton("Next"),
//           ],
//         )
//       ],
//     );
//   }

//   Widget pageButton(String text, {bool selected = false}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: selected ? Colors.black : Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: selected ? Colors.white : Colors.black,
//         ),
//       ),
//     );
//   }
// }

// class MyData extends DataTableSource with UIMixin {
//   List<Customer> data = [];

//   MyData(this.data);

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => data.length;

//   @override
//   int get selectedRowCount => 0;

//   @override
//   DataRow getRow(int index) {
//     return DataRow(
//       cells: [
//         DataCell(MyText.bodyMedium(
//           data[index].id.toString(),
//           fontWeight: 600,
//         )),
//         DataCell(MyText.bodyMedium(
//           data[index].firstName,
//           fontWeight: 600,
//         )),
//         DataCell(MyText.bodyMedium(data[index].phoneNumber.toString())),
//         DataCell(MyText.bodyMedium(data[index].balance.toString())),
//         DataCell(MyText.bodyMedium(data[index].ordersCount.toString())),
//         DataCell(MyText.bodyMedium(
//             Utils.getDateStringFromDateTime(data[index].lastOrder).toString())),
//         DataCell(
//           Align(
//             alignment: Alignment.center,
//             child: Row(
//               children: [
//                 MyContainer.bordered(
//                   onTap: () => {},
//                   padding: MySpacing.xy(6, 6),
//                   borderColor: contentTheme.primary.withAlpha(40),
//                   child: Icon(
//                     LucideIcons.edit2,
//                     size: 12,
//                     color: contentTheme.primary,
//                   ),
//                 ),
//                 MySpacing.width(12),
//                 MyContainer.bordered(
//                   onTap: () => {},
//                   padding: MySpacing.xy(6, 6),
//                   borderColor: contentTheme.primary.withAlpha(40),
//                   child: Icon(
//                     LucideIcons.trash2,
//                     size: 12,
//                     color: contentTheme.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:yamazone/helpers/theme/admin_theme.dart';
import 'package:yamazone/views/apps/user_management/user_detail.dart';
import 'package:yamazone/views/apps/user_management/widget/user_dialog.dart';
import 'package:yamazone/views/layouts/layout.dart';

// ─── Data Model ────────────────────────────────────────────────────────────

enum UserType { buyer, seller, driver }

enum UserStatus { active, blocked, pending }

class UserModel {
  final String name;
  final String email;
  final String avatarUrl;
  final UserType type;
  final UserStatus status;
  final String lastLogin;
  bool isSelected;

  UserModel({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.type,
    required this.status,
    required this.lastLogin,
    this.isSelected = false,
  });
}

// ─── Sample Data ────────────────────────────────────────────────────────────

final List<UserModel> sampleUsers = [
  UserModel(
    name: 'Sarah Johnson',
    email: 'sarah.j@email.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    type: UserType.buyer,
    status: UserStatus.active,
    lastLogin: '2 hours ago',
  ),
  UserModel(
    name: 'Mike Chen',
    email: 'mike.chen@email.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=11',
    type: UserType.seller,
    status: UserStatus.blocked,
    lastLogin: '5 days ago',
  ),
  UserModel(
    name: 'David Rodriguez',
    email: 'david.r@email.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=57',
    type: UserType.driver,
    status: UserStatus.active,
    lastLogin: '1 day ago',
  ),
  UserModel(
    name: 'Emma Wilson',
    email: 'emma.w@email.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=45',
    type: UserType.buyer,
    status: UserStatus.pending,
    lastLogin: 'Never',
  ),
  UserModel(
    name: 'James Thompson',
    email: 'james.t@email.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    type: UserType.seller,
    status: UserStatus.active,
    lastLogin: '3 hours ago',
  ),
];

// ─── Theme Constants ─────────────────────────────────────────────────────────

class AppColors {
  static const Color primary = Color(0xFF1B4332); // dark green
  static const Color accent = Color(0xFFD4A017); // gold/amber
  static const Color background = Color(0xFFFAF9F6); // warm off-white
  static const Color cardBg = Colors.white;
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color divider = Color(0xFFE5E7EB);

  static const Color statusActive = Color(0xFF6B8F71);
  static const Color statusActiveText = Color(0xFF2D6A4F);
  static const Color statusBlocked = Color(0xFFE53E3E);
  static const Color statusPending = Color(0xFFD4A017);

  static const Color buyerBg = Color(0xFFFFF8E1);
  static const Color buyerText = Color(0xFFB7791F);
  static const Color sellerBg = Color(0xFFF0FFF4);
  static const Color sellerText = Color(0xFF276749);
  static const Color driverBg = Color(0xFFEBF8FF);
  static const Color driverText = Color(0xFF2B6CB0);
}

// ─── Main Page ───────────────────────────────────────────────────────────────

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedUserType = 'All User Types';
  String _selectedStatus = 'All Status';
  String _selectedSort = 'Sort by Date';
  bool _selectAll = false;
  List<UserModel> _users = List.from(sampleUsers);

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      for (var u in _users) {
        u.isSelected = _selectAll;
      }
    });
  }

  void _toggleUser(int index, bool? value) {
    setState(() {
      _users[index].isSelected = value ?? false;
      _selectAll = _users.every((u) => u.isSelected);
    });
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchFilters(),
                      const SizedBox(height: 24),
                      _buildUsersTable(),
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

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          const Text(
            'User Management',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 18),
            label: const Text(
              'Add User',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  // ── Search & Filters ──────────────────────────────────────────────────────

  Widget _buildSearchFilters() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Search & Filters',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _selectedUserType = 'All User Types';
                    _selectedStatus = 'All Status';
                    _selectedSort = 'Sort by Date';
                  });
                },
                child: const Text(
                  'Clear All',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Search field
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    hintStyle: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.divider),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.divider),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // User Type dropdown
              Expanded(
                flex: 2,
                child: _buildDropdown(
                  value: _selectedUserType,
                  items: ['All User Types', 'Buyer', 'Seller', 'Driver'],
                  onChanged: (v) => setState(() => _selectedUserType = v!),
                ),
              ),
              const SizedBox(width: 12),
              // Status dropdown
              Expanded(
                flex: 2,
                child: _buildDropdown(
                  value: _selectedStatus,
                  items: ['All Status', 'Active', 'Blocked', 'Pending'],
                  onChanged: (v) => setState(() => _selectedStatus = v!),
                ),
              ),
              const SizedBox(width: 12),
              // Sort dropdown
              Expanded(
                flex: 2,
                child: _buildDropdown(
                  value: _selectedSort,
                  items: ['Sort by Date', 'Sort by Name', 'Sort by Status'],
                  onChanged: (v) => setState(() => _selectedSort = v!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
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
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
      dropdownColor: Colors.white,
      style: const TextStyle(color: AppColors.textDark, fontSize: 13),
    );
  }

  // ── Users Table ───────────────────────────────────────────────────────────

  Widget _buildUsersTable() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          // Table header
          _buildTableHeader(),
          const Divider(height: 1, color: AppColors.divider),
          // Table rows
          ...List.generate(_users.length, (i) {
            return Column(
              children: [
                _buildUserRow(_users[i], i),
                if (i < _users.length - 1)
                  const Divider(height: 1, color: AppColors.divider),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // SizedBox(
          //   width: 40,
          //   child: Checkbox(
          //     value: _selectAll,
          //     onChanged: _toggleSelectAll,
          //     fillColor: WidgetStateProperty.resolveWith<Color>((
          //       Set<WidgetState> states,
          //     ) {
          //       if (states.contains(WidgetState.disabled)) {
          //         return Colors.transparent;
          //       }
          //       return LeftBarTheme.lightLeftBarTheme.activeItemBackground;
          //     }),
          //     activeColor: AppColors.primary,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(4),
          //     ),
          //   ),
          // ),
          const Expanded(flex: 2, child: Text('User', style: _headerStyle)),
          SizedBox(width: 15),
          const Expanded(
            flex: 2,
            child: Align(child: Text('Type', style: _headerStyle)),
          ),
          SizedBox(width: 15),
          const Expanded(
            flex: 2,
            child: Align(child: Text('Status', style: _headerStyle)),
          ),
          const Expanded(
            flex: 2,
            child: Align(child: Text('Last Login', style: _headerStyle)),
          ),
          const SizedBox(
            width: 120,
            child: Align(
              child: Text(
                'Actions',
                style: _headerStyle,
                textAlign: TextAlign.right,
              ),
            ),
          ),
          // Total users count
          // const SizedBox(width: 16),
          // const Text(
          //   '1,247 total users',
          //   style: TextStyle(
          //     fontSize: 12,
          //     color: AppColors.textMuted,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
    letterSpacing: 0.2,
  );

  Widget _buildUserRow(UserModel user, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Checkbox
          // SizedBox(
          //   width: 40,
          //   child: Checkbox(
          //     value: user.isSelected,
          //     onChanged: (v) => _toggleUser(index, v),
          //     activeColor: AppColors.primary,
          //     fillColor: WidgetStateProperty.resolveWith<Color>((
          //       Set<WidgetState> states,
          //     ) {
          //       if (states.contains(WidgetState.disabled)) {
          //         return Colors.transparent;
          //       }
          //       return LeftBarTheme.lightLeftBarTheme.activeItemBackground;
          //     }),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(4),
          //     ),
          //   ),
          // ),

          // User info
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(user.avatarUrl),
                  backgroundColor: AppColors.divider,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Type badge
          Expanded(flex: 2, child: _buildTypeBadge(user.type)),
          SizedBox(width: 15),

          // Status badge
          Expanded(
            flex: 2,
            child: Align(child: _buildStatusBadge(user.status)),
          ),
          SizedBox(width: 15),

          // Last login
          Expanded(
            flex: 2,
            child: Align(
              child: Text(
                user.lastLogin,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),

          // Actions
          SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _actionIcon(
                  Icons.vpn_key_outlined,
                  AppColors.accent,
                  'Reset Password',
                  () {},
                ),
                const SizedBox(width: 8),
                _actionIcon(
                  Icons.block_outlined,
                  Colors.redAccent,
                  'Block User',
                  () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.4),
                      builder:
                          (context) => const BlockUserDialog(
                            userName: 'John Anderson',
                            userId: 'USR-24589',
                          ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                _actionIcon(
                  Icons.visibility_outlined,
                  AppColors.primary,
                  'View Details',
                  () {
                    Get.toNamed("/user/userdetail");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(UserType type) {
    final config =
        {
          UserType.buyer: (
            Icons.shopping_bag_outlined,
            'Buyer',
            AppColors.buyerBg,
            AppColors.buyerText,
          ),
          UserType.seller: (
            Icons.storefront_outlined,
            'Seller',
            AppColors.sellerBg,
            AppColors.sellerText,
          ),
          UserType.driver: (
            Icons.directions_car_outlined,
            'Driver',
            AppColors.driverBg,
            AppColors.driverText,
          ),
        }[type]!;

    return Align(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: config.$3,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(config.$1, size: 13, color: config.$4),
            const SizedBox(width: 4),
            Text(
              config.$2,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: config.$4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(UserStatus status) {
    final config =
        {
          UserStatus.active: (
            'Active',
            AppColors.statusActiveText,
            const Color(0xFFDCFCE7),
          ),
          UserStatus.blocked: (
            'Blocked',
            AppColors.statusBlocked,
            const Color(0xFFFEE2E2),
          ),
          UserStatus.pending: (
            'Pending',
            AppColors.statusPending,
            const Color(0xFFFEF9C3),
          ),
        }[status]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: config.$3,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: config.$2.withOpacity(0.25)),
      ),
      child: Text(
        config.$1,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: config.$2,
        ),
      ),
    );
  }

  Widget _actionIcon(
    IconData icon,
    Color color,
    String tooltip,
    Function()? onTap,
  ) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }

  // ── Pagination ────────────────────────────────────────────────────────────

  Widget _buildPagination() {
    return Row(
      children: [
        const Text(
          'Showing 1 to 5 of 1,247 results',
          style: TextStyle(fontSize: 13, color: AppColors.textMuted),
        ),
        const Spacer(),
        Row(
          children: [
            _pageBtn('Previous', false),
            const SizedBox(width: 4),
            _pageNumBtn('1', isActive: true),
            _pageNumBtn('2'),
            _pageNumBtn('3'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('—', style: TextStyle(color: AppColors.textMuted)),
            ),
            _pageNumBtn('249'),
            const SizedBox(width: 4),
            _pageBtn('Next', true),
          ],
        ),
      ],
    );
  }

  Widget _pageBtn(String label, bool isNext) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textDark,
        side: const BorderSide(color: AppColors.divider),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _pageNumBtn(String number, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive ? null : Border.all(color: AppColors.divider),
          ),
          child: Text(
            number,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }
}
