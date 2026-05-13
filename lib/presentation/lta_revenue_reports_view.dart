import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaRevenueReportsView extends StatefulWidget {
  const LtaRevenueReportsView({super.key});

  @override
  State<LtaRevenueReportsView> createState() => _LtaRevenueReportsViewState();
}

class _LtaRevenueReportsViewState extends State<LtaRevenueReportsView> {
  bool loading = true;
  String selectedPeriod = "This Month";
  String selectedRegion = "All Regions";
  String selectedService = "All Services";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> regionOptions = [
    {"label": "All Regions", "value": "All Regions"},
    {"label": "North", "value": "North"},
    {"label": "South", "value": "South"},
    {"label": "East", "value": "East"},
    {"label": "West", "value": "West"},
    {"label": "Central", "value": "Central"},
  ];

  List<Map<String, dynamic>> serviceOptions = [
    {"label": "All Services", "value": "All Services"},
    {"label": "Standard Delivery", "value": "Standard Delivery"},
    {"label": "Express Delivery", "value": "Express Delivery"},
    {"label": "Same Day Delivery", "value": "Same Day Delivery"},
    {"label": "Bulk Transport", "value": "Bulk Transport"},
  ];

  List<Map<String, dynamic>> revenueOverview = [
    {
      "title": "Total Revenue",
      "value": 2450000,
      "unit": "\$",
      "change": 12.5,
      "trend": "up",
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "title": "Monthly Growth",
      "value": 8.3,
      "unit": "%",
      "change": 2.1,
      "trend": "up",
      "icon": Icons.trending_up,
      "color": primaryColor,
    },
    {
      "title": "Average Order Value",
      "value": 185.50,
      "unit": "\$",
      "change": -1.2,
      "trend": "down",
      "icon": Icons.shopping_cart,
      "color": infoColor,
    },
    {
      "title": "Profit Margin",
      "value": 18.7,
      "unit": "%",
      "change": 0.8,
      "trend": "up",
      "icon": Icons.pie_chart,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> monthlyData = [
    {"month": "Jan", "revenue": 1850000, "orders": 9245, "avgValue": 200.11},
    {"month": "Feb", "revenue": 1920000, "orders": 9680, "avgValue": 198.35},
    {"month": "Mar", "revenue": 2100000, "orders": 10500, "avgValue": 200.00},
    {"month": "Apr", "revenue": 2200000, "orders": 11220, "avgValue": 196.08},
    {"month": "May", "revenue": 2350000, "orders": 12100, "avgValue": 194.21},
    {"month": "Jun", "revenue": 2450000, "orders": 13200, "avgValue": 185.61},
  ];

  List<Map<String, dynamic>> serviceRevenue = [
    {
      "service": "Standard Delivery",
      "revenue": 980000,
      "percentage": 40.0,
      "orders": 5280,
      "avgValue": 185.61,
      "growth": 8.5,
      "color": primaryColor,
    },
    {
      "service": "Express Delivery",
      "revenue": 735000,
      "percentage": 30.0,
      "orders": 2940,
      "avgValue": 250.00,
      "growth": 15.2,
      "color": successColor,
    },
    {
      "service": "Same Day Delivery",
      "revenue": 490000,
      "percentage": 20.0,
      "orders": 1400,
      "avgValue": 350.00,
      "growth": 22.8,
      "color": warningColor,
    },
    {
      "service": "Bulk Transport",
      "revenue": 245000,
      "percentage": 10.0,
      "orders": 350,
      "avgValue": 700.00,
      "growth": 5.1,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> regionRevenue = [
    {
      "region": "North",
      "revenue": 612500,
      "percentage": 25.0,
      "orders": 3300,
      "growth": 10.2,
      "topCity": "Boston",
    },
    {
      "region": "South",
      "revenue": 588000,
      "percentage": 24.0,
      "orders": 3168,
      "growth": 14.8,
      "topCity": "Atlanta",
    },
    {
      "region": "West",
      "revenue": 490000,
      "percentage": 20.0,
      "orders": 2640,
      "growth": 18.5,
      "topCity": "Los Angeles",
    },
    {
      "region": "East",
      "revenue": 441000,
      "percentage": 18.0,
      "orders": 2376,
      "growth": 8.9,
      "topCity": "New York",
    },
    {
      "region": "Central",
      "revenue": 318500,
      "percentage": 13.0,
      "orders": 1716,
      "growth": 6.7,
      "topCity": "Chicago",
    },
  ];

  List<Map<String, dynamic>> topCustomers = [
    {
      "customer": "TechCorp Industries",
      "customerId": "TC001",
      "revenue": 125000,
      "orders": 89,
      "avgOrder": 1404.49,
      "lastOrder": "2024-06-14",
      "growth": 28.5,
    },
    {
      "customer": "Global Logistics Ltd",
      "customerId": "GL002",
      "revenue": 98000,
      "orders": 156,
      "avgOrder": 628.21,
      "lastOrder": "2024-06-15",
      "growth": 15.8,
    },
    {
      "customer": "Metro Retail Chain",
      "customerId": "MR003",
      "revenue": 87500,
      "orders": 234,
      "avgOrder": 373.93,
      "lastOrder": "2024-06-13",
      "growth": 12.3,
    },
    {
      "customer": "Premium Foods Co",
      "customerId": "PF004",
      "revenue": 76000,
      "orders": 67,
      "avgOrder": 1134.33,
      "lastOrder": "2024-06-12",
      "growth": 22.1,
    },
    {
      "customer": "BuildMax Construction",
      "customerId": "BM005",
      "revenue": 68500,
      "orders": 45,
      "avgOrder": 1522.22,
      "lastOrder": "2024-06-11",
      "growth": 35.7,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  Widget _buildOverviewCard(Map<String, dynamic> metric) {
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (metric["color"] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"] as IconData,
                  color: metric["color"] as Color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                (metric["trend"] as String) == "up" 
                    ? Icons.trending_up 
                    : Icons.trending_down,
                color: (metric["trend"] as String) == "up" 
                    ? successColor 
                    : dangerColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (metric["unit"] == "\$")
                Text(
                  "\$${((metric["value"] as num).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${(metric["value"] as num).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: (metric["trend"] as String) == "up" 
                      ? successColor.withValues(alpha: 0.1)
                      : dangerColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${(metric["trend"] as String) == "up" ? '+' : ''}${(metric["change"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 11,
                    color: (metric["trend"] as String) == "up" 
                        ? successColor 
                        : dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: service["color"] as Color,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${service["service"]}",
                        style: TextStyle(
                          fontSize: fsH6,
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
                        color: successColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "+${(service["growth"] as num).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "\$${((service["revenue"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "(${(service["percentage"] as num).toStringAsFixed(1)}%)",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${service["orders"]} orders",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Avg: \$${((service["avgValue"] as num).toDouble()).currency}",
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
        ],
      ),
    );
  }

  Widget _buildRegionCard(Map<String, dynamic> region) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${region["region"]} Region",
                  style: TextStyle(
                    fontSize: fsH6,
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
                  color: successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "+${(region["growth"] as num).toStringAsFixed(1)}%",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${((region["revenue"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Revenue (${(region["percentage"] as num).toStringAsFixed(1)}%)",
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
                    "${region["orders"]} orders",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Top: ${region["topCity"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.business,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${customer["customer"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "ID: ${customer["customerId"]}",
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
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "+${(customer["growth"] as num).toStringAsFixed(1)}%",
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
                child: Column(
                  children: [
                    Text(
                      "\$${((customer["revenue"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Revenue",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${customer["orders"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Orders",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${((customer["avgOrder"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Avg Order",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${DateTime.parse("${customer["lastOrder"]}T00:00:00Z").dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Last Order",
                      style: TextStyle(
                        fontSize: 10,
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

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Revenue Reports"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Revenue Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export report
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share report
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
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Period",
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
                    label: "Region",
                    items: regionOptions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Service Type",
                    items: serviceOptions,
                    value: selectedService,
                    onChanged: (value, label) {
                      selectedService = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Revenue Overview
            Text(
              "Revenue Overview",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: revenueOverview.map((metric) {
                return _buildOverviewCard(metric);
              }).toList(),
            ),

            // Service Revenue Breakdown
            Text(
              "Revenue by Service Type",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: serviceRevenue.map((service) {
                return _buildServiceCard(service);
              }).toList(),
            ),

            // Regional Revenue
            Text(
              "Revenue by Region",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: regionRevenue.map((region) {
                return _buildRegionCard(region);
              }).toList(),
            ),

            // Top Customers
            Text(
              "Top Revenue Customers",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: topCustomers.map((customer) {
                return _buildCustomerCard(customer);
              }).toList(),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Detailed Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      // Export detailed report
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule Report",
                    icon: Icons.schedule,
                    size: bs.md,
                    onPressed: () {
                      // Schedule automatic reports
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
