import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStats1View extends StatefulWidget {
  const GrlStats1View({Key? key}) : super(key: key);

  @override
  State<GrlStats1View> createState() => _GrlStats1ViewState();
}

class _GrlStats1ViewState extends State<GrlStats1View> {
  String selectedPeriod = "month";
  String selectedMetric = "revenue";
  
  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> metrics = [
    {"label": "Revenue", "value": "revenue"},
    {"label": "Orders", "value": "orders"},
    {"label": "Customers", "value": "customers"},
    {"label": "Conversion", "value": "conversion"},
  ];

  Map<String, dynamic> salesData = {
    "totalRevenue": 485690.75,
    "totalOrders": 2847,
    "totalCustomers": 1923,
    "conversionRate": 4.8,
    "averageOrderValue": 170.52,
    "revenueGrowth": 12.5,
    "ordersGrowth": 8.3,
    "customersGrowth": 15.2,
    "conversionGrowth": -2.1,
  };

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "Premium Wireless Headphones",
      "revenue": 45280.00,
      "orders": 156,
      "avgPrice": 290.26,
      "growth": 18.5,
      "category": "Electronics"
    },
    {
      "name": "Organic Cotton T-Shirt",
      "revenue": 38950.00,
      "orders": 892,
      "avgPrice": 43.67,
      "growth": 22.1,
      "category": "Clothing"
    },
    {
      "name": "Smart Fitness Watch",
      "revenue": 32180.00,
      "orders": 89,
      "avgPrice": 361.57,
      "growth": -5.2,
      "category": "Electronics"
    },
    {
      "name": "Bamboo Kitchen Set",
      "revenue": 28450.00,
      "orders": 234,
      "avgPrice": 121.58,
      "growth": 31.4,
      "category": "Home & Garden"
    },
    {
      "name": "Yoga Mat Premium",
      "revenue": 24670.00,
      "orders": 445,
      "avgPrice": 55.44,
      "growth": 9.8,
      "category": "Sports"
    },
  ];

  List<Map<String, dynamic>> revenueByCategory = [
    {"category": "Electronics", "revenue": 156780.00, "percentage": 32.3, "growth": 8.9},
    {"category": "Clothing", "revenue": 124560.00, "percentage": 25.6, "growth": 15.2},
    {"category": "Home & Garden", "revenue": 89340.00, "percentage": 18.4, "growth": 12.7},
    {"category": "Sports", "revenue": 67890.00, "percentage": 14.0, "growth": 22.1},
    {"category": "Beauty", "revenue": 47120.00, "percentage": 9.7, "growth": 6.3},
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "revenue": 35680, "orders": 198, "customers": 145},
    {"month": "Feb", "revenue": 42150, "orders": 234, "customers": 167},
    {"month": "Mar", "revenue": 38920, "orders": 221, "customers": 159},
    {"month": "Apr", "revenue": 51240, "orders": 289, "customers": 198},
    {"month": "May", "revenue": 48670, "orders": 276, "customers": 186},
    {"month": "Jun", "revenue": 56890, "orders": 318, "customers": 234},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Sales report downloaded");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Sales report shared");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Time Period",
                      items: periods,
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Primary Metric",
                      items: metrics,
                      value: selectedMetric,
                      onChanged: (value, label) {
                        selectedMetric = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Key Metrics Dashboard
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Sales Performance Overview",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          selectedPeriod.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildMetricCard(
                        "Total Revenue",
                        "\$${((salesData["totalRevenue"] as double) / 1000).toStringAsFixed(1)}K",
                        salesData["revenueGrowth"] as double,
                        Icons.attach_money,
                        Colors.white,
                      ),
                      _buildMetricCard(
                        "Total Orders",
                        "${salesData["totalOrders"]}",
                        salesData["ordersGrowth"] as double,
                        Icons.shopping_cart,
                        Colors.white,
                      ),
                      _buildMetricCard(
                        "New Customers",
                        "${salesData["totalCustomers"]}",
                        salesData["customersGrowth"] as double,
                        Icons.people,
                        Colors.white,
                      ),
                      _buildMetricCard(
                        "Conversion Rate",
                        "${salesData["conversionRate"]}%",
                        salesData["conversionGrowth"] as double,
                        Icons.trending_up,
                        Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Revenue by Category
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Revenue by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...revenueByCategory.map((category) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${category["category"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "\$${((category["revenue"] as double) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: (category["growth"] as double) > 0 ? 
                                      successColor.withAlpha(20) : dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${(category["growth"] as double) > 0 ? '+' : ''}${(category["growth"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: (category["growth"] as double) > 0 ? successColor : dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: (category["percentage"] as double) / 100,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${(category["percentage"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),

            // Top Products
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Top Performing Products",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          si("All products view opened");
                        },
                      ),
                    ],
                  ),
                  ...topProducts.map((product) => Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: primaryColor.withAlpha(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${product["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
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
                                color: primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${product["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Revenue",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((product["revenue"] as double) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Orders",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${product["orders"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Avg Price",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(product["avgPrice"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: (product["growth"] as double) > 0 ? 
                                      successColor.withAlpha(20) : dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${(product["growth"] as double) > 0 ? '+' : ''}${(product["growth"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: (product["growth"] as double) > 0 ? successColor : dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),

            // Monthly Trends
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Monthly Trends",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Column(
                      spacing: spSm,
                      children: monthlyTrends.map((trend) => Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: Text(
                                "${trend["month"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Row(
                                children: [
                                  // Revenue bar
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(50),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: FractionallySizedBox(
                                        widthFactor: (trend["revenue"] as int) / 60000,
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    width: 60,
                                    child: Text(
                                      "\$${((trend["revenue"] as int) / 1000).toStringAsFixed(0)}K",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    child: Text(
                                      "${trend["orders"]} orders",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Additional Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_basket,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Average Order Value",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(salesData["averageOrderValue"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Per transaction",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Revenue Growth",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "+${(salesData["revenueGrowth"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "vs last period",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildMetricCard(String title, String value, double growth, IconData icon, Color textColor) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: textColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor.withAlpha(200),
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spSm,
              vertical: spXs,
            ),
            decoration: BoxDecoration(
              color: growth > 0 ? Colors.green.withAlpha(50) : Colors.red.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${growth > 0 ? '+' : ''}${growth.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: growth > 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
