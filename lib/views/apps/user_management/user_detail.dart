// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get_utils/src/extensions/export.dart';
// import 'package:get/instance_manager.dart';
// import 'package:get/route_manager.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:webkit/helpers/utils/ui_mixins.dart';
// import 'package:webkit/helpers/widgets/my_button.dart';
// import 'package:webkit/views/layouts/layout.dart';

// import '../../../controller/apps/ecommerce/product_detail_controller.dart';

// class UserDetail extends StatefulWidget {
//   const UserDetail({super.key});

//   @override
//   State<UserDetail> createState() => _UserDetailState();
// }

// class _UserDetailState extends State<UserDetail>
//     with SingleTickerProviderStateMixin, UIMixin {
//   late ProductDetailController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(ProductDetailController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       child: GetBuilder(
//         init: controller,
//         builder: (controller) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Header
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "User Details",
//                           style: GoogleFonts.montserrat(
//                               color: Color(0xff111827),
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           "Complete user profile and activity management",
//                           style: GoogleFonts.montserrat(
//                               color: Color(0xff6B7280),
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         _actionButton("Reset Password",
//                             leftBarTheme.activeItemBackground),
//                         const SizedBox(width: 10),
//                         _actionButton("Force Logout", Color(0xffD4AF37)),
//                         const SizedBox(width: 10),
//                         _actionButton("Block User", Color(0xffDC2626)),
//                       ],
//                     )
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 _userProfileCard(),

//                 const SizedBox(height: 20),

//                 /// Stats
//                 _statsRow(),

//                 const SizedBox(height: 20),

//                 /// KYC + Wallet + Quick Action
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(child: _kycCard()),
//                     const SizedBox(width: 20),
//                     Expanded(child: _walletCard()),
//                     const SizedBox(width: 20),
//                     Expanded(child: _quickActions()),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 /// Orders + Disputes
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(child: _recentOrders()),
//                     const SizedBox(width: 20),
//                     Expanded(child: _activeDisputes()),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 /// Transactions
//                 _recentTransactions(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _actionButton(String text, Color color) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       ),
//       onPressed: () {},
//       label: Text(
//         text,
//         style: GoogleFonts.montserrat(
//             fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
//       ),
//       icon: Icon(Icons.key, color: Colors.white),
//     );
//   }

//   Widget _userProfileCard() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 35,
//               backgroundColor: Colors.orange.shade200,
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "John Anderson",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black),
//                       ),
//                       SizedBox(width: 10),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: contentTheme.primary.withValues(alpha: .10)),
//                         child: Text(
//                           "Active",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: contentTheme.primary),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: contentTheme.primary.withValues(alpha: .10)),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.security_outlined,
//                               color: contentTheme.primary,
//                               size: 19,
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               "Verified",
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: contentTheme.primary),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Spacer(),
//                       ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           elevation: 0,
//                           backgroundColor: Color(0xffE5E7EB),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8)),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 16),
//                         ),
//                         onPressed: () {},
//                         label: Text(
//                           "Edit Profile",
//                           style: GoogleFonts.montserrat(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         ),
//                         icon: Icon(Icons.edit, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     "john.anderson@email.com",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B)),
//                   ),
//                   Text(
//                     "+1 (555) 123-4567",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B)),
//                   ),
//                   Text(
//                     "User ID: USR-2024-45891 | Member since: Jan 15, 2024",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B)),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _statsRow() {
//     return Row(
//       children: [
//         Expanded(child: _statCard("247", "Total Orders")),
//         const SizedBox(width: 10),
//         Expanded(child: _statCard("\$45,892", "Total Spent")),
//         const SizedBox(width: 10),
//         Expanded(child: _statCard("\$2,450", "Wallet Balance")),
//         const SizedBox(width: 10),
//         Expanded(child: _statCard("3", "Active Disputes")),
//         const SizedBox(width: 10),
//         Expanded(child: _statCard("4.8", "Rating")),
//       ],
//     );
//   }

