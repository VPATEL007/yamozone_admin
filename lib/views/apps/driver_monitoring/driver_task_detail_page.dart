import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/views/layouts/layout.dart';

// ─── Color palette (matches screenshots) ────────────────────────────────────
const kGold = Color(0xFFC9A84C);
const kGoldLight = Color(0xFFF5EDD5);
const kGoldBorder = Color(0xFFE8D5A3);
const kBg = Color(0xFFFAF8F3);
const kSidebar = Color(0xFF1A1A1A);
const kSidebarActive = Color(0xFF2D5016);
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF666666);
const kSuccess = Color(0xFF4CAF50);
const kPending = Color(0xFFF5A623);
const kDanger = Color(0xFFE53E3E);
const kInfo = Color(0xFF2196F3);
const kCardBg = Color(0xFFFFFFFF);

// ─── Data models ─────────────────────────────────────────────────────────────
class TaskStop {
  final String label;
  final String address;
  final String time;
  final StopStatus status;
  const TaskStop({
    required this.label,
    required this.address,
    required this.time,
    required this.status,
  });
}

enum StopStatus { completed, active, pending }

enum TaskStatus { inProgress, completed, cancelled, assigned }

// ─── Main Page ────────────────────────────────────────────────────────────────
class DriverTaskDetailPage extends StatelessWidget {
  const DriverTaskDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: _MainContent(),
        ),
      ),
    );
  }
}

// ─── Sidebar ──────────────────────────────────────────────────────────────────

// ─── Main Content ─────────────────────────────────────────────────────────────
class _MainContent extends StatelessWidget {
  const _MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map texture background (subtle)
        Positioned.fill(child: CustomPaint(painter: _MapTexturePainter())),
        // Scrollable content
        SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _PageHeader(),
              const SizedBox(height: 24),
              // Top row: Task Info + Status Timeline
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _TaskInfoCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: _TaskStatusCard()),
                ],
              ),
              const SizedBox(height: 16),
              // Middle row: Route + Earnings
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _RouteStopsCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: _EarningsCard()),
                ],
              ),
              const SizedBox(height: 16),
              // Bottom row: Customer Info + Activity Log
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _CustomerInfoCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 3, child: _ActivityLogCard()),
                ],
              ),
              const SizedBox(height: 16),
              // Action Bar
              _ActionBar(),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Page Header ─────────────────────────────────────────────────────────────
class _PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kCardBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kGoldBorder),
            ),
            child: const Icon(Icons.arrow_back, size: 18, color: kTextPrimary),
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Detail',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kTextPrimary,
              ),
            ),
            Text(
              'Driver Monitoring  ›  Rajesh Kumar  ›  Task #TK-2024-0892',
              style: TextStyle(fontSize: 12, color: kTextSecondary),
            ),
          ],
        ),
        const Spacer(),
        _StatusBadge(label: 'In Progress', color: kInfo),
      ],
    );
  }
}

