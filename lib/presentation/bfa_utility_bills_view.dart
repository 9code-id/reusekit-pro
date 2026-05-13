import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaUtilityBillsView extends StatefulWidget {
  const BfaUtilityBillsView({super.key});

  @override
  State<BfaUtilityBillsView> createState() => _BfaUtilityBillsViewState();
}

class _BfaUtilityBillsViewState extends State<BfaUtilityBillsView> {
  int currentTab = 0;

  List<Map<String, dynamic>> electricBills = [
    {
      "id": 1,
      "provider": "City Electric Company",
      "account": "E-789456123",
      "amount": 125.50,
      "dueDate": "2025-01-20",
      "billPeriod": "Dec 2024",
      "usage": "450 kWh",
      "status": "Pending",
      "lastReading": "15,450",
      "currentReading": "15,900"
    },
    {
      "id": 2,
      "provider": "Green Power Electric",
      "account": "E-456789012",
      "amount": 98.75,
      "dueDate": "2025-01-25",
      "billPeriod": "Dec 2024",
      "usage": "320 kWh",
      "status": "Paid",
      "lastReading": "8,200",
      "currentReading": "8,520"
    }
  ];

  List<Map<String, dynamic>> waterBills = [
    {
      "id": 1,
      "provider": "Municipal Water Authority",
      "account": "W-987654321",
      "amount": 78.25,
      "dueDate": "2025-01-18",
      "billPeriod": "Dec 2024",
      "usage": "1,200 gallons",
      "status": "Pending",
      "lastReading": "25,400",
      "currentReading": "26,600"
    },
    {
      "id": 2,
      "provider": "County Water Service",
      "account": "W-123456789",
      "amount": 65.40,
      "dueDate": "2025-01-22",
      "billPeriod": "Dec 2024",
      "usage": "950 gallons",
      "status": "Overdue",
      "lastReading": "12,100",
      "currentReading": "13,050"
    }
  ];

  List<Map<String, dynamic>> gasBills = [
    {
      "id": 1,
      "provider": "Natural Gas Company",
      "account": "G-555666777",
      "amount": 145.80,
      "dueDate": "2025-01-15",
      "billPeriod": "Dec 2024",
      "usage": "85 therms",
      "status": "Pending",
      "lastReading": "2,850",
      "currentReading": "2,935"
    }
  ];

  List<Map<String, dynamic>> internetBills = [
    {
      "id": 1,
      "provider": "FastNet Internet",
      "account": "I-789123456",
      "amount": 89.99,
      "dueDate": "2025-01-30",
      "billPeriod": "Jan 2025",
      "usage": "Unlimited",
      "status": "Paid",
      "plan": "100 Mbps",
      "dataUsed": "750 GB"
    },
    {
      "id": 2,
      "provider": "SpeedLink Broadband",
      "account": "I-456789123",
      "amount": 110.00,
      "dueDate": "2025-01-12",
      "billPeriod": "Jan 2025",
      "usage": "Unlimited",
      "status": "Overdue",
      "plan": "200 Mbps",
      "dataUsed": "1.2 TB"
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getUtilityIcon(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return Icons.electrical_services;
      case 1:
        return Icons.water_drop;
      case 2:
        return Icons.local_fire_department;
      case 3:
        return Icons.wifi;
      default:
        return Icons.receipt;
    }
  }

  List<Map<String, dynamic>> _getCurrentBills() {
    switch (currentTab) {
      case 0:
        return electricBills;
      case 1:
        return waterBills;
      case 2:
        return gasBills;
      case 3:
        return internetBills;
      default:
        return [];
    }
  }

  double _getTotalDue() {
    return _getCurrentBills()
        .where((bill) => bill["status"] != "Paid")
        .map((bill) => bill["amount"] as double)
        .fold(0.0, (sum, amount) => sum + amount);
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Utility Bills",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Electric", icon: Icon(Icons.electrical_services)),
        Tab(text: "Water", icon: Icon(Icons.water_drop)),
        Tab(text: "Gas", icon: Icon(Icons.local_fire_department)),
        Tab(text: "Internet", icon: Icon(Icons.wifi)),
      ],
      tabChildren: [
        // Electric Bills Tab
        _buildUtilityTab(electricBills, "Electricity"),
        // Water Bills Tab
        _buildUtilityTab(waterBills, "Water"),
        // Gas Bills Tab
        _buildUtilityTab(gasBills, "Natural Gas"),
        // Internet Bills Tab
        _buildUtilityTab(internetBills, "Internet"),
      ],
      onInit: (tabController) {
        // Optional: Handle tab controller initialization
      },
    );
  }

  Widget _buildUtilityTab(List<Map<String, dynamic>> bills, String utilityType) {
    double totalDue = bills
        .where((bill) => bill["status"] != "Paid")
        .map((bill) => bill["amount"] as double)
        .fold(0.0, (sum, amount) => sum + amount);

    int overdueCount = bills.where((bill) => bill["status"] == "Overdue").length;
    int pendingCount = bills.where((bill) => bill["status"] == "Pending").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        _getUtilityIcon(currentTab),
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$utilityType Bills",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${bills.length} account${bills.length != 1 ? 's' : ''}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Total Due",
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "\$${totalDue.currency}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (overdueCount > 0)
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Overdue",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "$overdueCount",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (pendingCount > 0)
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Pending",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "$pendingCount",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Bills List
          if (bills.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    _getUtilityIcon(currentTab),
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No $utilityType Bills",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Add your $utilityType provider to track bills and payments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QButton(
                    label: "Add $utilityType Bill",
                    icon: Icons.add,
                    onPressed: () {
                      // navigateTo(AddUtilityBillView(utilityType));
                    },
                  ),
                ],
              ),
            )
          else
            ...bills.map((bill) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: bill["status"] == "Overdue"
                      ? Border.all(color: dangerColor.withAlpha(128))
                      : null,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            _getUtilityIcon(currentTab),
                            color: primaryColor,
                            size: 24,
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
                                      "${bill["provider"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(bill["status"]).withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${bill["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(bill["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Account: ${bill["account"]}",
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
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(bill["amount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Usage",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${bill["usage"]}",
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Due Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(bill["dueDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: bill["status"] == "Overdue" ? dangerColor : primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Bill Period: ",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${bill["billPeriod"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    if (bill["status"] != "Paid") ...[
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: bill["status"] == "Overdue" ? "Pay Now (Overdue)" : "Pay Bill",
                          onPressed: () {
                            // navigateTo(PayBillView(bill));
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),

          // Add New Bill Button
          if (bills.isNotEmpty)
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add Another $utilityType Account",
                icon: Icons.add,
                onPressed: () {
                  // navigateTo(AddUtilityBillView(utilityType));
                },
              ),
            ),
        ],
      ),
    );
  }
}
