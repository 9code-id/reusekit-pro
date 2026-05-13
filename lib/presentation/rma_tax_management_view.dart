import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTaxManagementView extends StatefulWidget {
  const RmaTaxManagementView({super.key});

  @override
  State<RmaTaxManagementView> createState() => _RmaTaxManagementViewState();
}

class _RmaTaxManagementViewState extends State<RmaTaxManagementView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedTaxType = "All";
  String selectedPeriod = "Current Quarter";
  String selectedStatus = "All";

  List<Map<String, dynamic>> taxTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Sales Tax", "value": "sales"},
    {"label": "Income Tax", "value": "income"},
    {"label": "VAT", "value": "vat"},
    {"label": "Property Tax", "value": "property"},
    {"label": "Payroll Tax", "value": "payroll"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Quarter", "value": "current_quarter"},
    {"label": "Last Quarter", "value": "last_quarter"},
    {"label": "Current Year", "value": "current_year"},
    {"label": "Last Year", "value": "last_year"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "pending"},
    {"label": "Filed", "value": "filed"},
    {"label": "Paid", "value": "paid"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> taxSummary = [
    {
      "title": "Total Tax Liability",
      "amount": 42850.75,
      "change": 8.5,
      "icon": Icons.account_balance,
      "color": dangerColor,
      "period": "This Quarter",
    },
    {
      "title": "Taxes Paid",
      "amount": 38240.50,
      "change": 12.3,
      "icon": Icons.payment,
      "color": successColor,
      "period": "YTD",
    },
    {
      "title": "Outstanding Amount",
      "amount": 4610.25,
      "change": -15.2,
      "icon": Icons.pending_actions,
      "color": warningColor,
      "period": "Current",
    },
    {
      "title": "Tax Savings",
      "amount": 8950.00,
      "change": 25.8,
      "icon": Icons.savings,
      "color": primaryColor,
      "period": "This Year",
    },
  ];

  List<Map<String, dynamic>> taxObligations = [
    {
      "id": "TAX-2024-Q1-001",
      "type": "Sales Tax",
      "amount": 12450.50,
      "dueDate": "2024-04-15",
      "status": "pending",
      "jurisdiction": "California",
      "period": "Q1 2024",
      "filed": false,
    },
    {
      "id": "TAX-2024-Q1-002",
      "type": "Income Tax",
      "amount": 25800.00,
      "dueDate": "2024-04-15",
      "status": "filed",
      "jurisdiction": "Federal",
      "period": "Q1 2024",
      "filed": true,
    },
    {
      "id": "TAX-2024-001",
      "type": "VAT",
      "amount": 8750.25,
      "dueDate": "2024-03-31",
      "status": "paid",
      "jurisdiction": "UK",
      "period": "Q1 2024",
      "filed": true,
    },
    {
      "id": "TAX-2024-002",
      "type": "Payroll Tax",
      "amount": 15600.75,
      "dueDate": "2024-03-15",
      "status": "overdue",
      "jurisdiction": "New York",
      "period": "Q1 2024",
      "filed": false,
    },
    {
      "id": "TAX-2024-003",
      "type": "Property Tax",
      "amount": 5890.00,
      "dueDate": "2024-05-01",
      "status": "pending",
      "jurisdiction": "Texas",
      "period": "2024",
      "filed": false,
    },
  ];

  List<Map<String, dynamic>> taxRates = [
    {
      "jurisdiction": "California",
      "salesTax": 7.25,
      "incomeTax": 13.3,
      "propertyTax": 0.75,
      "lastUpdated": "2024-01-01",
    },
    {
      "jurisdiction": "New York",
      "salesTax": 8.0,
      "incomeTax": 10.9,
      "propertyTax": 1.25,
      "lastUpdated": "2024-01-01",
    },
    {
      "jurisdiction": "Texas",
      "salesTax": 6.25,
      "incomeTax": 0.0,
      "propertyTax": 1.8,
      "lastUpdated": "2024-01-01",
    },
    {
      "jurisdiction": "Federal",
      "salesTax": 0.0,
      "incomeTax": 21.0,
      "propertyTax": 0.0,
      "lastUpdated": "2024-01-01",
    },
    {
      "jurisdiction": "UK",
      "salesTax": 20.0,
      "incomeTax": 19.0,
      "propertyTax": 0.0,
      "lastUpdated": "2024-01-01",
    },
  ];

  List<Map<String, dynamic>> upcomingDeadlines = [
    {
      "type": "Sales Tax",
      "jurisdiction": "California",
      "dueDate": "2024-04-15",
      "amount": 12450.50,
      "daysLeft": 12,
      "status": "pending",
    },
    {
      "type": "Income Tax",
      "jurisdiction": "Federal",
      "dueDate": "2024-04-15",
      "amount": 25800.00,
      "daysLeft": 12,
      "status": "filed",
    },
    {
      "type": "VAT Return",
      "jurisdiction": "UK",
      "dueDate": "2024-04-30",
      "amount": 8950.75,
      "daysLeft": 27,
      "status": "pending",
    },
    {
      "type": "Property Tax",
      "jurisdiction": "Texas",
      "dueDate": "2024-05-01",
      "amount": 5890.00,
      "daysLeft": 28,
      "status": "pending",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid': return successColor;
      case 'filed': return primaryColor;
      case 'pending': return warningColor;
      case 'overdue': return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getUrgencyColor(int daysLeft) {
    if (daysLeft <= 7) return dangerColor;
    if (daysLeft <= 14) return warningColor;
    return successColor;
  }

  void _showTaxDetails(Map<String, dynamic> tax) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Tax Obligation Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(tax["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      color: _getStatusColor(tax["status"]),
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${tax["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(tax["status"]),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(tax["status"]),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${tax["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              _buildDetailRow("Tax Type", "${tax["type"]}"),
              _buildDetailRow("Jurisdiction", "${tax["jurisdiction"]}"),
              _buildDetailRow("Period", "${tax["period"]}"),
              _buildDetailRow("Amount", "\$${((tax["amount"] as num).toDouble()).currency}"),
              _buildDetailRow("Due Date", "${tax["dueDate"]}"),
              SizedBox(height: spSm),
              if (tax["filed"] == true) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Tax Return Filed",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: warningColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Tax Return Not Filed",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          if (tax["status"] == "pending") ...[
            QButton(
              label: "File Return",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Tax return filed successfully");
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: taxSummary.map((summary) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (summary["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            summary["icon"],
                            color: summary["color"],
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (summary["change"] as num) >= 0 
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                (summary["change"] as num) >= 0 
                                    ? Icons.trending_up 
                                    : Icons.trending_down,
                                color: (summary["change"] as num) >= 0 
                                    ? successColor 
                                    : dangerColor,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${(summary["change"] as num) >= 0 ? '+' : ''}${(summary["change"] as num).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: (summary["change"] as num) >= 0 
                                      ? successColor 
                                      : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${summary["title"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((summary["amount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${summary["period"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),
          Text(
            "Upcoming Deadlines",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...upcomingDeadlines.map((deadline) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getUrgencyColor(deadline["daysLeft"]),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${deadline["type"]} - ${deadline["jurisdiction"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Due: ${deadline["dueDate"]}",
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getUrgencyColor(deadline["daysLeft"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${deadline["daysLeft"]} days",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getUrgencyColor(deadline["daysLeft"]),
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((deadline["amount"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
    );
  }

  Widget _buildObligationsTab() {
    var filteredObligations = taxObligations.where((obligation) {
      bool matchesSearch = searchQuery.isEmpty || 
          obligation["type"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          obligation["jurisdiction"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          obligation["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedTaxType == "All" || obligation["type"] == selectedTaxType;
      bool matchesStatus = selectedStatus == "All" || obligation["status"] == selectedStatus;
      
      return matchesSearch && matchesType && matchesStatus;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search tax obligations...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showFiltersDialog();
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...filteredObligations.map((obligation) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(obligation["status"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${obligation["id"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${obligation["type"]} - ${obligation["jurisdiction"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(obligation["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${obligation["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(obligation["status"]),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((obligation["amount"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Due: ${obligation["dueDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.schedule,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${obligation["period"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (obligation["filed"] == true)
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
                        ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _showTaxDetails(obligation),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 14,
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
    );
  }

  Widget _buildRatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tax Rates by Jurisdiction",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...taxRates.map((rate) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${rate["jurisdiction"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "Updated: ${rate["lastUpdated"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
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
                              "Sales Tax",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(rate["salesTax"] as num).toStringAsFixed(2)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Income Tax",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(rate["incomeTax"] as num).toStringAsFixed(2)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Property Tax",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(rate["propertyTax"] as num).toStringAsFixed(2)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
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
          }).toList(),
        ],
      ),
    );
  }

  void _showFiltersDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Tax Obligations"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Tax Type",
              items: taxTypeOptions,
              value: selectedTaxType,
              onChanged: (value, label) {
                selectedTaxType = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedTaxType = "All";
              selectedStatus = "All";
              selectedPeriod = "Current Quarter";
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("Clear"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tax Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Obligations", icon: Icon(Icons.receipt_long)),
        Tab(text: "Tax Rates", icon: Icon(Icons.percent)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildObligationsTab(),
        _buildRatesTab(),
      ],
    );
  }
}
