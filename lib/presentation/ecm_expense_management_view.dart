import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmExpenseManagementView extends StatefulWidget {
  const EcmExpenseManagementView({super.key});

  @override
  State<EcmExpenseManagementView> createState() => _EcmExpenseManagementViewState();
}

class _EcmExpenseManagementViewState extends State<EcmExpenseManagementView> {
  String selectedCategory = "all";
  String selectedPeriod = "this_month";
  String filterStatus = "all";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> expenses = [
    {
      "id": "EXP-001",
      "category": "marketing",
      "subcategory": "Digital Advertising",
      "description": "Google Ads Campaign - Q2",
      "amount": 2500.0,
      "currency": "USD",
      "date": "2024-06-18",
      "vendor": "Google Ads",
      "status": "approved",
      "receipt": "receipt_001.pdf",
      "submittedBy": "Sarah Marketing",
      "approvedBy": "John Manager",
      "tags": ["advertising", "digital", "ppc"],
      "recurring": false
    },
    {
      "id": "EXP-002",
      "category": "technology",
      "subcategory": "Software Licenses",
      "description": "Adobe Creative Cloud - Annual",
      "amount": 1200.0,
      "currency": "USD",
      "date": "2024-06-15",
      "vendor": "Adobe Inc.",
      "status": "pending",
      "receipt": "receipt_002.pdf",
      "submittedBy": "Tech Team",
      "approvedBy": null,
      "tags": ["software", "license", "creative"],
      "recurring": true
    },
    {
      "id": "EXP-003",
      "category": "operations",
      "subcategory": "Office Supplies",
      "description": "Monthly office supplies",
      "amount": 350.0,
      "currency": "USD",
      "date": "2024-06-12",
      "vendor": "Office Depot",
      "status": "paid",
      "receipt": "receipt_003.pdf",
      "submittedBy": "Admin Team",
      "approvedBy": "Operations Manager",
      "tags": ["supplies", "office", "monthly"],
      "recurring": true
    },
    {
      "id": "EXP-004",
      "category": "personnel",
      "subcategory": "Training & Development",
      "description": "Employee training workshop",
      "amount": 800.0,
      "currency": "USD",
      "date": "2024-06-10",
      "vendor": "Training Institute",
      "status": "rejected",
      "receipt": "receipt_004.pdf",
      "submittedBy": "HR Team",
      "approvedBy": "CEO",
      "tags": ["training", "development", "workshop"],
      "recurring": false
    },
    {
      "id": "EXP-005",
      "category": "marketing",
      "subcategory": "Content Creation",
      "description": "Video production services",
      "amount": 1800.0,
      "currency": "USD",
      "date": "2024-06-08",
      "vendor": "Creative Studio",
      "status": "approved",
      "receipt": "receipt_005.pdf",
      "submittedBy": "Marketing Team",
      "approvedBy": "Marketing Director",
      "tags": ["video", "content", "production"],
      "recurring": false
    }
  ];

  final List<Map<String, dynamic>> categoryBudgets = [
    {
      "category": "marketing",
      "budget": 15000.0,
      "spent": 12500.0,
      "remaining": 2500.0,
      "percentage": 83.3,
      "expenses": 28
    },
    {
      "category": "technology",
      "budget": 8000.0,
      "spent": 6200.0,
      "remaining": 1800.0,
      "percentage": 77.5,
      "expenses": 15
    },
    {
      "category": "operations",
      "budget": 5000.0,
      "spent": 4100.0,
      "remaining": 900.0,
      "percentage": 82.0,
      "expenses": 22
    },
    {
      "category": "personnel",
      "budget": 12000.0,
      "spent": 8900.0,
      "remaining": 3100.0,
      "percentage": 74.2,
      "expenses": 18
    },
    {
      "category": "administrative",
      "budget": 3000.0,
      "spent": 2800.0,
      "remaining": 200.0,
      "percentage": 93.3,
      "expenses": 12
    }
  ];

  final List<Map<String, dynamic>> recentExpenses = [
    {
      "description": "Server hosting costs",
      "amount": 450.0,
      "category": "technology",
      "date": "2024-06-19",
      "status": "approved"
    },
    {
      "description": "Marketing conference ticket",
      "amount": 350.0,
      "category": "marketing",
      "date": "2024-06-18",
      "status": "pending"
    },
    {
      "description": "Office cleaning service",
      "amount": 200.0,
      "category": "operations",
      "date": "2024-06-17",
      "status": "paid"
    }
  ];

