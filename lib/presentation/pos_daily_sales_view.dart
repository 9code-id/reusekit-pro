import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosDailySalesView extends StatefulWidget {
  const PosDailySalesView({super.key});

  @override
  State<PosDailySalesView> createState() => _PosDailySalesViewState();
}

class _PosDailySalesViewState extends State<PosDailySalesView> {
  DateTime selectedDate = DateTime.now();
  String selectedView = "Overview";
  
  List<Map<String, dynamic>> viewOptions = [
    {"label": "Overview", "value": "Overview"},
    {"label": "Transactions", "value": "Transactions"},
    {"label": "Products", "value": "Products"},
    {"label": "Payment Methods", "value": "Payment Methods"},
  ];

  Map<String, dynamic> dailySummary = {
    "totalSales": 24750.0,
    "totalTransactions": 187,
    "avgTransactionValue": 132.35,
    "totalCustomers": 156,
    "returningCustomers": 89,
    "newCustomers": 67,
    "grossProfit": 9870.0,
    "profitMargin": 39.9,
    "cashSales": 8950.0,
    "cardSales": 12800.0,
    "digitalSales": 3000.0,
    "refunds": 285.0,
    "discounts": 1240.0,
  };

  List<Map<String, dynamic>> hourlyData = [
    {"hour": "08:00", "sales": 450.0, "transactions": 3, "customers": 3},
    {"hour": "09:00", "sales": 1250.0, "transactions": 8, "customers": 7},
    {"hour": "10:00", "sales": 2100.0, "transactions": 12, "customers": 11},
    {"hour": "11:00", "sales": 2850.0, "transactions": 18, "customers": 16},
    {"hour": "12:00", "sales": 3200.0, "transactions": 22, "customers": 19},
    {"hour": "13:00", "sales": 2950.0, "transactions": 21, "customers": 18},
    {"hour": "14:00", "sales": 3100.0, "transactions": 24, "customers": 21},
    {"hour": "15:00", "sales": 2750.0, "transactions": 19, "customers": 17},
    {"hour": "16:00", "sales": 2400.0, "transactions": 16, "customers": 14},
    {"hour": "17:00", "sales": 2000.0, "transactions": 15, "customers": 13},
    {"hour": "18:00", "sales": 1700.0, "transactions": 12, "customers": 10},
    {"hour": "19:00", "sales": 1000.0, "transactions": 8, "customers": 6},
  ];

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "iPhone 15 Pro",
      "category": "Electronics",
      "unitsSold": 12,
      "revenue": 8400.0,
      "profit": 2520.0,
      "image": "https://picsum.photos/60/60?random=1&keyword=phone"
    },
    {
      "name": "Samsung Galaxy Watch",
      "category": "Electronics",
      "unitsSold": 8,
      "revenue": 2400.0,
      "profit": 960.0,
      "image": "https://picsum.photos/60/60?random=2&keyword=watch"
    },
    {
      "name": "Nike Air Max",
      "category": "Footwear",
      "unitsSold": 15,
      "revenue": 1800.0,
      "profit": 540.0,
      "image": "https://picsum.photos/60/60?random=3&keyword=shoes"
    },
    {
      "name": "MacBook Air M3",
      "category": "Electronics",
      "unitsSold": 4,
      "revenue": 4400.0,
      "profit": 880.0,
      "image": "https://picsum.photos/60/60?random=4&keyword=laptop"
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "method": "Credit Card",
      "amount": 12800.0,
      "transactions": 89,
      "percentage": 51.7,
      "icon": Icons.credit_card,
      "color": primaryColor,
    },
    {
      "method": "Cash",
      "amount": 8950.0,
      "transactions": 67,
      "percentage": 36.2,
      "icon": Icons.payments,
      "color": successColor,
    },
    {
      "method": "Digital Wallet",
      "amount": 3000.0,
      "transactions": 31,
      "percentage": 12.1,
      "icon": Icons.phone_android,
      "color": infoColor,
    },
  ];

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selected Date",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  selectedDate.dMMMy,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              QButton(
                icon: Icons.chevron_left,
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.subtract(Duration(days: 1));
                  });
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.calendar_today,
                size: bs.sm,
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.chevron_right,
                size: bs.sm,
                onPressed: selectedDate.isBefore(DateTime.now().subtract(Duration(days: 1))) ? () {
                  setState(() {
                    selectedDate = selectedDate.add(Duration(days: 1));
                  });
                } : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalesSummary() {
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
          Text(
            "Daily Summary",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${dailySummary["totalSales"].currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Sales",
                        textAlign: TextAlign.center,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.receipt,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${dailySummary["totalTransactions"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Transactions",
                        textAlign: TextAlign.center,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${dailySummary["totalCustomers"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Customers",
                        textAlign: TextAlign.center,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.payments,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${dailySummary["avgTransactionValue"].toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Avg Transaction",
                        textAlign: TextAlign.center,
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
        ],
      ),
    );
  }

  Widget _buildHourlySalesChart() {
    double maxSales = hourlyData.map((h) => h["sales"] as double).reduce((a, b) => a > b ? a : b);
    
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
          Text(
            "Hourly Sales Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: hourlyData.map((hour) {
                  double normalizedHeight = ((hour["sales"] as double) / maxSales) * 150;
                  
                  return Container(
                    margin: EdgeInsets.only(right: spXs),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 30,
                          height: normalizedHeight,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                primaryColor,
                                primaryColor.withAlpha(150),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${hour["hour"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${((hour["sales"] as double) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 8,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopProducts() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Selling Products",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to all products
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
          Column(
            children: topProducts.map((product) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${product["image"]}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${product["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${product["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Units sold: ${product["unitsSold"]}",
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
                          "\$${(product["revenue"] as double).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Profit: \$${(product["profit"] as double).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentBreakdown() {
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
          Text(
            "Payment Methods",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: paymentMethods.map((payment) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (payment["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (payment["color"] as Color).withAlpha(50),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      payment["icon"] as IconData,
                      color: payment["color"] as Color,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${payment["method"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${payment["transactions"]} transactions",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (payment["percentage"] as double) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: payment["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
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
                          "${(payment["percentage"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialMetrics() {
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
          Text(
            "Financial Details",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${dailySummary["grossProfit"].currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Gross Profit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${dailySummary["profitMargin"].toStringAsFixed(1)}% margin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${dailySummary["refunds"].currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Refunds",
                        textAlign: TextAlign.center,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${dailySummary["discounts"].currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Discounts",
                        textAlign: TextAlign.center,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Sales"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Daily sales report shared successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Daily sales report downloaded");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDateSelector(),
            _buildSalesSummary(),
            _buildHourlySalesChart(),
            _buildTopProducts(),
            _buildPaymentBreakdown(),
            _buildFinancialMetrics(),
          ],
        ),
      ),
    );
  }
}
