import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaMiniStatementView extends StatefulWidget {
  const BfaMiniStatementView({super.key});

  @override
  State<BfaMiniStatementView> createState() => _BfaMiniStatementViewState();
}

class _BfaMiniStatementViewState extends State<BfaMiniStatementView> {
  String selectedPeriod = "7";
  
  // Sample account data
  Map<String, dynamic> account = {
    "accountNumber": "****5678",
    "accountType": "Savings Account",
    "currentBalance": 125750.0,
    "availableBalance": 125750.0,
    "currency": "USD"
  };

  // Sample transactions
  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "type": "Credit",
      "description": "Salary Credit",
      "amount": 5000.0,
      "balance": 125750.0,
      "date": "2024-12-15T10:30:00Z",
      "category": "Income",
      "icon": Icons.trending_up
    },
    {
      "id": "TXN002", 
      "type": "Debit",
      "description": "Online Shopping",
      "amount": -250.0,
      "balance": 120750.0,
      "date": "2024-12-14T16:45:00Z",
      "category": "Shopping",
      "icon": Icons.shopping_bag
    },
    {
      "id": "TXN003",
      "type": "Debit", 
      "description": "ATM Withdrawal",
      "amount": -100.0,
      "balance": 121000.0,
      "date": "2024-12-14T09:15:00Z",
      "category": "Cash",
      "icon": Icons.local_atm
    },
    {
      "id": "TXN004",
      "type": "Credit",
      "description": "Refund - Amazon",
      "amount": 75.0,
      "balance": 121100.0,
      "date": "2024-12-13T14:20:00Z",
      "category": "Refund",
      "icon": Icons.keyboard_return
    },
    {
      "id": "TXN005",
      "type": "Debit",
      "description": "Electricity Bill",
      "amount": -125.0,
      "balance": 121025.0,
      "date": "2024-12-12T11:00:00Z",
      "category": "Utilities",
      "icon": Icons.flash_on
    },
    {
      "id": "TXN006",
      "type": "Debit",
      "description": "Transfer to John",
      "amount": -500.0,
      "balance": 121150.0,
      "date": "2024-12-11T13:30:00Z",
      "category": "Transfer",
      "icon": Icons.send
    },
    {
      "id": "TXN007",
      "type": "Credit",
      "description": "Dividend Credit",
      "amount": 150.0,
      "balance": 121650.0,
      "date": "2024-12-10T08:45:00Z",
      "category": "Investment",
      "icon": Icons.trending_up
    }
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 7 days", "value": "7"},
    {"label": "Last 15 days", "value": "15"},
    {"label": "Last 30 days", "value": "30"},
    {"label": "Last 90 days", "value": "90"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mini Statement"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Statement downloaded successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Statement shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Account Balance Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${account["accountType"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "${account["accountNumber"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "Current Balance",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${(account["currentBalance"] as double).currency}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Available: \$${(account["availableBalance"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ],
              ),
            ),

            // Period Filter
            Row(
              children: [
                Text(
                  "Period:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Period",
                    items: periodItems,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Transaction Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Transaction Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Money In", 
                          transactions.where((t) => (t["amount"] as double) > 0)
                              .fold(0.0, (sum, t) => sum + (t["amount"] as double)),
                          successColor,
                          Icons.trending_up
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Money Out", 
                          transactions.where((t) => (t["amount"] as double) < 0)
                              .fold(0.0, (sum, t) => sum + ((t["amount"] as double) * -1)),
                          dangerColor,
                          Icons.trending_down
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Transactions List
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spLg),
                    child: Row(
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
                          onTap: () {
                            //navigateTo('BfaTransactionHistoryView')
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  ...List.generate(transactions.length, (index) {
                    final transaction = transactions[index];
                    return _buildTransactionItem(transaction, index == transactions.length - 1);
                  }),
                ],
              ),
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Transfer Money",
                          icon: Icons.send,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaTransferMoneyView')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Request Statement",
                          icon: Icons.description,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaEStatementView')
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

  Widget _buildSummaryCard(String title, double amount, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction, bool isLast) {
    bool isCredit = (transaction["amount"] as double) > 0;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spLg, vertical: spSm),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCredit ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              transaction["icon"],
              color: isCredit ? successColor : dangerColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${transaction["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${DateTime.parse(transaction["date"]).dMMMy}",
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
                "${isCredit ? '+' : ''}\$${((transaction["amount"] as double).abs()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isCredit ? successColor : dangerColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Bal: \$${(transaction["balance"] as double).currency}",
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