  List<Map<String, dynamic>> get filteredExpenses {
    List<Map<String, dynamic>> filtered = List.from(expenses);
    
    if (selectedCategory != "all") {
      filtered = filtered.where((expense) => expense["category"] == selectedCategory).toList();
    }
    
    if (filterStatus != "all") {
      filtered = filtered.where((expense) => expense["status"] == filterStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((expense) => 
        (expense["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (expense["vendor"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (expense["id"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "pending":
        return warningColor;
      case "paid":
        return infoColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "approved":
        return "Approved";
      case "pending":
        return "Pending";
      case "paid":
        return "Paid";
      case "rejected":
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "marketing":
        return primaryColor;
      case "technology":
        return infoColor;
      case "operations":
        return successColor;
      case "personnel":
        return warningColor;
      case "administrative":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "marketing":
        return Icons.campaign;
      case "technology":
        return Icons.computer;
      case "operations":
        return Icons.business;
      case "personnel":
        return Icons.people;
      case "administrative":
        return Icons.admin_panel_settings;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalBudget = categoryBudgets.map((c) => c["budget"] as double).reduce((a, b) => a + b);
    double totalSpent = categoryBudgets.map((c) => c["spent"] as double).reduce((a, b) => a + b);
    double totalRemaining = totalBudget - totalSpent;
    int totalExpenseCount = categoryBudgets.map((c) => c["expenses"] as int).reduce((a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new expense
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_balance_wallet, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Budget",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalBudget / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.trending_down, color: dangerColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Spent",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalSpent / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.savings, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Remaining",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalRemaining / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.receipt, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Expenses",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$totalExpenseCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Category Budgets
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Budget by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...categoryBudgets.map((budget) {
                    bool isOverBudget = (budget["percentage"] as double) > 100;
                    bool isNearLimit = (budget["percentage"] as double) > 80;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(budget["category"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getCategoryIcon(budget["category"]),
                                  color: _getCategoryColor(budget["category"]),
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${(budget["category"] as String).replaceAll("_", " ").toUpperCase()}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${budget["expenses"]} expenses",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((budget["spent"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "of \$${((budget["budget"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: ((budget["percentage"] as double) / 100).clamp(0.0, 1.0),
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isOverBudget ? dangerColor :
                                         isNearLimit ? warningColor : successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${(budget["percentage"] as double).toStringAsFixed(1)}% used",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isOverBudget ? dangerColor :
                                         isNearLimit ? warningColor : successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${((budget["remaining"] as double).toDouble()).currency} remaining",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      QButton(
                        label: "Add Expense",
                        size: bs.sm,
                        onPressed: () {
                          // Add new expense
                        },
                      ),
                      QButton(
                        label: "Import CSV",
                        size: bs.sm,
                        onPressed: () {
                          // Import expenses from CSV
                        },
                      ),
                      QButton(
                        label: "Export Report",
                        size: bs.sm,
                        onPressed: () {
                          // Export expense report
                        },
                      ),
                      QButton(
                        label: "Set Budgets",
                        size: bs.sm,
                        onPressed: () {
                          // Set category budgets
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search expenses...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: [
                      {"label": "All Categories", "value": "all"},
                      {"label": "Marketing", "value": "marketing"},
                      {"label": "Technology", "value": "technology"},
                      {"label": "Operations", "value": "operations"},
                      {"label": "Personnel", "value": "personnel"},
                      {"label": "Administrative", "value": "administrative"},
                    ],
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Approved", "value": "approved"},
                      {"label": "Paid", "value": "paid"},
                      {"label": "Rejected", "value": "rejected"},
                    ],
                    value: filterStatus,
                    onChanged: (value, label) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: [
                      {"label": "This Month", "value": "this_month"},
                      {"label": "Last Month", "value": "last_month"},
                      {"label": "This Quarter", "value": "this_quarter"},
                      {"label": "This Year", "value": "this_year"},
                    ],
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Expenses List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Expenses (${filteredExpenses.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Bulk Actions",
                        size: bs.sm,
                        onPressed: () {
                          // Show bulk actions menu
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredExpenses.map((expense) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(expense["category"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getCategoryIcon(expense["category"]),
                                  color: _getCategoryColor(expense["category"]),
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${expense["description"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${expense["vendor"]} • ${expense["subcategory"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${expense["date"]} • ${expense["id"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((expense["amount"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(expense["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      _getStatusText(expense["status"]),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(expense["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Submitted By",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${expense["submittedBy"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (expense["approvedBy"] != null)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Approved By",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${expense["approvedBy"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (expense["recurring"] as bool)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.repeat,
                                        size: 12,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Recurring",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          if ((expense["tags"] as List).isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Wrap(
                              spacing: spXs,
                              children: (expense["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Receipt",
                                  size: bs.sm,
                                  onPressed: () {
                                    // View receipt
                                  },
                                ),
                              ),
                              if (expense["status"] == "pending") ...[
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Approve",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Approve expense
                                  },
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Reject",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Reject expense
                                  },
                                ),
                              ],
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show options menu
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
