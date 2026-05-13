import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaSalesAnalyticsView extends StatefulWidget {
  const HhaSalesAnalyticsView({super.key});

  @override
  State<HhaSalesAnalyticsView> createState() => _HhaSalesAnalyticsViewState();
}

class _HhaSalesAnalyticsViewState extends State<HhaSalesAnalyticsView> {
  String selectedPeriod = "This Month";
  String selectedChannel = "All";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> channelOptions = [
    {"label": "All Channels", "value": "All"},
    {"label": "Direct Booking", "value": "Direct"},
    {"label": "Online Travel Agencies", "value": "OTA"},
    {"label": "Walk-in", "value": "Walk-in"},
    {"label": "Corporate", "value": "Corporate"},
  ];

  List<Map<String, dynamic>> salesMetrics = [
    {
      "title": "Total Sales",
      "value": 245678.50,
      "change": 15.8,
      "target": 220000.0,
      "icon": Icons.attach_money,
      "color": 0xFF4CAF50,
    },
    {
      "title": "Bookings",
      "value": 324.0,
      "change": 12.3,
      "target": 300.0,
      "icon": Icons.event,
      "color": 0xFF2196F3,
      "isCount": true,
    },
    {
      "title": "Average Booking Value",
      "value": 758.39,
      "change": 3.1,
      "target": 730.0,
      "icon": Icons.trending_up,
      "color": 0xFFFF9800,
    },
    {
      "title": "Conversion Rate",
      "value": 18.7,
      "change": 2.4,
      "target": 15.0,
      "icon": Icons.percent,
      "color": 0xFF9C27B0,
      "isPercentage": true,
    },
  ];

  List<Map<String, dynamic>> salesChannels = [
    {
      "channel": "Direct Booking",
      "sales": 98654.30,
      "bookings": 130,
      "percentage": 40.1,
      "avgValue": 758.88,
      "change": 8.5,
      "color": 0xFF4CAF50,
      "icon": Icons.web,
    },
    {
      "channel": "Online Travel Agencies",
      "sales": 86543.20,
      "bookings": 142,
      "percentage": 35.2,
      "avgValue": 609.46,
      "change": 12.3,
      "color": 0xFF2196F3,
      "icon": Icons.travel_explore,
    },
    {
      "channel": "Walk-in",
      "sales": 36785.40,
      "bookings": 32,
      "percentage": 15.0,
      "avgValue": 1149.54,
      "change": -5.2,
      "color": 0xFFFF9800,
      "icon": Icons.directions_walk,
    },
    {
      "channel": "Corporate",
      "sales": 23695.60,
      "bookings": 20,
      "percentage": 9.7,
      "avgValue": 1184.78,
      "change": 18.7,
      "color": 0xFF9C27B0,
      "icon": Icons.business,
    },
  ];

  List<Map<String, dynamic>> salesTrends = [
    {"week": "Week 1", "sales": 58430.25, "bookings": 76},
    {"week": "Week 2", "sales": 62785.50, "bookings": 82},
    {"week": "Week 3", "sales": 59425.75, "bookings": 78},
    {"week": "Week 4", "sales": 65037.00, "bookings": 88},
  ];

  List<Map<String, dynamic>> topPerformingRooms = [
    {
      "roomType": "Executive Suite",
      "sales": 78542.30,
      "bookings": 45,
      "avgRate": 1745.38,
      "occupancy": 94.7,
      "revenue": 23.2,
    },
    {
      "roomType": "Deluxe Room",
      "sales": 89675.80,
      "bookings": 98,
      "avgRate": 915.06,
      "occupancy": 87.3,
      "revenue": 26.5,
    },
    {
      "roomType": "Standard Room",
      "sales": 56234.40,
      "bookings": 134,
      "avgRate": 419.66,
      "occupancy": 82.1,
      "revenue": 16.6,
    },
    {
      "roomType": "Presidential Suite",
      "sales": 21226.00,
      "bookings": 8,
      "avgRate": 2653.25,
      "occupancy": 80.0,
      "revenue": 6.3,
    },
  ];