// ─── Task Info Card ───────────────────────────────────────────────────────────
class _TaskInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.assignment_rounded, title: 'Task Information'),
          const SizedBox(height: 16),
          // Driver row
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: kGoldLight,
                child: const Icon(Icons.person, color: kGold, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rajesh Kumar',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'DRV001234  •  Auto Rickshaw',
                    style: TextStyle(fontSize: 12, color: kTextSecondary),
                  ),
                  Text(
                    'MH 12 AB 1234',
                    style: TextStyle(
                      fontSize: 11,
                      color: kGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 24, color: kGoldBorder),
          // Task meta grid
          _InfoGrid(
            items: const [
              ('Task ID', 'TK-2024-0892'),
              ('Task Type', 'Delivery'),
              ('Assigned At', '10 Jan 2024, 09:15 AM'),
              ('Started At', '10 Jan 2024, 09:32 AM'),
              ('Est. Completion', '10 Jan 2024, 11:00 AM'),
              ('Priority', 'High'),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Task Status Card ─────────────────────────────────────────────────────────
class _TaskStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steps = [
      ('Task Assigned', '09:15 AM', true, false),
      ('Driver Accepted', '09:18 AM', true, false),
      ('Picked Up', '09:45 AM', true, false),
      ('In Transit', '10:02 AM', true, true),
      ('Delivered', '--', false, false),
      ('Completed', '--', false, false),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.timeline_rounded, title: 'Task Progress'),
          const SizedBox(height: 20),
          ...steps.asMap().entries.map((e) {
            final idx = e.key;
            final s = e.value;
            final isLast = idx == steps.length - 1;
            return _TimelineStep(
              label: s.$1,
              time: s.$2,
              isDone: s.$3,
              isActive: s.$4,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final String label;
  final String time;
  final bool isDone;
  final bool isActive;
  final bool isLast;
  const _TimelineStep({
    required this.label,
    required this.time,
    required this.isDone,
    required this.isActive,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    Color dotColor =
        isDone
            ? kSuccess
            : isActive
            ? kGold
            : const Color(0xFFDDDDDD);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dot + line
        Column(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor,
                border: isActive ? Border.all(color: kGold, width: 2.5) : null,
              ),
              child:
                  isDone
                      ? const Icon(Icons.check, size: 11, color: Colors.white)
                      : isActive
                      ? const Icon(Icons.circle, size: 8, color: Colors.white)
                      : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 28,
                color:
                    isDone
                        ? kSuccess.withOpacity(0.3)
                        : const Color(0xFFEEEEEE),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isDone || isActive ? kTextPrimary : kTextSecondary,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 11, color: kTextSecondary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Route Stops Card ─────────────────────────────────────────────────────────
class _RouteStopsCard extends StatelessWidget {
  final stops = const [
    TaskStop(
      label: 'Pickup',
      address: 'Bandra Station, Mumbai – Platform 2',
      time: '09:32 AM',
      status: StopStatus.completed,
    ),
    TaskStop(
      label: 'Stop 1',
      address: 'Linking Road, Bandra West',
      time: '09:52 AM',
      status: StopStatus.completed,
    ),
    TaskStop(
      label: 'Stop 2',
      address: 'Juhu Beach Road, Near Hotel Sun-n-Sand',
      time: '10:18 AM',
      status: StopStatus.active,
    ),
    TaskStop(
      label: 'Drop',
      address: 'Andheri East, MIDC – Gate No. 3',
      time: 'Est. 10:50 AM',
      status: StopStatus.pending,
    ),
  ];

  const _RouteStopsCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CardTitle(icon: Icons.route_rounded, title: 'Route & Stops'),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kGoldLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kGoldBorder),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.straighten, size: 12, color: kGold),
                    SizedBox(width: 4),
                    Text(
                      '12.4 km',
                      style: TextStyle(
                        fontSize: 11,
                        color: kGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...stops.asMap().entries.map((e) {
            return _RouteStopRow(
              stop: e.value,
              isLast: e.key == stops.length - 1,
            );
          }),
        ],
      ),
    );
  }
}

class _RouteStopRow extends StatelessWidget {
  final TaskStop stop;
  final bool isLast;
  const _RouteStopRow({required this.stop, required this.isLast});

  @override
  Widget build(BuildContext context) {
    Color dotColor;
    IconData dotIcon;
    Color textColor;

    switch (stop.status) {
      case StopStatus.completed:
        dotColor = kSuccess;
        dotIcon = Icons.check_circle_rounded;
        textColor = kTextSecondary;
        break;
      case StopStatus.active:
        dotColor = kGold;
        dotIcon = Icons.location_on_rounded;
        textColor = kTextPrimary;
        break;
      case StopStatus.pending:
        dotColor = const Color(0xFFCCCCCC);
        dotIcon = Icons.radio_button_unchecked_rounded;
        textColor = kTextSecondary;
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(dotIcon, color: dotColor, size: 22),
            if (!isLast) Container(width: 2, height: 36, color: kGoldBorder),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color:
                              stop.status == StopStatus.active
                                  ? kGoldLight
                                  : const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          stop.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color:
                                stop.status == StopStatus.active
                                    ? kGold
                                    : kTextSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stop.address,
                        style: TextStyle(fontSize: 12.5, color: textColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  stop.time,
                  style: TextStyle(fontSize: 11, color: kTextSecondary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Earnings Card ────────────────────────────────────────────────────────────
class _EarningsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.payments_rounded, title: 'Task Earnings'),
          const SizedBox(height: 16),
          // Total earning highlight
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF5EDD5), Color(0xFFEDD9A3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kGoldBorder),
            ),
            child: Column(
              children: const [
                Text(
                  'Total Payout',
                  style: TextStyle(fontSize: 12, color: kTextSecondary),
                ),
                SizedBox(height: 4),
                Text(
                  '₹ 820',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: kTextPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Pending Release',
                  style: TextStyle(fontSize: 11, color: kPending),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _EarningRow(label: 'Base Fare', amount: '₹ 500'),
          _EarningRow(label: 'Distance Bonus', amount: '₹ 120'),
          _EarningRow(label: 'Peak Hour Bonus', amount: '₹ 150'),
          _EarningRow(
            label: 'Platform Fee (−)',
            amount: '− ₹ 50',
            isDeduction: true,
          ),
          const Divider(color: kGoldBorder, height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Net Earnings',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹ 820',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: kSuccess,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EarningRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isDeduction;
  const _EarningRow({
    required this.label,
    required this.amount,
    this.isDeduction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12.5, color: kTextSecondary)),
          Text(
            amount,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: isDeduction ? kDanger : kTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Customer Info Card ───────────────────────────────────────────────────────
class _CustomerInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.person_pin_rounded, title: 'Customer Details'),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: kGoldLight,
                child: const Icon(Icons.person, color: kGold),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Priya Sharma',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    'USR-8821',
                    style: TextStyle(fontSize: 11, color: kTextSecondary),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 20, color: kGoldBorder),
          _InfoRow(icon: Icons.phone, label: '+91 98765 43210'),
          const SizedBox(height: 8),
          _InfoRow(icon: Icons.email, label: 'priya.sharma@email.com'),
          const SizedBox(height: 8),
          _InfoRow(icon: Icons.star_rounded, label: '4.8 Rating  •  23 Trips'),
          const Divider(height: 20, color: kGoldBorder),
          // Proof of delivery
          _CardTitle(
            icon: Icons.photo_camera_rounded,
            title: 'Proof of Delivery',
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _ProofThumb(icon: Icons.image, label: 'Photo 1'),
              const SizedBox(width: 10),
              _ProofThumb(icon: Icons.image, label: 'Photo 2'),
              const SizedBox(width: 10),
              _ProofThumb(icon: Icons.image, label: 'Signature'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProofThumb extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ProofThumb({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: kGoldLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kGoldBorder),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: kGold, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 9, color: kTextSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: kGold),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12.5, color: kTextPrimary),
        ),
      ],
    );
  }
}

// ─── Activity Log Card ────────────────────────────────────────────────────────
class _ActivityLogCard extends StatelessWidget {
  final logs = const [
    (
      '09:15 AM',
      'Task #TK-2024-0892 created and assigned to Rajesh Kumar',
      Icons.assignment_ind_rounded,
      kGold,
    ),
    (
      '09:18 AM',
      'Driver accepted the task',
      Icons.check_circle_outline,
      kSuccess,
    ),
    (
      '09:32 AM',
      'Driver arrived at pickup location – Bandra Station',
      Icons.location_on_outlined,
      kInfo,
    ),
    (
      '09:45 AM',
      'Package picked up and delivery started',
      Icons.inventory_2_outlined,
      kGold,
    ),
    (
      '09:52 AM',
      'Stop 1 completed – Linking Road, Bandra West',
      Icons.done_all_rounded,
      kSuccess,
    ),
    (
      '10:02 AM',
      'Driver currently en route to Stop 2',
      Icons.directions_rounded,
      kInfo,
    ),
    (
      '10:08 AM',
      'Customer sent a message: "Please call on arrival"',
      Icons.chat_bubble_outline,
      kPending,
    ),
  ];

  const _ActivityLogCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CardTitle(icon: Icons.history_rounded, title: 'Activity Log'),
              const Spacer(),
              _GoldBadge(label: '7 events'),
            ],
          ),
          const SizedBox(height: 16),
          ...logs.asMap().entries.map((e) {
            final isLast = e.key == logs.length - 1;
            final log = e.value;
            return _ActivityLogRow(
              time: log.$1,
              description: log.$2,
              icon: log.$3,
              color: log.$4,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }
}

class _ActivityLogRow extends StatelessWidget {
  final String time;
  final String description;
  final IconData icon;
  final Color color;
  final bool isLast;

  const _ActivityLogRow({
    required this.time,
    required this.description,
    required this.icon,
    required this.color,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon column
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 15, color: color),
            ),
            if (!isLast) Container(width: 1.5, height: 28, color: kGoldBorder),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 10, color: kTextSecondary),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12.5, color: kTextPrimary),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Action Bar ───────────────────────────────────────────────────────────────
class _ActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGoldBorder),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.admin_panel_settings_rounded,
            color: kGold,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            'Admin Actions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: kTextPrimary,
            ),
          ),
          const Spacer(),
          _ActionButton(
            label: 'Reassign Driver',
            icon: Icons.swap_horiz_rounded,
            style: _ButtonStyle.outline,
          ),
          const SizedBox(width: 10),
          _ActionButton(
            label: 'Cancel Task',
            icon: Icons.cancel_outlined,
            style: _ButtonStyle.danger,
          ),
          const SizedBox(width: 10),
          _ActionButton(
            label: 'Force Complete',
            icon: Icons.check_circle_rounded,
            style: _ButtonStyle.gold,
          ),
          const SizedBox(width: 10),
          _ActionButton(
            label: 'Export Details',
            icon: Icons.download_rounded,
            style: _ButtonStyle.outline,
          ),
        ],
      ),
    );
  }
}

