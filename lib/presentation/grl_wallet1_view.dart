import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWallet1View extends StatefulWidget {
  @override
  State<GrlWallet1View> createState() => _GrlWallet1ViewState();
}

class _GrlWallet1ViewState extends State<GrlWallet1View> {
  List<Map<String, dynamic>> transactions = [
    {
      "id": "1",
      "type": "income",
      "title": "Salary Payment",
      "category": "Job",
      "amount": 5000.0,
      "date": "2024-01-15",
      "icon": Icons.work,
      "color": Colors.green
    },
    {
      "id": "2",
      "type": "expense",
      "title": "Grocery Shopping",
      "category": "Food",
      "amount": 120.0,
      "date": "2024-01-14",
      "icon": Icons.shopping_cart,
      "color": Colors.orange
    },
    {
      "id": "3",
      "type": "expense",
      "title": "Gas Station",
      "category": "Transportation",
      "amount": 65.0,
      "date": "2024-01-13",
      "icon": Icons.local_gas_station,
      "color": Colors.blue
    },
    {
      "id": "4",
      "type": "income",
      "title": "Freelance Work",
      "category": "Business",
      "amount": 800.0,
      "date": "2024-01-12",
      "icon": Icons.laptop,
      "color": Colors.purple
    },
    {
      "id": "5",
      "type": "expense",
      "title": "Electric Bill",
      "category": "Utilities",
      "amount": 95.0,
      "date": "2024-01-11",
      "icon": Icons.electrical_services,
      "color": Colors.red
    },
    {
      "id": "6",
      "type": "income",
      "title": "Investment Return",
      "category": "Investment",
      "amount": 320.0,
      "date": "2024-01-10",
      "icon": Icons.trending_up,
      "color": Colors.teal
    }
  ];

  double get totalBalance {
    double income = transactions
        .where((t) => t["type"] == "income")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
    double expenses = transactions
        .where((t) => t["type"] == "expense")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
    return income - expenses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wallet"),
        actions: [
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
            // Balance Card
            Container(
              width: double.infinity,
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
                    "Total Balance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "\$${totalBalance.currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBalanceInfo(
                        "Income",
                        transactions
                            .where((t) => t["type"] == "income")
                            .fold(0.0, (sum, t) => sum + (t["amount"] as double)),
                        Icons.arrow_upward,
                        Colors.green,
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withAlpha(100),
                      ),
                      _buildBalanceInfo(
                        "Expenses",
                        transactions
                            .where((t) => t["type"] == "expense")
                            .fold(0.0, (sum, t) => sum + (t["amount"] as double)),
                        Icons.arrow_downward,
                        Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add Income",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Add Expense",
                    icon: Icons.remove,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Transactions Header
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
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            // Transactions List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return _buildTransactionItem(transaction);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceInfo(String title, double amount, IconData icon, Color color) {
    return Column(
      spacing: spXs,
      children: [
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: color.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withAlpha(200),
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
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    bool isIncome = transaction["type"] == "income";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
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
                Text(
                  "${transaction["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${transaction["category"]} • ${transaction["date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${isIncome ? '+' : '-'}\$${(transaction["amount"] as double).currency}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isIncome ? successColor : dangerColor,
            ),
          ),
        ],
      ),
    );
  }
}