//   Widget _statCard(String value, String title) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         child: Column(
//           children: [
//             Image.asset("assets/icon/dashboard.png",
//                 color: contentTheme.primary, width: 25, height: 30),
//             Text(value,
//                 style: GoogleFonts.montserrat(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black)),
//             Text(title,
//                 style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     color: Color(0xff4B4B4B),
//                     fontWeight: FontWeight.w400)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _kycCard() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("KYC Verification",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black)),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: contentTheme.primary.withValues(alpha: .10)),
//                   child: Text(
//                     "Verified",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: contentTheme.primary),
//                   ),
//                 ),
//               ],
//             ),
//             ListTile(
//               leading: Icon(Icons.badge),
//               title: Text("Identity Document",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black)),
//               trailing: Icon(
//                 Icons.check_circle,
//                 color: Color(0xff22C55E),
//                 size: 22,
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.location_on),
//               title: Text("Address Proof",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black)),
//               trailing: Icon(
//                 Icons.check_circle,
//                 color: Color(0xff22C55E),
//                 size: 22,
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.camera_alt),
//               title: Text("Selfie Verification",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black)),
//               trailing: Icon(
//                 Icons.check_circle,
//                 color: Color(0xff22C55E),
//                 size: 22,
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.account_balance),
//               title: Text("Bank Account",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black)),
//               trailing: Icon(
//                 Icons.check_circle,
//                 color: Color(0xff22C55E),
//                 size: 22,
//               ),
//             ),
//             Divider(),
//             Text("Verified on: March 12, 2024",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff4B4B4B))),
//             Text("Verified by: Admin Team",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff4B4B4B))),
//             SizedBox(height: 10),
//             MyButton.medium(
//               onPressed: () {},
//               block: true,
//               backgroundColor: Color(0xffF3F4F6),
//               elevation: 0,
//               child: Text("View Documents",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black)),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _walletCard() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Wallet Overview",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black)),
//                 Icon(
//                   Icons.account_balance_wallet_rounded,
//                   color: contentTheme.primary,
//                 )
//               ],
//             ),
//             const SizedBox(height: 15),
//             Container(
//               width: Get.width,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: leftBarTheme.activeItemBackground,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Available Balance",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.white)),
//                   Text("\$2,450.00",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 34,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white)),
//                   Text("Last updated: 2 hours ago",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.white)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Total Deposits",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B))),
//                 Text("\$48,340.00",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black)),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Total Withdrawals",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B))),
//                 Text("\$48,340.00",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black)),
//               ],
//             ).paddingSymmetric(vertical: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Pending Payouts",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff4B4B4B))),
//                 Text("\$850",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.red)),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       elevation: 0,
//                       backgroundColor: leftBarTheme.activeItemBackground,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 16),
//                     ),
//                     onPressed: () {},
//                     label: Text(
//                       "Add Funds",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white),
//                     ),
//                     icon: Icon(Icons.add, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       elevation: 0,
//                       backgroundColor: Color(0xffF3F4F6),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 16),
//                     ),
//                     onPressed: () {},
//                     label: Text(
//                       "History",
//                       style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black),
//                     ),
//                     icon: Icon(Icons.add, color: Colors.black),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _quickActions() {
//     return Card(
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Quick Actions",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black))
//             .paddingOnly(left: 15),
//         ListTile(
//             leading: Icon(
//               Icons.email,
//               color: contentTheme.primary,
//             ),
//             title: Text("Send Email",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black)),
//             trailing: Icon(
//               Icons.arrow_forward,
//               color: contentTheme.primary,
//             )),
//         ListTile(
//             leading: Icon(
//               Icons.message,
//               color: contentTheme.primary,
//             ),
//             title: Text("Send Message",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black)),
//             trailing: Icon(
//               Icons.arrow_forward,
//               color: contentTheme.primary,
//             )),
//         ListTile(
//             leading: Icon(
//               Icons.airplane_ticket,
//               color: contentTheme.primary,
//             ),
//             title: Text("Create Ticket",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black)),
//             trailing: Icon(
//               Icons.arrow_forward,
//               color: contentTheme.primary,
//             )),
//         ListTile(
//             leading: Icon(
//               Icons.flag,
//               color: contentTheme.primary,
//             ),
//             title: Text("Flag Account",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black)),
//             trailing: Icon(
//               Icons.arrow_forward,
//               color: contentTheme.primary,
//             )),
//         ListTile(
//             leading: Icon(
//               Icons.person_add_disabled_rounded,
//               color: contentTheme.primary,
//             ),
//             title: Text("Suspended Account",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black)),
//             trailing: Icon(
//               Icons.arrow_forward,
//               color: contentTheme.primary,
//             )),
//         ListTile(
//             leading: Icon(
//               Icons.exposure_outlined,
//               color: contentTheme.primary,
//             ),
//             title: Text("Export Data",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black)),
//             trailing: Icon(
//               Icons.arrow_forward,
//               color: contentTheme.primary,
//             )),
//       ],
//     ).paddingSymmetric(horizontal: 15, vertical: 15));
//   }

