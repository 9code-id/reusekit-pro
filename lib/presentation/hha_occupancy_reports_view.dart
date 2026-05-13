import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaOccupancyReportsView extends StatefulWidget {
  const HhaOccupancyReportsView({super.key});

  @override
  State<HhaOccupancyReportsView> createState() => _HhaOccupancyReportsViewState();
}

class _HhaOccupancyReportsViewState extends State<HhaOccupancyReportsView> {
  String selectedPeriod = "This Month";
  String selectedRoomType = "All";
  bool loading = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> roomTypeOptions = [
    {"label": "All Room Types", "value": "All"},
    {"label": "Standard Room", "value": "Standard"},
    {"label": "Deluxe Room", "value": "Deluxe"},
    {"label": "Suite", "value": "Suite"},
    {"label": "Presidential Suite", "value": "Presidential"},
  ];

  List<Map<String, dynamic>> occupancyMetrics = [
    {
      "title": "Overall Occupancy",
      "value": 87.3,
      "change": 5.2,
      "target": 85.0,
      "icon": Icons.hotel,
      "color": 0xFF2196F3,
    },
    {
      "title": "Average Daily Rate",
      "value": 195.50,
      "change": 8.3,
      "target": 180.0,
      "icon": Icons.attach_money,
      "color": 0xFF4CAF50,
    },
    {
      "title": "Revenue Per Room",
      "value": 170.45,
      "change": 12.8,
      "target": 150.0,
      "icon": Icons.trending_up,
      "color": 0xFFFF9800,
    },
    {
      "title": "Average Length of Stay",
      "value": 2.8,
      "change": -0.2,
      "target": 3.0,
      "icon": Icons.schedule,
      "color": 0xFF9C27B0,
    },
  ];

  List<Map<String, dynamic>> dailyOccupancy = [
    {"date": "2024-03-01", "occupancy": 78.5, "rooms": 157, "total": 200},
    {"date": "2024-03-02", "occupancy": 82.0, "rooms": 164, "total": 200},
    {"date": "2024-03-03", "occupancy": 89.5, "rooms": 179, "total": 200},
    {"date": "2024-03-04", "occupancy": 91.0, "rooms": 182, "total": 200},
    {"date": "2024-03-05", "occupancy": 94.5, "rooms": 189, "total": 200},
    {"date": "2024-03-06", "occupancy": 96.0, "rooms": 192, "total": 200},
    {"date": "2024-03-07", "occupancy": 87.5, "rooms": 175, "total": 200},
  ];

  List<Map<String, dynamic>> roomTypeData = [
    {
      "type": "Standard Room",
      "totalRooms": 120,
      "occupiedRooms": 98,
      "occupancyRate": 81.7,
      "avgRate": 159.99,
      "revenue": 15679.02,
      "color": 0xFF2196F3,
    },
    {
      "type": "Deluxe Room",
      "totalRooms": 50,
      "occupiedRooms": 47,
      "occupancyRate": 94.0,
      "avgRate": 219.99,
      "revenue": 10339.53,
      "color": 0xFF4CAF50,
    },
    {
      "type": "Suite",
      "totalRooms": 25,
      "occupiedRooms": 22,
      "occupancyRate": 88.0,
      "avgRate": 359.99,
      "revenue": 7919.78,
      "color": 0xFFFF9800,
    },
    {
      "type": "Presidential Suite",
      "totalRooms": 5,
      "occupiedRooms": 4,
      "occupancyRate": 80.0,
      "avgRate": 599.99,
      "revenue": 2399.96,
      "color": 0xFF9C27B0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Occupancy Reports"),
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
                      label: "Room Type",
                      items: roomTypeOptions,
                      value: selectedRoomType,
                      onChanged: (value, label) {
                        selectedRoomType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spLg),

              // Key Metrics
              Text(
                "Key Occupancy Metrics",
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
                children: occupancyMetrics.map((metric) {
                  final isPositive = (metric["change"] as double) >= 0;
                  final isOnTarget = metric["title"] == "Average Length of Stay" 
                    ? (metric["value"] as double) >= (metric["target"] as double)
                    : (metric["value"] as double) >= (metric["target"] as double);
                  
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
                          metric["title"].toString().contains("Rate") || metric["title"].toString().contains("Revenue")
                            ? "\$${((metric["value"] as double)).toStringAsFixed(2)}"
                            : metric["title"].toString().contains("Occupancy")
                            ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                            : "${(metric["value"] as double).toStringAsFixed(1)} days",
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
                              metric["title"].toString().contains("Rate") || metric["title"].toString().contains("Revenue")
                                ? "\$${((metric["target"] as double)).toStringAsFixed(2)}"
                                : metric["title"].toString().contains("Occupancy")
                                ? "${(metric["target"] as double).toStringAsFixed(1)}%"
                                : "${(metric["target"] as double).toStringAsFixed(1)} days",
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

              // Daily Occupancy Trend
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
                          "Daily Occupancy Trend",
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
                        itemCount: dailyOccupancy.length,
                        itemBuilder: (context, index) {
                          final data = dailyOccupancy[index];
                          final occupancy = (data["occupancy"] as double);
                          final height = (occupancy / 100) * 150;
                          
                          return Container(
                            width: 60,
                            margin: EdgeInsets.only(right: spSm),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${occupancy.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 30,
                                  height: height,
                                  decoration: BoxDecoration(
                                    color: occupancy >= 90 ? successColor :
                                           occupancy >= 75 ? warningColor : 
                                           dangerColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${DateTime.parse(data["date"] as String).day}",
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

              // Room Type Breakdown
              Text(
                "Room Type Performance",
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
                itemCount: roomTypeData.length,
                itemBuilder: (context, index) {
                  final roomType = roomTypeData[index];
                  final occupancyRate = (roomType["occupancyRate"] as double);
                  final occupiedRooms = (roomType["occupiedRooms"] as int);
                  final totalRooms = (roomType["totalRooms"] as int);
                  
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
                          color: Color(roomType["color"] as int),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${roomType["type"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "$occupiedRooms of $totalRooms rooms occupied",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spMd,
                                vertical: spSm,
                              ),
                              decoration: BoxDecoration(
                                color: occupancyRate >= 90 
                                  ? successColor.withAlpha(20)
                                  : occupancyRate >= 75 
                                  ? warningColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${occupancyRate.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: occupancyRate >= 90 
                                    ? successColor
                                    : occupancyRate >= 75 
                                    ? warningColor
                                    : dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        
                        // Progress Bar
                        LinearProgressIndicator(
                          value: occupancyRate / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(roomType["color"] as int),
                          ),
                        ),
                        SizedBox(height: spSm),
                        
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Average Rate",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "\$${((roomType["avgRate"] as double)).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
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
                                    "Revenue",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "\$${((roomType["revenue"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
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
                },
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
      ss("Occupancy report exported successfully");
    });
  }
}
