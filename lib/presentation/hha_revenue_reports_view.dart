import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRevenueReportsView extends StatefulWidget {
  const HhaRevenueReportsView({super.key});

  @override
  State<HhaRevenueReportsView> createState() => _HhaRevenueReportsViewState();
}

class _HhaRevenueReportsViewState extends State<HhaRevenueReportsView> {
  String selectedPeriod = "This Month";
  String selectedRevenueType = "All";
  bool loading = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> revenueTypeOptions = [
    {"label": "All Revenue", "value": "All"},
    {"label": "Room Revenue", "value": "Room"},
    {"label": "Food & Beverage", "value": "F&B"},
    {"label": "Spa & Wellness", "value": "Spa"},
    {"label": "Other Services", "value": "Other"},
  ];

  List<Map<String, dynamic>> revenueMetrics = [
    {
      "title": "Total Revenue",
      "value": 245678.50,
      "change": 15.8,
      "target": 220000.0,
      "icon": Icons.attach_money,
      "color": 0xFF4CAF50,
    },
    {
      "title": "Room Revenue",
      "value": 165432.30,
      "change": 12.3,
      "target": 150000.0,
      "icon": Icons.hotel,
      "color": 0xFF2196F3,
    },
    {
      "title": "F&B Revenue",
      "value": 54321.80,
      "change": 8.7,
      "target": 50000.0,
      "icon": Icons.restaurant,
      "color": 0xFFFF9800,
    },
    {
      "title": "Other Revenue",
      "value": 25924.40,
      "change": 22.1,
      "target": 20000.0,
      "icon": Icons.spa,
      "color": 0xFF9C27B0,
    },
  ];

  List<Map<String, dynamic>> dailyRevenue = [
    {"date": "2024-03-01", "total": 7850.50, "room": 5200.00, "fb": 1850.50, "other": 800.00},
    {"date": "2024-03-02", "total": 8520.75, "room": 5680.00, "fb": 1940.75, "other": 900.00},
    {"date": "2024-03-03", "total": 9245.30, "room": 6150.00, "fb": 2195.30, "other": 900.00},
    {"date": "2024-03-04", "total": 8875.60, "room": 5920.00, "fb": 2055.60, "other": 900.00},
    {"date": "2024-03-05", "total": 9680.90, "room": 6450.00, "fb": 2330.90, "other": 900.00},
    {"date": "2024-03-06", "total": 10245.80, "room": 6850.00, "fb": 2495.80, "other": 900.00},
    {"date": "2024-03-07", "total": 8950.45, "room": 5980.00, "fb": 2070.45, "other": 900.00},
  ];

  List<Map<String, dynamic>> revenueBySource = [
    {
      "source": "Room Revenue",
      "percentage": 67.3,
      "amount": 165432.30,
      "change": 12.3,
      "color": 0xFF2196F3,
      "icon": Icons.hotel,
    },
    {
      "source": "Food & Beverage",
      "percentage": 22.1,
      "amount": 54321.80,
      "change": 8.7,
      "color": 0xFFFF9800,
      "icon": Icons.restaurant,
    },
    {
      "source": "Spa & Wellness",
      "percentage": 7.8,
      "amount": 19154.20,
      "change": 18.5,
      "color": 0xFF9C27B0,
      "icon": Icons.spa,
    },
    {
      "source": "Other Services",
      "percentage": 2.8,
      "amount": 6770.20,
      "change": 25.4,
      "color": 0xFF4CAF50,
      "icon": Icons.room_service,
    },
  ];

  List<Map<String, dynamic>> monthlyComparison = [
    {"month": "Oct", "revenue": 198500.00, "target": 200000.00},
    {"month": "Nov", "revenue": 215300.00, "target": 210000.00},
    {"month": "Dec", "revenue": 235600.00, "target": 220000.00},
    {"month": "Jan", "revenue": 201400.00, "target": 200000.00},
    {"month": "Feb", "revenue": 218900.00, "target": 215000.00},
    {"month": "Mar", "revenue": 245678.50, "target": 220000.00},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Revenue Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              _exportReport();
            },
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Time Period",
                      items: periodOptions,
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Revenue Type",
                      items: revenueTypeOptions,
                      value: selectedRevenueType,
                      onChanged: (value, label) {
                        selectedRevenueType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spLg),

              // Revenue Metrics
              Text(
                "Revenue Overview",
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
                children: revenueMetrics.map((metric) {
                  final isPositive = (metric["change"] as double) >= 0;
                  final isOnTarget = (metric["value"] as double) >= (metric["target"] as double);
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
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
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Color(metric["color"] as int).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                metric["icon"] as IconData,
                                color: Color(metric["color"] as int),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${metric["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        
                        Text(
                          "\$${((metric["value"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        
                        Row(
                          children: [
                            Icon(
                              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                              color: isPositive ? successColor : dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${isPositive ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: isPositive ? successColor : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        
                        Row(
                          children: [
                            Text(
                              "Target: ",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((metric["target"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isOnTarget ? successColor : dangerColor,
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
              SizedBox(height: spLg),

              // Daily Revenue Trend
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Text(
                          "Daily Revenue Trend",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dailyRevenue.length,
                        itemBuilder: (context, index) {
                          final data = dailyRevenue[index];
                          final revenue = (data["total"] as double);
                          final maxRevenue = dailyRevenue.map((d) => d["total"] as double).reduce((a, b) => a > b ? a : b);
                          final height = (revenue / maxRevenue) * 150;
                          
                          return Container(
                            width: 80,
                            margin: EdgeInsets.only(right: spSm),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${(revenue / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 40,
                                  height: height,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        primaryColor,
                                        primaryColor.withAlpha(150),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${DateTime.parse(data["date"] as String).day}/${DateTime.parse(data["date"] as String).month}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),

              // Revenue by Source
              Text(
                "Revenue by Source",
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
                itemCount: revenueBySource.length,
                itemBuilder: (context, index) {
                  final source = revenueBySource[index];
                  final percentage = (source["percentage"] as double);
                  final amount = (source["amount"] as double);
                  final change = (source["change"] as double);
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: Color(source["color"] as int),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Color(source["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            source["icon"] as IconData,
                            color: Color(source["color"] as int),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${source["source"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${amount.currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(source["color"] as int),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Color(source["color"] as int).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${percentage.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(source["color"] as int),
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "+${change.toStringAsFixed(1)}%",
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
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: spLg),

              // Monthly Comparison
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monthly Performance vs Target",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: monthlyComparison.length,
                      itemBuilder: (context, index) {
                        final month = monthlyComparison[index];
                        final revenue = (month["revenue"] as double);
                        final target = (month["target"] as double);
                        final achievement = (revenue / target) * 100;
                        final isOnTarget = revenue >= target;
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isOnTarget 
                              ? successColor.withAlpha(10)
                              : warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isOnTarget 
                                ? successColor.withAlpha(30)
                                : warningColor.withAlpha(30),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                child: Text(
                                  "${month["month"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Revenue: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${revenue.currency}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    LinearProgressIndicator(
                                      value: achievement / 100,
                                      backgroundColor: disabledColor,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        isOnTarget ? successColor : warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${achievement.toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isOnTarget ? successColor : warningColor,
                                    ),
                                  ),
                                  Text(
                                    "Target: \$${target.currency}",
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
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  void _exportReport() {
    showLoading();
    
    // Simulate export process
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Revenue report exported successfully");
    });
  }
}
