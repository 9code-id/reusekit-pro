import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosFinancialSummaryView extends StatefulWidget {
  const PosFinancialSummaryView({Key? key}) : super(key: key);

  @override
  State<PosFinancialSummaryView> createState() => _PosFinancialSummaryViewState();
}

class _PosFinancialSummaryViewState extends State<PosFinancialSummaryView> {
  int selectedPeriod = 0;
  List<Map<String, dynamic>> periods = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> summaryData = [
    {
      "title": "Total Sales",
      "amount": 25840.50,
      "count": 156,
      "trend": 12.5,
      "icon": Icons.trending_up,
      "color": Colors.green
    },
    {
      "title": "Cash Sales",
      "amount": 18340.25,
      "count": 98,
      "trend": 8.3,
      "icon": Icons.attach_money,
      "color": Colors.blue
    },
    {
      "title": "Card Sales",
      "amount": 7500.25,
      "count": 58,
      "trend": 15.2,
      "icon": Icons.credit_card,
      "color": Colors.purple
    },
    {
      "title": "Refunds",
      "amount": 285.75,
      "count": 3,
      "trend": -2.1,
      "icon": Icons.keyboard_return,
      "color": Colors.red
    },
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "TXN-2024-001",
      "type": "Sale",
      "amount": 45.80,
      "payment": "Cash",
      "time": "14:32",
      "items": 3,
      "cashier": "Sarah M."
    },
    {
      "id": "TXN-2024-002",
      "type": "Sale",
      "amount": 128.50,
      "payment": "Card",
      "time": "14:28",
      "items": 7,
      "cashier": "John D."
    },
    {
      "id": "TXN-2024-003",
      "type": "Refund",
      "amount": -25.00,
      "payment": "Cash",
      "time": "14:15",
      "items": 1,
      "cashier": "Sarah M."
    },
    {
      "id": "TXN-2024-004",
      "type": "Sale",
      "amount": 89.25,
      "payment": "Card",
      "time": "14:10",
      "items": 4,
      "cashier": "Mike R."
    },
    {
      "id": "TXN-2024-005",
      "type": "Sale",
      "amount": 234.75,
      "payment": "Cash",
      "time": "13:58",
      "items": 12,
      "cashier": "Sarah M."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Summary"),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              ss("Report printed successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selection
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: List.generate(periods.length, (index) {
                  final period = periods[index];
                  final isSelected = selectedPeriod == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedPeriod = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spXs),
                        margin: EdgeInsets.only(right: index < periods.length - 1 ? spXs : 0),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${period["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: spMd),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: summaryData.map((data) {
                return Container(
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
                              color: (data["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              data["icon"] as IconData,
                              color: data["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (data["trend"] as double) > 0 ? Colors.green.withAlpha(20) : Colors.red.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(data["trend"] as double) > 0 ? '+' : ''}${(data["trend"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                color: (data["trend"] as double) > 0 ? Colors.green : Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${data["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((data["amount"] as double).abs()).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${data["count"]} transactions",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
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
                          label: "Cash Drawer",
                          icon: Icons.point_of_sale,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo(PosCashDrawerView)
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Reconciliation",
                          icon: Icons.balance,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo(PosReconciliationView)
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Recent Transactions
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
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          //navigateTo(TransactionListView)
                        },
                        child: Text(
                          "View All",
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recentTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = recentTransactions[index];
                      final isRefund = transaction["type"] == "Refund";
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: index < recentTransactions.length - 1 ? spSm : 0),
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
                                color: isRefund ? Colors.red.withAlpha(20) : Colors.green.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                isRefund ? Icons.keyboard_return : Icons.point_of_sale,
                                color: isRefund ? Colors.red : Colors.green,
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
                                        "${transaction["id"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${transaction["time"]}",
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
                                        "${transaction["payment"]} • ${transaction["items"]} items",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${isRefund ? '-' : ''}\$${((transaction["amount"] as double).abs()).currency}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isRefund ? Colors.red : Colors.green,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Cashier: ${transaction["cashier"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                    ),
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
