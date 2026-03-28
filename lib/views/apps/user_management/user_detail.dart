import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/views/layouts/layout.dart';

import '../../../controller/apps/ecommerce/product_detail_controller.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProductDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProductDetailController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Details",
                          style: GoogleFonts.montserrat(
                              color: Color(0xff111827),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Complete user profile and activity management",
                          style: GoogleFonts.montserrat(
                              color: Color(0xff6B7280),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _actionButton("Reset Password",
                            leftBarTheme.activeItemBackground),
                        const SizedBox(width: 10),
                        _actionButton("Force Logout", Color(0xffD4AF37)),
                        const SizedBox(width: 10),
                        _actionButton("Block User", Color(0xffDC2626)),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 20),

                _userProfileCard(),

                const SizedBox(height: 20),

                /// Stats
                _statsRow(),

                const SizedBox(height: 20),

                /// KYC + Wallet + Quick Action
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _kycCard()),
                    const SizedBox(width: 20),
                    Expanded(child: _walletCard()),
                    const SizedBox(width: 20),
                    Expanded(child: _quickActions()),
                  ],
                ),

                const SizedBox(height: 20),

                /// Orders + Disputes
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _recentOrders()),
                    const SizedBox(width: 20),
                    Expanded(child: _activeDisputes()),
                  ],
                ),

                const SizedBox(height: 20),

                /// Transactions
                _recentTransactions(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _actionButton(String text, Color color) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      onPressed: () {},
      label: Text(
        text,
        style: GoogleFonts.montserrat(
            fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      icon: Icon(Icons.key, color: Colors.white),
    );
  }

  Widget _userProfileCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.orange.shade200,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "John Anderson",
                      style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: contentTheme.primary.withValues(alpha: .10)),
                      child: Text(
                        "Active",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: contentTheme.primary),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: contentTheme.primary.withValues(alpha: .10)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.security_outlined,
                            color: contentTheme.primary,
                            size: 19,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Verified",
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: contentTheme.primary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width * 0.47),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color(0xffE5E7EB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                      ),
                      onPressed: () {},
                      label: Text(
                        "Edit Profile",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      icon: Icon(Icons.edit, color: Colors.black),
                    ),
                  ],
                ),
                Text(
                  "john.anderson@email.com",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4B4B4B)),
                ),
                Text(
                  "+1 (555) 123-4567",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4B4B4B)),
                ),
                Text(
                  "User ID: USR-2024-45891 | Member since: Jan 15, 2024",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4B4B4B)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        Expanded(child: _statCard("247", "Total Orders")),
        const SizedBox(width: 10),
        Expanded(child: _statCard("\$45,892", "Total Spent")),
        const SizedBox(width: 10),
        Expanded(child: _statCard("\$2,450", "Wallet Balance")),
        const SizedBox(width: 10),
        Expanded(child: _statCard("3", "Active Disputes")),
        const SizedBox(width: 10),
        Expanded(child: _statCard("4.8", "Rating")),
      ],
    );
  }

  Widget _statCard(String value, String title) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Image.asset("assets/icon/dashboard.png",
                color: contentTheme.primary, width: 25, height: 30),
            Text(value,
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Text(title,
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Color(0xff4B4B4B),
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }

  Widget _kycCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("KYC Verification",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: contentTheme.primary.withValues(alpha: .10)),
                  child: Text(
                    "Verified",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: contentTheme.primary),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.badge),
              title: Text("Identity Document",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              trailing: Icon(
                Icons.check_circle,
                color: Color(0xff22C55E),
                size: 22,
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Address Proof",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              trailing: Icon(
                Icons.check_circle,
                color: Color(0xff22C55E),
                size: 22,
              ),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Selfie Verification",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              trailing: Icon(
                Icons.check_circle,
                color: Color(0xff22C55E),
                size: 22,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text("Bank Account",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              trailing: Icon(
                Icons.check_circle,
                color: Color(0xff22C55E),
                size: 22,
              ),
            ),
            Divider(),
            Text("Verified on: March 12, 2024",
                style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4B4B4B))),
            Text("Verified by: Admin Team",
                style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4B4B4B))),
            SizedBox(height: 10),
            MyButton.medium(
              onPressed: () {},
              block: true,
              backgroundColor: Color(0xffF3F4F6),
              elevation: 0,
              child: Text("View Documents",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  Widget _walletCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Wallet Overview",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Icon(
                  Icons.account_balance_wallet_rounded,
                  color: contentTheme.primary,
                )
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: leftBarTheme.activeItemBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Available Balance",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  Text("\$2,450.00",
                      style: GoogleFonts.montserrat(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  Text("Last updated: 2 hours ago",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Deposits",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B))),
                Text("\$48,340.00",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Withdrawals",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B))),
                Text("\$48,340.00",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ],
            ).paddingSymmetric(vertical: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pending Payouts",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B))),
                Text("\$850",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.red)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: leftBarTheme.activeItemBackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                    ),
                    onPressed: () {},
                    label: Text(
                      "Add Funds",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xffF3F4F6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                    ),
                    onPressed: () {},
                    label: Text(
                      "History",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    icon: Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _quickActions() {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quick Actions",
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))
            .paddingOnly(left: 15),
        ListTile(
            leading: Icon(
              Icons.email,
              color: contentTheme.primary,
            ),
            title: Text("Send Email",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            trailing: Icon(
              Icons.arrow_forward,
              color: contentTheme.primary,
            )),
        ListTile(
            leading: Icon(
              Icons.message,
              color: contentTheme.primary,
            ),
            title: Text("Send Message",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            trailing: Icon(
              Icons.arrow_forward,
              color: contentTheme.primary,
            )),
        ListTile(
            leading: Icon(
              Icons.airplane_ticket,
              color: contentTheme.primary,
            ),
            title: Text("Create Ticket",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            trailing: Icon(
              Icons.arrow_forward,
              color: contentTheme.primary,
            )),
        ListTile(
            leading: Icon(
              Icons.flag,
              color: contentTheme.primary,
            ),
            title: Text("Flag Account",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            trailing: Icon(
              Icons.arrow_forward,
              color: contentTheme.primary,
            )),
        ListTile(
            leading: Icon(
              Icons.person_add_disabled_rounded,
              color: contentTheme.primary,
            ),
            title: Text("Suspended Account",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            trailing: Icon(
              Icons.arrow_forward,
              color: contentTheme.primary,
            )),
        ListTile(
            leading: Icon(
              Icons.exposure_outlined,
              color: contentTheme.primary,
            ),
            title: Text("Export Data",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            trailing: Icon(
              Icons.arrow_forward,
              color: contentTheme.primary,
            )),
      ],
    ).paddingSymmetric(horizontal: 15, vertical: 15));
  }

  Widget _recentOrders() {
    return Card(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Orders",
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Text("View All",
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: contentTheme.primary)),
          ],
        ).paddingSymmetric(horizontal: 15),
        SizedBox(height: 15),
        ListTile(
          subtitle: Text("March 18, 2024",
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4B4B4B))),
          title: Text("Order #ORD-8923",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("\$245",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: contentTheme.primary.withValues(alpha: .10)),
                child: Text(
                  "Completed",
                  style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: contentTheme.primary),
                ),
              ),
            ],
          ),
          leading: Image.asset("assets/icon/orders.png", width: 48, height: 48),
        ),
        ListTile(
          subtitle: Text("March 18, 2024",
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4B4B4B))),
          title: Text("Order #ORD-8923",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("\$245",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: contentTheme.primary.withValues(alpha: .10)),
                child: Text(
                  "Completed",
                  style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: contentTheme.primary),
                ),
              ),
            ],
          ),
          leading: Image.asset("assets/icon/orders.png", width: 48, height: 48),
        ),
        ListTile(
          subtitle: Text("March 18, 2024",
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4B4B4B))),
          title: Text("Order #ORD-8923",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("\$245",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: contentTheme.primary.withValues(alpha: .10)),
                child: Text(
                  "Completed",
                  style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: contentTheme.primary),
                ),
              ),
            ],
          ),
          leading: Image.asset("assets/icon/orders.png", width: 48, height: 48),
        ),
        ListTile(
          subtitle: Text("March 18, 2024",
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4B4B4B))),
          title: Text("Order #ORD-8923",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("\$245",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: contentTheme.primary.withValues(alpha: .10)),
                child: Text(
                  "Completed",
                  style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: contentTheme.primary),
                ),
              ),
            ],
          ),
          leading: Image.asset("assets/icon/orders.png", width: 48, height: 48),
        ),
      ],
    ).paddingSymmetric(vertical: 10));
  }

  Widget _activeDisputes() {
    return Card(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Active Disputes",
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Text("View All",
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: contentTheme.primary)),
          ],
        ),
        SizedBox(height: 15),
        Container(
            decoration: BoxDecoration(
                color: contentTheme.primary.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dispute #DSP-445",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    Text("Product not received as described",
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black))
                        .paddingSymmetric(vertical: 5),
                    Text("Order #ORD-8891",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: contentTheme.primary.withValues(alpha: .10)),
                      child: Text(
                        "High Priority",
                        style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: contentTheme.primary),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Opened: 2 days ago",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 15, vertical: 10)),
        SizedBox(height: 15),
        Container(
            decoration: BoxDecoration(
                color: contentTheme.primary.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dispute #DSP-445",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    Text("Product not received as described",
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black))
                        .paddingSymmetric(vertical: 5),
                    Text("Order #ORD-8891",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: contentTheme.primary.withValues(alpha: .10)),
                      child: Text(
                        "High Priority",
                        style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: contentTheme.primary),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Opened: 2 days ago",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 15, vertical: 10)),
        SizedBox(height: 15),
        Container(
            decoration: BoxDecoration(
                color: contentTheme.primary.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dispute #DSP-445",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    Text("Product not received as described",
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black))
                        .paddingSymmetric(vertical: 5),
                    Text("Order #ORD-8891",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: contentTheme.primary.withValues(alpha: .10)),
                      child: Text(
                        "High Priority",
                        style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: contentTheme.primary),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Opened: 2 days ago",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 15, vertical: 10)),
        SizedBox(height: 15),
        MyButton.medium(
          onPressed: () {},
          block: true,
          backgroundColor: leftBarTheme.activeItemBackground,
          elevation: 0,
          child: Text("Manage All Disputes",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        )
      ],
    ).paddingSymmetric(vertical: 15, horizontal: 15));
  }

  Widget _recentTransactions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Card(
                child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent Transactions",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text("View All",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: contentTheme.primary)),
              ],
            ).paddingSymmetric(horizontal: 15),
            SizedBox(height: 15),
            ListTile(
              subtitle: Text("March 18, 2024 - 2:30 PM",
                  style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4B4B4B))),
              title: Text("Deposit",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              trailing: Text("+\$500.00",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: contentTheme.primary)),
              leading:
                  Image.asset("assets/icon/orders.png", width: 48, height: 48),
            ),
            ListTile(
              subtitle: Text("March 18, 2024 - 2:30 PM",
                  style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4B4B4B))),
              title: Text("Deposit",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              trailing: Text("+\$500.00",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: contentTheme.primary)),
              leading:
                  Image.asset("assets/icon/orders.png", width: 48, height: 48),
            ),
            ListTile(
              subtitle: Text("March 18, 2024 - 2:30 PM",
                  style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4B4B4B))),
              title: Text("Deposit",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              trailing: Text("+\$500.00",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: contentTheme.primary)),
              leading:
                  Image.asset("assets/icon/orders.png", width: 48, height: 48),
            ),
          ],
        ).paddingSymmetric(vertical: 10))),
        const SizedBox(width: 20),
        Expanded(child: Visibility(visible: false, child: _activeDisputes())),
      ],
    );
  }
}