//   Widget _recentOrders() {
//     return Card(
//         child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Recent Orders",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black)),
//             Text("View All",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: contentTheme.primary)),
//           ],
//         ).paddingSymmetric(horizontal: 15),
//         SizedBox(height: 15),
//         ListTile(
//           subtitle: Text("March 18, 2024",
//               style: GoogleFonts.montserrat(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff4B4B4B))),
//           title: Text("Order #ORD-8923",
//               style: GoogleFonts.montserrat(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black)),
//           trailing: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text("\$245",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black)),
//               SizedBox(height: 2),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: contentTheme.primary.withValues(alpha: .10)),
//                 child: Text(
//                   "Completed",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w500,
//                       color: contentTheme.primary),
//                 ),
//               ),
//             ],
//           ),
//           leading: Image.asset("assets/icon/orders.png", width: 48, height: 48),
//         ),
//         ListTile(
//           subtitle: Text("March 18, 2024",
//               style: GoogleFonts.montserrat(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff4B4B4B))),
//           title: Text("Order #ORD-8923",
//               style: GoogleFonts.montserrat(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black)),
//           trailing: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text("\$245",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black)),
//               SizedBox(height: 2),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: contentTheme.primary.withValues(alpha: .10)),
//                 child: Text(
//                   "Completed",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w500,
//                       color: contentTheme.primary),
//                 ),
//               ),
//             ],
//           ),
//           leading: Image.asset("assets/icon/orders.png", width: 48, height: 48),
//         ),
//         ListTile(
//           subtitle: Text("March 18, 2024",
//               style: GoogleFonts.montserrat(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff4B4B4B))),
//           title: Text("Order #ORD-8923",
//               style: GoogleFonts.montserrat(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black)),
//           trailing: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text("\$245",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black)),
//               SizedBox(height: 2),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: contentTheme.primary.withValues(alpha: .10)),
//                 child: Text(
//                   "Completed",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w500,
//                       color: contentTheme.primary),
//                 ),
//               ),
//             ],
//           ),
//           leading: Image.asset("assets/icon/orders.png", width: 48, height: 48),
//         ),
//         ListTile(
//           subtitle: Text("March 18, 2024",
//               style: GoogleFonts.montserrat(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff4B4B4B))),
//           title: Text("Order #ORD-8923",
//               style: GoogleFonts.montserrat(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black)),
//           trailing: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text("\$245",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black)),
//               SizedBox(height: 2),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: contentTheme.primary.withValues(alpha: .10)),
//                 child: Text(
//                   "Completed",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w500,
//                       color: contentTheme.primary),
//                 ),
//               ),
//             ],
//           ),
//           leading: Image.asset("assets/icon/orders.png", width: 48, height: 48),
//         ),
//       ],
//     ).paddingSymmetric(vertical: 10));
//   }

