// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:yamazone/controller/apps/fitness/fitness_controller.dart';
// import 'package:yamazone/helpers/utils/ui_mixins.dart';
// import 'package:yamazone/views/apps/driver_monitoring/driver_profile_page.dart';
// import 'package:yamazone/views/layouts/layout.dart';

// class DriverMonitoringPage extends StatefulWidget {
//   const DriverMonitoringPage({super.key});

//   @override
//   State<DriverMonitoringPage> createState() => _DriverMonitoringPageState();
// }

// class _DriverMonitoringPageState extends State<DriverMonitoringPage>
//     with SingleTickerProviderStateMixin, UIMixin {
//   late FitnessController controller;

//   @override
//   void initState() {
//     controller = Get.put(FitnessController());
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     controller.isWeb = MediaQuery.of(context).size.width > 767;

//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//         child: GetBuilder(
//             init: controller,
//             builder: (controller) {
//               return SizedBox(
//                 width: Get.width,
//                 height: Get.height,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       /// TOP HEADER
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Driver Monitoring",
//                             style: GoogleFonts.montserrat(
//                                 fontSize: 23,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff1F2937)),
//                           ),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 elevation: 0,
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 25),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8)),
//                                 backgroundColor:
//                                     leftBarTheme.activeItemBackground),
//                             onPressed: () {},
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.refresh,
//                                   size: 20,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(width: 6),
//                                 Text(
//                                   "Refresh Data",
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),

//                       const SizedBox(height: 16),

//                       /// MAIN CONTENT
//                       Expanded(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             /// LEFT PANEL - DRIVERS
//                             Expanded(
//                               flex: 2,
//                               child: _activeDriversCard(),
//                             ),

//                             const SizedBox(width: 16),

//                             /// CENTER MAP
//                             Expanded(
//                               flex: 4,
//                               child: _mapCard(),
//                             ),

//                             const SizedBox(width: 16),

//                             /// RIGHT PANEL
//                             Expanded(
//                               flex: 2,
//                               child: Column(
//                                 children: [
//                                   _driverDetailsCard(),
//                                   const SizedBox(height: 16),
//                                   _quickActionsCard(),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 16),

//                       /// BOTTOM TABLE
//                       _taskTable(),
//                     ],
//                   ),
//                 ),
//               );
//             }));
//   }

//   /// ================= LEFT PANEL =================
//   Widget _activeDriversCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             /// TITLE
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Active Drivers",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xff111827))),
//                 Chip(
//                   label: Text("12 Online",style: GoogleFonts.montserrat(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xff111827))))
//               ],
//             ),

//             const SizedBox(height: 10),

//             /// SEARCH
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Search drivers...",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),

//             const SizedBox(height: 10),

