import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaUtilityTrackingView extends StatefulWidget {
  const FmaUtilityTrackingView({super.key});

  @override
  State<FmaUtilityTrackingView> createState() => _FmaUtilityTrackingViewState();
}

class _FmaUtilityTrackingViewState extends State<FmaUtilityTrackingView> {
  int selectedTab = 0;
  String selectedPeriod = "This Month";
  String selectedUtilityType = "";

  List<Map<String, dynamic>> currentUtilities = [
    {
      "type": "Electricity",
      "provider": "City Power Company",
      "currentUsage": 4580.5,
      "currentCost": 687.08,
      "previousUsage": 4320.2,
      "previousCost": 648.03,
      "unit": "kWh",
      "rate": 0.15,
      "billingDate": "2024-06-25",
      "dueDate": "2024-07-15",
      "status": "Current",
      "accountNumber": "ELC-2024-001",
      "meterReading": 125678.5,
    },
    {
      "type": "Natural Gas",
      "provider": "Metro Gas Services",
      "currentUsage": 2340.8,
      "currentCost": 234.08,
      "previousUsage": 2180.5,
      "previousCost": 218.05,
      "unit": "therms",
      "rate": 0.10,
      "billingDate": "2024-06-20",
      "dueDate": "2024-07-10",
      "status": "Current",
      "accountNumber": "GAS-2024-002",
      "meterReading": 98765.8,
    },
    {
      "type": "Water",
      "provider": "Municipal Water Authority",
      "currentUsage": 1850.0,
      "currentCost": 148.00,
      "previousUsage": 1720.0,
      "previousCost": 137.60,
      "unit": "gallons",
      "rate": 0.08,
      "billingDate": "2024-06-28",
      "dueDate": "2024-07-18",
      "status": "Due Soon",
      "accountNumber": "WAT-2024-003",
      "meterReading": 67890.0,
    },
    {
      "type": "Waste Management",
      "provider": "Green Waste Solutions",
      "currentUsage": 8.0,
      "currentCost": 285.00,
      "previousUsage": 7.5,
      "previousCost": 268.75,
      "unit": "pickups",
      "rate": 35.625,
      "billingDate": "2024-06-15",
      "dueDate": "2024-07-05",
      "status": "Overdue",
      "accountNumber": "WST-2024-004",
      "meterReading": 0,
    },
    {
      "type": "Internet",
      "provider": "Business Connect ISP",
      "currentUsage": 2500.0,
      "currentCost": 199.99,
      "previousUsage": 2200.0,
      "previousCost": 199.99,
      "unit": "GB",
      "rate": 0.08,
      "billingDate": "2024-06-30",
      "dueDate": "2024-07-20",
      "status": "Current",
      "accountNumber": "INT-2024-005",
      "meterReading": 0,
    },
  ];

