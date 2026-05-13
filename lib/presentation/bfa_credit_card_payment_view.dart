import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCreditCardPaymentView extends StatefulWidget {
  const BfaCreditCardPaymentView({super.key});

  @override
  State<BfaCreditCardPaymentView> createState() => _BfaCreditCardPaymentViewState();
}

class _BfaCreditCardPaymentViewState extends State<BfaCreditCardPaymentView> {
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> creditCards = [
    {
      "id": 1,
      "bank": "Chase Bank",
      "cardName": "Chase Sapphire Preferred",
      "cardNumber": "****1234",
      "cardType": "Visa",
      "currentBalance": 2750.50,
      "creditLimit": 10000.00,
      "minimumPayment": 85.00,
      "totalDue": 2750.50,
      "dueDate": "2025-01-20",
      "interestRate": 18.99,
      "status": "Active",
      "lastPayment": 500.00,
      "lastPaymentDate": "2024-12-20",
      "rewardPoints": 15750,
      "color": Colors.blue,
      "cardImage": "https://picsum.photos/300/180?random=1&credit"
    },
    {
      "id": 2,
      "bank": "American Express",
      "cardName": "Amex Gold Card",
      "cardNumber": "****5678",
      "cardType": "American Express",
      "currentBalance": 1250.75,
      "creditLimit": 5000.00,
      "minimumPayment": 45.00,
      "totalDue": 1250.75,
      "dueDate": "2025-01-15",
      "interestRate": 21.99,
      "status": "Active",
      "lastPayment": 200.00,
      "lastPaymentDate": "2024-12-15",
      "rewardPoints": 8250,
      "color": Colors.amber,
      "cardImage": "https://picsum.photos/300/180?random=2&credit"
    },
    {
      "id": 3,
      "bank": "Citi Bank",
      "cardName": "Citi Double Cash",
      "cardNumber": "****9012",
      "cardType": "Mastercard",
      "currentBalance": 850.25,
      "creditLimit": 3000.00,
      "minimumPayment": 35.00,
      "totalDue": 850.25,
      "dueDate": "2025-01-10",
      "interestRate": 16.99,
      "status": "Overdue",
      "lastPayment": 150.00,
      "lastPaymentDate": "2024-11-10",
      "rewardPoints": 4125,
      "color": Colors.red,
      "cardImage": "https://picsum.photos/300/180?random=3&credit"
    },
    {
      "id": 4,
      "bank": "Capital One",
      "cardName": "Capital One Venture",
      "cardNumber": "****3456",
      "cardType": "Visa",
      "currentBalance": 0.00,
      "creditLimit": 8000.00,
      "minimumPayment": 0.00,
      "totalDue": 0.00,
      "dueDate": "2025-01-25",
      "interestRate": 19.99,
      "status": "Active",
      "lastPayment": 320.00,
      "lastPaymentDate": "2024-12-25",
      "rewardPoints": 12500,
      "color": Colors.green,
      "cardImage": "https://picsum.photos/300/180?random=4&credit"
    }
  ];

  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": 1,
      "bank": "Chase Bank",
      "cardName": "Chase Sapphire Preferred",
      "amount": 500.00,
      "date": "2024-12-20T15:30:00",
      "status": "Success",
      "transactionId": "CC789456123",
      "paymentType": "Full Payment"
    },
    {
      "id": 2,
      "bank": "American Express",
      "cardName": "Amex Gold Card",
      "amount": 200.00,
      "date": "2024-12-15T10:45:00",
      "status": "Success",
      "transactionId": "CC456789012",
      "paymentType": "Minimum Payment"
    },
    {
      "id": 3,
      "bank": "Capital One",
      "cardName": "Capital One Venture",
      "amount": 320.00,
      "date": "2024-12-25T09:15:00",
      "status": "Success",
      "transactionId": "CC123456789",
      "paymentType": "Custom Payment"
    }
  ];

  List<Map<String, dynamic>> get filteredCards {
    if (selectedFilter == "All") return creditCards;
    return creditCards.where((card) => card["status"] == selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Overdue":
        return dangerColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  double _getUtilizationPercentage(double balance, double limit) {
    if (limit == 0) return 0;
    return (balance / limit) * 100;
  }

  Color _getUtilizationColor(double percentage) {
    if (percentage >= 80) return dangerColor;
    if (percentage >= 50) return warningColor;
    return successColor;
  }

  int get overdueCount => creditCards.where((card) => card["status"] == "Overdue").length;
  int get activeCount => creditCards.where((card) => card["status"] == "Active").length;
  double get totalBalance => creditCards
      .where((card) => card["status"] == "Active" || card["status"] == "Overdue")
      .map((card) => card["currentBalance"] as double)
      .fold(0.0, (sum, amount) => sum + amount);
  double get totalMinimumDue => creditCards
      .where((card) => card["status"] == "Active" || card["status"] == "Overdue")
      .map((card) => card["minimumPayment"] as double)
      .fold(0.0, (sum, amount) => sum + amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credit Card Payments"),
        actions: [
          IconButton(
            icon: Icon(Icons.credit_score),
            onPressed: () {
              // navigateTo(CreditScoreView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Overview
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
                          Icons.credit_card,
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
                              "Credit Cards",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${creditCards.where((c) => c["status"] != "Closed").length} active cards",
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
                              "Total Balance",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "\$${totalBalance.currency}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Minimum Due",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "\$${totalMinimumDue.currency}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
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

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: successColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$activeCount",
                          style: TextStyle(
                            fontSize: fsH4,
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
                      color: dangerColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: dangerColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: dangerColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Overdue",
                              style: TextStyle(
                                fontSize: 14,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$overdueCount",
                          style: TextStyle(
                            fontSize: fsH4,
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

            // Filter Options
            QCategoryPicker(
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Credit Cards List
            ...filteredCards.map((card) {
              double utilizationPercentage = _getUtilizationPercentage(
                card["currentBalance"] as double,
                card["creditLimit"] as double,
              );
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: card["status"] == "Overdue"
                      ? Border.all(color: dangerColor.withAlpha(128))
                      : null,
                ),
                child: Column(
                  children: [
                    // Card Header
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${card["cardImage"]}"),
                              fit: BoxFit.cover,
                            ),
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
                                      "${card["cardName"]}",
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
                                      color: _getStatusColor(card["status"]).withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${card["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(card["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${card["bank"]} • ${card["cardNumber"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${card["cardType"]} • ${utilizationPercentage.toStringAsFixed(1)}% utilization",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _getUtilizationColor(utilizationPercentage),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Balance and Limit
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Balance",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(card["currentBalance"] as double).currency}",
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
                                "Credit Limit",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(card["creditLimit"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
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
                                "Available Credit",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((card["creditLimit"] as double) - (card["currentBalance"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Credit Utilization Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Credit Utilization",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${utilizationPercentage.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getUtilizationColor(utilizationPercentage),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: utilizationPercentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _getUtilizationColor(utilizationPercentage),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Payment Info
                    if (card["currentBalance"] > 0) ...[
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Minimum Payment",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(card["minimumPayment"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
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
                                  "Due Date",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(card["dueDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: card["status"] == "Overdue" ? dangerColor : primaryColor,
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
                                  "Interest Rate",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(card["interestRate"] as num).toStringAsFixed(2)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                            child: QButton(
                              label: "Minimum (\$${(card["minimumPayment"] as double).currency})",
                              size: bs.sm,
                              onPressed: () {
                                // Pay minimum
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Pay Full (\$${(card["currentBalance"] as double).currency})",
                              size: bs.sm,
                              onPressed: () {
                                // Pay full balance
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Custom Payment Amount",
                          icon: Icons.payment,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(CustomCreditCardPaymentView(card));
                          },
                        ),
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "No balance due - You're all caught up!",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    // Rewards Points
                    if (card["rewardPoints"] != null) ...[
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.amber.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.stars,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Reward Points: ${(card["rewardPoints"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.amber.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),

            // Recent Payments
            if (paymentHistory.isNotEmpty) ...[
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
                        Expanded(
                          child: Text(
                            "Recent Payments",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigateTo(CreditCardPaymentHistoryView());
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...paymentHistory.take(3).map((payment) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.credit_card,
                                color: successColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${payment["cardName"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${payment["bank"]} • ${DateTime.parse(payment["date"]).dMMMy}",
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
                                  "\$${(payment["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${payment["paymentType"]}",
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
                    }).toList(),
                  ],
                ),
              ),
            ],

            // Add New Card
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Credit Card",
                icon: Icons.add,
                onPressed: () {
                  // navigateTo(AddCreditCardView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