//             /// DRIVER LIST
//             Expanded(
//               child: ListView(
//                 children: const [
//                   _DriverTile(
//                     name: "John Mitchell",
//                     id: "DRV-001",
//                     status: "Active",
//                     tasks: "3 tasks",
//                   ),
//                   _DriverTile(
//                     name: "David Chen",
//                     id: "DRV-002",
//                     status: "En Route",
//                     tasks: "2 tasks",
//                   ),
//                   _DriverTile(
//                     name: "Sarah Wilson",
//                     id: "DRV-003",
//                     status: "Active",
//                     tasks: "1 task",
//                   ),
//                   _DriverTile(
//                     name: "Mike Rodriguez",
//                     id: "DRV-004",
//                     status: "Delayed",
//                     tasks: "4 tasks",
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   /// ================= MAP =================
//   Widget _mapCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         children: [
//           const ListTile(
//             title: Text("Driver Location Map"),
//             subtitle: Text("Real-time driver positions and routes"),
//           ),
//           Expanded(
//             child: Container(
//               margin: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Center(child: Text("Map Placeholder")),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ================= DETAILS =================
//   Widget _driverDetailsCard() {
//     return InkWell(
//       onTap: () {
//         Get.to(() => DriverProfilePage());
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: const Padding(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Driver Details",
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               Text("John Mitchell - DRV-001"),
//               SizedBox(height: 10),
//               Text("Current Status: Active"),
//               Text("Vehicle: Honda CRV - ABC123"),
//               Text("Last Update: 2 mins ago"),
//               Text("Total Deliveries: 847"),
//               Text("Rating: ⭐⭐⭐⭐⭐"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// ================= ACTIONS =================
//   Widget _quickActionsCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text("Quick Actions",
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             const SizedBox(height: 10),
//             _actionBtn("Contact Driver"),
//             _actionBtn("Mark as Delayed"),
//             _actionBtn("Force Failed Delivery"),
//             _actionBtn("Set Offline"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _actionBtn(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green[800],
//           minimumSize: const Size(double.infinity, 45),
//         ),
//         onPressed: () {},
//         child: Text(text),
//       ),
//     );
//   }

//   /// ================= TABLE =================
//   Widget _taskTable() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         height: 220,
//         child: Column(
//           children: [
//             const ListTile(
//               title: Text("Active Tasks - John Mitchell"),
//             ),
//             Expanded(
//               child: DataTable(
//                 columns: const [
//                   DataColumn(label: Text("Order ID")),
//                   DataColumn(label: Text("Customer")),
//                   DataColumn(label: Text("Address")),
//                   DataColumn(label: Text("Status")),
//                   DataColumn(label: Text("ETA")),
//                 ],
//                 rows: const [
//                   DataRow(cells: [
//                     DataCell(Text("#ORD-2024-001")),
//                     DataCell(Text("Emma Thompson")),
//                     DataCell(Text("123 Oak Street")),
//                     DataCell(Text("In Transit")),
//                     DataCell(Text("15 mins")),
//                   ]),
//                   DataRow(cells: [
//                     DataCell(Text("#ORD-2024-002")),
//                     DataCell(Text("Robert Chen")),
//                     DataCell(Text("456 Pine Avenue")),
//                     DataCell(Text("Picked Up")),
//                     DataCell(Text("25 mins")),
//                   ]),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// DRIVER TILE
// class _DriverTile extends StatelessWidget {
//   final String name, id, status, tasks;

//   const _DriverTile({
//     required this.name,
//     required this.id,
//     required this.status,
//     required this.tasks,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: const CircleAvatar(child: Icon(Icons.person)),
//       title: Text(name),
//       subtitle: Text("ID: $id"),
//       trailing: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Chip(label: Text(status)),
//           Text(tasks, style: const TextStyle(fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yamazone/helpers/theme/admin_theme.dart';
import 'package:yamazone/views/apps/driver_monitoring/driver_profile_page.dart';
import 'package:yamazone/views/layouts/layout.dart';

// ─────────────────────────────────────────────
// THEME CONSTANTS
// ─────────────────────────────────────────────
const kPrimary = Color(0xFFB8962E);
const kPrimaryDark = Color(0xFF1A3C2B);
const kBg = Color(0xFFFAF8F3);
const kCardBg = Colors.white;
const kTextDark = Color(0xFF1A1A1A);
const kTextMid = Color(0xFF555555);
const kTextLight = Color(0xFF999999);
const kDivider = Color(0xFFEEEAE0);

const kStatusActive = Color(0xFF2E7D32);
const kStatusEnRoute = Color(0xFFE65100);
const kStatusDelayed = Color(0xFFB71C1C);

const kBadgeActiveBg = Color(0xFFE8F5E9);
const kBadgeActiveText = Color(0xFF2E7D32);
const kBadgeEnRouteBg = Color(0xFFFFF3E0);
const kBadgeEnRouteText = Color(0xFFE65100);
const kBadgeDelayedBg = Color(0xFFFFEBEE);
const kBadgeDelayedText = Color(0xFFB71C1C);

const kPriorityHighBg = Color(0xFFFFEBEE);
const kPriorityHighText = Color(0xFFB71C1C);
const kPriorityMedBg = Color(0xFFFFF8E1);
const kPriorityMedText = Color(0xFFF57F17);
const kPriorityLowBg = Color(0xFFE8F5E9);
const kPriorityLowText = Color(0xFF2E7D32);

// ─────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────
enum DriverStatus { active, enRoute, delayed }

class DriverModel {
  final String name, id, initials;
  final int tasks;
  final DriverStatus status;
  const DriverModel({
    required this.name,
    required this.id,
    required this.initials,
    required this.tasks,
    required this.status,
  });
}

class TaskModel {
  final String orderId, customer, phone, address, status, priority, eta;
  final bool selected;
  const TaskModel({
    required this.orderId,
    required this.customer,
    required this.phone,
    required this.address,
    required this.status,
    required this.priority,
    required this.eta,
    this.selected = false,
  });
}

final _drivers = [
  const DriverModel(
    name: 'John Mitchell',
    id: 'DRV-001',
    initials: 'JM',
    tasks: 3,
    status: DriverStatus.active,
  ),
  const DriverModel(
    name: 'David Chen',
    id: 'DRV-002',
    initials: 'DC',
    tasks: 2,
    status: DriverStatus.enRoute,
  ),
  const DriverModel(
    name: 'Sarah Wilson',
    id: 'DRV-003',
    initials: 'SW',
    tasks: 1,
    status: DriverStatus.active,
  ),
  const DriverModel(
    name: 'Mike Rodriguez',
    id: 'DRV-004',
    initials: 'MR',
    tasks: 4,
    status: DriverStatus.delayed,
  ),
];

final _tasks = [
  const TaskModel(
    orderId: '#ORD-2024-001',
    customer: 'Emma Thompson',
    phone: '+1 555-0123',
    address: '123 Oak Street, Downtown',
    status: 'In Transit',
    priority: 'High',
    eta: '15 mins',
  ),
  const TaskModel(
    orderId: '#ORD-2024-002',
    customer: 'Robert Chen',
    phone: '+1 555-0456',
    address: '456 Pine Avenue, Midtown',
    status: 'Picked Up',
    priority: 'Medium',
    eta: '25 mins',
  ),
  const TaskModel(
    orderId: '#ORD-2024-003',
    customer: 'Lisa Anderson',
    phone: '+1 555-0789',
    address: '789 Elm Court, Uptown',
    status: 'Assigned',
    priority: 'Low',
    eta: '45 mins',
  ),
];

// ─────────────────────────────────────────────
// ENTRY POINT
// ─────────────────────────────────────────────

// ─────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────
class DriverMonitoringScreen extends StatefulWidget {
  const DriverMonitoringScreen({super.key});
  @override
  State<DriverMonitoringScreen> createState() => _DriverMonitoringScreenState();
}

class _DriverMonitoringScreenState extends State<DriverMonitoringScreen> {
  int _selectedDriverIndex = 0;
  final _searchCtrl = TextEditingController();
  final Set<int> _selectedTasks = {};

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  DriverModel get _selectedDriver => _drivers[_selectedDriverIndex];

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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // ── Top 3-column row ──
                      LayoutBuilder(
                        builder: (ctx, constraints) {
                          final isWide = constraints.maxWidth > 800;
                          return isWide
                              ? IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: _ActiveDriversPanel(
                                        drivers: _drivers,
                                        selectedIndex: _selectedDriverIndex,
                                        onSelect:
                                            (i) => setState(
                                              () => _selectedDriverIndex = i,
                                            ),
                                        searchCtrl: _searchCtrl,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(child: _MapPanel()),
                                    const SizedBox(width: 14),
                                    SizedBox(
                                      width: 260,
                                      child: _DriverDetailsPanel(
                                        driver: _selectedDriver,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Column(
                                children: [
                                  _ActiveDriversPanel(
                                    drivers: _drivers,
                                    selectedIndex: _selectedDriverIndex,
                                    onSelect:
                                        (i) => setState(
                                          () => _selectedDriverIndex = i,
                                        ),
                                    searchCtrl: _searchCtrl,
                                  ),
                                  const SizedBox(height: 14),
                                  _MapPanel(),
                                  const SizedBox(height: 14),
                                  _DriverDetailsPanel(driver: _selectedDriver),
                                ],
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      // ── Active Tasks Table ──
                      _ActiveTasksSection(
                        driver: _selectedDriver,
                        tasks: _tasks,
                        selectedTasks: _selectedTasks,
                        onToggleTask:
                            (i) => setState(() {
                              if (_selectedTasks.contains(i)) {
                                _selectedTasks.remove(i);
                              } else {
                                _selectedTasks.add(i);
                              }
                            }),
                        onToggleAll:
                            () => setState(() {
                              if (_selectedTasks.length == _tasks.length) {
                                _selectedTasks.clear();
                              } else {
                                _selectedTasks.addAll(
                                  List.generate(_tasks.length, (i) => i),
                                );
                              }
                            }),
                      ),
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

// ─────────────────────────────────────────────
// TOP BAR
// ─────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        color: kCardBg,
        border: Border(bottom: BorderSide(color: kDivider)),
      ),
      child: Row(
        children: [
          const Text(
            'Driver Monitoring',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: kTextDark,
              letterSpacing: 0.3,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.refresh, size: 16, color: Colors.white),
            label: const Text(
              'Refresh Data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ACTIVE DRIVERS PANEL
// ─────────────────────────────────────────────
class _ActiveDriversPanel extends StatelessWidget {
  final List<DriverModel> drivers;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final TextEditingController searchCtrl;

  const _ActiveDriversPanel({
    required this.drivers,
    required this.selectedIndex,
    required this.onSelect,
    required this.searchCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Active Drivers',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kTextDark,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kPrimary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '12 Online',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: kPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Search
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: kBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kDivider),
            ),
            child: TextField(
              controller: searchCtrl,
              style: const TextStyle(fontSize: 13, color: kTextDark),
              decoration: const InputDecoration(
                hintText: 'Search drivers...',
                hintStyle: TextStyle(fontSize: 13, color: kTextLight),
                prefixIcon: Icon(Icons.search, size: 18, color: kTextLight),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            drivers.length,
            (i) => _DriverListTile(
              driver: drivers[i],
              isSelected: i == selectedIndex,
              onTap: () {
                Get.toNamed('/driver/taskdetail');
              },
              // onTap: () => onSelect(i),
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverListTile extends StatelessWidget {
  final DriverModel driver;
  final bool isSelected;
  final VoidCallback onTap;
  const _DriverListTile({
    required this.driver,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected ? kPrimaryDark.withOpacity(0.06) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                isSelected ? kPrimaryDark.withOpacity(0.2) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: kPrimary.withOpacity(0.15),
              child: Text(
                driver.initials,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kPrimary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kTextDark,
                    ),
                  ),
                  Text(
                    'ID: ${driver.id}',
                    style: const TextStyle(fontSize: 11, color: kTextLight),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _StatusBadge(status: driver.status),
                const SizedBox(height: 4),
                Text(
                  '${driver.tasks} task${driver.tasks > 1 ? 's' : ''}',
                  style: const TextStyle(fontSize: 11, color: kTextLight),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MAP PANEL
// ─────────────────────────────────────────────
class _MapPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Driver Location Map',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: kTextDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Real-time driver positions and routes',
                  style: TextStyle(fontSize: 12, color: kTextLight),
                ),
              ],
            ),
          ),
          const Divider(color: kDivider, height: 1),
          // Map placeholder
          SizedBox(
            height: 310,
            child: Stack(
              children: [
                // Simulated map background
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEF2E6),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(14),
                    ),
                  ),
                  child: CustomPaint(
                    painter: _MapGridPainter(),
                    child: const SizedBox.expand(),
                  ),
                ),
                // Driver pins
                Positioned(
                  left: 140,
                  top: 100,
                  child: _MapPin(color: kStatusActive, label: 'JM'),
                ),
                Positioned(
                  left: 220,
                  top: 160,
                  child: _MapPin(color: kStatusEnRoute, label: 'DC'),
                ),
                Positioned(
                  left: 80,
                  top: 200,
                  child: _MapPin(color: kStatusActive, label: 'SW'),
                ),
                Positioned(
                  left: 300,
                  top: 80,
                  child: _MapPin(color: kStatusDelayed, label: 'MR'),
                ),
                // Legend
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kDivider),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _LegendItem(color: kStatusActive, label: 'Active (8)'),
                        SizedBox(height: 5),
                        _LegendItem(
                          color: kStatusEnRoute,
                          label: 'En Route (3)',
                        ),
                        SizedBox(height: 5),
                        _LegendItem(
                          color: kStatusDelayed,
                          label: 'Delayed (1)',
                        ),
                      ],
                    ),
                  ),
                ),
                // Fullscreen icon
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: kDivider),
                    ),
                    child: const Icon(
                      Icons.fullscreen,
                      size: 18,
                      color: kTextMid,
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
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: kTextDark)),
      ],
    );
  }
}

class _MapPin extends StatelessWidget {
  final Color color;
  final String label;
  const _MapPin({required this.color, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Container(width: 2, height: 8, color: color.withOpacity(0.6)),
      ],
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFD8DFD0)
          ..strokeWidth = 0.8;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Simulate roads
    final roadPaint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, 120), Offset(size.width, 150), roadPaint);
    canvas.drawLine(const Offset(180, 0), Offset(160, size.height), roadPaint);
    canvas.drawLine(const Offset(0, 220), Offset(size.width, 200), roadPaint);
    canvas.drawLine(const Offset(300, 0), Offset(320, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
// DRIVER DETAILS PANEL
// ─────────────────────────────────────────────
class _DriverDetailsPanel extends StatelessWidget {
  final DriverModel driver;
  const _DriverDetailsPanel({required this.driver});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Driver Details',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: kTextDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${driver.name} - ${driver.id}',
            style: const TextStyle(fontSize: 12, color: kTextLight),
          ),
          const SizedBox(height: 16),
          const Divider(color: kDivider, height: 1),
          const SizedBox(height: 14),
          _DetailRow(
            label: 'Current Status:',
            value: '',
            widget: _StatusBadge(status: driver.status),
          ),
          _DetailRow(label: 'Vehicle:', value: 'Honda CRV - ABC123'),
          _DetailRow(label: 'Last Update:', value: '2 mins ago'),
          _DetailRow(label: 'Total Deliveries:', value: '847'),
          _DetailRow(
            label: 'Rating:',
            value: '',
            widget: Row(
              children: [
                const Text(
                  '4.8',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kTextDark,
                  ),
                ),
                const SizedBox(width: 6),
                Row(
                  children: List.generate(
                    5,
                    (i) => const Icon(Icons.star, size: 14, color: kPrimary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: kDivider, height: 1),
          const SizedBox(height: 14),
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kTextDark,
            ),
          ),
          const SizedBox(height: 12),
          _QuickActionBtn(
            icon: Icons.phone_outlined,
            label: 'Contact Driver',
            color: kPrimaryDark,
          ),
          const SizedBox(height: 8),
          _QuickActionBtn(
            icon: Icons.warning_amber_outlined,
            label: 'Mark as Delayed',
            color: kPrimaryDark,
          ),
          const SizedBox(height: 8),
          _QuickActionBtn(
            icon: Icons.cancel_outlined,
            label: 'Force Failed Delivery',
            color: kPrimaryDark,
          ),
          const SizedBox(height: 8),
          _QuickActionBtn(
            icon: Icons.pause_circle_outline,
            label: 'Set Offline',
            color: kPrimaryDark,
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? widget;
  const _DetailRow({required this.label, required this.value, this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: kTextMid),
            ),
          ),
          Expanded(
            flex: 5,
            child:
                widget ??
                Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kTextDark,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _QuickActionBtn({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 15, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ACTIVE TASKS SECTION
// ─────────────────────────────────────────────
class _ActiveTasksSection extends StatelessWidget {
  final DriverModel driver;
  final List<TaskModel> tasks;
  final Set<int> selectedTasks;
  final ValueChanged<int> onToggleTask;
  final VoidCallback onToggleAll;

  const _ActiveTasksSection({
    required this.driver,
    required this.tasks,
    required this.selectedTasks,
    required this.onToggleTask,
    required this.onToggleAll,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                'Active Tasks - ${driver.name}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kTextDark,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check, size: 14, color: Colors.white),
                label: const Text(
                  'Mark Complete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryDark,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.close, size: 14, color: Colors.white),
                label: const Text(
                  'Force Fail',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Table
          _TaskTable(
            tasks: tasks,
            selectedTasks: selectedTasks,
            onToggleTask: onToggleTask,
            onToggleAll: onToggleAll,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TASK TABLE
// ─────────────────────────────────────────────
class _TaskTable extends StatelessWidget {
  final List<TaskModel> tasks;
  final Set<int> selectedTasks;
  final ValueChanged<int> onToggleTask;
  final VoidCallback onToggleAll;

  const _TaskTable({
    required this.tasks,
    required this.selectedTasks,
    required this.onToggleTask,
    required this.onToggleAll,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final isWide = constraints.maxWidth > 700;
        if (!isWide) return _MobileTaskList(tasks: tasks);

        return Column(
          children: [
            // Header row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: kBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 26,
                    child: Checkbox(
                      value:
                          selectedTasks.length == tasks.length &&
                          tasks.isNotEmpty,
                      onChanged: (_) => onToggleAll(),
                      fillColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.orange.withValues(alpha: .32);
                        }
                        return LeftBarTheme
                            .lightLeftBarTheme
                            .activeItemBackground;
                      }),
                      activeColor: kPrimary,
                      side: const BorderSide(color: kDivider),
                    ),
                  ),
                  _HeaderCell('Order ID', flex: 3),
                  _HeaderCell('Customer', flex: 4),
                  _HeaderCell('Delivery Address', flex: 5),
                  _HeaderCell('Status', flex: 3),
                  _HeaderCell('Priority', flex: 2),
                  _HeaderCell('ETA', flex: 2),
                  _HeaderCell('Actions', flex: 2),
                ],
              ),
            ),
            const SizedBox(height: 4),
            ...List.generate(tasks.length, (i) {
              final t = tasks[i];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color:
                      selectedTasks.contains(i)
                          ? kPrimary.withOpacity(0.05)
                          : kCardBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        selectedTasks.contains(i)
                            ? kPrimary.withOpacity(0.2)
                            : kDivider,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 32,
                      child: Checkbox(
                        value: selectedTasks.contains(i),
                        onChanged: (_) => onToggleTask(i),
                        activeColor: kPrimary,
                        side: const BorderSide(color: kDivider),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        t.orderId,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: kPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Align(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.customer,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kTextDark,
                              ),
                            ),
                            Text(
                              t.phone,
                              style: const TextStyle(
                                fontSize: 11,
                                color: kTextLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                        child: Text(
                          t.address,
                          style: const TextStyle(fontSize: 12, color: kTextMid),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: _TaskStatusBadge(status: t.status),
                    ),
                    Expanded(
                      flex: 2,
                      child: _PriorityBadge(priority: t.priority),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        child: Text(
                          t.eta,
                          style: const TextStyle(
                            fontSize: 12,
                            color: kTextDark,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _IconBtn(
                            icon: Icons.remove_red_eye_outlined,
                            color: kTextMid,
                            onTap: () {
                              Get.toNamed("/driver/profile");
                            },
                          ),
                          _IconBtn(
                            icon: Icons.check,
                            color: kStatusActive,
                            onTap: () {},
                          ),
                          _IconBtn(
                            icon: Icons.close,
                            color: kStatusDelayed,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final int flex;
  const _HeaderCell(this.label, {required this.flex});
  @override
  Widget build(BuildContext context) => Expanded(
    flex: flex,
    child: Align(
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: kTextMid,
          letterSpacing: 0.3,
        ),
      ),
    ),
  );
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _IconBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Icon(icon, size: 16, color: color),
    ),
  );
}

// Mobile fallback
class _MobileTaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  const _MobileTaskList({required this.tasks});
  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          tasks.map((t) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kCardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kDivider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        t.orderId,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: kPrimary,
                        ),
                      ),
                      const Spacer(),
                      _TaskStatusBadge(status: t.status),
                      const SizedBox(width: 6),
                      _PriorityBadge(priority: t.priority),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.customer,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kTextDark,
                    ),
                  ),
                  Text(
                    t.phone,
                    style: const TextStyle(fontSize: 11, color: kTextLight),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t.address,
                    style: const TextStyle(fontSize: 12, color: kTextMid),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'ETA: ${t.eta}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kTextDark,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}

// ─────────────────────────────────────────────
// BADGE WIDGETS
// ─────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final DriverStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    String label;
    Color bg, text, dot;
    switch (status) {
      case DriverStatus.active:
        label = 'Active';
        bg = kBadgeActiveBg;
        text = kBadgeActiveText;
        dot = kStatusActive;
        break;
      case DriverStatus.enRoute:
        label = 'En Route';
        bg = kBadgeEnRouteBg;
        text = kBadgeEnRouteText;
        dot = kStatusEnRoute;
        break;
      case DriverStatus.delayed:
        label = 'Delayed';
        bg = kBadgeDelayedBg;
        text = kBadgeDelayedText;
        dot = kStatusDelayed;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: text,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskStatusBadge extends StatelessWidget {
  final String status;
  const _TaskStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg, text;
    switch (status) {
      case 'In Transit':
        bg = kBadgeEnRouteBg;
        text = kBadgeEnRouteText;
        break;
      case 'Picked Up':
        bg = const Color(0xFFE3F2FD);
        text = const Color(0xFF1565C0);
        break;
      default:
        bg = const Color(0xFFF3F3F3);
        text = kTextMid;
    }
    return Align(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: text,
          ),
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String priority;
  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color bg, text;
    switch (priority) {
      case 'High':
        bg = kPriorityHighBg;
        text = kPriorityHighText;
        break;
      case 'Medium':
        bg = kPriorityMedBg;
        text = kPriorityMedText;
        break;
      default:
        bg = kPriorityLowBg;
        text = kPriorityLowText;
    }
    return Align(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          priority,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: text,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE CARD
// ─────────────────────────────────────────────
class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const _Card({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kDivider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
