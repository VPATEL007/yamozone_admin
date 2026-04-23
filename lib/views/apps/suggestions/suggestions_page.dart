import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:yamazone/views/layouts/layout.dart';

// ─── Data Models ─────────────────────────────────────────────────────────────

class Suggestion {
  final String id;
  final String title;
  final String source;
  final String target;
  final String priority;
  final String status;
  final int votes;
  final String createdAt;
  final bool anonymous;

  const Suggestion({
    required this.id,
    required this.title,
    required this.source,
    required this.target,
    required this.priority,
    required this.status,
    required this.votes,
    required this.createdAt,
    this.anonymous = false,
  });
}

const _suggestions = [
  Suggestion(
    id: 'SUG-2024-124',
    title: 'Add dark mode for the mobile app',
    source: 'Employee',
    target: 'Employees',
    priority: 'Medium',
    status: 'New',
    votes: 42,
    createdAt: '2h ago',
  ),
  Suggestion(
    id: 'SUG-2024-123',
    title: 'More payment methods (Mobile Money)',
    source: 'User',
    target: 'Users',
    priority: 'High',
    status: 'In Progress',
    votes: 89,
    createdAt: '5h ago',
  ),
  Suggestion(
    id: 'SUG-2024-122',
    title: 'Improve delivery tracking accuracy',
    source: 'User',
    target: 'Users',
    priority: 'High',
    status: 'In Progress',
    votes: 76,
    createdAt: '1d ago',
  ),
  Suggestion(
    id: 'SUG-2024-121',
    title: 'Allow scheduling orders in advance',
    source: 'Employee',
    target: 'Users',
    priority: 'Medium',
    status: 'New',
    votes: 35,
    createdAt: '1d ago',
  ),
  Suggestion(
    id: 'SUG-2024-120',
    title: 'Better search with filters by price range',
    source: 'User',
    target: 'Users',
    priority: 'Medium',
    status: 'Resolved',
    votes: 63,
    createdAt: '2d ago',
  ),
  Suggestion(
    id: 'SUG-2024-119',
    title: 'Add rating for drivers',
    source: 'User',
    target: 'Users',
    priority: 'High',
    status: 'Resolved',
    votes: 92,
    createdAt: '3d ago',
  ),
  Suggestion(
    id: 'SUG-2024-118',
    title: 'Bulk upload products for sellers',
    source: 'Employee',
    target: 'Employees',
    priority: 'Low',
    status: 'Rejected',
    votes: 8,
    createdAt: '4d ago',
  ),
];

// ─── Colors & Theme ──────────────────────────────────────────────────────────

const kPrimary = Color(0xFF1A6B3C);
const kPrimaryLight = Color(0xFFE8F5EE);
const kAccentGold = Color(0xFFF5A623);
const kBgColor = Color(0xFFF5F6FA);
const kSidebarBg = Color(0xFF1A1F2E);
const kSidebarText = Color(0xFFB0B8D1);
const kSidebarActive = Color(0xFF2D6A4F);
const kBorderColor = Color(0xFFE2E8F0);
const kTextPrimary = Color(0xFF1A202C);
const kTextSecondary = Color(0xFF718096);