enum _ButtonStyle { gold, outline, danger }

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final _ButtonStyle style;
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    Color bg, fg, border;
    switch (style) {
      case _ButtonStyle.gold:
        bg = kGold;
        fg = Colors.white;
        border = kGold;
        break;
      case _ButtonStyle.danger:
        bg = kDanger.withOpacity(0.1);
        fg = kDanger;
        border = kDanger.withOpacity(0.4);
        break;
      case _ButtonStyle.outline:
        bg = Colors.transparent;
        fg = kTextPrimary;
        border = kGoldBorder;
        break;
    }

    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 14, color: fg),
      label: Text(
        label,
        style: TextStyle(fontSize: 12, color: fg, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        elevation: 0,
        side: BorderSide(color: border),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// ─── Reusable widgets ─────────────────────────────────────────────────────────
class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardBg.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGoldBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CardTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const _CardTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: kGold),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kTextPrimary,
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoldBadge extends StatelessWidget {
  final String label;
  const _GoldBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: kGoldLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kGoldBorder),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: kGold,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final List<(String, String)> items;
  const _InfoGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children:
          items.map((item) {
            return SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.$1,
                    style: TextStyle(fontSize: 11, color: kTextSecondary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.$2,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}

// ─── Map Texture Background Painter ──────────────────────────────────────────
class _MapTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = kGold.withOpacity(0.04)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    // Horizontal grid lines
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical grid lines
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Diagonal accent lines (like map roads)
    final roadPaint =
        Paint()
          ..color = kGold.withOpacity(0.06)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;

    canvas.drawLine(
      const Offset(0, 200),
      Offset(size.width * 0.6, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width, size.height * 0.7),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width, size.height * 0.4),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
