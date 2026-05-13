import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction1View extends StatefulWidget {
  const GrlTransaction1View({Key? key}) : super(key: key);

  @override
  State<GrlTransaction1View> createState() => _GrlTransaction1ViewState();
}

class _GrlTransaction1ViewState extends State<GrlTransaction1View> {
  String selectedFilter = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> transactions = [
    {
      "id": "TRX001",
      "title": "Coffee Purchase",
      "amount": -4.50,
      "date": "2024-12-20",
      "category": "Food & Drink",
      "type": "expense",
      "status": "completed",
      "merchant": "Starbucks",
      "icon": Icons.local_cafe,
    },
    {
      "id": "TRX002", 
      "title": "Salary Deposit",
      "amount": 3500.00,
      "date": "2024-12-20",
      "category": "Income",
      "type": "income",
      "status": "completed",
      "merchant": "Company ABC",
      "icon": Icons.account_balance_wallet,
    },
    {
      "id": "TRX003",
      "title": "Online Shopping",
      "amount": -89.99,
      "date": "2024-12-19",
      "category": "Shopping",
      "type": "expense", 
      "status": "pending",
      "merchant": "Amazon",
      "icon": Icons.shopping_bag,
    },
    {
      "id": "TRX004",
      "title": "Gas Station",
      "amount": -45.20,
      "date": "2024-12-19",
      "category": "Transportation",
      "type": "expense",
      "status": "completed",
      "merchant": "Shell",
      "icon": Icons.local_gas_station,
    },
    {
      "id": "TRX005",
      "title": "Freelance Payment",
      "amount": 750.00,
      "date": "2024-12-18",
      "category": "Income",
      "type": "income",
      "status": "completed",
      "merchant": "Client XYZ",
      "icon": Icons.work,
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((transaction) {
      bool matchesFilter = selectedFilter == "All" || 
          transaction["type"] == selectedFilter.toLowerCase();
      bool matchesSearch = searchQuery.isEmpty ||
          transaction["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          transaction["merchant"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search transactions...",
                    value: searchQuery,
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

            // Filter Categories
            QCategoryPicker(
              items: const [
                {
                  "label": "All",
                  "value": "All",
                },
                {
                  "label": "Income",
                  "value": "Income",
                },
                {
                  "label": "Expense",
                  "value": "Expense",
                },
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Balance Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  Text(
                    "\$${((transactions.fold(0.0, (sum, t) => sum + (t["amount"] as double)))).currency}",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Income",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "\$${((transactions.where((t) => (t["amount"] as double) > 0).fold(0.0, (sum, t) => sum + (t["amount"] as double)))).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Expenses",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "\$${((transactions.where((t) => (t["amount"] as double) < 0).fold(0.0, (sum, t) => sum + (t["amount"] as double)).abs())).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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

            // Recent Transactions Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // Transaction List
            ...List.generate(filteredTransactions.length, (index) {
              final transaction = filteredTransactions[index];
              final isIncome = (transaction["amount"] as double) > 0;
              final statusColor = transaction["status"] == "completed" 
                  ? successColor 
                  : warningColor;

              return Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isIncome ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        transaction["icon"] as IconData,
                        color: isIncome ? successColor : dangerColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${transaction["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${isIncome ? '+' : ''}\$${((transaction["amount"] as double).abs()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isIncome ? successColor : dangerColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${transaction["merchant"]} • ${transaction["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${transaction["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${DateTime.parse(transaction["date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            if (filteredTransactions.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No transactions found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
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
}
