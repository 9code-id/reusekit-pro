import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDashboardView extends StatefulWidget {
  const DlaDashboardView({super.key});

  @override
  State<DlaDashboardView> createState() => _DlaDashboardViewState();
}

class _DlaDashboardViewState extends State<DlaDashboardView> {
  int selectedPeriod = 0;
  
  List<String> periods = ["Today", "This Week", "This Month", "All Time"];
  
  Map<String, dynamic> dashboardData = {
    "totalEarnings": 1250.75,
    "totalDeliveries": 85,
    "avgRating": 4.8,
    "totalDistance": 425.5,
    "todayEarnings": 145.50,
    "todayDeliveries": 8,
    "weeklyGoal": 500.0,
    "completionRate": 98.5,
  };
  
  List<Map<String, dynamic>> recentDeliveries = [
    {
      "id": "DL085",
      "restaurant": "Pizza Palace",
      "customer": "John Smith",
      "earnings": 15.75,
      "distance": "3.2 km",
      "time": "25 min",
      "rating": 5,
      "date": "2024-01-15",
      "status": "completed",
    },
    {
      "id": "DL084",
      "restaurant": "Burger Express",
      "customer": "Sarah Johnson",
      "earnings": 12.25,
      "distance": "2.1 km",
      "time": "18 min",
      "rating": 4,
      "date": "2024-01-15",
      "status": "completed",
    },
    {
      "id": "DL083",
      "restaurant": "Sushi World",
      "customer": "Mike Davis",
      "earnings": 18.50,
      "distance": "4.5 km",
      "time": "32 min",
      "rating": 5,
      "date": "2024-01-14",
      "status": "completed",
    },
  ];
  
  List<Map<String, dynamic>> weeklyEarnings = [
    {"day": "Mon", "amount": 125.50},
    {"day": "Tue", "amount": 98.75},
    {"day": "Wed", "amount": 156.25},
    {"day": "Thu", "amount": 189.00},
    {"day": "Fri", "amount": 201.75},
    {"day": "Sat", "amount": 234.50},
    {"day": "Sun", "amount": 145.50},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              // Export data
            },
            icon: Icon(Icons.file_download),
          ),
          IconButton(
            onPressed: () {
              // Settings
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            QCategoryPicker(
              items: periods.map((period) => {
                "label": period,
                "value": period,
              }).toList(),
              value: periods[selectedPeriod],
              onChanged: (index, label, value, item) {
                selectedPeriod = index;
                setState(() {});
              },
            ),
            
            // Key Metrics
            Text(
              "Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    title: "Total Earnings",
                    value: "\$${(dashboardData["totalEarnings"] as double).toStringAsFixed(2)}",
                    icon: Icons.account_balance_wallet,
                    color: successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildMetricCard(
                    title: "Deliveries",
                    value: "${dashboardData["totalDeliveries"]}",
                    icon: Icons.local_shipping,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    title: "Avg Rating",
                    value: "${(dashboardData["avgRating"] as double).toStringAsFixed(1)}⭐",
                    icon: Icons.star,
                    color: warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildMetricCard(
                    title: "Distance",
                    value: "${(dashboardData["totalDistance"] as double).toStringAsFixed(1)} km",
                    icon: Icons.route,
                    color: infoColor,
                  ),
                ),
              ],
            ),
            
            // Weekly Goal Progress
            Text(
              "Weekly Goal",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Earnings Goal",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(dashboardData["totalEarnings"] as double).toStringAsFixed(2)} / \$${(dashboardData["weeklyGoal"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  LinearProgressIndicator(
                    value: (dashboardData["totalEarnings"] as double) / (dashboardData["weeklyGoal"] as double),
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${(((dashboardData["totalEarnings"] as double) / (dashboardData["weeklyGoal"] as double)) * 100).toStringAsFixed(1)}% Complete",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "\$${((dashboardData["weeklyGoal"] as double) - (dashboardData["totalEarnings"] as double)).toStringAsFixed(2)} to go",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Weekly Earnings Chart
            Text(
              "Weekly Earnings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: weeklyEarnings.map((day) {
                      double maxAmount = weeklyEarnings.map((d) => d["amount"] as double).reduce((a, b) => a > b ? a : b);
                      double height = ((day["amount"] as double) / maxAmount) * 60;
                      
                      return Column(
                        children: [
                          Text(
                            "\$${(day["amount"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            width: 24,
                            height: height > 10 ? height : 10,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${day["day"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Performance Stats
            Text(
              "Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  _buildPerformanceRow(
                    "Completion Rate",
                    "${(dashboardData["completionRate"] as double).toStringAsFixed(1)}%",
                    Icons.check_circle,
                    successColor,
                  ),
                  
                  _buildPerformanceRow(
                    "Average Rating",
                    "${(dashboardData["avgRating"] as double).toStringAsFixed(1)}/5.0",
                    Icons.star,
                    warningColor,
                  ),
                  
                  _buildPerformanceRow(
                    "Today's Earnings",
                    "\$${(dashboardData["todayEarnings"] as double).toStringAsFixed(2)}",
                    Icons.today,
                    primaryColor,
                  ),
                  
                  _buildPerformanceRow(
                    "Today's Deliveries",
                    "${dashboardData["todayDeliveries"]}",
                    Icons.local_shipping,
                    infoColor,
                  ),
                ],
              ),
            ),
            
            // Recent Deliveries
            Text(
              "Recent Deliveries",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...recentDeliveries.map((delivery) => _buildDeliveryCard(delivery)),
            
            SizedBox(height: spMd),
            
            // View All Button
            Container(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to full delivery history
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: spMd),
                  side: BorderSide(color: primaryColor),
                ),
                child: Text(
                  "View All Deliveries",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
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
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPerformanceRow(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
  
  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#${delivery["id"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "\$${(delivery["earnings"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Icon(
                Icons.restaurant,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${delivery["restaurant"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < (delivery["rating"] as int) ? Icons.star : Icons.star_border,
                    color: warningColor,
                    size: 14,
                  );
                }),
              ),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${delivery["distance"]} • ${delivery["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${delivery["date"]}",
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
  }
}
