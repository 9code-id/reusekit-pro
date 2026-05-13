import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaExpenseListView extends StatefulWidget {
  const AbaExpenseListView({super.key});

  @override
  State<AbaExpenseListView> createState() => _AbaExpenseListViewState();
}

class _AbaExpenseListViewState extends State<AbaExpenseListView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  String selectedDateRange = "all_time";
  String sortBy = "date_desc";

  List<Map<String, dynamic>> expenses = [
    {
      "id": "EXP-2025-001",
      "title": "Assessment Materials",
      "description": "Standardized assessment tools and educational materials",
      "amount": 450.00,
      "date": "2025-01-15",
      "category": "materials",
      "status": "approved",
      "receipt_attached": true,
      "vendor": "Psychological Corp",
      "payment_method": "Credit Card",
      "reimbursable": true,
      "submitted_by": "Dr. Sarah Johnson",
      "approved_by": "Finance Manager",
      "approval_date": "2025-01-16",
      "tags": ["assessment", "materials", "educational"]
    },
    {
      "id": "EXP-2025-002",
      "title": "ABA Training Workshop",
      "description": "Advanced behavioral intervention techniques certification",
      "amount": 1200.00,
      "date": "2025-01-12",
      "category": "training",
      "status": "pending",
      "receipt_attached": true,
      "vendor": "ABA Training Institute",
      "payment_method": "Bank Transfer",
      "reimbursable": true,
      "submitted_by": "Dr. Michael Chen",
      "approved_by": null,
      "approval_date": null,
      "tags": ["training", "certification", "professional development"]
    },
    {
      "id": "EXP-2025-003",
      "title": "Office Supplies",
      "description": "Stationery, printing supplies, and general office materials",
      "amount": 185.50,
      "date": "2025-01-10",
      "category": "office",
      "status": "approved",
      "receipt_attached": true,
      "vendor": "Office Depot",
      "payment_method": "Cash",
      "reimbursable": false,
      "submitted_by": "Admin Staff",
      "approved_by": "Office Manager",
      "approval_date": "2025-01-11",
      "tags": ["office", "supplies", "stationery"]
    },
    {
      "id": "EXP-2025-004",
      "title": "Therapy Equipment Repair",
      "description": "Maintenance and repair of sensory integration equipment",
      "amount": 320.00,
      "date": "2025-01-18",
      "category": "equipment",
      "status": "rejected",
      "receipt_attached": true,
      "vendor": "Tech Repair Services",
      "payment_method": "Check",
      "reimbursable": true,
      "submitted_by": "Dr. Lisa Rodriguez",
      "approved_by": "Finance Manager",
      "approval_date": "2025-01-19",
      "rejection_reason": "Equipment under warranty",
      "tags": ["equipment", "repair", "maintenance"]
    },
    {
      "id": "EXP-2025-005",
      "title": "Client Travel Expenses",
      "description": "Mileage and parking for home visit sessions",
      "amount": 85.00,
      "date": "2025-01-20",
      "category": "travel",
      "status": "submitted",
      "receipt_attached": true,
      "vendor": "Various",
      "payment_method": "Personal Card",
      "reimbursable": true,
      "submitted_by": "Dr. Amanda Wilson",
      "approved_by": null,
      "approval_date": null,
      "tags": ["travel", "mileage", "home visits"]
    },
    {
      "id": "EXP-2025-006",
      "title": "Software License",
      "description": "Annual subscription for behavior tracking software",
      "amount": 599.99,
      "date": "2025-01-08",
      "category": "technology",
      "status": "approved",
      "receipt_attached": true,
      "vendor": "BehaviorSoft Inc",
      "payment_method": "Credit Card",
      "reimbursable": false,
      "submitted_by": "IT Administrator",
      "approved_by": "Director",
      "approval_date": "2025-01-09",
      "tags": ["software", "license", "technology"]
    },
    {
      "id": "EXP-2025-007",
      "title": "Conference Registration",
      "description": "Registration for International ABA Conference",
      "amount": 850.00,
      "date": "2025-01-22",
      "category": "training",
      "status": "reimbursed",
      "receipt_attached": true,
      "vendor": "ABA International",
      "payment_method": "Credit Card",
      "reimbursable": true,
      "submitted_by": "Dr. Sarah Johnson",
      "approved_by": "Director",
      "approval_date": "2025-01-23",
      "reimbursement_date": "2025-01-25",
      "tags": ["conference", "professional development", "networking"]
    },
    {
      "id": "EXP-2025-008",
      "title": "Client Materials",
      "description": "Sensory toys and learning aids for therapy sessions",
      "amount": 275.00,
      "date": "2025-01-14",
      "category": "materials",
      "status": "approved",
      "receipt_attached": false,
      "vendor": "Learning Resources",
      "payment_method": "Credit Card",
      "reimbursable": true,
      "submitted_by": "Dr. Michael Chen",
      "approved_by": "Clinical Director",
      "approval_date": "2025-01-15",
      "tags": ["sensory", "toys", "therapy materials"]
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Materials & Supplies", "value": "materials"},
    {"label": "Training & Education", "value": "training"},
    {"label": "Office Expenses", "value": "office"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Travel", "value": "travel"},
    {"label": "Software & Technology", "value": "technology"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Submitted", "value": "submitted"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Reimbursed", "value": "reimbursed"},
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "All Time", "value": "all_time"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "This Year", "value": "this_year"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date (Newest)", "value": "date_desc"},
    {"label": "Date (Oldest)", "value": "date_asc"},
    {"label": "Amount (High to Low)", "value": "amount_desc"},
    {"label": "Amount (Low to High)", "value": "amount_asc"},
    {"label": "Status", "value": "status"},
    {"label": "Category", "value": "category"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return successColor;
      case 'pending':
        return warningColor;
      case 'submitted':
        return infoColor;
      case 'rejected':
        return dangerColor;
      case 'reimbursed':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'approved':
        return 'Approved';
      case 'pending':
        return 'Pending Review';
      case 'submitted':
        return 'Submitted';
      case 'rejected':
        return 'Rejected';
      case 'reimbursed':
        return 'Reimbursed';
      default:
        return 'Unknown';
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'materials':
        return Icons.inventory;
      case 'training':
        return Icons.school;
      case 'office':
        return Icons.business;
      case 'equipment':
        return Icons.build;
      case 'travel':
        return Icons.directions_car;
      case 'technology':
        return Icons.computer;
      default:
        return Icons.receipt;
    }
  }

  List<Map<String, dynamic>> get filteredAndSortedExpenses {
    List<Map<String, dynamic>> filtered = expenses.where((expense) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${expense["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${expense["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${expense["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${expense["vendor"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${expense["submitted_by"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || expense["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || expense["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();

    // Sort expenses
    filtered.sort((a, b) {
      switch (sortBy) {
        case 'date_desc':
          return "${b["date"]}".compareTo("${a["date"]}");
        case 'date_asc':
          return "${a["date"]}".compareTo("${b["date"]}");
        case 'amount_desc':
          return (b["amount"] as double).compareTo(a["amount"] as double);
        case 'amount_asc':
          return (a["amount"] as double).compareTo(b["amount"] as double);
        case 'status':
          return "${a["status"]}".compareTo("${b["status"]}");
        case 'category':
          return "${a["category"]}".compareTo("${b["category"]}");
        default:
          return 0;
      }
    });

    return filtered;
  }

  double get totalFilteredAmount {
    return filteredAndSortedExpenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense List"),
        actions: [
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: _showFilterBottomSheet,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndQuickFilters(),
            _buildExpensesSummary(),
            _buildExpensesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndQuickFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search expenses...",
                value: searchQuery,
                hint: "Title, description, vendor, or submitter",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.search,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        QHorizontalScroll(
          children: [
            _buildQuickFilterChip("All", selectedCategory == "all", () {
              selectedCategory = "all";
              setState(() {});
            }),
            _buildQuickFilterChip("Materials", selectedCategory == "materials", () {
              selectedCategory = "materials";
              setState(() {});
            }),
            _buildQuickFilterChip("Training", selectedCategory == "training", () {
              selectedCategory = "training";
              setState(() {});
            }),
            _buildQuickFilterChip("Pending", selectedStatus == "pending", () {
              selectedStatus = "pending";
              setState(() {});
            }),
            _buildQuickFilterChip("Approved", selectedStatus == "approved", () {
              selectedStatus = "approved";
              setState(() {});
            }),
            _buildQuickFilterChip("Reimbursable", false, () {
              // Filter for reimbursable expenses
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
          ),
          boxShadow: isSelected ? [shadowSm] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildExpensesSummary() {
    int totalItems = filteredAndSortedExpenses.length;
    int pendingItems = filteredAndSortedExpenses.where((expense) => expense["status"] == "pending" || expense["status"] == "submitted").length;
    int approvedItems = filteredAndSortedExpenses.where((expense) => expense["status"] == "approved").length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Expense Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$totalItems items",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryItem("Total Amount", "\$${totalFilteredAmount.currency}", Icons.attach_money, primaryColor),
              _buildSummaryItem("Pending", "$pendingItems items", Icons.hourglass_empty, warningColor),
              _buildSummaryItem("Approved", "$approvedItems items", Icons.check_circle, successColor),
              _buildSummaryItem("Average", "\$${totalItems > 0 ? (totalFilteredAmount / totalItems).toStringAsFixed(2) : "0.00"}", Icons.trending_up, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesList() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Expenses (${filteredAndSortedExpenses.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Row(
              children: [
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {},
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: _showSortBottomSheet,
                ),
              ],
            ),
          ],
        ),
        if (filteredAndSortedExpenses.isEmpty)
          _buildEmptyState()
        else
          ...filteredAndSortedExpenses.map((expense) => _buildExpenseListItem(expense)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long,
            color: disabledBoldColor,
            size: 64,
          ),
          SizedBox(height: spMd),
          Text(
            "No expenses found",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Try adjusting your search or filter criteria",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Clear Filters",
            icon: Icons.clear,
            size: bs.md,
            onPressed: () {
              searchQuery = "";
              selectedCategory = "all";
              selectedStatus = "all";
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseListItem(Map<String, dynamic> expense) {
    List<String> tags = (expense["tags"] as List<dynamic>).cast<String>();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${expense["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getCategoryIcon("${expense["category"]}"),
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${expense["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${expense["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${expense["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      _getStatusLabel("${expense["status"]}"),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor("${expense["status"]}"),
                      ),
                    ),
                  ),
                  Text(
                    "\$${(expense["amount"] as double).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: disabledBoldColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${expense["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.business,
                          color: disabledBoldColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${expense["vendor"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: disabledBoldColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Submitted by ${expense["submitted_by"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        if (expense["receipt_attached"] == true)
                          Row(
                            children: [
                              Icon(
                                Icons.attach_file,
                                color: infoColor,
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Receipt",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () => _showExpenseActions(expense),
                  ),
                ],
              ),
            ],
          ),
          if (tags.isNotEmpty)
            Container(
              width: double.infinity,
              child: Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: tags.take(3).map((tag) => Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                    ),
                  ),
                )).toList(),
              ),
            ),
          if (expense["reimbursable"] == true)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Reimbursable expense",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          if (expense["rejection_reason"] != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Rejection reason: ${expense["rejection_reason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
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

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            Text(
              "Filter Expenses",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Date Range",
              items: dateRangeOptions,
              value: selectedDateRange,
              onChanged: (value, label) {
                selectedDateRange = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear Filters",
                    size: bs.md,
                    onPressed: () {
                      selectedCategory = "all";
                      selectedStatus = "all";
                      selectedDateRange = "all_time";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply",
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            Text(
              "Sort Expenses",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Sort By",
              items: sortOptions,
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showExpenseActions(Map<String, dynamic> expense) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Expense Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            _buildActionButton("View Details", Icons.visibility, () {
              Navigator.pop(context);
            }),
            _buildActionButton("Edit Expense", Icons.edit, () {
              Navigator.pop(context);
            }),
            _buildActionButton("View Receipt", Icons.attach_file, () {
              Navigator.pop(context);
            }),
            _buildActionButton("Duplicate", Icons.copy, () {
              Navigator.pop(context);
            }),
            if (expense["status"] == "submitted" || expense["status"] == "pending")
              _buildActionButton("Cancel Submission", Icons.cancel, () {
                Navigator.pop(context);
              }),
            _buildActionButton("Delete", Icons.delete, () {
              Navigator.pop(context);
            }, isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return Container(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radiusSm),
          child: Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isDestructive ? dangerColor : primaryColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDestructive ? dangerColor : primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
