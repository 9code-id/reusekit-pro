import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosMonthlySalesView extends StatefulWidget {
  const PosMonthlySalesView({super.key});

  @override
  State<PosMonthlySalesView> createState() => _PosMonthlySalesViewState();
}

class _PosMonthlySalesViewState extends State<PosMonthlySalesView> {
  DateTime selectedMonth = DateTime.now();
  String selectedView = "Overview";
  
  List<Map<String, dynamic>> viewOptions = [
    {"label": "Overview", "value": "Overview"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Categories", "value": "Categories"},
    {"label": "Trends", "value": "Trends"},
  ];

  Map<String, dynamic> monthlySummary = {
    "totalSales": 742350.0,
    "totalTransactions": 5687,
    "totalCustomers": 4201,
    "avgDailySales": 23948.39,
    "avgTransactionValue": 130.52,
    "grossProfit": 296940.0,
    "profitMargin": 40.0,
    "bestWeek": "Week 3",
    "bestDay": "Black Friday",
    "monthOverMonthGrowth": 18.5,
    "customerRetentionRate": 78.3,
    "newCustomers": 912,
    "returningCustomers": 3289,
  };

  List<Map<String, dynamic>> weeklyData = [
    {
      "week": "Week 1",
      "period": "Jan 1-7",
      "sales": 168450.0,
      "transactions": 1247,
      "customers": 1089,
      "profit": 67380.0,
      "avgDaily": 24064.29,
      "growth": 12.5,
      "status": "good",
    },
    {
      "week": "Week 2", 
      "period": "Jan 8-14",
      "sales": 185200.0,
      "transactions": 1389,
      "customers": 1156,
      "profit": 74080.0,
      "avgDaily": 26457.14,
      "growth": 15.2,
      "status": "excellent",
    },
    {
      "week": "Week 3",
      "period": "Jan 15-21", 
      "sales": 210900.0,
      "transactions": 1567,
      "customers": 1289,
      "profit": 84360.0,
      "avgDaily": 30128.57,
      "growth": 22.8,
      "status": "excellent",
    },
    {
      "week": "Week 4",
      "period": "Jan 22-28",
      "sales": 177800.0,
      "transactions": 1484,
      "customers": 1167,
      "profit": 71120.0,
      "avgDaily": 25400.0,
      "growth": 8.7,
      "status": "good",
    },
  ];

  List<Map<String, dynamic>> dailyTrends = [
    {"day": 1, "sales": 18200.0, "target": 20000.0},
    {"day": 2, "sales": 21500.0, "target": 20000.0},
    {"day": 3, "sales": 23800.0, "target": 20000.0},
    {"day": 4, "sales": 26100.0, "target": 20000.0},
    {"day": 5, "sales": 28900.0, "target": 20000.0},
    {"day": 6, "sales": 34200.0, "target": 20000.0},
    {"day": 7, "sales": 15750.0, "target": 20000.0},
    {"day": 8, "sales": 19800.0, "target": 20000.0},
    {"day": 9, "sales": 24600.0, "target": 20000.0},
    {"day": 10, "sales": 27200.0, "target": 20000.0},
    {"day": 11, "sales": 29800.0, "target": 20000.0},
    {"day": 12, "sales": 31500.0, "target": 20000.0},
    {"day": 13, "sales": 36700.0, "target": 20000.0},
    {"day": 14, "sales": 17900.0, "target": 20000.0},
    {"day": 15, "sales": 21200.0, "target": 20000.0},
    {"day": 16, "sales": 25800.0, "target": 20000.0},
    {"day": 17, "sales": 28400.0, "target": 20000.0},
    {"day": 18, "sales": 32100.0, "target": 20000.0},
    {"day": 19, "sales": 35600.0, "target": 20000.0},
    {"day": 20, "sales": 38900.0, "target": 20000.0},
    {"day": 21, "sales": 19600.0, "target": 20000.0},
    {"day": 22, "sales": 22800.0, "target": 20000.0},
    {"day": 23, "sales": 26500.0, "target": 20000.0},
    {"day": 24, "sales": 29200.0, "target": 20000.0},
    {"day": 25, "sales": 31800.0, "target": 20000.0},
    {"day": 26, "sales": 33400.0, "target": 20000.0},
    {"day": 27, "sales": 28900.0, "target": 20000.0},
    {"day": 28, "sales": 24200.0, "target": 20000.0},
  ];

  List<Map<String, dynamic>> categoryPerformance = [
    {
      "category": "Electronics",
      "monthlySales": 296940.0,
      "percentage": 40.0,
      "monthGrowth": 22.5,
      "weeklyAvg": 74235.0,
      "transactions": 1356,
      "icon": Icons.devices,
      "color": primaryColor,
    },
    {
      "category": "Clothing",
      "monthlySales": 200634.0,
      "percentage": 27.0,
      "monthGrowth": 15.8,
      "weeklyAvg": 50158.5,
      "transactions": 1987,
      "icon": Icons.checkroom,
      "color": successColor,
    },
    {
      "category": "Home & Garden",
      "monthlySales": 148470.0,
      "percentage": 20.0,
      "monthGrowth": 18.2,
      "weeklyAvg": 37117.5,
      "transactions": 856,
      "icon": Icons.home,
      "color": infoColor,
    },
    {
      "category": "Sports",
      "monthlySales": 96306.0,
      "percentage": 13.0,
      "monthGrowth": 8.9,
      "weeklyAvg": 24076.5,
      "transactions": 1488,
      "icon": Icons.sports,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> monthlyComparison = [
    {"month": "This Month (Jan)", "sales": 742350.0, "growth": 0.0, "isSelected": true},
    {"month": "Last Month (Dec)", "sales": 626180.0, "growth": -15.6, "isSelected": false}, 
    {"month": "Nov", "sales": 589420.0, "growth": -20.6, "isSelected": false},
    {"month": "Oct", "sales": 612890.0, "growth": -17.4, "isSelected": false},
    {"month": "Sep", "sales": 598340.0, "growth": -19.4, "isSelected": false},
    {"month": "Aug", "sales": 678920.0, "growth": -8.6, "isSelected": false},
  ];

  Widget _buildMonthSelector() {
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
                  "Selected Month",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${selectedMonth.year} ${_getMonthName(selectedMonth.month)}",
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
                    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
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
                    initialDate: selectedMonth,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      selectedMonth = DateTime(date.year, date.month);
                    });
                  }
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.chevron_right,
                size: bs.sm,
                onPressed: selectedMonth.isBefore(DateTime(DateTime.now().year, DateTime.now().month)) ? () {
                  setState(() {
                    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
                  });
                } : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlySummary() {
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
                "Monthly Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "+${monthlySummary["monthOverMonthGrowth"].toStringAsFixed(1)}% vs last month",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
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
                        "\$${monthlySummary["totalSales"].currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Sales",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                        Icons.account_balance_wallet,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${monthlySummary["grossProfit"].currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Gross Profit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                        Icons.receipt,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${monthlySummary["totalTransactions"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Transactions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                        Icons.people,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${monthlySummary["totalCustomers"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Customers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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

  Widget _buildWeeklyBreakdown() {
    double maxSales = weeklyData.map((w) => w["sales"] as double).reduce((a, b) => a > b ? a : b);
    
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
            "Weekly Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklyData.map((week) {
                double normalizedHeight = ((week["sales"] as double) / maxSales) * 150;
                Color statusColor = _getWeekStatusColor(week["status"]);
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 60,
                      height: normalizedHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            statusColor,
                            statusColor.withAlpha(150),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${week["week"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${((week["sales"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyDetails() {
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
            "Weekly Performance Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: weeklyData.map((week) {
              Color statusColor = _getWeekStatusColor(week["status"]);
              String statusText = _getWeekStatusText(week["status"]);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${week["week"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      statusText,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: statusColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${week["period"]}",
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
                              "\$${(week["sales"] as double).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "+${(week["growth"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transactions: ${week["transactions"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Customers: ${week["customers"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                "Profit: \$${(week["profit"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Daily Avg: \$${(week["avgDaily"] as double).currency}",
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
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyTrendsChart() {
    double maxSales = dailyTrends.map((d) => d["sales"] as double).reduce((a, b) => a > b ? a : b);
    double targetLine = (dailyTrends[0]["target"] as double) / maxSales * 180;
    
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
            "Daily Sales Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            child: Stack(
              children: [
                // Target line
                Positioned(
                  top: 200 - targetLine - 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 1,
                    color: dangerColor.withAlpha(100),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs),
                          color: Colors.white,
                          child: Text(
                            "Target",
                            style: TextStyle(
                              fontSize: 10,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: dailyTrends.map((day) {
                      double normalizedHeight = ((day["sales"] as double) / maxSales) * 180;
                      bool aboveTarget = (day["sales"] as double) > (day["target"] as double);
                      
                      return Container(
                        margin: EdgeInsets.only(right: 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 12,
                              height: normalizedHeight,
                              decoration: BoxDecoration(
                                color: aboveTarget ? successColor : warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(height: spXs),
                            if ((day["day"] as int) % 5 == 1)
                              Text(
                                "${day["day"]}",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: disabledBoldColor,
                                ),
                              )
                            else
                              SizedBox(height: 12),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Above Target",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: warningColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Below Target",
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

  Widget _buildCategoryPerformance() {
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
            "Category Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: categoryPerformance.map((category) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (category["color"] as Color).withAlpha(50),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: category["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${category["category"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                                  widthFactor: (category["percentage"] as double) / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: category["color"] as Color,
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
                              "\$${(category["monthlySales"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
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
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Weekly Avg: \$${(category["weeklyAvg"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Transactions: ${category["transactions"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "+${(category["monthGrowth"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.bold,
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

  Widget _buildMonthlyComparison() {
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
            "6-Month Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: monthlyComparison.map((month) {
              bool isSelected = month["isSelected"] as bool;
              Color bgColor = isSelected ? primaryColor.withAlpha(20) : Colors.grey[50]!;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${month["month"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "\$${(month["sales"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    if (!isSelected)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: (month["growth"] as double) >= 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${(month["growth"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 10,
                            color: (month["growth"] as double) >= 0 ? successColor : dangerColor,
                            fontWeight: FontWeight.bold,
                          ),
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

  Color _getWeekStatusColor(String status) {
    switch (status) {
      case "excellent":
        return Colors.purple;
      case "good":
        return successColor;
      case "average":
        return warningColor;
      default:
        return dangerColor;
    }
  }

  String _getWeekStatusText(String status) {
    switch (status) {
      case "excellent":
        return "EXCELLENT";
      case "good":
        return "GOOD";
      case "average":
        return "AVERAGE";
      default:
        return "NEEDS IMPROVEMENT";
    }
  }

  String _getMonthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monthly Sales"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Monthly sales report shared successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Monthly sales report downloaded");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildMonthSelector(),
            _buildMonthlySummary(),
            _buildWeeklyBreakdown(),
            _buildWeeklyDetails(),
            _buildDailyTrendsChart(),
            _buildCategoryPerformance(),
            _buildMonthlyComparison(),
          ],
        ),
      ),
    );
  }
}
