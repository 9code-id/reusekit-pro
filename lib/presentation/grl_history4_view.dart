import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHistory4View extends StatefulWidget {
  @override
  State<GrlHistory4View> createState() => _GrlHistory4ViewState();
}

class _GrlHistory4ViewState extends State<GrlHistory4View> {
  String searchQuery = "";
  String selectedCategory = "All";
  List<Map<String, dynamic>> historyData = [
    {
      "id": "TR001",
      "type": "Investment",
      "amount": 2500.00,
      "date": "2024-12-15",
      "status": "Completed",
      "description": "Cryptocurrency Purchase",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "id": "TR002",
      "type": "Withdrawal",
      "amount": -850.00,
      "date": "2024-12-14",
      "status": "Processing",
      "description": "Bank Transfer",
      "icon": Icons.trending_down,
      "color": warningColor,
    },
    {
      "id": "TR003",
      "type": "Deposit",
      "amount": 1200.00,
      "date": "2024-12-13",
      "status": "Completed",
      "description": "Salary Credit",
      "icon": Icons.add_circle,
      "color": infoColor,
    },
    {
      "id": "TR004",
      "type": "Transfer",
      "amount": -300.00,
      "date": "2024-12-12",
      "status": "Failed",
      "description": "Payment Failed",
      "icon": Icons.swap_horiz,
      "color": dangerColor,
    },
    {
      "id": "TR005",
      "type": "Investment",
      "amount": 5000.00,
      "date": "2024-12-11",
      "status": "Completed",
      "description": "Stock Purchase",
      "icon": Icons.trending_up,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> get filteredHistory {
    return historyData.where((item) {
      final matchesSearch = item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || item["type"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilter(),
            _buildSummaryCards(),
            _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search transactions",
                value: searchQuery,
                hint: "Search by ID, description...",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.search,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        QCategoryPicker(
          items: [
            {"label": "All", "value": "All"},
            {"label": "Investment", "value": "Investment"},
            {"label": "Withdrawal", "value": "Withdrawal"},
            {"label": "Deposit", "value": "Deposit"},
            {"label": "Transfer", "value": "Transfer"},
          ],
          value: selectedCategory,
          onChanged: (index, label, value, item) {
            selectedCategory = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    final totalIncome = historyData
        .where((item) => (item["amount"] as double) > 0)
        .fold(0.0, (sum, item) => sum + (item["amount"] as double));
    final totalExpense = historyData
        .where((item) => (item["amount"] as double) < 0)
        .fold(0.0, (sum, item) => sum + (item["amount"] as double).abs());
    final netBalance = totalIncome - totalExpense;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            "Total Income",
            "\$${totalIncome.currency}",
            Icons.arrow_upward,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Total Expense",
            "\$${totalExpense.currency}",
            Icons.arrow_downward,
            dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Net Balance",
            "\$${netBalance.currency}",
            Icons.account_balance_wallet,
            netBalance >= 0 ? successColor : dangerColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return Column(
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
          itemCount: filteredHistory.length,
          itemBuilder: (context, index) {
            final transaction = filteredHistory[index];
            return _buildHistoryItem(transaction);
          },
        ),
      ],
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> transaction) {
    final amount = transaction["amount"] as double;
    final isPositive = amount > 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: transaction["color"] as Color,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
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
                    Text(
                      "${transaction["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(transaction["status"]).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${transaction["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getStatusColor(transaction["status"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${transaction["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${transaction["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${DateTime.parse(transaction["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isPositive ? '+' : ''}\$${amount.abs().currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? successColor : dangerColor,
                ),
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Processing":
        return warningColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