  List<Map<String, dynamic>> customerSegments = [
    {
      "segment": "Business Travelers",
      "sales": 98765.40,
      "percentage": 40.2,
      "avgStay": 2.3,
      "bookings": 145,
      "color": 0xFF2196F3,
    },
    {
      "segment": "Leisure Travelers",
      "sales": 89432.10,
      "percentage": 36.4,
      "avgStay": 3.8,
      "bookings": 98,
      "color": 0xFF4CAF50,
    },
    {
      "segment": "Groups & Events",
      "sales": 36785.20,
      "percentage": 15.0,
      "avgStay": 2.1,
      "bookings": 24,
      "color": 0xFFFF9800,
    },
    {
      "segment": "VIP Guests",
      "sales": 20695.80,
      "percentage": 8.4,
      "avgStay": 4.2,
      "bookings": 12,
      "color": 0xFF9C27B0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Sales Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Channels", icon: Icon(Icons.share)),
        Tab(text: "Rooms", icon: Icon(Icons.hotel)),
        Tab(text: "Customers", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildChannelsTab(),
        _buildRoomsTab(),
        _buildCustomersTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
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
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Sales Metrics
          Text(
            "Sales Performance",
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
            children: salesMetrics.map((metric) {
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
                      metric["isPercentage"] == true
                        ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                        : metric["isCount"] == true
                        ? "${(metric["value"] as double).toStringAsFixed(0)}"
                        : "\$${((metric["value"] as double)).currency}",
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
                        SizedBox(width: spSm),
                        Icon(
                          isOnTarget ? Icons.check_circle : Icons.error,
                          color: isOnTarget ? successColor : warningColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),

          // Sales Trend Chart
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
                  "Weekly Sales Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: salesTrends.length,
                    itemBuilder: (context, index) {
                      final trend = salesTrends[index];
                      final sales = (trend["sales"] as double);
                      final maxSales = salesTrends.map((d) => d["sales"] as double).reduce((a, b) => a > b ? a : b);
                      final height = (sales / maxSales) * 150;
                      
                      return Container(
                        width: 100,
                        margin: EdgeInsets.only(right: spMd),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(sales / 1000).toStringAsFixed(0)}K",
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
                              "${trend["week"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${trend["bookings"]} bookings",
                              style: TextStyle(
                                fontSize: 10,
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
        ],
      ),
    );
  }

  Widget _buildChannelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sales by Channel",
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
            itemCount: salesChannels.length,
            itemBuilder: (context, index) {
              final channel = salesChannels[index];
              final sales = (channel["sales"] as double);
              final bookings = (channel["bookings"] as int);
              final percentage = (channel["percentage"] as double);
              final avgValue = (channel["avgValue"] as double);
              final change = (channel["change"] as double);
              final isPositive = change >= 0;
              
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
                      color: Color(channel["color"] as int),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Color(channel["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            channel["icon"] as IconData,
                            color: Color(channel["color"] as int),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${channel["channel"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "$bookings bookings • ${percentage.toStringAsFixed(1)}% of total",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Row(
                          children: [
                            Icon(
                              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                              color: isPositive ? successColor : dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${isPositive ? '+' : ''}${change.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: isPositive ? successColor : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Progress Bar
                    LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(channel["color"] as int),
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
                                "Total Sales",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${sales.currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(channel["color"] as int),
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
                                "Avg. Booking Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${avgValue.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
    );
  }

  Widget _buildRoomsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Room Performance",
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
            itemCount: topPerformingRooms.length,
            itemBuilder: (context, index) {
              final room = topPerformingRooms[index];
              final sales = (room["sales"] as double);
              final bookings = (room["bookings"] as int);
              final avgRate = (room["avgRate"] as double);
              final occupancy = (room["occupancy"] as double);
              final revenueShare = (room["revenue"] as double);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: index == 0 ? Color(0xFFFFD700) :
                                   index == 1 ? Color(0xFFC0C0C0) :
                                   index == 2 ? Color(0xFFCD7F32) : primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                                "${room["roomType"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "$bookings bookings • ${revenueShare.toStringAsFixed(1)}% of total revenue",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Text(
                          "\$${sales.currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildRoomMetric("Average Rate", "\$${avgRate.toStringAsFixed(2)}", "per night"),
                        _buildRoomMetric("Occupancy", "${occupancy.toStringAsFixed(1)}%", "this month"),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Segments",
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
            itemCount: customerSegments.length,
            itemBuilder: (context, index) {
              final segment = customerSegments[index];
              final sales = (segment["sales"] as double);
              final percentage = (segment["percentage"] as double);
              final avgStay = (segment["avgStay"] as double);
              final bookings = (segment["bookings"] as int);
              
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
                      color: Color(segment["color"] as int),
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
                                "${segment["segment"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "$bookings bookings • ${percentage.toStringAsFixed(1)}% of total sales",
                                style: TextStyle(
                                  fontSize: 12,
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
                            color: Color(segment["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${percentage.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Color(segment["color"] as int),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Progress Bar
                    LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(segment["color"] as int),
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
                                "Total Sales",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${sales.currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(segment["color"] as int),
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
                                "Avg. Stay Duration",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${avgStay.toStringAsFixed(1)} nights",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
    );
  }

  Widget _buildRoomMetric(String title, String value, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