// ─── Main Page ────────────────────────────────────────────────────────────────

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({super.key});

  @override
  State<SuggestionsPage> createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage>
    with SingleTickerProviderStateMixin {
  bool _showDialog = false;
  late AnimationController _animController;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  String _selectedTab = 'All';

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(1.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _fadeAnim = Tween<double>(begin: 0, end: 0.4).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _openDialog() {
    setState(() => _showDialog = true);
    _animController.forward();
  }

  void _closeDialog() {
    _animController.reverse().then((_) {
      setState(() => _showDialog = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PageHeader(onNewSuggestion: _openDialog),
                    const SizedBox(height: 20),
                    const _FilterRow(),
                    const SizedBox(height: 20),
                    const _StatCards(),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _SuggestionsTable(
                            selectedTab: _selectedTab,
                            onTabChange:
                                (t) => setState(() => _selectedTab = t),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const _RightSidebar(),
                      ],
                    ),
                  ],
                ),
              ),
              // ── Overlay + Slide Dialog
              if (_showDialog) ...[
                FadeTransition(
                  opacity: _fadeAnim,
                  child: GestureDetector(
                    onTap: _closeDialog,
                    child: Container(color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: _NewSuggestionPanel(onClose: _closeDialog),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Sidebar ─────────────────────────────────────────────────────────────────

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Dashboard', Icons.dashboard_outlined, false),
      ('User Management', Icons.people_outline, false),
      ('KYC Approvals', Icons.verified_user_outlined, false),
      ('Listing Moderation', Icons.list_alt_outlined, false),
      ('Orders & Escrow', Icons.receipt_long_outlined, false),
      ('Dispute Center', Icons.balance_outlined, false),
      ('Driver Monitoring', Icons.local_shipping_outlined, false),
      ('Suggestions', Icons.lightbulb_outline, true),
      ('System Settings', Icons.settings_outlined, false),
      ('Notifications', Icons.notifications_outlined, false),
      ('Audit Logs', Icons.history_outlined, false),
    ];

    return Container(
      width: 220,
      color: kSidebarBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: kAccentGold,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.diamond,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'YamoZone',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Nav Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (_, i) {
                final (label, icon, active) = items[i];
                return _SidebarItem(
                  label: label,
                  icon: icon,
                  active: active,
                  badge: active ? 24 : null,
                );
              },
            ),
          ),
          // User
          const Divider(color: Color(0xFF2D3748), height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFF4A5568),
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Super Admin',
                      style: TextStyle(color: kSidebarText, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: kSidebarText,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final int? badge;

  const _SidebarItem({
    required this.label,
    required this.icon,
    required this.active,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: active ? kPrimary.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: active ? Colors.white : kSidebarText,
          size: 20,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : kSidebarText,
            fontSize: 13,
            fontWeight: active ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing:
            badge != null
                ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$badge',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : null,
        onTap: () {},
      ),
    );
  }
}

// ─── Top Bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: kBorderColor)),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: kTextSecondary),
          const Spacer(),
          // Search
          Container(
            width: 260,
            height: 36,
            decoration: BoxDecoration(
              color: kBgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kBorderColor),
            ),
            child: const Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.search, color: kTextSecondary, size: 18),
                SizedBox(width: 8),
                Text(
                  'Search anything...',
                  style: TextStyle(color: kTextSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Notification bell
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: kTextSecondary,
                size: 24,
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      '8',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Avatar
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF4A5568),
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Admin',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Super Admin',
                    style: TextStyle(fontSize: 11, color: kTextSecondary),
                  ),
                ],
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: kTextSecondary,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Page Header ─────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  final VoidCallback onNewSuggestion;
  const _PageHeader({required this.onNewSuggestion});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suggestions Panel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kTextPrimary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Collect ideas and feedback to improve the platform for users and employees.',
              style: TextStyle(fontSize: 13, color: kTextSecondary),
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: onNewSuggestion,
          icon: const Icon(Icons.add, size: 18, color: Colors.white),
          label: const Text(
            'New Suggestion',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }
}

// ─── Filter Row ──────────────────────────────────────────────────────────────

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBorderColor),
      ),
      child: Row(
        children: [
          // Search
          Expanded(
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: kBgColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kBorderColor),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.search, color: kTextSecondary, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Search suggestions by title, descri...',
                    style: TextStyle(color: kTextSecondary, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          _FilterDropdown(label: 'All Sources'),
          const SizedBox(width: 8),
          _FilterDropdown(label: 'All Targets'),
          const SizedBox(width: 8),
          _FilterDropdown(label: 'All Statuses'),
          const SizedBox(width: 8),
          _FilterDropdown(label: 'All Priorities'),
          const SizedBox(width: 8),
          _FilterDropdown(
            label: 'Last 30 days',
            icon: Icons.calendar_today_outlined,
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, size: 16),
            label: const Text('Filters'),
            style: OutlinedButton.styleFrom(
              foregroundColor: kTextPrimary,
              side: const BorderSide(color: kBorderColor),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

class _FilterDropdown extends StatelessWidget {
  final String label;
  final IconData? icon;
  const _FilterDropdown({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: kTextSecondary),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: kTextPrimary),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: kTextSecondary,
          ),
        ],
      ),
    );
  }
}