//   Widget _activeDisputes() {
//     return Card(
//         child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Active Disputes",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black)),
//             Text("View All",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: contentTheme.primary)),
//           ],
//         ),
//         SizedBox(height: 15),
//         Container(
//             decoration: BoxDecoration(
//                 color: contentTheme.primary.withValues(alpha: .10),
//                 borderRadius: BorderRadius.circular(8)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Dispute #DSP-445",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black)),
//                     Text("Product not received as described",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black))
//                         .paddingSymmetric(vertical: 5),
//                     Text("Order #ORD-8891",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black)),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: contentTheme.primary.withValues(alpha: .10)),
//                       child: Text(
//                         "High Priority",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w500,
//                             color: contentTheme.primary),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text("Opened: 2 days ago",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black)),
//                   ],
//                 )
//               ],
//             ).paddingSymmetric(horizontal: 15, vertical: 10)),
//         SizedBox(height: 15),
//         Container(
//             decoration: BoxDecoration(
//                 color: contentTheme.primary.withValues(alpha: .10),
//                 borderRadius: BorderRadius.circular(8)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Dispute #DSP-445",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black)),
//                     Text("Product not received as described",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black))
//                         .paddingSymmetric(vertical: 5),
//                     Text("Order #ORD-8891",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black)),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: contentTheme.primary.withValues(alpha: .10)),
//                       child: Text(
//                         "High Priority",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w500,
//                             color: contentTheme.primary),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text("Opened: 2 days ago",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black)),
//                   ],
//                 )
//               ],
//             ).paddingSymmetric(horizontal: 15, vertical: 10)),
//         SizedBox(height: 15),
//         Container(
//             decoration: BoxDecoration(
//                 color: contentTheme.primary.withValues(alpha: .10),
//                 borderRadius: BorderRadius.circular(8)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Dispute #DSP-445",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black)),
//                     Text("Product not received as described",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black))
//                         .paddingSymmetric(vertical: 5),
//                     Text("Order #ORD-8891",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black)),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: contentTheme.primary.withValues(alpha: .10)),
//                       child: Text(
//                         "High Priority",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w500,
//                             color: contentTheme.primary),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text("Opened: 2 days ago",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black)),
//                   ],
//                 )
//               ],
//             ).paddingSymmetric(horizontal: 15, vertical: 10)),
//         SizedBox(height: 15),
//         MyButton.medium(
//           onPressed: () {},
//           block: true,
//           backgroundColor: leftBarTheme.activeItemBackground,
//           elevation: 0,
//           child: Text("Manage All Disputes",
//               style: GoogleFonts.montserrat(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white)),
//         )
//       ],
//     ).paddingSymmetric(vertical: 15, horizontal: 15));
//   }

//   Widget _recentTransactions() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//             child: Card(
//                 child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Recent Transactions",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black)),
//                 Text("View All",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: contentTheme.primary)),
//               ],
//             ).paddingSymmetric(horizontal: 15),
//             SizedBox(height: 15),
//             ListTile(
//               subtitle: Text("March 18, 2024 - 2:30 PM",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff4B4B4B))),
//               title: Text("Deposit",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//               trailing: Text("+\$500.00",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: contentTheme.primary)),
//               leading:
//                   Image.asset("assets/icon/orders.png", width: 48, height: 48),
//             ),
//             ListTile(
//               subtitle: Text("March 18, 2024 - 2:30 PM",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff4B4B4B))),
//               title: Text("Deposit",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//               trailing: Text("+\$500.00",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: contentTheme.primary)),
//               leading:
//                   Image.asset("assets/icon/orders.png", width: 48, height: 48),
//             ),
//             ListTile(
//               subtitle: Text("March 18, 2024 - 2:30 PM",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff4B4B4B))),
//               title: Text("Deposit",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//               trailing: Text("+\$500.00",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: contentTheme.primary)),
//               leading:
//                   Image.asset("assets/icon/orders.png", width: 48, height: 48),
//             ),
//           ],
//         ).paddingSymmetric(vertical: 10))),
//         const SizedBox(width: 20),
//         Expanded(child: Visibility(visible: false, child: _activeDisputes())),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/views/layouts/layout.dart';

