import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPeakHoursView extends StatefulWidget {
  const PosPeakHoursView({super.key});

  @override
  State<PosPeakHoursView> createState() => _PosPeakHoursViewState();
}

class _PosPeakHoursViewState extends State<PosPeakHoursView> {
  String selectedPeriod = "This Week";
  String selectedStore = "All Stores";
  bool loading = false;

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "Last Week", "value": "Last Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> storeItems = [
    {"label": "All Stores", "value": "All Stores"},
    {"label": "Main Store", "value": "Main Store"},
    {"label": "Branch A", "value": "Branch A"},
    {"label": "Branch B", "value": "Branch B"},
    {"label": "Online Store", "value": "Online Store"},
  ];

  List<Map<String, dynamic>> peakHours = [
    {
      "hour": "18:00",
      "sales": 21450.90,
      "transactions": 145,
      "customers": 128,
      "avg_ticket": 147.94,
      "utilization": 95.5,
      "rank": 1,
      "growth": 32.1,
      "category": "Dinner Rush",
      "color": dangerColor,
    },
    {
      "hour": "19:00",
      "sales": 19880.60,
      "transactions": 134,
      "customers": 118,
      "avg_ticket": 148.36,
      "utilization": 89.2,
      "rank": 2,
      "growth": 24.7,
      "category": "Evening Peak",
      "color": warningColor,
    },
    {
      "hour": "17:00",
      "sales": 18920.75,
      "transactions": 125,
      "customers": 112,
      "avg_ticket": 151.37,
      "utilization": 87.8,
      "rank": 3,
      "growth": 28.5,
      "category": "After Work",
      "color": primaryColor,
    },
    {
      "hour": "20:00",
      "sales": 16450.25,
      "transactions": 102,
      "customers": 89,
      "avg_ticket": 161.28,
      "utilization": 76.4,
      "rank": 4,
      "growth": 18.3,
      "category": "Late Dinner",
      "color": infoColor,
    },
    {
      "hour": "13:00",
      "sales": 15890.50,
      "transactions": 108,
      "customers": 95,
      "avg_ticket": 147.13,
      "utilization": 82.1,
      "rank": 5,
      "growth": 22.1,
      "category": "Lunch Rush",
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> weeklyPattern = [
    {
      "day": "Monday",
      "peak_hour": "18:00",
      "peak_sales": 18250.75,
      "peak_transactions": 125,
      "avg_utilization": 78.5,
      "pattern": "Steady Growth",
    },
    {
      "day": "Tuesday",
      "peak_hour": "19:00",
      "peak_sales": 19420.50,
      "peak_transactions": 132,
      "avg_utilization": 82.3,
      "pattern": "Evening Peak",
    },
    {
      "day": "Wednesday",
      "peak_hour": "18:30",
      "peak_sales": 20180.25,
      "peak_transactions": 138,
      "avg_utilization": 85.7,
      "pattern": "Mid-Week High",
    },
    {
      "day": "Thursday",
      "peak_hour": "19:30",
      "peak_sales": 21650.80,
      "peak_transactions": 148,
      "avg_utilization": 89.2,
      "pattern": "Pre-Weekend",
    },
    {
      "day": "Friday",
      "peak_hour": "20:00",
      "peak_sales": 24890.90,
      "peak_transactions": 165,
      "avg_utilization": 95.8,
      "pattern": "Weekend Start",
    },
    {
      "day": "Saturday",
      "peak_hour": "19:00",
      "peak_sales": 26450.25,
      "peak_transactions": 178,
      "avg_utilization": 98.2,
      "pattern": "Weekend Peak",
    },
    {
      "day": "Sunday",
      "peak_hour": "17:00",
      "peak_sales": 22180.75,
      "peak_transactions": 156,
      "avg_utilization": 91.4,
      "pattern": "Weekend Wind-Down",
    },
  ];

  Map<String, dynamic> get topPeakHour => peakHours.first;
  double get avgUtilization => peakHours.fold(0.0, (sum, hour) => sum + (hour["utilization"] as double)) / peakHours.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Peak Hours Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _showSettings,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildFilters(),
                  _buildSummaryCards(),
                  _buildPeakHoursChart(),
                  _buildTopPeakHours(),
                  _buildWeeklyPattern(),
                  _buildUtilizationMetrics(),
                  _buildOptimizationTips(),
                ],
              ),
            ),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Period",
            items: periodItems,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              _loadData();
            },
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: QDropdownField(
            label: "Store",
            items: storeItems,
            value: selectedStore,
            onChanged: (value, label) {
              selectedStore = value;
              _loadData();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Peak Hour",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${topPeakHour["hour"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${topPeakHour["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.trending_up, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Peak Sales",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "\$${(topPeakHour["sales"] as double).currency}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.trending_up, color: successColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "+${(topPeakHour["growth"] as double).toStringAsFixed(1)}%",
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
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.speed, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Avg Utilization",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${avgUtilization.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Capacity Used",
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
    );
  }

  Widget _buildPeakHoursChart() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Peak Hours Visualization",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "Peak Hours\nChart",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Critical Peak",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "High Peak",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Moderate",
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
  }

  Widget _buildTopPeakHours() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Peak Hours",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spMd,
            children: peakHours.map((hour) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (hour["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: hour["color"] as Color,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: hour["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              "#${hour["rank"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${hour["hour"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: (hour["color"] as Color).withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${hour["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: hour["color"] as Color,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${(hour["sales"] as double).currency} | ${hour["transactions"]} transactions",
                                style: TextStyle(
                                  fontSize: 14,
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
                              "${(hour["utilization"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Utilization",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        SizedBox(width: 52),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Customers",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${hour["customers"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                      "Avg Ticket",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(hour["avg_ticket"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                      "Growth",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.trending_up,
                                          color: successColor,
                                          size: 14,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "+${(hour["growth"] as double).toStringAsFixed(1)}%",
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

  Widget _buildWeeklyPattern() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Peak Pattern",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: weeklyPattern.map((day) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        "${day["day"]}",
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
                                "Peak: ${day["peak_hour"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${day["pattern"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "\$${(day["peak_sales"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Text(
                                "${day["peak_transactions"]} transactions",
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
                    Text(
                      "${(day["avg_utilization"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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

  Widget _buildUtilizationMetrics() {
    List<Map<String, dynamic>> utilizationLevels = [
      {
        "level": "Critical (90%+)",
        "hours": 2,
        "color": dangerColor,
        "description": "Maximum capacity reached",
      },
      {
        "level": "High (70-89%)",
        "hours": 4,
        "color": warningColor,
        "description": "Near capacity, monitor closely",
      },
      {
        "level": "Moderate (50-69%)",
        "hours": 6,
        "color": infoColor,
        "description": "Optimal operating level",
      },
      {
        "level": "Low (30-49%)",
        "hours": 8,
        "color": successColor,
        "description": "Below optimal, room for growth",
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Utilization Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spMd,
            children: utilizationLevels.map((level) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (level["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: level["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${level["hours"]}h",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${level["level"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${level["description"]}",
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
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationTips() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Optimization Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spMd,
            children: [
              _buildTipItem(
                Icons.group_add,
                successColor,
                "Staff Optimization",
                "Increase staff during peak hours (17:00-20:00) to reduce wait times and improve customer satisfaction.",
              ),
              _buildTipItem(
                Icons.inventory,
                infoColor,
                "Inventory Management",
                "Pre-stock high-demand items 30 minutes before peak hours to ensure availability.",
              ),
              _buildTipItem(
                Icons.schedule,
                warningColor,
                "Shift Planning",
                "Schedule experienced staff during critical peak hours to maintain service quality.",
              ),
              _buildTipItem(
                Icons.local_offer,
                primaryColor,
                "Promotional Strategy",
                "Offer off-peak hour promotions to distribute traffic and reduce congestion during rush hours.",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(IconData icon, Color color, String title, String description) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _loadData() {
    loading = true;
    setState(() {});

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
    });
  }

  void _refreshData() {
    _loadData();
  }

  void _showSettings() {
    // Navigate to settings
    si("Opening peak hours settings");
  }
}