// ─── Stat Cards ──────────────────────────────────────────────────────────────

class _StatCards extends StatelessWidget {
  const _StatCards();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          icon: Icons.lightbulb_outline,
          iconColor: const Color(0xFF805AD5),
          iconBg: const Color(0xFFF3EBFF),
          label: 'Total Suggestions',
          value: '124',
          sub: '↑ 18% vs last 30 days',
          subColor: Colors.green,
        ),
        const SizedBox(width: 16),
        _StatCard(
          icon: Icons.add_box_outlined,
          iconColor: const Color(0xFF3182CE),
          iconBg: const Color(0xFFEBF5FF),
          label: 'New',
          value: '24',
          sub: '19.4% of total',
        ),
        const SizedBox(width: 16),
        _StatCard(
          icon: Icons.autorenew,
          iconColor: const Color(0xFFD69E2E),
          iconBg: const Color(0xFFFFF9E6),
          label: 'In Progress',
          value: '36',
          sub: '29.0% of total',
        ),
        const SizedBox(width: 16),
        _StatCard(
          icon: Icons.check_circle_outline,
          iconColor: const Color(0xFF38A169),
          iconBg: const Color(0xFFE6FAF1),
          label: 'Resolved',
          value: '48',
          sub: '38.7% of total',
        ),
        const SizedBox(width: 16),
        _StatCard(
          icon: Icons.cancel_outlined,
          iconColor: const Color(0xFFE53E3E),
          iconBg: const Color(0xFFFFF0F0),
          label: 'Rejected',
          value: '16',
          sub: '12.9% of total',
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor, iconBg;
  final String label, value, sub;
  final Color? subColor;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.sub,
    this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: kTextSecondary),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: kTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sub,
              style: TextStyle(fontSize: 11, color: subColor ?? kTextSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Suggestions Table ───────────────────────────────────────────────────────

class _SuggestionsTable extends StatelessWidget {
  final String selectedTab;
  final ValueChanged<String> onTabChange;

  const _SuggestionsTable({
    required this.selectedTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ('All', 124),
      ('New', 24),
      ('In Progress', 36),
      ('Resolved', 48),
      ('Rejected', 16),
    ];

    final filtered =
        selectedTab == 'All'
            ? _suggestions
            : _suggestions.where((s) => s.status == selectedTab).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: kBorderColor)),
            ),
            child: Row(
              children:
                  tabs.map((t) {
                    final (name, count) = t;
                    final active = name == selectedTab;
                    Color? dotColor;
                    if (name == 'New') dotColor = const Color(0xFF3182CE);
                    if (name == 'In Progress')
                      dotColor = const Color(0xFFD69E2E);
                    if (name == 'Resolved') dotColor = const Color(0xFF38A169);
                    if (name == 'Rejected') dotColor = const Color(0xFFE53E3E);

                    return GestureDetector(
                      onTap: () => onTabChange(name),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border:
                              active
                                  ? const Border(
                                    bottom: BorderSide(
                                      color: kPrimary,
                                      width: 2,
                                    ),
                                  )
                                  : null,
                        ),
                        child: Row(
                          children: [
                            if (dotColor != null) ...[
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: dotColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                    active
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                color: active ? kTextPrimary : kTextSecondary,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '$count',
                              style: const TextStyle(
                                fontSize: 12,
                                color: kTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF7FAFC),
              border: Border(bottom: BorderSide(color: kBorderColor)),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    'ID',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text(
                    'Source',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text(
                    'Target',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text(
                    'Priority',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    'Votes',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    'Created',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
                ),
                SizedBox(width: 60),
              ],
            ),
          ),
          // Rows
          ...filtered.map((s) => _SuggestionRow(s: s)),
          // Pagination
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: kBorderColor)),
            ),
            child: Row(
              children: [
                Text(
                  'Showing 1 to ${filtered.length} of 124 suggestions',
                  style: const TextStyle(fontSize: 13, color: kTextSecondary),
                ),
                const Spacer(),
                _PaginationBtn(icon: Icons.chevron_left, onTap: () {}),
                const SizedBox(width: 4),
                _PageNumBtn(num: 1, active: true),
                const SizedBox(width: 4),
                _PageNumBtn(num: 2, active: false),
                const SizedBox(width: 4),
                _PageNumBtn(num: 3, active: false),
                const SizedBox(width: 4),
                const Text('...', style: TextStyle(color: kTextSecondary)),
                const SizedBox(width: 4),
                _PageNumBtn(num: 13, active: false),
                const SizedBox(width: 4),
                _PaginationBtn(icon: Icons.chevron_right, onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  final Suggestion s;
  const _SuggestionRow({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kBorderColor)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              s.id,
              style: const TextStyle(fontSize: 12, color: kTextSecondary),
            ),
          ),
          Expanded(
            child: Text(
              s.title,
              style: const TextStyle(fontSize: 13, color: kTextPrimary),
            ),
          ),
          SizedBox(width: 90, child: _SourceBadge(label: s.source)),
          SizedBox(width: 90, child: _TargetBadge(label: s.target)),
          SizedBox(width: 90, child: _PriorityBadge(label: s.priority)),
          SizedBox(width: 100, child: _StatusBadge(label: s.status)),
          SizedBox(
            width: 60,
            child: Text(
              '${s.votes}',
              style: const TextStyle(fontSize: 13, color: kTextPrimary),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              s.createdAt,
              style: const TextStyle(fontSize: 12, color: kTextSecondary),
            ),
          ),
          SizedBox(
            width: 60,
            child: Row(
              children: [
                Icon(Icons.shield_outlined, size: 16, color: kTextSecondary),
                const SizedBox(width: 8),
                Icon(Icons.more_horiz, size: 16, color: kTextSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceBadge extends StatelessWidget {
  final String label;
  const _SourceBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final isEmployee = label == 'Employee';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isEmployee ? const Color(0xFFEBF5FF) : const Color(0xFFF0FFF4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: isEmployee ? const Color(0xFF2B6CB0) : const Color(0xFF276749),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _TargetBadge extends StatelessWidget {
  final String label;
  const _TargetBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final isEmployee = label == 'Employees';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isEmployee ? const Color(0xFFEBF5FF) : const Color(0xFFF0FFF4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: isEmployee ? const Color(0xFF2B6CB0) : const Color(0xFF276749),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String label;
  const _PriorityBadge({required this.label});

  Color get color {
    switch (label) {
      case 'High':
        return const Color(0xFFE53E3E);
      case 'Medium':
        return const Color(0xFFD69E2E);
      default:
        return const Color(0xFF718096);
    }
  }

  Color get bg {
    switch (label) {
      case 'High':
        return const Color(0xFFFFF0F0);
      case 'Medium':
        return const Color(0xFFFFF9E6);
      default:
        return const Color(0xFFF7FAFC);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  const _StatusBadge({required this.label});

  Color get color {
    switch (label) {
      case 'New':
        return const Color(0xFF3182CE);
      case 'In Progress':
        return const Color(0xFFD69E2E);
      case 'Resolved':
        return const Color(0xFF38A169);
      case 'Rejected':
        return const Color(0xFFE53E3E);
      default:
        return kTextSecondary;
    }
  }

  Color get bg {
    switch (label) {
      case 'New':
        return const Color(0xFFEBF5FF);
      case 'In Progress':
        return const Color(0xFFFFF9E6);
      case 'Resolved':
        return const Color(0xFFE6FAF1);
      case 'Rejected':
        return const Color(0xFFFFF0F0);
      default:
        return const Color(0xFFF7FAFC);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _PaginationBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _PaginationBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: kTextSecondary),
      ),
    );
  }
}

class _PageNumBtn extends StatelessWidget {
  final int num;
  final bool active;
  const _PageNumBtn({required this.num, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: active ? kPrimary : Colors.white,
        border: Border.all(color: active ? kPrimary : kBorderColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          '$num',
          style: TextStyle(
            fontSize: 13,
            color: active ? Colors.white : kTextPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ─── Right Sidebar ────────────────────────────────────────────────────────────

class _RightSidebar extends StatelessWidget {
  const _RightSidebar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        children: [
          // By Target
          _SideCard(
            title: 'Suggestions by Target',
            child: Column(
              children: [
                const SizedBox(height: 8),
                // Simple donut visual
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: 0.629,
                          strokeWidth: 14,
                          backgroundColor: const Color(0xFF3182CE),
                          valueColor: const AlwaysStoppedAnimation(
                            Color(0xFF805AD5),
                          ),
                        ),
                        const Text(
                          '124',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _LegendRow(
                  color: const Color(0xFF805AD5),
                  label: 'Users',
                  value: '78 (62.9%)',
                ),
                const SizedBox(height: 4),
                _LegendRow(
                  color: const Color(0xFF3182CE),
                  label: 'Employees',
                  value: '46 (37.1%)',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // By Category
          _SideCard(
            title: 'Suggestions by Category',
            child: Column(
              children: [
                _CatRow(
                  icon: Icons.star_outline,
                  iconColor: const Color(0xFF38A169),
                  label: 'Features & Improvements',
                  count: 54,
                ),
                _CatRow(
                  icon: Icons.payment_outlined,
                  iconColor: kAccentGold,
                  label: 'Payments',
                  count: 22,
                ),
                _CatRow(
                  icon: Icons.local_shipping_outlined,
                  iconColor: const Color(0xFF3182CE),
                  label: 'Delivery & Logistics',
                  count: 18,
                ),
                _CatRow(
                  icon: Icons.phone_android_outlined,
                  iconColor: const Color(0xFF805AD5),
                  label: 'Mobile App',
                  count: 14,
                ),
                _CatRow(
                  icon: Icons.more_horiz,
                  iconColor: kTextSecondary,
                  label: 'Other',
                  count: 16,
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View all categories',
                        style: TextStyle(fontSize: 13, color: kPrimary),
                      ),
                      Icon(Icons.arrow_forward, size: 14, color: kPrimary),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Recent Activity
          _SideCard(
            title: 'Recent Activity',
            child: Column(
              children: [
                _ActivityRow(
                  color: const Color(0xFF3182CE),
                  title: 'New suggestion submitted',
                  sub: 'Add live chat support',
                  time: '2h ago',
                ),
                _ActivityRow(
                  color: const Color(0xFF38A169),
                  title: 'Suggestion resolved',
                  sub: 'Enable order cancellation',
                  time: '5h ago',
                ),
                _ActivityRow(
                  color: kAccentGold,
                  title: 'Status updated',
                  sub: 'SUG-2024-123 moved to In Progress',
                  time: '1d ago',
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View all activity',
                        style: TextStyle(fontSize: 13, color: kPrimary),
                      ),
                      Icon(Icons.arrow_forward, size: 14, color: kPrimary),
                    ],
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

class _SideCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SideCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: kTextPrimary,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  final Color color;
  final String label, value;
  const _LegendRow({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: kTextSecondary),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _CatRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final int count;
  const _CatRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: kTextPrimary),
            ),
          ),
          Text(
            '$count',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final Color color;
  final String title, sub, time;
  const _ActivityRow({
    required this.color,
    required this.title,
    required this.sub,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 3),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(fontSize: 11, color: kTextSecondary),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 11, color: kTextSecondary),
          ),
        ],
      ),
    );
  }
}

// ─── New Suggestion Panel ─────────────────────────────────────────────────────

class _NewSuggestionPanel extends StatefulWidget {
  final VoidCallback onClose;
  const _NewSuggestionPanel({required this.onClose});

  @override
  State<_NewSuggestionPanel> createState() => _NewSuggestionPanelState();
}

class _NewSuggestionPanelState extends State<_NewSuggestionPanel> {
  bool _anonymous = false;
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 20, 0),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Suggestion',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Share your idea or feedback to help us\nimprove YamoZone.',
                      style: TextStyle(fontSize: 13, color: kTextSecondary),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: widget.onClose,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: kBgColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: kTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 24),
          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  _FieldLabel(label: 'Title', required: true),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _titleCtrl,
                    maxLength: 100,
                    decoration: _inputDec('Enter a clear and concise title'),
                  ),
                  const SizedBox(height: 16),
                  // Description
                  _FieldLabel(label: 'Description', required: true),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _descCtrl,
                    maxLength: 2000,
                    maxLines: 5,
                    decoration: _inputDec(
                      'Describe your suggestion in detail. What problem does it solve? What improvement would it bring?',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Source & Target row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FieldLabel(label: 'Source', required: true),
                            const SizedBox(height: 6),
                            _SelectDropdown(
                              icon: Icons.people_outline,
                              hint: 'Select source',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FieldLabel(label: 'Target', required: true),
                            const SizedBox(height: 6),
                            _SelectDropdown(
                              icon: Icons.adjust_outlined,
                              hint: 'Select target',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Category & Priority row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FieldLabel(label: 'Category', required: true),
                            const SizedBox(height: 6),
                            _SelectDropdown(
                              icon: Icons.category_outlined,
                              hint: 'Select category',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FieldLabel(label: 'Priority', required: true),
                            const SizedBox(height: 6),
                            _SelectDropdown(
                              icon: Icons.flag_outlined,
                              hint: 'Select priority',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Attachments
                  const Text(
                    'Attachments',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: kTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Optional',
                    style: TextStyle(fontSize: 11, color: kTextSecondary),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: kBgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: kBorderColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 32,
                          color: kTextSecondary,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Drag and drop files here or click to browse',
                          style: TextStyle(fontSize: 12, color: kTextSecondary),
                        ),
                        const Text(
                          'PNG, JPG, PDF up to 10MB (Max 3 files)',
                          style: TextStyle(fontSize: 11, color: kTextSecondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Anonymous toggle
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kBgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kBorderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: kBorderColor),
                          ),
                          child: const Icon(
                            Icons.mail_outline,
                            size: 18,
                            color: kTextSecondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Anonymous Submission',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: kTextPrimary,
                                ),
                              ),
                              Text(
                                'Submit this suggestion anonymously',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: kTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _anonymous,
                          onChanged: (v) => setState(() => _anonymous = v),
                          activeColor: kPrimary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Info banner
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF8FF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF90CDF4)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Color(0xFF2B6CB0),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Your suggestion will be reviewed by our team. You'll be notified about the status updates.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF2C5282),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Action Buttons
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: kBorderColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onClose,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kTextPrimary,
                      side: const BorderSide(color: kBorderColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      widget.onClose();
                    },
                    icon: const Icon(
                      Icons.send_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Submit Suggestion',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
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

  InputDecoration _inputDec(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 13, color: kTextSecondary),
    contentPadding: const EdgeInsets.all(12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kBorderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kPrimary),
    ),
    filled: true,
    fillColor: Colors.white,
    counterStyle: const TextStyle(fontSize: 11, color: kTextSecondary),
  );
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final bool required;
  const _FieldLabel({required this.label, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: kTextPrimary,
          ),
        ),
        if (required)
          const Text(' *', style: TextStyle(color: Colors.red, fontSize: 13)),
      ],
    );
  }
}

class _SelectDropdown extends StatelessWidget {
  final IconData icon;
  final String hint;
  const _SelectDropdown({required this.icon, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: kTextSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              hint,
              style: const TextStyle(fontSize: 13, color: kTextSecondary),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: kTextSecondary,
          ),
        ],
      ),
    );
  }
}
