import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yamazone/helpers/theme/admin_theme.dart';
import 'package:yamazone/views/layouts/layout.dart';

// ─────────────────────────────────────────────
// COLORS & THEME
// ─────────────────────────────────────────────
const kPrimary = Color(0xFF1B5E20); // dark green
const kPrimaryLight = Color(0xFF2E7D32);
const kAccentGold = Color(0xFFD4A017);
const kBgPage = Color(0xFFF5F5F0);
const kCardBg = Colors.white;
const kBorder = Color(0xFFE0E0E0);
const kTextDark = Color(0xFF1A1A1A);
const kTextMed = Color(0xFF555555);
const kTextLight = Color(0xFF999999);
const kGreen = Color(0xFF2E7D32);
const kRed = Color(0xFFD32F2F);
const kTagActive = Color(0xFFE8F5E9);
const kTagActiveText = Color(0xFF2E7D32);
const kTagBlocked = Color(0xFFFFEBEE);
const kTagBlockedText = Color(0xFFD32F2F);

// ─────────────────────────────────────────────
// DASHBOARD SCREEN  (wraps Drawer + Body)
// ─────────────────────────────────────────────
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: kBgPage,
        body: Layout(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: DashboardBody(),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DASHBOARD BODY
// ─────────────────────────────────────────────
class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── TOP BAR ──
        _TopBar(),
        // ── SCROLLABLE CONTENT ──
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Dashboard Overview',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kTextDark,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Monitor your marketplace performance',
                  style: TextStyle(fontSize: 13, color: kTextLight),
                ),
                const SizedBox(height: 20),

                // ── STAT CARDS ──
                _StatCardsRow(),
                const SizedBox(height: 24),

                // ── CHARTS ROW ──
                _ChartsRow(),
                const SizedBox(height: 24),

                // ── BOTTOM TABLES ──
                _BottomSection(),
              ],
            ),
          ),
        ),
      ],
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
      height: 60,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Date Range Dropdown
          _DropdownChip(label: 'Date Range'),
          const SizedBox(width: 12),
          // City Dropdown
          _DropdownChip(label: 'City / Neighborhood'),
          const Spacer(),
          // Search
          Container(
            width: 200,
            height: 36,
            decoration: BoxDecoration(
              color: kBgPage,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kBorder),
            ),
            child: const Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.search, size: 16, color: kTextLight),
                SizedBox(width: 6),
                Text(
                  'Search...',
                  style: TextStyle(color: kTextLight, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DropdownChip extends StatelessWidget {
  final String label;
  const _DropdownChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: kBgPage,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: kTextDark)),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: kTextMed),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// STAT CARDS ROW
