import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction9View extends StatefulWidget {
  @override
  State<GrlTransaction9View> createState() => _GrlTransaction9ViewState();
}

class _GrlTransaction9ViewState extends State<GrlTransaction9View> {
  String selectedPeriod = "This Month";
  String selectedCategory = "All";
  
  List<String> periods = ["This Week", "This Month", "Last Month", "This Year"];
  List<String> categories = ["All", "Food", "Shopping", "Transport", "Entertainment"];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "merchant": "Starbucks Coffee",
      "category": "Food",
      "amount": -4.50,
      "date": "2024-01-15",
      "time": "08:30 AM",
      "status": "completed",
      "icon": Icons.local_cafe,
      "color": Colors.brown,
    },
    {
      "id": "TXN002",
      "merchant": "Amazon Purchase",
      "category": "Shopping",
      "amount": -29.99,
      "date": "2024-01-15",
      "time": "02:15 PM",
      "status": "completed",
      "icon": Icons.shopping_bag,
      "color": Colors.orange,
    },
    {
      "id": "TXN003",
      "merchant": "Salary Deposit",
      "category": "Income",
      "amount": 2500.00,
      "date": "2024-01-14",
      "time": "09:00 AM",
      "status": "completed",
      "icon": Icons.account_balance,
      "color": Colors.green,
    },
    {
      "id": "TXN004",
      "merchant": "Uber Ride",
      "category": "Transport",
      "amount": -12.75,
      "date": "2024-01-14",
      "time": "07:45 PM",
      "status": "completed",
      "icon": Icons.directions_car,
      "color": Colors.blue,
    },
    {
      "id": "TXN005",
      "merchant": "Netflix Subscription",
      "category": "Entertainment",
      "amount": -15.99,
      "date": "2024-01-13",
      "time": "12:00 PM",
      "status": "completed",
      "icon": Icons.play_circle,
      "color": Colors.red,
    },
    {
      "id": "TXN006",
      "merchant": "Gas Station",
      "category": "Transport",
      "amount": -45.20,
      "date": "2024-01-13",
      "time": "06:30 PM",
      "status": "pending",
      "icon": Icons.local_gas_station,
      "color": Colors.green,
    },
    {
      "id": "TXN007",
      "merchant": "Grocery Store",
      "category": "Food",
      "amount": -67.85,
      "date": "2024-01-12",
      "time": "11:15 AM",
      "status": "completed",
      "icon": Icons.shopping_cart,
      "color": Colors.green,
    },
    {
      "id": "TXN008",
      "merchant": "Movie Theater",
      "category": "Entertainment",
      "amount": -24.50,
      "date": "2024-01-11",
      "time": "08:00 PM",
      "status": "completed",
      "icon": Icons.movie,
      "color": Colors.purple,
    },
  ];

  Map<String, dynamic> summary = {
    "total_income": 2500.00,
    "total_expense": 200.78,
    "net_balance": 2299.22,
    "transaction_count": 8,
  };

  List<Map<String, dynamic>> get filteredTransactions {
    if (selectedCategory == "All") {
      return transactions;
    }
    return transactions.where((t) => "${t["category"]}" == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterModal(),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Period",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: periods.map((period) {
                      bool isSelected = period == selectedPeriod;
                      return GestureDetector(
                        onTap: () {
                          selectedPeriod = period;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            period,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Income",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((summary["total_income"] as double).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_down,
                              color: dangerColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Expense",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((summary["total_expense"] as double).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            // Net Balance
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Net Balance",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${((summary["net_balance"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${summary["transaction_count"]} transactions this month",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Category Filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Transactions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showFilterModal(),
                  child: Row(
                    children: [
                      Text(
                        selectedCategory,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        Icons.arrow_drop_down,
                        color: primaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            // Transactions List
            Column(
              children: filteredTransactions.map((transaction) {
                bool isIncome = (transaction["amount"] as double) > 0;
                String date = "${transaction["date"]}";
                String time = "${transaction["time"]}";
                bool isPending = "${transaction["status"]}" == "pending";

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isPending ? Border.all(color: warningColor.withAlpha(100)) : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: (transaction["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          transaction["icon"] as IconData,
                          color: transaction["color"] as Color,
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
                                    "${transaction["merchant"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (isPending)
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
                                      "Pending",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${transaction["category"]} • $date $time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${isIncome ? '+' : ''}\$${((transaction["amount"] as double).abs().toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isIncome ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Load More Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More Transactions",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter Transactions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "Category",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: categories.map((category) {
                bool isSelected = category == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
