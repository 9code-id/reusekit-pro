import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaLiabilityAccountsView extends StatefulWidget {
  const AbaLiabilityAccountsView({super.key});

  @override
  State<AbaLiabilityAccountsView> createState() => _AbaLiabilityAccountsViewState();
}

class _AbaLiabilityAccountsViewState extends State<AbaLiabilityAccountsView> {
  String searchQuery = "";
  String selectedSubtype = "All";
  bool loading = false;

  List<Map<String, dynamic>> subtypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Current Liabilities", "value": "Current Liabilities"},
    {"label": "Long-term Liabilities", "value": "Long-term Liabilities"},
    {"label": "Payroll Liabilities", "value": "Payroll Liabilities"},
    {"label": "Tax Liabilities", "value": "Tax Liabilities"},
  ];

  List<Map<String, dynamic>> liabilityAccounts = [
    {
      "id": "l001",
      "name": "Accounts Payable",
      "number": "2001",
      "subtype": "Current Liabilities",
      "balance": 8500.25,
      "status": "Active",
      "description": "Outstanding vendor bills and invoices",
      "dueWithin30Days": 5200.00,
      "overdue": 800.00,
      "lastTransaction": "2024-12-18",
      "vendorCount": 15,
      "averagePaymentDays": 28
    },
    {
      "id": "l002",
      "name": "Credit Card Payable",
      "number": "2100",
      "subtype": "Current Liabilities",
      "balance": 3200.00,
      "status": "Active",
      "description": "Business credit card outstanding balance",
      "dueWithin30Days": 3200.00,
      "overdue": 0.00,
      "lastTransaction": "2024-12-16",
      "vendorCount": 1,
      "averagePaymentDays": 15
    },
    {
      "id": "l003",
      "name": "Accrued Expenses",
      "number": "2200",
      "subtype": "Current Liabilities",
      "balance": 1500.00,
      "status": "Active",
      "description": "Expenses incurred but not yet paid",
      "dueWithin30Days": 1500.00,
      "overdue": 0.00,
      "lastTransaction": "2024-12-17",
      "vendorCount": 8,
      "averagePaymentDays": 12
    },
    {
      "id": "l004",
      "name": "Short-term Notes Payable",
      "number": "2300",
      "subtype": "Current Liabilities",
      "balance": 5000.00,
      "status": "Active",
      "description": "Short-term business loan",
      "dueWithin30Days": 500.00,
      "overdue": 0.00,
      "lastTransaction": "2024-12-01",
      "vendorCount": 1,
      "averagePaymentDays": 30
    },
    {
      "id": "l005",
      "name": "Payroll Taxes Payable",
      "number": "2400",
      "subtype": "Payroll Liabilities",
      "balance": 2200.00,
      "status": "Active",
      "description": "Employee and employer payroll taxes",
      "dueWithin30Days": 2200.00,
      "overdue": 0.00,
      "lastTransaction": "2024-12-15",
      "vendorCount": 3,
      "averagePaymentDays": 15
    },
    {
      "id": "l006",
      "name": "Employee Benefits Payable",
      "number": "2450",
      "subtype": "Payroll Liabilities",
      "balance": 800.00,
      "status": "Active",
      "description": "Health insurance and retirement contributions",
      "dueWithin30Days": 800.00,
      "overdue": 0.00,
      "lastTransaction": "2024-12-10",
      "vendorCount": 2,
      "averagePaymentDays": 30
    },
    {
      "id": "l007",
      "name": "Sales Tax Payable",
      "number": "2500",
      "subtype": "Tax Liabilities",
      "balance": 1800.00,
      "status": "Active",
      "description": "Collected sales tax to be remitted",
      "dueWithin30Days": 1800.00,
      "overdue": 0.00,
      "lastTransaction": "2024-12-19",
      "vendorCount": 1,
      "averagePaymentDays": 30
    },
    {
      "id": "l008",
      "name": "Income Tax Payable",
      "number": "2600",
      "subtype": "Tax Liabilities",
      "balance": 4500.00,
      "status": "Active",
      "description": "Estimated quarterly income tax",
      "dueWithin30Days": 0.00,
      "overdue": 0.00,
      "lastTransaction": "2024-12-05",
      "vendorCount": 1,
      "averagePaymentDays": 90
    },
    {
      "id": "l009",
      "name": "Long-term Business Loan",
      "number": "2700",
      "subtype": "Long-term Liabilities",
      "balance": 15000.00,
      "status": "Active",
      "description": "Equipment financing loan",
      "dueWithin30Days": 500.00,
      "overdue": 0.00,
      "lastTransaction": "2024-12-01",
      "vendorCount": 1,
      "averagePaymentDays": 30
    },
    {
      "id": "l010",
      "name": "Equipment Lease",
      "number": "2800",
      "subtype": "Long-term Liabilities",
      "balance": 3600.00,
      "status": "Active",
      "description": "Office equipment lease payments",
      "dueWithin30Days": 300.00,
      "overdue": 0.00,
      "lastTransaction": "2024-12-01",
      "vendorCount": 1,
      "averagePaymentDays": 30
    }
  ];

  List<Map<String, dynamic>> get filteredAccounts {
    return liabilityAccounts.where((account) {
      bool matchesSearch = "${account["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${account["number"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSubtype = selectedSubtype == "All" || account["subtype"] == selectedSubtype;
      return matchesSearch && matchesSubtype;
    }).toList();
  }

  Color _getSubtypeColor(String subtype) {
    switch (subtype) {
      case "Current Liabilities":
        return dangerColor;
      case "Long-term Liabilities":
        return warningColor;
      case "Payroll Liabilities":
        return infoColor;
      case "Tax Liabilities":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getSubtypeIcon(String subtype) {
    switch (subtype) {
      case "Current Liabilities":
        return Icons.schedule;
      case "Long-term Liabilities":
        return Icons.hourglass_empty;
      case "Payroll Liabilities":
        return Icons.people;
      case "Tax Liabilities":
        return Icons.receipt_long;
      default:
        return Icons.credit_card;
    }
  }

  double get totalLiabilities {
    return filteredAccounts.map((account) => account["balance"] as double).fold(0.0, (sum, balance) => sum + balance);
  }

  double get totalCurrentLiabilities {
    return filteredAccounts
        .where((account) => account["subtype"] == "Current Liabilities")
        .map((account) => account["balance"] as double)
        .fold(0.0, (sum, balance) => sum + balance);
  }

  double get totalDueWithin30Days {
    return filteredAccounts.map((account) => account["dueWithin30Days"] as double).fold(0.0, (sum, amount) => sum + amount);
  }

  double get totalOverdue {
    return filteredAccounts.map((account) => account["overdue"] as double).fold(0.0, (sum, amount) => sum + amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liability Accounts"),
        actions: [
          IconButton(
            onPressed: () {
              //navigateTo('PayBillsView')
            },
            icon: Icon(Icons.payment),
          ),
          IconButton(
            onPressed: () {
              //navigateTo('AddLiabilityAccountView')
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Search and Filter Section
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Search liability accounts...",
                                value: searchQuery,
                                hint: "Account name or number",
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        QDropdownField(
                          label: "Liability Type",
                          items: subtypeOptions,
                          value: selectedSubtype,
                          onChanged: (value, label) {
                            selectedSubtype = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Summary Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildSummaryCard(
                        "Total Liabilities",
                        "${totalLiabilities.currency}",
                        Icons.credit_card,
                        dangerColor,
                      ),
                      _buildSummaryCard(
                        "Current Liabilities",
                        "${totalCurrentLiabilities.currency}",
                        Icons.schedule,
                        warningColor,
                      ),
                      _buildSummaryCard(
                        "Due in 30 Days",
                        "${totalDueWithin30Days.currency}",
                        Icons.alarm,
                        infoColor,
                      ),
                      _buildSummaryCard(
                        "Overdue",
                        "${totalOverdue.currency}",
                        Icons.warning,
                        totalOverdue > 0 ? dangerColor : successColor,
                      ),
                    ],
                  ),

                  // Payment Alerts
                  if (totalDueWithin30Days > 0) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: warningColor.withAlpha(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.alarm,
                              color: warningColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Due Soon",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "${totalDueWithin30Days.currency} due within 30 days",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Pay Bills",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('PayBillsView')
                            },
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Accounts List
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              Icon(
                                Icons.list,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Liability Accounts (${filteredAccounts.length})",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredAccounts.length,
                          separatorBuilder: (context, index) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final account = filteredAccounts[index];
                            bool hasOverdue = (account["overdue"] as double) > 0;
                            bool hasDueSoon = (account["dueWithin30Days"] as double) > 0;

                            return GestureDetector(
                              onTap: () {
                                //navigateTo('LiabilityAccountDetailView', account)
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: _getSubtypeColor("${account["subtype"]}").withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        _getSubtypeIcon("${account["subtype"]}"),
                                        color: _getSubtypeColor("${account["subtype"]}"),
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${account["name"]}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ),
                                              if (hasOverdue) ...[
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: spXs,
                                                    vertical: 2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: dangerColor.withAlpha(20),
                                                    borderRadius: BorderRadius.circular(radiusXs),
                                                  ),
                                                  child: Text(
                                                    "OVERDUE",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: dangerColor,
                                                    ),
                                                  ),
                                                ),
                                              ] else if (hasDueSoon) ...[
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: spXs,
                                                    vertical: 2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: warningColor.withAlpha(20),
                                                    borderRadius: BorderRadius.circular(radiusXs),
                                                  ),
                                                  child: Text(
                                                    "DUE SOON",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: warningColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Text(
                                                "No. ${account["number"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Container(
                                                width: 4,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: disabledColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spXs,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _getSubtypeColor("${account["subtype"]}").withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "${account["subtype"]}",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: _getSubtypeColor("${account["subtype"]}"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (account["description"] != null) ...[
                                            SizedBox(height: 2),
                                            Text(
                                              "${account["description"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                          if (hasDueSoon) ...[
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.schedule,
                                                  color: warningColor,
                                                  size: 12,
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "Due: ${(account["dueWithin30Days"] as double).currency}",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color: warningColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${(account["balance"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: dangerColor,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "${account["vendorCount"]} vendor${(account["vendorCount"] as int) > 1 ? 's' : ''}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: disabledColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('PayBillsView')
        },
        child: Icon(Icons.payment),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_down,
                color: color,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