  List<Map<String, dynamic>> monthlyHistory = [
    {
      "month": "June 2024",
      "electricity": {"usage": 4580.5, "cost": 687.08},
      "gas": {"usage": 2340.8, "cost": 234.08},
      "water": {"usage": 1850.0, "cost": 148.00},
      "waste": {"usage": 8.0, "cost": 285.00},
      "internet": {"usage": 2500.0, "cost": 199.99},
      "total": 1554.15,
    },
    {
      "month": "May 2024",
      "electricity": {"usage": 4320.2, "cost": 648.03},
      "gas": {"usage": 2180.5, "cost": 218.05},
      "water": {"usage": 1720.0, "cost": 137.60},
      "waste": {"usage": 7.5, "cost": 268.75},
      "internet": {"usage": 2200.0, "cost": 199.99},
      "total": 1472.42,
    },
    {
      "month": "April 2024",
      "electricity": {"usage": 4150.8, "cost": 622.62},
      "gas": {"usage": 2050.2, "cost": 205.02},
      "water": {"usage": 1680.0, "cost": 134.40},
      "waste": {"usage": 7.0, "cost": 250.00},
      "internet": {"usage": 2100.0, "cost": 199.99},
      "total": 1412.03,
    },
    {
      "month": "March 2024",
      "electricity": {"usage": 4450.3, "cost": 667.55},
      "gas": {"usage": 2420.6, "cost": 242.06},
      "water": {"usage": 1790.0, "cost": 143.20},
      "waste": {"usage": 8.5, "cost": 302.50},
      "internet": {"usage": 2300.0, "cost": 199.99},
      "total": 1555.30,
    },
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "type": "High Usage Alert",
      "utility": "Electricity",
      "message": "Current usage is 12% higher than last month",
      "severity": "Medium",
      "date": "2024-06-25",
    },
    {
      "type": "Payment Overdue",
      "utility": "Waste Management",
      "message": "Payment is 5 days overdue",
      "severity": "High",
      "date": "2024-06-30",
    },
    {
      "type": "Due Soon",
      "utility": "Water",
      "message": "Payment due in 3 days",
      "severity": "Low",
      "date": "2024-07-01",
    },
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> utilityTypeItems = [
    {"label": "All Utilities", "value": ""},
    {"label": "Electricity", "value": "Electricity"},
    {"label": "Natural Gas", "value": "Natural Gas"},
    {"label": "Water", "value": "Water"},
    {"label": "Waste Management", "value": "Waste Management"},
    {"label": "Internet", "value": "Internet"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Current":
        return successColor;
      case "Due Soon":
        return warningColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getAlertColor(String severity) {
    switch (severity) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getUtilityIcon(String type) {
    switch (type) {
      case "Electricity":
        return Icons.electrical_services;
      case "Natural Gas":
        return Icons.local_fire_department;
      case "Water":
        return Icons.water_drop;
      case "Waste Management":
        return Icons.delete;
      case "Internet":
        return Icons.wifi;
      default:
        return Icons.power;
    }
  }

  Widget _buildOverviewTab() {
    double totalCurrentCost = currentUtilities.fold(0.0, (sum, utility) => sum + (utility["currentCost"] as double));
    double totalPreviousCost = currentUtilities.fold(0.0, (sum, utility) => sum + (utility["previousCost"] as double));
    double costChange = totalCurrentCost - totalPreviousCost;
    double percentChange = totalPreviousCost > 0 ? (costChange / totalPreviousCost) * 100 : 0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(Icons.attach_money, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Total Cost",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "\$${totalCurrentCost.currency}",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "This Month",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          costChange >= 0 ? Icons.trending_up : Icons.trending_down,
                          color: costChange >= 0 ? dangerColor : successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Monthly Change",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${costChange >= 0 ? '+' : ''}\$${costChange.abs().currency}",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: costChange >= 0 ? dangerColor : successColor,
                      ),
                    ),
                    Text(
                      "${percentChange >= 0 ? '+' : ''}${percentChange.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(Icons.schedule, color: warningColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Due Soon",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${currentUtilities.where((u) => u["status"] == "Due Soon").length}",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Bills",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(Icons.error, color: dangerColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Overdue",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${currentUtilities.where((u) => u["status"] == "Overdue").length}",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Bills",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Current Bills
          Container(
            padding: EdgeInsets.all(spMd),
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
                    Icon(Icons.receipt, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Current Bills",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Pay All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...currentUtilities.map((utility) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: _getStatusColor("${utility["status"]}").withAlpha(100),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _getStatusColor("${utility["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          _getUtilityIcon("${utility["type"]}"),
                          color: _getStatusColor("${utility["status"]}"),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${utility["type"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${utility["status"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${utility["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${utility["provider"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Usage: ${(utility["currentUsage"] as double).toStringAsFixed(1)} ${utility["unit"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${(utility["currentCost"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Due: ${utility["dueDate"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getStatusColor("${utility["status"]}"),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "vs Last: \$${(utility["previousCost"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),

          // Alerts
          Container(
            padding: EdgeInsets.all(spMd),
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
                    Icon(Icons.notifications, color: dangerColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Alerts & Notifications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...alerts.map((alert) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getAlertColor("${alert["severity"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: _getAlertColor("${alert["severity"]}").withAlpha(100),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        alert["type"] == "Payment Overdue" 
                            ? Icons.payment 
                            : alert["type"] == "High Usage Alert"
                                ? Icons.trending_up
                                : Icons.schedule,
                        color: _getAlertColor("${alert["severity"]}"),
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${alert["utility"]} - ${alert["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${alert["message"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${alert["date"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Period Filter
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodItems,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Utility Type",
                  items: utilityTypeItems,
                  value: selectedUtilityType,
                  onChanged: (value, label) {
                    selectedUtilityType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Monthly History
          ...monthlyHistory.map((month) => Container(
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spSm),
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
                    Icon(Icons.calendar_month, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "${month["month"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(month["total"] as double).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 150,
                  children: [
                    _buildUtilityHistoryCard("Electricity", month["electricity"], Icons.electrical_services),
                    _buildUtilityHistoryCard("Natural Gas", month["gas"], Icons.local_fire_department),
                    _buildUtilityHistoryCard("Water", month["water"], Icons.water_drop),
                    _buildUtilityHistoryCard("Waste", month["waste"], Icons.delete),
                    _buildUtilityHistoryCard("Internet", month["internet"], Icons.wifi),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildUtilityHistoryCard(String title, Map<String, dynamic> data, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "\$${(data["cost"] as double).currency}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${(data["usage"] as double).toStringAsFixed(1)}",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Utility Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildHistoryTab(),
      ],
    );
  }
}
