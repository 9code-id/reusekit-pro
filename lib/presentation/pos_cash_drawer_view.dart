import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCashDrawerView extends StatefulWidget {
  const PosCashDrawerView({Key? key}) : super(key: key);

  @override
  State<PosCashDrawerView> createState() => _PosCashDrawerViewState();
}

class _PosCashDrawerViewState extends State<PosCashDrawerView> {
  bool isDrawerOpen = false;
  String currentCashier = "Sarah Mitchell";
  DateTime shiftStartTime = DateTime.now().subtract(Duration(hours: 3, minutes: 45));
  
  Map<String, dynamic> drawerStatus = {
    "starting_float": 200.00,
    "current_balance": 1850.75,
    "cash_sales": 1420.50,
    "cash_in": 150.00,
    "cash_out": 75.25,
    "expected_balance": 1695.25,
    "variance": 155.50,
    "transaction_count": 47,
  };

  List<Map<String, dynamic>> denominationCounts = [
    {"type": "bills", "value": 100.00, "count": 8, "total": 800.00},
    {"type": "bills", "value": 50.00, "count": 12, "total": 600.00},
    {"type": "bills", "value": 20.00, "count": 15, "total": 300.00},
    {"type": "bills", "value": 10.00, "count": 8, "total": 80.00},
    {"type": "bills", "value": 5.00, "count": 6, "total": 30.00},
    {"type": "bills", "value": 1.00, "count": 15, "total": 15.00},
    {"type": "coins", "value": 0.25, "count": 32, "total": 8.00},
    {"type": "coins", "value": 0.10, "count": 45, "total": 4.50},
    {"type": "coins", "value": 0.05, "count": 38, "total": 1.90},
    {"type": "coins", "value": 0.01, "count": 125, "total": 1.25},
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "Cash Sale",
      "amount": 45.80,
      "time": "14:32",
      "transaction_id": "TXN-001",
      "icon": Icons.point_of_sale,
      "color": Colors.green
    },
    {
      "type": "Cash Out",
      "amount": -25.00,
      "time": "14:15",
      "transaction_id": "CO-008",
      "icon": Icons.remove_circle,
      "color": Colors.red
    },
    {
      "type": "Cash In",
      "amount": 50.00,
      "time": "13:45",
      "transaction_id": "CI-012",
      "icon": Icons.add_circle,
      "color": Colors.blue
    },
    {
      "type": "Cash Sale",
      "amount": 128.50,
      "time": "13:28",
      "transaction_id": "TXN-002",
      "icon": Icons.point_of_sale,
      "color": Colors.green
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkDrawerStatus();
  }

  void _checkDrawerStatus() {
    // Simulate drawer status check
    isDrawerOpen = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cash Drawer"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo(CashDrawerHistoryView)
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Status Card
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
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isDrawerOpen ? Colors.green.withAlpha(20) : Colors.red.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          isDrawerOpen ? Icons.lock_open : Icons.lock,
                          color: isDrawerOpen ? Colors.green : Colors.red,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isDrawerOpen ? "Drawer Open" : "Drawer Closed",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: isDrawerOpen ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              "Cashier: $currentCashier",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${DateTime.now().difference(shiftStartTime).inHours}h ${DateTime.now().difference(shiftStartTime).inMinutes % 60}m",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Balance Overview
            Row(
              children: [
                Expanded(
                  child: Container(
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
                          "Current Balance",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(drawerStatus["current_balance"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Expected: \$${(drawerStatus["expected_balance"] as double).currency}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                          "Variance",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(drawerStatus["variance"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: (drawerStatus["variance"] as double) >= 0 ? Colors.green : Colors.red,
                          ),
                        ),
                        Text(
                          "${drawerStatus["transaction_count"]} transactions",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

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
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Open Drawer",
                          icon: Icons.lock_open,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo(PosOpenDrawerView)
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Close Drawer",
                          icon: Icons.lock,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo(PosCloseDrawerView)
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Cash In",
                          icon: Icons.add_circle,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo(PosCashInView)
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Cash Out",
                          icon: Icons.remove_circle,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo(PosCashOutView)
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Denomination Breakdown
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
                      Text(
                        "Cash Breakdown",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          //navigateTo(PosCashCountView)
                        },
                        child: Text(
                          "Count Cash",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  // Bills Section
                  Text(
                    "Bills",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  ...denominationCounts.where((d) => d["type"] == "bills").map((denomination) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "\$${(denomination["value"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${denomination["count"]} × \$${(denomination["value"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "\$${(denomination["total"] as double).currency}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  SizedBox(height: spSm),
                  
                  // Coins Section
                  Text(
                    "Coins",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  ...denominationCounts.where((d) => d["type"] == "coins").map((denomination) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${(denomination["value"] as double) < 1 ? ((denomination["value"] as double) * 100).toInt() : (denomination["value"] as double).toInt()}¢",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${denomination["count"]} coins",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "\$${(denomination["total"] as double).currency}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Recent Activities
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
                    "Recent Activities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recentActivities.length,
                    itemBuilder: (context, index) {
                      final activity = recentActivities[index];
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: index < recentActivities.length - 1 ? spSm : 0),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (activity["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                activity["icon"] as IconData,
                                color: activity["color"] as Color,
                                size: 18,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${activity["type"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${activity["time"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${activity["transaction_id"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${(activity["amount"] as double) < 0 ? '-' : ''}\$${((activity["amount"] as double).abs()).currency}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: activity["color"] as Color,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
    );
  }
}
