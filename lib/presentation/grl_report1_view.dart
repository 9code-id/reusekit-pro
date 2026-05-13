import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport1View extends StatefulWidget {
  @override
  State<GrlReport1View> createState() => _GrlReport1ViewState();
}

class _GrlReport1ViewState extends State<GrlReport1View> {
  int selectedPeriod = 0;
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> periods = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> salesData = [
    {
      "title": "Total Revenue",
      "value": 125000.0,
      "change": 12.5,
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "title": "Total Orders",
      "value": 847.0,
      "change": 8.2,
      "icon": Icons.shopping_cart,
      "color": primaryColor,
    },
    {
      "title": "New Customers",
      "value": 234.0,
      "change": -3.1,
      "icon": Icons.person_add,
      "color": infoColor,
    },
    {
      "title": "Average Order",
      "value": 147.6,
      "change": 5.8,
      "icon": Icons.analytics,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "Premium Coffee Beans",
      "sold": 156,
      "revenue": 23400.0,
      "image": "https://picsum.photos/60/60?random=1&keyword=coffee",
    },
    {
      "name": "Wireless Headphones",
      "sold": 89,
      "revenue": 17800.0,
      "image": "https://picsum.photos/60/60?random=2&keyword=headphones",
    },
    {
      "name": "Smart Watch",
      "sold": 67,
      "revenue": 20100.0,
      "image": "https://picsum.photos/60/60?random=3&keyword=watch",
    },
    {
      "name": "Laptop Stand",
      "sold": 134,
      "revenue": 8040.0,
      "image": "https://picsum.photos/60/60?random=4&keyword=laptop",
    },
    {
      "name": "Phone Case",
      "sold": 298,
      "revenue": 5960.0,
      "image": "https://picsum.photos/60/60?random=5&keyword=phone",
    },
  ];

  List<Map<String, dynamic>> recentOrders = [
    {
      "id": "#ORD-2024-001",
      "customer": "John Smith",
      "amount": 234.50,
      "status": "completed",
      "date": "2024-12-22 10:30",
    },
    {
      "id": "#ORD-2024-002",
      "customer": "Sarah Johnson",
      "amount": 89.99,
      "status": "pending",
      "date": "2024-12-22 09:15",
    },
    {
      "id": "#ORD-2024-003",
      "customer": "Mike Brown",
      "amount": 456.00,
      "status": "processing",
      "date": "2024-12-22 08:45",
    },
    {
      "id": "#ORD-2024-004",
      "customer": "Emma Davis",
      "amount": 123.75,
      "status": "completed",
      "date": "2024-12-21 16:20",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Report"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Report exported successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Report shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(),
            _buildMetricsGrid(),
            _buildTopProductsSection(),
            _buildRecentOrdersSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Report Period",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: periods,
            value: periods[selectedPeriod]["value"],
            onChanged: (index, label, value, item) {
              selectedPeriod = index;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: salesData.map((metric) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (metric["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      metric["icon"] as IconData,
                      color: metric["color"] as Color,
                      size: 20,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: (metric["change"] as double) >= 0 ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: (metric["change"] as double) >= 0 ? successColor : dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${metric["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                metric["title"] == "Total Revenue" || metric["title"] == "Average Order"
                    ? "\$${((metric["value"] as double)).currency}"
                    : "${(metric["value"] as double).toInt()}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTopProductsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Top Selling Products",
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
                  // Navigate to products
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: topProducts.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> product = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: index < topProducts.length - 1 ? spSm : 0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${product["image"]}"),
                          fit: BoxFit.cover,
                        ),
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
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(product["sold"] as int)} sold",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((product["revenue"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
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

  Widget _buildRecentOrdersSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recent Orders",
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
                  // Navigate to orders
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: recentOrders.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> order = entry.value;
              
              Color statusColor = order["status"] == "completed" 
                  ? successColor 
                  : order["status"] == "pending" 
                      ? warningColor 
                      : infoColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: index < recentOrders.length - 1 ? spSm : 0),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${order["id"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${order["customer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${order["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${((order["amount"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${order["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
}
