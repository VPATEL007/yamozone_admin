import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/views/layouts/layout.dart';

// ─────────────────────────────────────────────
//  Theme constants  (matches your sidebar gold)
// ─────────────────────────────────────────────
const kGold = Color(0xFFB8860B);
const kGoldLight = Color(0xFFF5F0DC);
const kGoldSoft = Color(0xFFD4A017);
const kBg = Color(0xFFFAF8F2);
const kSidebar = Color(0xFF1A1A1A);
const kTextDark = Color(0xFF1C1C1C);
const kTextMuted = Color(0xFF9E9E9E);
const kBorder = Color(0xFFE8E0CC);

// ─────────────────────────────────────────────
//  Data models
// ─────────────────────────────────────────────
enum WithdrawalStatus { pending, paid, approved, rejected }

enum WithdrawalType { escrow, delivery }

class WithdrawalRequest {
  final String id;
  final String userName;
  final String userRole;
  final double amount;
  final WithdrawalType type;
  final WithdrawalStatus status;
  final String date;

  const WithdrawalRequest({
    required this.id,
    required this.userName,
    required this.userRole,
    required this.amount,
    required this.type,
    required this.status,
    required this.date,
  });
}

const _requests = [
  WithdrawalRequest(
    id: 'WD-1021',
    userName: 'John Smith',
    userRole: 'Seller',
    amount: 500.00,
    type: WithdrawalType.escrow,
    status: WithdrawalStatus.pending,
    date: 'Jan 15, 2024',
  ),
  WithdrawalRequest(
    id: 'WD-1022',
    userName: 'Mike Johnson',
    userRole: 'Driver',
    amount: 120.00,
    type: WithdrawalType.delivery,
    status: WithdrawalStatus.paid,
    date: 'Jan 14, 2024',
  ),
  WithdrawalRequest(
    id: 'WD-1023',
    userName: 'Sarah Davis',
    userRole: 'Seller',
    amount: 750.00,
    type: WithdrawalType.escrow,
    status: WithdrawalStatus.approved,
    date: 'Jan 13, 2024',
  ),
  WithdrawalRequest(
    id: 'WD-1024',
    userName: 'David Wilson',
    userRole: 'Driver',
    amount: 85.50,
    type: WithdrawalType.delivery,
    status: WithdrawalStatus.rejected,
    date: 'Jan 12, 2024',
  ),
];

// ─────────────────────────────────────────────
//  Entry

// ─────────────────────────────────────────────
//  Withdrawal Requests Page
// ─────────────────────────────────────────────
class WithdrawalRequestsPage extends StatefulWidget {
  const WithdrawalRequestsPage({super.key});

  @override
  State<WithdrawalRequestsPage> createState() => _WithdrawalRequestsPageState();
}

class _WithdrawalRequestsPageState extends State<WithdrawalRequestsPage> {
  String _userType = 'All Users';
  String _status = 'All Status';
  DateTime? _dateFrom;
  DateTime? _dateTo;
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top Bar ──
                _TopBar(),
                const SizedBox(height: 24),

                // ── Filter Card ──
                _FilterSection(
                  userType: _userType,
                  status: _status,
                  dateFrom: _dateFrom,
                  dateTo: _dateTo,
                  onUserTypeChanged: (v) => setState(() => _userType = v),
                  onStatusChanged: (v) => setState(() => _status = v),
                  onDateFromChanged: (v) => setState(() => _dateFrom = v),
                  onDateToChanged: (v) => setState(() => _dateTo = v),
                ),
                const SizedBox(height: 24),

                // ── Table Card ──
                _TableSection(
                  currentPage: _currentPage,
                  onPageChanged: (p) => setState(() => _currentPage = p),
                ),
                const SizedBox(height: 28),

