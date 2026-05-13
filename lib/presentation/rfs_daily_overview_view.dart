import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsDailyOverviewView extends StatefulWidget {
  const RfsDailyOverviewView({super.key});

  @override
  State<RfsDailyOverviewView> createState() => _RfsDailyOverviewViewState();
}

class _RfsDailyOverviewViewState extends State<RfsDailyOverviewView> {
  String selectedDate = DateTime.now().toString().split(' ')[0];
  
  List<Map<String, dynamic>> dailyStats = [
    {
      "title": "Total Orders",
      "value": 247,
      "icon": Icons.receipt_long,
      "color": primaryColor,
      "change": "+12%",
      "isPositive": true,
    },
    {
      "title": "Revenue",
      "value": 15420.00,
      "icon": Icons.monetization_on,
      "color": successColor,
      "change": "+8%",
      "isPositive": true,
    },
    {
      "title": "Average Order",
      "value": 62.43,
      "icon": Icons.trending_up,
      "color": infoColor,
      "change": "-3%",
      "isPositive": false,
    },
    {
      "title": "Table Turnover",
      "value": 3.2,
      "icon": Icons.table_restaurant,
      "color": warningColor,
      "change": "+5%",
      "isPositive": true,
    },
  ];

  List<Map<String, dynamic>> hourlyData = [
    {"hour": "9:00", "orders": 12, "revenue": 720.50},
    {"hour": "10:00", "orders": 18, "revenue": 1150.25},
    {"hour": "11:00", "orders": 25, "revenue": 1620.75},
    {"hour": "12:00", "orders": 45, "revenue": 2890.00},
    {"hour": "13:00", "orders": 52, "revenue": 3380.50},
    {"hour": "14:00", "orders": 38, "revenue": 2470.25},
    {"hour": "15:00", "orders": 28, "revenue": 1825.75},
    {"hour": "16:00", "orders": 15, "revenue": 980.00},
    {"hour": "17:00", "orders": 14, "revenue": 895.50},
  ];

  List<Map<String, dynamic>> topItems = [
    {
      "name": "Grilled Salmon",
      "orders": 32,
      "revenue": 1280.00,
      "category": "Main Course",
    },
    {
      "name": "Chicken Caesar Salad",
      "orders": 28,
      "revenue": 840.00,
      "category": "Salad",
    },
    {
      "name": "Beef Burger Deluxe",
      "orders": 25,
      "revenue": 975.00,
      "category": "Burger",
    },
    {
      "name": "Margherita Pizza",
      "orders": 22,
      "revenue": 660.00,
      "category": "Pizza",
    },
    {
      "name": "Chocolate Lava Cake",
      "orders": 18,
      "revenue": 450.00,
      "category": "Dessert",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDatePicker(
                    label: "Select Date",
                    value: DateTime.parse(selectedDate),
                    onChanged: (value) {
                      selectedDate = value.toString().split(' ')[0];
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            Text(
              "Today's Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: dailyStats.map((stat) {
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
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (stat["isPositive"] as bool)
                                  ? successColor.withAlpha(30)
                                  : dangerColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${stat["change"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (stat["isPositive"] as bool)
                                    ? successColor
                                    : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        stat["title"] == "Revenue" || stat["title"] == "Average Order"
                            ? "\$${((stat["value"] as num).toDouble()).currency}"
                            : "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),
            
            Text(
              "Hourly Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Hour",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Orders",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Revenue",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...hourlyData.map((data) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${data["hour"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${data["orders"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "\$${((data["revenue"] as num).toDouble()).currency}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            Text(
              "Top Selling Items",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: topItems.map((item) {
                  int index = topItems.indexOf(item);
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      border: index < topItems.length - 1
                          ? Border(
                              bottom: BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: index < 3
                                ? primaryColor.withAlpha(30)
                                : disabledColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: index < 3 ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${item["category"]}",
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
                              "${item["orders"]} orders",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "\$${((item["revenue"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