// ── Palette ────────────────────────────────────────────────────────────────
const kBg = Color(0xFFF7F6F2);
const kCard = Colors.white;
const kGreen = Color(0xFF2D5016);
const kGreenLight = Color(0xFF4A7C2F);
const kGold = Color(0xFFB8860B);
const kGoldLight = Color(0xFFD4A017);
const kRed = Color(0xFFDC2626);
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF6B7280);
const kBorder = Color(0xFFE5E7EB);
const kSuccess = Color(0xFF16A34A);
const kWarning = Color(0xFFD97706);
const kHighPriority = Color(0xFFDC2626);
const kMedium = Color(0xFFD97706);
const kLow = Color(0xFF16A34A);
const kBalanceBg = Color(0xFF1C3A0E);

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProfileHeader(),
                      const SizedBox(height: 20),
                      _StatsRow(),
                      const SizedBox(height: 20),
                      // KYC + Wallet + Quick Actions row
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: _KycCard()),
                            const SizedBox(width: 16),
                            Expanded(flex: 4, child: _WalletCard()),
                            const SizedBox(width: 16),
                            Expanded(flex: 3, child: _QuickActionsCard()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Orders + Disputes row
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _RecentOrdersCard()),
                            const SizedBox(width: 16),
                            Expanded(child: _ActiveDisputesCard()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _RecentTransactionsCard(),
                      const SizedBox(height: 24),
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

// ── Top Bar ────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kCard,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, size: 20, color: kTextSecondary),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'User Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              Text(
                'Complete user profile and activity management',
                style: TextStyle(fontSize: 12, color: kTextSecondary),
              ),
            ],
          ),
          const Spacer(),
          _ActionButton(
            icon: Icons.lock_reset,
            label: 'Reset Password',
            color: kGreen,
            textColor: Colors.white,
          ),
          const SizedBox(width: 8),
          _ActionButton(
            icon: Icons.logout,
            label: 'Force Logout',
            color: kGold,
            textColor: Colors.white,
          ),
          const SizedBox(width: 8),
          _ActionButton(
            icon: Icons.block,
            label: 'Block User',
            color: kRed,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 14, color: textColor),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// ── Profile Header ─────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kBorder, width: 2),
              color: const Color(0xFFF3F4F6),
            ),
            child: const Icon(Icons.person, size: 36, color: kTextSecondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'John Anderson',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kTextPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _Badge(label: 'Active', color: kSuccess),
                    const SizedBox(width: 6),
                    _Badge(label: '✓ Verified', color: kGold, bgOpacity: true),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'john.anderson@email.com',
                  style: TextStyle(fontSize: 13, color: kTextSecondary),
                ),
                const Text(
                  '+1 (555) 123-4567',
                  style: TextStyle(fontSize: 13, color: kTextSecondary),
                ),
                const SizedBox(height: 4),
                const Text(
                  'User ID: USR-2024-45891  |  Member since: Jan 15, 2024',
                  style: TextStyle(fontSize: 12, color: kTextSecondary),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit, size: 14, color: kTextSecondary),
            label: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 13, color: kTextSecondary),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: kBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final bool bgOpacity;

  const _Badge({
    required this.label,
    required this.color,
    this.bgOpacity = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(bgOpacity ? 0.1 : 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
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

// ── Stats Row ──────────────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'icon': Icons.shopping_bag_outlined,
        'value': '247',
        'label': 'Total Orders',
        'color': kGold,
      },
      {
        'icon': Icons.attach_money,
        'value': '\$45,892',
        'label': 'Total Spent',
        'color': kSuccess,
      },
      {
        'icon': Icons.account_balance_wallet_outlined,
        'value': '\$2,450',
        'label': 'Wallet Balance',
        'color': kGold,
      },
      {
        'icon': Icons.balance_outlined,
        'value': '3',
        'label': 'Active Disputes',
        'color': kGold,
      },
      {
        'icon': Icons.star_outlined,
        'value': '4.8',
        'label': 'Rating',
        'color': kGold,
      },
    ];

    return Row(
      children:
          stats.map((s) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  right: stats.indexOf(s) < stats.length - 1 ? 12 : 0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kBorder),
                ),
                child: Column(
                  children: [
                    Icon(
                      s['icon'] as IconData,
                      size: 24,
                      color: s['color'] as Color,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      s['value'] as String,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      s['label'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: kTextSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}

// ── KYC Card ───────────────────────────────────────────────────────────────
class _KycCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      'Identity Document',
      'Address Proof',
      'Selfie Verification',
      'Bank Account',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'KYC Verification',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              _Badge(label: 'Verified', color: kSuccess),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 18, color: kSuccess),
                  const SizedBox(width: 10),
                  Text(
                    item,
                    style: const TextStyle(fontSize: 13, color: kTextPrimary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Verified on: March 12, 2024',
            style: TextStyle(fontSize: 11, color: kTextSecondary),
          ),
          const Text(
            'Verified by: Admin Team',
            style: TextStyle(fontSize: 11, color: kTextSecondary),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: kBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'View Documents',
                style: TextStyle(fontSize: 13, color: kTextPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Wallet Card ────────────────────────────────────────────────────────────
class _WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wallet Overview',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              const Icon(Icons.account_balance_wallet, size: 18, color: kGold),
            ],
          ),
          const SizedBox(height: 16),
          // Balance box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kBalanceBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Available Balance',
                  style: TextStyle(fontSize: 12, color: Colors.white60),
                ),
                SizedBox(height: 6),
                Text(
                  '\$2,450.00',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Last updated: 2 hours ago',
                  style: TextStyle(fontSize: 11, color: Colors.white54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _WalletRow(
            label: 'Total Deposits',
            value: '\$48,340.00',
            color: kTextPrimary,
          ),
          const SizedBox(height: 8),
          _WalletRow(
            label: 'Total Withdrawals',
            value: '\$45,890.00',
            color: kTextPrimary,
          ),
          const SizedBox(height: 8),
          _WalletRow(label: 'Pending Payouts', value: '\$850.00', color: kRed),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 14, color: Colors.white),
                  label: const Text(
                    'Add Funds',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBalanceBg,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.history,
                    size: 14,
                    color: kTextSecondary,
                  ),
                  label: const Text(
                    'History',
                    style: TextStyle(fontSize: 13, color: kTextSecondary),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kBorder),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WalletRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _WalletRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: kTextSecondary),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

// ── Quick Actions Card ─────────────────────────────────────────────────────
class _QuickActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.email_outlined, 'label': 'Send Email'},
      {'icon': Icons.chat_bubble_outline, 'label': 'Send Message'},
      {'icon': Icons.confirmation_number_outlined, 'label': 'Create Ticket'},
      {'icon': Icons.flag_outlined, 'label': 'Flag Account'},
      {'icon': Icons.pause_circle_outline, 'label': 'Suspend Account'},
      {'icon': Icons.download_outlined, 'label': 'Export Data'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: kTextPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...actions.map(
            (a) => _QuickActionTile(
              icon: a['icon'] as IconData,
              label: a['label'] as String,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickActionTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        leading: Icon(icon, size: 18, color: kGold),
        title: Text(
          label,
          style: const TextStyle(fontSize: 13, color: kTextPrimary),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          size: 18,
          color: kTextSecondary,
        ),
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        hoverColor: kBg,
      ),
    );
  }
}

// ── Recent Orders Card ─────────────────────────────────────────────────────
class _RecentOrdersCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': '#ORD-8923',
        'date': 'March 18, 2024',
        'amount': '\$245.00',
        'status': 'Completed',
        'color': kSuccess,
      },
      {
        'id': '#ORD-8891',
        'date': 'March 16, 2024',
        'amount': '\$189.50',
        'status': 'Processing',
        'color': kGold,
      },
      {
        'id': '#ORD-8845',
        'date': 'March 14, 2024',
        'amount': '\$567.00',
        'status': 'Shipped',
        'color': kGreenLight,
      },
      {
        'id': '#ORD-8823',
        'date': 'March 12, 2024',
        'amount': '\$412.75',
        'status': 'Delivered',
        'color': kSuccess,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Orders',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(fontSize: 13, color: kGold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...orders.map(
            (o) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBorder),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kGold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 18,
                      color: kGold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ${o['id']}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kTextPrimary,
                          ),
                        ),
                        Text(
                          o['date'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: kTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        o['amount'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: kTextPrimary,
                        ),
                      ),
                      Text(
                        o['status'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: o['color'] as Color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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

// ── Active Disputes Card ───────────────────────────────────────────────────
class _ActiveDisputesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final disputes = [
      {
        'id': '#DSP-445',
        'priority': 'High Priority',
        'priorityColor': kHighPriority,
        'desc': 'Product not received as described',
        'order': 'Order #ORD-8891',
        'time': 'Opened: 2 days ago',
        'bgColor': const Color(0xFFFFF8F8),
      },
      {
        'id': '#DSP-423',
        'priority': 'Medium',
        'priorityColor': kMedium,
        'desc': 'Refund request pending',
        'order': 'Order #ORD-8845',
        'time': 'Opened: 5 days ago',
        'bgColor': const Color(0xFFFFFBF0),
      },
      {
        'id': '#DSP-401',
        'priority': 'Low',
        'priorityColor': kLow,
        'desc': 'Delivery delay complaint',
        'order': 'Order #ORD-8823',
        'time': 'Opened: 1 week ago',
        'bgColor': const Color(0xFFF0FFF4),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Disputes',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: kHighPriority.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '3 Active',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kHighPriority,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...disputes.map(
            (d) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: d['bgColor'] as Color,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dispute ${d['id']}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: kTextPrimary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (d['priorityColor'] as Color).withOpacity(
                            0.12,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          d['priority'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: d['priorityColor'] as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    d['desc'] as String,
                    style: const TextStyle(fontSize: 12, color: kTextSecondary),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        d['order'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: kTextSecondary,
                        ),
                      ),
                      Text(
                        d['time'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          color: kTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kBalanceBg,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Manage All Disputes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recent Transactions Card ───────────────────────────────────────────────
class _RecentTransactionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        'type': 'Deposit',
        'date': 'March 18, 2024 · 2:30 PM',
        'amount': '+\$500.00',
        'isPositive': true,
        'icon': Icons.arrow_downward,
      },
      {
        'type': 'Payment',
        'date': 'March 18, 2024 · 10:15 AM',
        'amount': '-\$245.00',
        'isPositive': false,
        'icon': Icons.arrow_upward,
      },
      {
        'type': 'Transfer',
        'date': 'March 17, 2024 · 5:00 PM',
        'amount': '-\$100.00',
        'isPositive': false,
        'icon': Icons.swap_horiz,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(fontSize: 13, color: kGold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...transactions.map((t) {
            final isPos = t['isPositive'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: kBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBorder),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          isPos
                              ? kSuccess.withOpacity(0.1)
                              : kRed.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      t['icon'] as IconData,
                      size: 16,
                      color: isPos ? kSuccess : kRed,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t['type'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kTextPrimary,
                          ),
                        ),
                        Text(
                          t['date'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: kTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    t['amount'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isPos ? kSuccess : kRed,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
