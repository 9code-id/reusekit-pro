import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction7View extends StatefulWidget {
  @override
  State<GrlTransaction7View> createState() => _GrlTransaction7ViewState();
}

class _GrlTransaction7ViewState extends State<GrlTransaction7View> {
  int selectedStatusIndex = 0;
  String selectedDateFilter = "All Time";
  String selectedTypeFilter = "All";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "all", "count": 125},
    {"label": "Completed", "value": "completed", "count": 89},
    {"label": "Pending", "value": "pending", "count": 23},
    {"label": "Failed", "value": "failed", "count": 13},
  ];

  List<Map<String, dynamic>> dateFilters = [
    {"label": "All Time", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All", "value": "All"},
    {"label": "Payment", "value": "Payment"},
    {"label": "Refund", "value": "Refund"},
    {"label": "Transfer", "value": "Transfer"},
    {"label": "Withdrawal", "value": "Withdrawal"},
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "type": "Payment",
      "title": "Online Shopping Payment",
      "description": "Amazon Purchase - Electronics",
      "amount": -299.99,
      "currency": "USD",
      "status": "completed",
      "date": "2024-01-15T14:30:00",
      "merchant": "Amazon",
      "merchantLogo": "https://picsum.photos/40/40?random=501",
      "category": "Shopping",
      "paymentMethod": "Credit Card ****1234",
      "fee": 0.0,
      "reference": "AMZ-2024-001",
    },
    {
      "id": "TXN002",
      "type": "Transfer",
      "title": "Money Transfer to John Doe",
      "description": "Split dinner bill",
      "amount": -50.00,
      "currency": "USD",
      "status": "completed",
      "date": "2024-01-14T20:15:00",
      "merchant": "John Doe",
      "merchantLogo": "https://picsum.photos/40/40?random=502",
      "category": "Transfer",
      "paymentMethod": "Bank Account",
      "fee": 2.50,
      "reference": "TRF-2024-002",
    },
    {
      "id": "TXN003",
      "type": "Payment",
      "title": "Subscription Payment",
      "description": "Netflix Monthly Subscription",
      "amount": -15.99,
      "currency": "USD",
      "status": "pending",
      "date": "2024-01-14T09:00:00",
      "merchant": "Netflix",
      "merchantLogo": "https://picsum.photos/40/40?random=503",
      "category": "Entertainment",
      "paymentMethod": "Debit Card ****5678",
      "fee": 0.0,
      "reference": "NFX-2024-003",
    },
    {
      "id": "TXN004",
      "type": "Refund",
      "title": "Purchase Refund",
      "description": "Returned item refund",
      "amount": 89.50,
      "currency": "USD",
      "status": "completed",
      "date": "2024-01-13T16:45:00",
      "merchant": "Best Buy",
      "merchantLogo": "https://picsum.photos/40/40?random=504",
      "category": "Refund",
      "paymentMethod": "Original Payment Method",
      "fee": 0.0,
      "reference": "REF-2024-004",
    },
    {
      "id": "TXN005",
      "type": "Payment",
      "title": "Gas Station Payment",
      "description": "Fuel purchase",
      "amount": -65.40,
      "currency": "USD",
      "status": "failed",
      "date": "2024-01-12T18:20:00",
      "merchant": "Shell Gas Station",
      "merchantLogo": "https://picsum.photos/40/40?random=505",
      "category": "Transportation",
      "paymentMethod": "Credit Card ****1234",
      "fee": 0.0,
      "reference": "GAS-2024-005",
    },
    {
      "id": "TXN006",
      "type": "Withdrawal",
      "title": "ATM Withdrawal",
      "description": "Cash withdrawal from ATM",
      "amount": -200.00,
      "currency": "USD",
      "status": "completed",
      "date": "2024-01-12T12:00:00",
      "merchant": "Bank of America ATM",
      "merchantLogo": "https://picsum.photos/40/40?random=506",
      "category": "ATM",
      "paymentMethod": "Debit Card ****5678",
      "fee": 3.00,
      "reference": "ATM-2024-006",
    },
    {
      "id": "TXN007",
      "type": "Payment",
      "title": "Restaurant Payment",
      "description": "Dinner at Italian Restaurant",
      "amount": -75.85,
      "currency": "USD",
      "status": "completed",
      "date": "2024-01-11T19:30:00",
      "merchant": "Mama Mia Restaurant",
      "merchantLogo": "https://picsum.photos/40/40?random=507",
      "category": "Food & Dining",
      "paymentMethod": "Credit Card ****1234",
      "fee": 0.0,
      "reference": "REST-2024-007",
    },
    {
      "id": "TXN008",
      "type": "Transfer",
      "title": "Salary Deposit",
      "description": "Monthly salary deposit",
      "amount": 3500.00,
      "currency": "USD",
      "status": "completed",
      "date": "2024-01-10T09:00:00",
      "merchant": "ABC Corporation",
      "merchantLogo": "https://picsum.photos/40/40?random=508",
      "category": "Income",
      "paymentMethod": "Direct Deposit",
      "fee": 0.0,
      "reference": "SAL-2024-008",
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    List<Map<String, dynamic>> filtered = transactions;

    // Filter by status
    if (selectedStatusIndex > 0) {
      String status = statusOptions[selectedStatusIndex]["value"];
      filtered = filtered.where((t) => t["status"] == status).toList();
    }

    // Filter by type
    if (selectedTypeFilter != "All") {
      filtered = filtered.where((t) => t["type"] == selectedTypeFilter).toList();
    }

    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusLabel(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "pending":
        return "Pending";
      case "failed":
        return "Failed";
      default:
        return "Unknown";
    }
  }

  IconData getTypeIcon(String type) {
    switch (type) {
      case "Payment":
        return Icons.payment;
      case "Transfer":
        return Icons.swap_horiz;
      case "Refund":
        return Icons.keyboard_return;
      case "Withdrawal":
        return Icons.atm;
      default:
        return Icons.receipt;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalBalance = transactions
        .where((t) => t["status"] == "completed")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));

    double totalIncome = transactions
        .where((t) => t["status"] == "completed" && (t["amount"] as double) > 0)
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));

    double totalExpense = transactions
        .where((t) => t["status"] == "completed" && (t["amount"] as double) < 0)
        .fold(0.0, (sum, t) => sum + (t["amount"] as double).abs());

    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
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
          children: [
            // Balance Overview
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Balance",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${totalBalance.abs().toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Income",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(200),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              "\$${totalIncome.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.trending_down,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Expenses",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(200),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              "\$${totalExpense.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
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

            SizedBox(height: spMd),

            // Status Filter Tabs
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: statusOptions.length,
                itemBuilder: (context, index) {
                  final option = statusOptions[index];
                  final isSelected = selectedStatusIndex == index;
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedStatusIndex = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                          boxShadow: isSelected ? [shadowSm] : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${option["count"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : primaryColor,
                              ),
                            ),
                            Text(
                              "${option["label"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: spMd),

            // Filters Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Date Range",
                    items: dateFilters,
                    value: selectedDateFilter,
                    onChanged: (value, label) {
                      selectedDateFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: typeFilters,
                    value: selectedTypeFilter,
                    onChanged: (value, label) {
                      selectedTypeFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Transaction List Header
            Row(
              children: [
                Text(
                  "Recent Transactions",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredTransactions.length} transactions",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Transaction List
            ...filteredTransactions.map((transaction) {
              final amount = transaction["amount"] as double;
              final isPositive = amount > 0;
              final fee = transaction["fee"] as double;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Type Icon
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            getTypeIcon(transaction["type"]),
                            color: primaryColor,
                            size: 24,
                          ),
                        ),

                        SizedBox(width: spSm),

                        // Transaction Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${transaction["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(transaction["status"]).withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      getStatusLabel(transaction["status"]),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getStatusColor(transaction["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: spXs),

                              Text(
                                "${transaction["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: spXs),

                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    child: Image.network(
                                      "${transaction["merchantLogo"]}",
                                      width: 16,
                                      height: 16,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${transaction["merchant"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.schedule,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${DateTime.parse(transaction["date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: spSm),

                        // Amount
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${isPositive ? '+' : ''}\$${amount.abs().toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: isPositive ? successColor : dangerColor,
                              ),
                            ),
                            if (fee > 0)
                              Text(
                                "Fee: \$${fee.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Transaction Details Row
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.credit_card,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${transaction["paymentMethod"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "ID: ${transaction["reference"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: disabledBoldColor,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredTransactions.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No transactions found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters to see more results",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
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