                // ── Stats Row ──
                _StatsRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Top Bar
// ─────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Container(
        //   width: 34,
        //   height: 34,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     shape: BoxShape.circle,
        //     border: Border.all(color: kBorder),
        //   ),
        //   child: Icon(Icons.arrow_back, size: 16, color: kTextDark),
        // ),
        // const SizedBox(width: 14),
        Text(
          'Withdrawal Requests',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: kTextDark,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Filter Section
// ─────────────────────────────────────────────
class _FilterSection extends StatelessWidget {
  final String userType;
  final String status;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final ValueChanged<String> onUserTypeChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<DateTime?> onDateFromChanged;
  final ValueChanged<DateTime?> onDateToChanged;

  const _FilterSection({
    required this.userType,
    required this.status,
    required this.dateFrom,
    required this.dateTo,
    required this.onUserTypeChanged,
    required this.onStatusChanged,
    required this.onDateFromChanged,
    required this.onDateToChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Requests',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kTextDark,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.filter_alt, size: 15, color: Colors.white),
                label: Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _FilterDropdown(
                  label: 'User Type',
                  value: userType,
                  items: ['All Users', 'Seller', 'Driver', 'Buyer'],
                  onChanged: onUserTypeChanged,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _FilterDropdown(
                  label: 'Status',
                  value: status,
                  items: [
                    'All Status',
                    'Pending',
                    'Paid',
                    'Approved',
                    'Rejected',
                  ],
                  onChanged: onStatusChanged,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _DatePickerField(
                  label: 'Date From',
                  value: dateFrom,
                  onChanged: onDateFromChanged,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _DatePickerField(
                  label: 'Date To',
                  value: dateTo,
                  onChanged: onDateToChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _FilterDropdown({
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
          style: TextStyle(
            fontSize: 12,
            color: kTextMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kBorder),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down, color: kTextMuted, size: 20),
            style: TextStyle(fontSize: 13, color: kTextDark),
            items:
                items
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
            onChanged: (v) => v != null ? onChanged(v) : null,
          ),
        ),
      ],
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  const _DatePickerField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: kTextMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              builder:
                  (ctx, child) => Theme(
                    data: Theme.of(
                      ctx,
                    ).copyWith(colorScheme: ColorScheme.light(primary: kGold)),
                    child: child!,
                  ),
            );
            onChanged(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value != null
                        ? '${value!.month.toString().padLeft(2, '0')}/${value!.day.toString().padLeft(2, '0')}/${value!.year}'
                        : 'mm/dd/yyyy',
                    style: TextStyle(
                      fontSize: 13,
                      color: value != null ? kTextDark : kTextMuted,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: kTextMuted,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Table Section
// ─────────────────────────────────────────────
class _TableSection extends StatelessWidget {
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const _TableSection({required this.currentPage, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          // Table header row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Withdrawal Requests',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: kTextDark,
                        ),
                      ),
                      Text(
                        'Total: 156 requests',
                        style: TextStyle(fontSize: 12, color: kTextMuted),
                      ),
                    ],
                  ),
                ),
                // Export button
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.download, size: 15, color: kGold),
                  label: Text(
                    'Export',
                    style: TextStyle(
                      fontSize: 13,
                      color: kGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kGold),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Search
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search requests...',
                      hintStyle: TextStyle(fontSize: 13, color: kTextMuted),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 18,
                        color: kTextMuted,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: kBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: kBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: kGold),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Column headers
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: kGoldLight,
              border: Border(
                top: BorderSide(color: kBorder),
                bottom: BorderSide(color: kBorder),
              ),
            ),
            child: Row(
              children: const [
                _ColHeader('Request ID', flex: 2),
                _ColHeader('User', flex: 3),
                _ColHeader('Amount', flex: 2),
                _ColHeader('Type', flex: 2),
                _ColHeader('Status', flex: 2),
                _ColHeader('Date', flex: 2),
                _ColHeader('Action', flex: 2, align: TextAlign.center),
              ],
            ),
          ),

          // Rows
          ..._requests.map((r) => _TableRow(request: r)),

          // Pagination
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: kBorder)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing 1-3 of 24 listings',
                  style: TextStyle(fontSize: 12, color: kTextMuted),
                ),
                _Pagination(current: currentPage, onChanged: onPageChanged),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColHeader extends StatelessWidget {
  final String text;
  final int flex;
  final TextAlign align;

  const _ColHeader(
    this.text, {
    required this.flex,
    this.align = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: kTextDark,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final WithdrawalRequest request;
  const _TableRow({required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kBorder.withOpacity(0.6))),
      ),
      child: Row(
        children: [
          // Request ID
          Expanded(
            flex: 2,
            child: Text(
              request.id,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: kTextDark,
              ),
            ),
          ),
          // User
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.userName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kTextDark,
                  ),
                ),
                Text(
                  request.userRole,
                  style: TextStyle(fontSize: 11, color: kTextMuted),
                ),
              ],
            ),
          ),
          // Amount
          Expanded(
            flex: 2,
            child: Text(
              '\$${request.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: kTextDark,
              ),
            ),
          ),
          // Type badge
          Expanded(flex: 2, child: _TypeBadge(request.type)),
          // Status badge
          Expanded(flex: 2, child: _StatusBadge(request.status)),
          // Date
          Expanded(
            flex: 2,
            child: Text(
              request.date,
              style: TextStyle(fontSize: 13, color: kTextDark),
            ),
          ),
          // Action
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: _ActionButton(request.status),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final WithdrawalType type;
  const _TypeBadge(this.type);

  @override
  Widget build(BuildContext context) {
    final label = type == WithdrawalType.escrow ? 'Escrow' : 'Delivery';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: kGoldLight,
        border: Border.all(color: kGold.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: kGold,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final WithdrawalStatus status;
  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    Color bg, text;
    String label;
    switch (status) {
      case WithdrawalStatus.pending:
        bg = const Color(0xFFFFF3E0);
        text = const Color(0xFFF57C00);
        label = 'Pending';
        break;
      case WithdrawalStatus.paid:
        bg = const Color(0xFFE8F5E9);
        text = const Color(0xFF388E3C);
        label = 'Paid';
        break;
      case WithdrawalStatus.approved:
        bg = const Color(0xFFE3F2FD);
        text = const Color(0xFF1976D2);
        label = 'Approved';
        break;
      case WithdrawalStatus.rejected:
        bg = const Color(0xFFFFEBEE);
        text = const Color(0xFFD32F2F);
        label = 'Rejected';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final WithdrawalStatus status;
  const _ActionButton(this.status);

  @override
  Widget build(BuildContext context) {
    String label;
    bool filled;

    switch (status) {
      case WithdrawalStatus.pending:
        label = 'Review';
        filled = true;
        break;
      case WithdrawalStatus.paid:
        label = 'Completed';
        filled = false;
        break;
      case WithdrawalStatus.approved:
        label = 'Process';
        filled = true;
        break;
      case WithdrawalStatus.rejected:
        label = 'View Details';
        filled = false;
        break;
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: filled ? kGold : Colors.white,
          border: Border.all(color: filled ? kGold : kBorder),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: filled ? Colors.white : kTextDark,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Pagination
// ─────────────────────────────────────────────
class _Pagination extends StatelessWidget {
  final int current;
  final ValueChanged<int> onChanged;

  const _Pagination({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PageBtn(
          label: 'Previous',
          onTap: current > 1 ? () => onChanged(current - 1) : null,
        ),
        const SizedBox(width: 6),
        _PageNum(page: 1, current: current, onTap: () => onChanged(1)),
        _PageNum(page: 2, current: current, onTap: () => onChanged(2)),
        _PageNum(page: 3, current: current, onTap: () => onChanged(3)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text('...', style: TextStyle(color: kTextMuted)),
        ),
        _PageNum(page: 249, current: current, onTap: () => onChanged(249)),
        const SizedBox(width: 6),
        _PageBtn(label: 'Next', onTap: () => onChanged(current + 1)),
      ],
    );
  }
}

class _PageNum extends StatelessWidget {
  final int page;
  final int current;
  final VoidCallback onTap;

  const _PageNum({
    required this.page,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = page == current;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? kGold : Colors.white,
          border: Border.all(color: isActive ? kGold : kBorder),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : kTextDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _PageBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _PageBtn({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kBorder),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: onTap != null ? kTextDark : kTextMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Stats Row
// ─────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = [
      (Icons.access_time_rounded, 'Pending Requests', '23', false),
      (Icons.check_circle_outline_rounded, 'Approved Today', '6', false),
      (Icons.attach_money_rounded, 'Total Amount', '\$12,450', false),
      (Icons.warning_amber_rounded, 'Urgent Reviews', '2', true),
    ];

    return Row(
      children:
          stats
              .map(
                (s) => Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: s == stats.last ? 0 : 16),
                    padding: const EdgeInsets.all(20),
                    decoration: _cardDecoration(),
                    child: Column(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: s.$4 ? const Color(0xFFFFF3E0) : kGoldLight,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            s.$1,
                            color: s.$4 ? const Color(0xFFF57C00) : kGold,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          s.$2,
                          style: TextStyle(fontSize: 13, color: kTextMuted),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          s.$3,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: kTextDark,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kGold,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 13, color: kGold),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

// ─────────────────────────────────────────────
//  Shared decoration helper
// ─────────────────────────────────────────────
BoxDecoration _cardDecoration() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: kBorder),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ],
);
