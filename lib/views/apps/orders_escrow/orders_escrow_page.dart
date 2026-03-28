import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webkit/controller/extra_pages/time_line_controller.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/apps/orders_escrow/order_detail_page.dart';
import 'package:webkit/views/layouts/layout.dart';
import 'package:webkit/views/orders_escrow/orders_review.dart';

class OrdersEscrowPage extends StatefulWidget {
  const OrdersEscrowPage({Key? key}) : super(key: key);

  @override
  State<OrdersEscrowPage> createState() => _OrdersEscrowPageState();
}

class _OrdersEscrowPageState extends State<OrdersEscrowPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late TimeLineController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(TimeLineController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// PAGE TITLE
                  Text(
                    "Orders & Escrow Management",
                    style: GoogleFonts.montserrat(
                      color: Color(0xff1F2937),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// TOP STATS
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                Get.to(() => OrdersReview());
                              },
                              child:
                                  StatCard("Total Orders", "2,847", "+12%"))),
                      SizedBox(width: 16),
                      Expanded(
                          child: StatCard(
                              "Escrow On Hold", "\$124,500", "On Hold")),
                      SizedBox(width: 16),
                      Expanded(
                          child: StatCard(
                              "Escrow Released", "\$892,340", "Released")),
                      SizedBox(width: 16),
                      Expanded(
                          child: StatCard(
                              "Total Refunded", "\$18,920", "Refunded")),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// FILTERS
                  const FilterSection(),

                  /// TABLE
                  OrdersTable()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String percent;

  const StatCard(this.title, this.value, this.percent, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (percent.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/icon/orders.png", width: 48, height: 48),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xfff6f0dd),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      percent,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ContentTheme.lightContentTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: Color(0xff4B4B4B)),
          ),
          Text(
            value,
            style: GoogleFonts.montserrat(
                fontSize: 29, fontWeight: FontWeight.w600, color: Colors.black),
          )
        ],
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          dropdown("All Statuses"),
          const SizedBox(width: 15),

          dropdown("All Users"),
          const SizedBox(width: 15),

          dropdown("Last 7 days"),
          const SizedBox(width: 15),

          /// SEARCH
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xffF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor:
                  LeftBarTheme.lightLeftBarTheme.activeItemBackground,
            ),
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.filter_alt,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 6),
                Text(
                  "Apply Filters",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget dropdown(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: text,
        underline: const SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down_sharp),
        items: [
          DropdownMenuItem(
              value: text,
              child: Text(
                text,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              )),
        ],
        onChanged: (v) {},
      ),
    );
  }
}

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("All Orders",
                  style: GoogleFonts.montserrat(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor:
                          LeftBarTheme.lightLeftBarTheme.activeItemBackground,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.download,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Export",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor:
                          LeftBarTheme.lightLeftBarTheme.activeItemBackground,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.refresh,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Refresh",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),

          /// DATA TABLE
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columnSpacing: 100,
                columns: [
                  DataColumn(
                      label: Text(
                    "Order ID",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Buyer",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Seller",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Driver",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Amount",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Escrow Status",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Date",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Actions",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
                ],
                rows: List.generate(
                  5,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text(
                        "#ORD-2847",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: ContentTheme.lightContentTheme.primary),
                      )),
                      DataCell(Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sarah Johnson",
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Text(
                            "sarah.j@email.com",
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff4B4B4B)),
                          )
                        ],
                      )),
                      DataCell(Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sarah Johnson",
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Text(
                            "sarah.j@email.com",
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff4B4B4B)),
                          )
                        ],
                      )),
                      DataCell(Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sarah Johnson",
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Text(
                            "sarah.j@email.com",
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff4B4B4B)),
                          )
                        ],
                      )),
                      DataCell(Text(
                        "\$2,450",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text("On Hold"),
                        ),
                      ),
                      DataCell(Text(
                        "Dec 28, 2024",
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4B4B4B)),
                      )),
                      DataCell(
                        IconButton(
                          onPressed: () {
                            Get.to(() => OrderDetailPage());
                          },
                          icon: const Icon(Icons.remove_red_eye, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
