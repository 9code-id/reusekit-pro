import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTracking9View extends StatefulWidget {
  @override
  State<GrlTracking9View> createState() => _GrlTracking9ViewState();
}

class _GrlTracking9ViewState extends State<GrlTracking9View> {
  String selectedType = 'all';
  String selectedPeriod = 'today';
  
  List<Map<String, dynamic>> expenses = [
    {
      "id": "EXP001",
      "title": "Coffee Shop",
      "category": "food",
      "amount": 12.50,
      "date": "2024-01-23",
      "time": "08:30",
      "paymentMethod": "credit_card",
      "location": "Starbucks Downtown",
      "description": "Morning latte and croissant",
      "receipt": true,
      "recurring": false,
    },
    {
      "id": "EXP002",
      "title": "Uber Ride",
      "category": "transportation",
      "amount": 18.75,
      "date": "2024-01-23",
      "time": "09:15",
      "paymentMethod": "mobile_pay",
      "location": "Downtown to Office",
      "description": "Ride to work meeting",
      "receipt": false,
      "recurring": false,
    },
    {
      "id": "EXP003",
      "title": "Netflix Subscription",
      "category": "entertainment",
      "amount": 15.99,
      "date": "2024-01-23",
      "time": "12:00",
      "paymentMethod": "credit_card",
      "location": "Online",
      "description": "Monthly streaming service",
      "receipt": true,
      "recurring": true,
    },
    {
      "id": "EXP004",
      "title": "Grocery Shopping",
      "category": "shopping",
      "amount": 85.30,
      "date": "2024-01-22",
      "time": "18:45",
      "paymentMethod": "debit_card",
      "location": "Whole Foods Market",
      "description": "Weekly groceries and household items",
      "receipt": true,
      "recurring": false,
    },
    {
      "id": "EXP005",
      "title": "Gym Membership",
      "category": "health",
      "amount": 49.99,
      "date": "2024-01-22",
      "time": "06:00",
      "paymentMethod": "bank_transfer",
      "location": "FitLife Gym",
      "description": "Monthly gym membership fee",
      "receipt": true,
      "recurring": true,
    },
  ];

  Map<String, dynamic> budgetData = {
    "totalBudget": 2500.00,
    "totalSpent": 1847.50,
    "remaining": 652.50,
    "categories": {
      "food": {"budget": 400.0, "spent": 245.80},
      "transportation": {"budget": 200.0, "spent": 156.25},
      "entertainment": {"budget": 150.0, "spent": 89.99},
      "shopping": {"budget": 600.0, "spent": 425.30},
      "health": {"budget": 300.0, "spent": 149.98},
      "utilities": {"budget": 850.0, "spent": 780.18},
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.receipt),
            onPressed: () {
              // navigateTo(ReceiptScannerView());
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo(ExpenseAnalyticsView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Budget Overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
                      "Monthly Budget",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Budget Progress
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${((budgetData["totalSpent"] as double)).currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "of \$${((budgetData["totalBudget"] as double)).currency} spent",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(76),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: ((budgetData["totalSpent"] as double) / (budgetData["totalBudget"] as double)).clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${((budgetData["remaining"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "remaining",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Period Filter
                QHorizontalScroll(
                  children: [
                    'today', 'week', 'month', 'year'
                  ].map((period) => GestureDetector(
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
                        color: selectedPeriod == period ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedPeriod == period ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Text(
                        period.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedPeriod == period ? Colors.white : primaryColor,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
                
                SizedBox(height: spMd),
                
                // Category Filter
                QHorizontalScroll(
                  children: [
                    'all', 'food', 'transportation', 'entertainment', 'shopping', 'health', 'utilities'
                  ].map((type) => GestureDetector(
                    onTap: () {
                      selectedType = type;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedType == type ? secondaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedType == type ? secondaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Text(
                        type.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedType == type ? Colors.white : secondaryColor,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Expenses List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Overview
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${expenses.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Transactions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${expenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Total Spent",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Recent Expenses",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Expense Cards
                  ...expenses.where((expense) {
                    if (selectedType == 'all') return true;
                    return expense["category"] == selectedType;
                  }).map((expense) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        // Expense Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(expense["category"]).withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(expense["category"]),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  _getCategoryIcon(expense["category"]),
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${expense["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${expense["category"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getCategoryColor(expense["category"]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${(expense["amount"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      if (expense["recurring"] as bool) ...[
                                        Icon(
                                          Icons.refresh,
                                          size: 12,
                                          color: warningColor,
                                        ),
                                        SizedBox(width: spXs),
                                      ],
                                      if (expense["receipt"] as bool) ...[
                                        Icon(
                                          Icons.receipt,
                                          size: 12,
                                          color: successColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Expense Details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Description
                              if (expense["description"] != null) ...[
                                Text(
                                  "${expense["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spMd),
                              ],
                              
                              // Transaction Details
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${expense["date"]} ${expense["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    _getPaymentMethodIcon(expense["paymentMethod"]),
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${expense["paymentMethod"]}".replaceAll('_', ' ').toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Location
                              if (expense["location"] != null) ...[
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${expense["location"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spMd),
                              ],
                              
                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "View Details",
                                      size: bs.sm,
                                      onPressed: () {
                                        // navigateTo(ExpenseDetailsView());
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.edit,
                                    size: bs.sm,
                                    onPressed: () {
                                      // navigateTo(EditExpenseView());
                                    },
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.more_vert,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(AddExpenseView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'food':
        return warningColor;
      case 'transportation':
        return infoColor;
      case 'entertainment':
        return primaryColor;
      case 'shopping':
        return successColor;
      case 'health':
        return dangerColor;
      case 'utilities':
        return secondaryColor;
      default:
        return primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'food':
        return Icons.restaurant;
      case 'transportation':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'shopping':
        return Icons.shopping_bag;
      case 'health':
        return Icons.medical_services;
      case 'utilities':
        return Icons.home;
      default:
        return Icons.category;
    }
  }

  IconData _getPaymentMethodIcon(String paymentMethod) {
    switch (paymentMethod) {
      case 'credit_card':
        return Icons.credit_card;
      case 'debit_card':
        return Icons.payment;
      case 'mobile_pay':
        return Icons.phone_android;
      case 'bank_transfer':
        return Icons.account_balance;
      case 'cash':
        return Icons.money;
      default:
        return Icons.payment;
    }
  }
}