// ─────────────────────────────────────────────
class _StatCardsRow extends StatelessWidget {
  final List<_StatData> stats = const [
    _StatData(Icons.people_alt, 'Total Users', '24,583', '+12%', true),
    _StatData(Icons.storefront, 'Sellers', '3,247', '+8%', true),
    _StatData(Icons.local_shipping, 'Drivers', '1,892', '+15%', true),
    _StatData(Icons.shopping_bag, 'Orders', '18,429', '+23%', false),
    _StatData(Icons.attach_money, 'Revenue', '\$847K', '+18%', false),
    _StatData(Icons.gavel, 'Disputes', '47', '+5', false),
    _StatData(
      Icons.badge_outlined,
      'KYC Pending',
      '12',
      'Pending\nrequests',
      false,
    ),
    // _StatData(
    //     Icons.location_city, 'Ahmedabad', '(Highest Orders)', 'Top City', true),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            stats
                .map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _StatCard(data: s),
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _StatData {
  final IconData icon;
  final String label;
  final String value;
  final String badge;
  final bool badgeGold;
  const _StatData(
    this.icon,
    this.label,
    this.value,
    this.badge,
    this.badgeGold,
  );
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.11,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(data.icon, size: 18, color: kAccentGold),
              ),
              Text(
                data.badge,
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: ContentTheme.lightContentTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.label,
                    style: const TextStyle(fontSize: 11, color: kTextLight),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.value,
                    style: TextStyle(
                      fontSize: data.value == "(Highest Orders)" ? 13 : 18,
                      fontWeight: FontWeight.bold,
                      color: kTextDark,
                    ),
                  ),
                ],
              ),
              Visibility(visible: data.badgeGold, child: Spacer()),
              Visibility(
                visible: data.badgeGold,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top City",
                      style: const TextStyle(fontSize: 11, color: kTextLight),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "California",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kTextDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CHARTS ROW
// ─────────────────────────────────────────────
class _ChartsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ChartCard(
            title: 'Orders per Day',
            child: _BarChartPlaceholder(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ChartCard(
            title: 'New Users Growth',
            child: _LineChartPlaceholder(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ChartCard(
            title: 'Dispute Rate (%)',
            child: _AreaChartPlaceholder(),
          ),
        ),
      ],
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _ChartCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: kTextDark,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// Simple bar chart using CustomPainter
class _BarChartPlaceholder extends StatelessWidget {
  const _BarChartPlaceholder();
  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _BarPainter(), child: const SizedBox.expand());
}

class _BarPainter extends CustomPainter {
  final List<double> values = const [
    0.4,
    0.65,
    0.5,
    0.8,
    0.6,
    0.75,
    0.9,
    0.55,
    0.7,
    0.85,
    0.6,
    0.45,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = kPrimary.withOpacity(0.7);
    final highlightPaint = Paint()..color = kPrimary;
    final w = size.width / (values.length * 1.6);
    final gap = w * 0.6;
    for (int i = 0; i < values.length; i++) {
      final x = i * (w + gap);
      final h = size.height * values[i];
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, size.height - h, w, h),
        const Radius.circular(4),
      );
      canvas.drawRRect(rect, i == 7 ? highlightPaint : paint);
    }
    // X-axis labels
    final tp = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < values.length; i++) {
      tp.text = TextSpan(
        text: '${i + 1}',
        style: const TextStyle(fontSize: 8, color: kTextLight),
      );
      tp.layout();
      tp.paint(canvas, Offset(i * (w + gap), size.height + 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple line chart using CustomPainter
class _LineChartPlaceholder extends StatelessWidget {
  const _LineChartPlaceholder();
  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _LinePainter(), child: const SizedBox.expand());
}

class _LinePainter extends CustomPainter {
  final List<double> values = const [
    0.3,
    0.45,
    0.4,
    0.55,
    0.5,
    0.65,
    0.6,
    0.75,
    0.7,
    0.85,
    0.8,
    0.9,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = kPrimary
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke;

    final fillPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [kPrimary.withOpacity(0.3), kPrimary.withOpacity(0.0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final fillPath = Path();
    final step = size.width / (values.length - 1);

    for (int i = 0; i < values.length; i++) {
      final x = i * step;
      final y = size.height - size.height * values[i];
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    fillPath.lineTo((values.length - 1) * step, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Dots
    final dotPaint = Paint()..color = kPrimary;
    for (int i = 0; i < values.length; i++) {
      canvas.drawCircle(
        Offset(i * step, size.height - size.height * values[i]),
        3,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple area chart with stepped data
class _AreaChartPlaceholder extends StatelessWidget {
  const _AreaChartPlaceholder();
  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _AreaPainter(), child: const SizedBox.expand());
}

class _AreaPainter extends CustomPainter {
  final List<double> values = const [
    0.6,
    0.55,
    0.7,
    0.5,
    0.65,
    0.4,
    0.55,
    0.45,
    0.5,
    0.35,
    0.4,
    0.3,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = kAccentGold
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke;

    final fillPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [
              kAccentGold.withOpacity(0.4),
              kAccentGold.withOpacity(0.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final fillPath = Path();
    final step = size.width / (values.length - 1);

    for (int i = 0; i < values.length; i++) {
      final x = i * step;
      final y = size.height - size.height * values[i];
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    fillPath.lineTo((values.length - 1) * step, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
// BOTTOM SECTION: User Management + KYC
// ─────────────────────────────────────────────
class _BottomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _UserManagementCard()),
        const SizedBox(width: 16),
        Expanded(flex: 2, child: _KycApprovalsCard()),
      ],
    );
  }
}

// ── USER MANAGEMENT TABLE ──
class _UserManagementCard extends StatefulWidget {
  @override
  State<_UserManagementCard> createState() => _UserManagementCardState();
}

class _UserManagementCardState extends State<_UserManagementCard> {
  int _tabIndex = 0;
  final List<String> _tabs = ['All', 'Buyers', 'Sellers', 'Drivers'];

  final List<_UserRow> _users = const [
    _UserRow('Sarah Johnson', 'Buyer • ID: #12847', 'Active', false),
    _UserRow('Michael Chen', 'Seller • ID: #12846', 'Active', false),
    _UserRow('David Martinez', 'Driver • ID: #12845', 'Blocked', true),
    _UserRow('Emma Wilson', 'Buyer • ID: #12844', 'Active', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'User Management',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kTextDark,
                ),
              ),
              // ElevatedButton.icon(
              //   onPressed: () {},
              //   icon: const Icon(Icons.add, size: 14),
              //   label: const Text('Add User', style: TextStyle(fontSize: 13)),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: kPrimary,
              //     foregroundColor: Colors.white,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 14,
              //       vertical: 8,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 12),

          // Search
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: kBgPage,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kBorder),
            ),
            child: const Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.search, size: 16, color: kTextLight),
                SizedBox(width: 6),
                Text(
                  'Search users...',
                  style: TextStyle(color: kTextLight, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Tabs
          Row(
            children: List.generate(_tabs.length, (i) {
              final selected = _tabIndex == i;
              return GestureDetector(
                onTap: () => setState(() => _tabIndex = i),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? kPrimary : kBgPage,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selected ? kPrimary : kBorder),
                  ),
                  child: Text(
                    _tabs[i],
                    style: TextStyle(
                      fontSize: 12,
                      color: selected ? Colors.white : kTextMed,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),

          // Users List
          ..._users.map((u) => _UserTile(user: u)),
        ],
      ),
    );
  }
}

class _UserRow {
  final String name;
  final String subtitle;
  final String status;
  final bool blocked;
  const _UserRow(this.name, this.subtitle, this.status, this.blocked);
}

class _UserTile extends StatelessWidget {
  final _UserRow user;
  const _UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: user.blocked ? const Color(0xFFFFCDD2) : kBorder,
            child: Text(
              user.name[0],
              style: TextStyle(
                color: user.blocked ? kRed : kTextMed,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Name & subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: kTextDark,
                  ),
                ),
                Text(
                  user.subtitle,
                  style: const TextStyle(fontSize: 11, color: kTextLight),
                ),
              ],
            ),
          ),
          // Status chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: user.blocked ? kTagBlocked : kTagActive,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              user.status,
              style: TextStyle(
                fontSize: 11,
                color: user.blocked ? kTagBlockedText : kTagActiveText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Actions
          Icon(Icons.vpn_key_outlined, size: 16, color: kAccentGold),
          const SizedBox(width: 8),
          Icon(Icons.more_vert, size: 16, color: kTextLight),
        ],
      ),
    );
  }
}

// ── KYC APPROVALS CARD ──
class _KycApprovalsCard extends StatefulWidget {
  @override
  State<_KycApprovalsCard> createState() => _KycApprovalsCardState();
}

class _KycApprovalsCardState extends State<_KycApprovalsCard> {
  int _tab = 0;

  final List<_KycEntry> _entries = const [
    _KycEntry('James Anderson', 'Seller • Submitted 2h ago'),
    _KycEntry('Lisa Thompson', 'Seller • Submitted 5h ago'),
    _KycEntry('Robert Garcia', 'Seller • Submitted 1d ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'KYC Approvals',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kTextDark,
                ),
              ),
              Row(
                children: [
                  _KycTab(
                    label: 'Sellers',
                    active: _tab == 0,
                    onTap: () => setState(() => _tab = 0),
                  ),
                  const SizedBox(width: 6),
                  _KycTab(
                    label: 'Drivers',
                    active: _tab == 1,
                    onTap: () => setState(() => _tab = 1),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            '12 pending verifications',
            style: TextStyle(fontSize: 12, color: kTextLight),
          ),
          const SizedBox(height: 14),

          // KYC Entries
          ..._entries.map((e) => _KycTile(entry: e)),
        ],
      ),
    );
  }
}

class _KycEntry {
  final String name;
  final String subtitle;
  const _KycEntry(this.name, this.subtitle);
}

class _KycTab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _KycTab({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? kPrimary : kBgPage,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: active ? kPrimary : kBorder),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: active ? Colors.white : kTextMed,
            fontWeight: active ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _KycTile extends StatelessWidget {
  final _KycEntry entry;
  const _KycTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: kBorder,
                child: Text(
                  entry.name[0],
                  style: const TextStyle(
                    color: kTextMed,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: kTextDark,
                    ),
                  ),
                  Text(
                    entry.subtitle,
                    style: const TextStyle(fontSize: 11, color: kTextLight),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check, size: 14),
                  label: const Text('Approve', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.close, size: 14),
                  label: const Text('Reject', style: TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kRed,
                    side: const BorderSide(color: kBorder),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xFFFFF8E1),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kBorder),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 16,
                  color: kAccentGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
