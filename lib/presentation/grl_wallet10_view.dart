import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWallet10View extends StatefulWidget {
  @override
  State<GrlWallet10View> createState() => _GrlWallet10ViewState();
}

class _GrlWallet10ViewState extends State<GrlWallet10View> {
  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "date": "2024-02-10",
      "time": "14:30",
      "description": "Netflix Subscription",
      "merchant": "Netflix Inc.",
      "category": "Entertainment",
      "amount": -15.99,
      "type": "subscription",
      "status": "completed",
      "paymentMethod": "Credit Card ****1234",
      "icon": Icons.tv,
      "color": Colors.red
    },
    {
      "id": "TXN002",
      "date": "2024-02-10",
      "time": "12:15",
      "description": "Grocery Shopping",
      "merchant": "SuperMart",
      "category": "Food & Dining",
      "amount": -85.42,
      "type": "purchase",
      "status": "completed",
      "paymentMethod": "Debit Card ****5678",
      "icon": Icons.shopping_cart,
      "color": Colors.orange
    },
    {
      "id": "TXN003",
      "date": "2024-02-09",
      "time": "16:45",
      "description": "Salary Deposit",
      "merchant": "TechCorp Inc.",
      "category": "Income",
      "amount": 3500.0,
      "type": "deposit",
      "status": "completed",
      "paymentMethod": "Direct Deposit",
      "icon": Icons.work,
      "color": Colors.green
    },
    {
      "id": "TXN004",
      "date": "2024-02-09",
      "time": "10:20",
      "description": "Coffee Shop",
      "merchant": "Brew Masters",
      "category": "Food & Dining",
      "amount": -4.75,
      "type": "purchase",
      "status": "completed",
      "paymentMethod": "Mobile Pay",
      "icon": Icons.local_cafe,
      "color": Colors.brown
    },
    {
      "id": "TXN005",
      "date": "2024-02-08",
      "time": "19:30",
      "description": "Transfer to John",
      "merchant": "John Smith",
      "category": "Transfer",
      "amount": -200.0,
      "type": "transfer",
      "status": "completed",
      "paymentMethod": "Bank Transfer",
      "icon": Icons.send,
      "color": Colors.blue
    },
    {
      "id": "TXN006",
      "date": "2024-02-08",
      "time": "15:12",
      "description": "Gas Station",
      "merchant": "Shell Gas",
      "category": "Transportation",
      "amount": -45.20,
      "type": "purchase",
      "status": "completed",
      "paymentMethod": "Credit Card ****1234",
      "icon": Icons.local_gas_station,
      "color": Colors.indigo
    },
    {
      "id": "TXN007",
      "date": "2024-02-07",
      "time": "11:45",
      "description": "Investment Return",
      "merchant": "Investment Fund",
      "category": "Investment",
      "amount": 125.50,
      "type": "dividend",
      "status": "completed",
      "paymentMethod": "Investment Account",
      "icon": Icons.trending_up,
      "color": Colors.teal
    },
    {
      "id": "TXN008",
      "date": "2024-02-07",
      "time": "09:30",
      "description": "Electric Bill",
      "merchant": "PowerCorp",
      "category": "Utilities",
      "amount": -89.50,
      "type": "bill_payment",
      "status": "pending",
      "paymentMethod": "AutoPay ****9012",
      "icon": Icons.electrical_services,
      "color": Colors.yellow
    }
  ];

  String selectedFilter = "All";
  List<String> filters = ["All", "Income", "Expenses", "Transfers", "Pending"];
  String selectedPeriod = "This Month";
  List<String> periods = ["Today", "This Week", "This Month", "Last Month"];

  List<Map<String, dynamic>> get filteredTransactions {
    List<Map<String, dynamic>> filtered = transactions;
    
    // Filter by type
    if (selectedFilter != "All") {
      if (selectedFilter == "Income") {
        filtered = filtered.where((t) => (t["amount"] as double) > 0).toList();
      } else if (selectedFilter == "Expenses") {
        filtered = filtered.where((t) => (t["amount"] as double) < 0).toList();
      } else if (selectedFilter == "Transfers") {
        filtered = filtered.where((t) => t["type"] == "transfer").toList();
      } else if (selectedFilter == "Pending") {
        filtered = filtered.where((t) => t["status"] == "pending").toList();
      }
    }
    
    return filtered;
  }

  double get totalIncome {
    return transactions
        .where((t) => (t["amount"] as double) > 0)
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
  }

  double get totalExpenses {
    return transactions
        .where((t) => (t["amount"] as double) < 0)
        .fold(0.0, (sum, t) => sum + (t["amount"] as double).abs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Transaction Summary
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Transaction Summary",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSummaryItem(
                        "Income",
                        totalIncome,
                        Icons.arrow_upward,
                        Colors.green.withAlpha(100),
                      ),
                      _buildSummaryItem(
                        "Expenses",
                        totalExpenses,
                        Icons.arrow_downward,
                        Colors.red.withAlpha(100),
                      ),
                      _buildSummaryItem(
                        "Net",
                        totalIncome - totalExpenses,
                        totalIncome - totalExpenses >= 0 
                            ? Icons.trending_up 
                            : Icons.trending_down,
                        totalIncome - totalExpenses >= 0 
                            ? Colors.green.withAlpha(100)
                            : Colors.red.withAlpha(100),
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
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: QDropdownField(
                      label: "Filter Type",
                      items: filters.map((filter) => {
                        "label": filter,
                        "value": filter,
                      }).toList(),
                      value: selectedFilter,
                      onChanged: (value, label) {
                        selectedFilter = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: QDropdownField(
                      label: "Period",
                      items: periods.map((period) => {
                        "label": period,
                        "value": period,
                      }).toList(),
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Transaction Statistics
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Transactions",
                    "${filteredTransactions.length}",
                    Icons.receipt,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Pending",
                    "${transactions.where((t) => t["status"] == "pending").length}",
                    Icons.schedule,
                    warningColor,
                  ),
                ),
              ],
            ),

            // Transactions List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Transactions",
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
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      return _buildTransactionItem(transaction);
                    },
                  ),
                ],
              ),
            ),

            // Export Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Export Options",
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
                          label: "Export PDF",
                          icon: Icons.picture_as_pdf,
                          size: bs.sm,
                          onPressed: () {
                            ss("PDF export started");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export CSV",
                          icon: Icons.table_chart,
                          size: bs.sm,
                          onPressed: () {
                            ss("CSV export started");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, double amount, IconData icon, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    double amount = transaction["amount"] as double;
    bool isIncome = amount > 0;
    String status = transaction["status"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: status == "pending" 
            ? warningColor.withAlpha(20)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(radiusSm),
        border: status == "pending" 
            ? Border.all(color: warningColor.withAlpha(100))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: (transaction["color"] as Color).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
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
                        "${transaction["description"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if (status == "pending")
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "PENDING",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${transaction["merchant"]} • ${transaction["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${transaction["date"]} ${transaction["time"]} • ${transaction["paymentMethod"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isIncome ? '+' : ''}\$${amount.abs().currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isIncome ? successColor : primaryColor,
                ),
              ),
              Text(
                "${transaction["id"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
