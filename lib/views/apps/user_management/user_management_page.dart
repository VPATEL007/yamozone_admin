import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/ecommerce/customers_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/utils/utils.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/images.dart';
import 'package:webkit/models/customer.dart';
import 'package:webkit/views/layouts/layout.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late CustomersController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CustomersController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerSection(),
                const SizedBox(height: 20),
                filterSection(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Users List",
                        style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    Text("1,247 total users",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ],
                ).paddingSymmetric(vertical: 10),
                userTable(),
                const SizedBox(height: 10),
                paginationSection()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget headerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("User Management",
            style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xff111827))),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text("Add User",
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: leftBarTheme.activeItemBackground,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        )
      ],
    );
  }

  Widget filterSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white, // glass transparency
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search users...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  dropdown("All User Types"),
                  const SizedBox(width: 10),
                  dropdown("All Status"),
                  const SizedBox(width: 10),
                  dropdown("Sort by Date"),
                ],
              ),
            )),
      ),
    );
  }

  Widget dropdown(String hint) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
                width: 150,
                height: 50,
                alignment: Alignment.center,
                color: Colors.white,
                child: DropdownButtonFormField(
                  dropdownColor: Colors.white,
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero),
                  items: [
                    DropdownMenuItem(
                      value: "Buyer",
                      child: Text("Buyer"),
                    ),
                    DropdownMenuItem(
                      value: "Seller",
                      child: Text("Seller"),
                    ),
                    DropdownMenuItem(
                      value: "Driver",
                      child: Text("Driver"),
                    ),
                  ],
                  onChanged: (value) {},
                ))));
    // return Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Image.asset(
    //       "assets/images/logo/backdrop.png",
    //       height: 42,
    //       width: 150,
    //     ),
    //     SizedBox(
    //       width: 150,
    //       child: DropdownButtonFormField(
    //         dropdownColor: Colors.white,
    //         focusColor: Colors.white,
    //         decoration: InputDecoration(
    //             border: InputBorder.none, contentPadding: EdgeInsets.zero),
    //         items: [
    //           DropdownMenuItem(
    //             value: "Buyer",
    //             child: Text("Buyer"),
    //           ),
    //           DropdownMenuItem(
    //             value: "Seller",
    //             child: Text("Seller"),
    //           ),
    //           DropdownMenuItem(
    //             value: "Driver",
    //             child: Text("Driver"),
    //           ),
    //         ],
    //         onChanged: (value) {},
    //       ).paddingSymmetric(horizontal: 15, vertical: 10),
    //     ),
    //   ],
    // );
  }

  Widget userTable() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white, // glass transparency
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DataTable(
                      dataRowMinHeight: 65,
                      dataRowMaxHeight: 65,
                      columnSpacing: 100,
                      columns: [
                        DataColumn(
                            label: Checkbox(
                          value: false,
                          side: BorderSide(),
                          focusColor: contentTheme.primary,
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.disabled)) {
                              return Colors.transparent;
                            }
                            return Colors.transparent;
                          }),
                          onChanged: (value) {},
                        )),
                        DataColumn(
                            label: Text(
                          "User",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          "Type",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          "Status",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          "Last Login",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          "Actions",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                      ],
                      rows: [
                        userRow(
                            "Sarah Johnson", "Buyer", "Active", "2 hours ago"),
                        userRow("Mike Chen", "Seller", "Blocked", "5 days ago"),
                        userRow(
                            "David Rodriguez", "Driver", "Active", "1 day ago"),
                        userRow("Emma Wilson", "Buyer", "Pending", "Never"),
                        userRow("Emma Wilson", "Buyer", "Pending", "Never"),
                        userRow("Emma Wilson", "Buyer", "Pending", "Never"),
                        userRow("Emma Wilson", "Buyer", "Pending", "Never"),
                        userRow("Emma Wilson", "Buyer", "Pending", "Never"),
                      ],
                    ),
                  ),
                ))));
  }

  DataRow userRow(String name, String type, String status, String login) {
    return DataRow(
      cells: [
        DataCell(Checkbox(
          value: false,
          side: BorderSide(),
          focusColor: contentTheme.primary,
          fillColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.transparent;
            }
            return Colors.transparent;
          }),
          onChanged: (value) {},
        )),
        DataCell(
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(Images.avatars.first),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Text(
                    "Last Login",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4B)),
                  )
                ],
              ),
            ],
          ),
        ),
        DataCell(typeBadge(type)),
        DataCell(statusBadge(status)),
        DataCell(Text(
          login,
          style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xff4B4B4B)),
        )),
        DataCell(
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.toNamed("/user/userdetail");
                  },
                  child: Icon(Icons.visibility, size: 18)),
              SizedBox(width: 10),
              Icon(Icons.edit, size: 18),
              SizedBox(width: 10),
              Icon(Icons.block, size: 18, color: Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget typeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: contentTheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/icon/dashboard.png",
            width: 10,
            color: contentTheme.primary,
            height: 15,
          ),
          SizedBox(width: 10),
          Text(
            type,
            style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: contentTheme.primary),
          ),
        ],
      ),
    );
  }

  Widget statusBadge(String status) {
    Color color;

    switch (status) {
      case "Active":
        color = Colors.green;
        break;
      case "Blocked":
        color = Colors.red;
        break;
      case "Pending":
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(
            fontSize: 15, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }

  Widget paginationSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Showing 1 to 5 of 1247 results"),
        Row(
          children: [
            pageButton("Previous"),
            pageButton("1", selected: true),
            pageButton("2"),
            pageButton("3"),
            pageButton("Next"),
          ],
        )
      ],
    );
  }

  Widget pageButton(String text, {bool selected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class MyData extends DataTableSource with UIMixin {
  List<Customer> data = [];

  MyData(this.data);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(MyText.bodyMedium(
          data[index].id.toString(),
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(
          data[index].firstName,
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(data[index].phoneNumber.toString())),
        DataCell(MyText.bodyMedium(data[index].balance.toString())),
        DataCell(MyText.bodyMedium(data[index].ordersCount.toString())),
        DataCell(MyText.bodyMedium(
            Utils.getDateStringFromDateTime(data[index].lastOrder).toString())),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.edit2,
                    size: 12,
                    color: contentTheme.primary,
                  ),
                ),
                MySpacing.width(12),
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.trash2,
                    size: 12,
                    color: contentTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
