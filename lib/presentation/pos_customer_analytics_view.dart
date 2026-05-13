import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCustomerAnalyticsView extends StatefulWidget {
  const PosCustomerAnalyticsView({super.key});

  @override
  State<PosCustomerAnalyticsView> createState() => _PosCustomerAnalyticsViewState();
}

class _PosCustomerAnalyticsViewState extends State<PosCustomerAnalyticsView> {
  String selectedPeriod = "This Month";
  String selectedSegment = "All Customers";
  bool loading = false;

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> segmentItems = [
    {"label": "All Customers", "value": "All Customers"},
    {"label": "VIP Customers", "value": "VIP Customers"},
    {"label": "Regular Customers", "value": "Regular Customers"},
    {"label": "New Customers", "value": "New Customers"},
    {"label": "Inactive Customers", "value": "Inactive Customers"},
  ];

  Map<String, dynamic> customerSummary = {
    "total_customers": 2847,
    "new_customers": 284,
    "returning_customers": 2563,
    "vip_customers": 156,
    "avg_transaction_value": 127.45,
    "avg_visit_frequency": 3.2,
    "customer_lifetime_value": 2450.80,
    "retention_rate": 78.5,
  };

  List<Map<String, dynamic>> customerSegments = [
    {
      "segment": "VIP Customers",
      "count": 156,
      "percentage": 5.5,
      "avg_spend": 485.20,
      "avg_frequency": 8.4,
      "total_revenue": 75690.40,
      "growth": 12.3,
      "color": dangerColor,
    },
    {
      "segment": "Regular Customers",
      "count": 1890,
      "percentage": 66.4,
      "avg_spend": 145.80,
      "avg_frequency": 4.2,
      "total_revenue": 275462.00,
      "growth": 8.7,
      "color": primaryColor,
    },
    {
      "segment": "Occasional Customers",
      "count": 578,
      "percentage": 20.3,
      "avg_spend": 89.45,
      "avg_frequency": 2.1,
      "total_revenue": 51702.10,
      "growth": 15.2,
      "color": successColor,
    },
    {
      "segment": "New Customers",
      "count": 223,
      "percentage": 7.8,
      "avg_spend": 76.30,
      "avg_frequency": 1.2,
      "total_revenue": 17016.90,
      "growth": 28.4,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> topCustomers = [
    {
      "name": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "total_spent": 3450.80,
      "visits": 24,
      "avg_order": 143.78,
      "last_visit": "2024-12-18",
      "loyalty_points": 1890,
      "tier": "VIP",
      "growth": 25.4,
    },
    {
      "name": "Michael Chen",
      "email": "m.chen@email.com",
      "total_spent": 2890.50,
      "visits": 19,
      "avg_order": 152.13,
      "last_visit": "2024-12-17",
      "loyalty_points": 1560,
      "tier": "VIP",
      "growth": 18.7,
    },
    {
      "name": "Emma Wilson",
      "email": "emma.w@email.com",
      "total_spent": 2234.25,
      "visits": 16,
      "avg_order": 139.64,
      "last_visit": "2024-12-16",
      "loyalty_points": 1245,
      "tier": "Gold",
      "growth": 32.1,
    },
    {
      "name": "David Rodriguez",
      "email": "d.rodriguez@email.com",
      "total_spent": 1987.40,
      "visits": 14,
      "avg_order": 141.96,
      "last_visit": "2024-12-15",
      "loyalty_points": 1089,
      "tier": "Gold",
      "growth": 12.8,
    },
    {
      "name": "Lisa Zhang",
      "email": "lisa.z@email.com",
      "total_spent": 1756.90,
      "visits": 12,
      "avg_order": 146.41,
      "last_visit": "2024-12-14",
      "loyalty_points": 967,
      "tier": "Silver",
      "growth": 21.5,
    },
  ];

  List<Map<String, dynamic>> behaviorAnalytics = [
    {
      "metric": "Peak Shopping Hours",
      "value": "6:00 - 8:00 PM",
      "description": "Most customers shop during evening hours",
      "icon": Icons.schedule,
      "color": primaryColor,
    },
    {
      "metric": "Preferred Payment",
      "value": "Credit Card (65%)",
      "description": "Majority prefer contactless payments",
      "icon": Icons.credit_card,
      "color": successColor,
    },
    {
      "metric": "Average Stay Duration",
      "value": "28 minutes",
      "description": "Customers spend moderate time browsing",
      "icon": Icons.timer,
      "color": infoColor,
    },
    {
      "metric": "Repeat Purchase Rate",
      "value": "78.5%",
      "description": "High customer retention and loyalty",
      "icon": Icons.refresh,
      "color": warningColor,
    },
  ];

  double get totalRevenue => customerSegments.fold(0.0, (sum, segment) => sum + (segment["total_revenue"] as double));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportData,
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
                  _buildCustomerSegmentation(),
                  _buildTopCustomers(),
                  _buildBehaviorAnalytics(),
                  _buildRetentionAnalysis(),
                  _buildInsights(),
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
            label: "Customer Segment",
            items: segmentItems,
            value: selectedSegment,
            onChanged: (value, label) {
              selectedSegment = value;
              _loadData();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      spacing: spMd,
      children: [
        Row(
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
                        Icon(Icons.people, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Total Customers",
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
                      "${customerSummary["total_customers"]}",
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
                          "+${customerSummary["new_customers"]} new",
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
                        Icon(Icons.attach_money, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Avg Transaction",
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
                      "\$${(customerSummary["avg_transaction_value"] as double).toStringAsFixed(2)}",
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
                          "+12.5% this month",
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
          ],
        ),
        Row(
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
                        Icon(Icons.star, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Customer LTV",
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
                      "\$${(customerSummary["customer_lifetime_value"] as double).currency}",
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
                          "+18.7% growth",
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
                        Icon(Icons.refresh, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Retention Rate",
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
                      "${(customerSummary["retention_rate"] as double).toStringAsFixed(1)}%",
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
                          "+5.3% improvement",
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
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerSegmentation() {
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
            "Customer Segmentation",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "Customer Segmentation\nChart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: spSm,
                    children: customerSegments.map((segment) {
                      return Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: segment["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${segment["segment"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "${(segment["percentage"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spMd,
            children: customerSegments.map((segment) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (segment["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: segment["color"] as Color,
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
                              Text(
                                "${segment["segment"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${segment["count"]} customers (${(segment["percentage"] as double).toStringAsFixed(1)}%)",
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
                              "\$${(segment["total_revenue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                                  "+${(segment["growth"] as double).toStringAsFixed(1)}%",
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
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Avg Spend",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(segment["avg_spend"] as double).toStringAsFixed(2)}",
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
                                "Visit Frequency",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(segment["avg_frequency"] as double).toStringAsFixed(1)}/month",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCustomers() {
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Top Customers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  // Navigate to all customers
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spMd,
            children: topCustomers.map((customer) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${customer["name"].toString().split(' ').map((name) => name[0]).join('')}",
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
                                "${customer["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getTierColor(customer["tier"] as String).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${customer["tier"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getTierColor(customer["tier"] as String),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${customer["email"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "\$${(customer["total_spent"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Text(
                                "${customer["visits"]} visits",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Text(
                                "${customer["loyalty_points"]} pts",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.trending_up, color: successColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "+${(customer["growth"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Last: ${DateTime.parse(customer["last_visit"] as String).dMMMy}",
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBehaviorAnalytics() {
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
            "Customer Behavior Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spMd,
            children: behaviorAnalytics.map((behavior) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (behavior["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: behavior["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        behavior["icon"] as IconData,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${behavior["metric"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${behavior["value"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: behavior["color"] as Color,
                            ),
                          ),
                          Text(
                            "${behavior["description"]}",
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

  Widget _buildRetentionAnalysis() {
    List<Map<String, dynamic>> retentionData = [
      {"period": "Week 1", "retention": 100.0, "customers": 284},
      {"period": "Week 2", "retention": 78.5, "customers": 223},
      {"period": "Week 3", "retention": 65.2, "customers": 185},
      {"period": "Week 4", "retention": 58.1, "customers": 165},
      {"period": "Month 2", "retention": 52.8, "customers": 150},
      {"period": "Month 3", "retention": 48.9, "customers": 139},
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
            "Customer Retention Analysis",
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
                "Customer Retention\nChart",
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
          Column(
            spacing: spSm,
            children: retentionData.map((data) {
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
                        "${data["period"]}",
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
                              Expanded(
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4 * ((data["retention"] as double) / 100),
                                      height: 8,
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
                                "${(data["retention"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${data["customers"]} customers",
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

  Widget _buildInsights() {
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
            "Customer Insights",
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
              _buildInsightItem(
                Icons.star,
                dangerColor,
                "VIP Customer Impact",
                "VIP customers represent only 5.5% of the customer base but contribute 18.1% of total revenue.",
              ),
              _buildInsightItem(
                Icons.group_add,
                successColor,
                "New Customer Growth",
                "28.4% increase in new customer acquisition with strong potential for conversion to regular customers.",
              ),
              _buildInsightItem(
                Icons.schedule,
                infoColor,
                "Optimal Engagement Time",
                "Customer engagement peaks between 6-8 PM, ideal for promotional campaigns and new product launches.",
              ),
              _buildInsightItem(
                Icons.trending_up,
                warningColor,
                "Retention Opportunity",
                "Focus on converting occasional customers to regulars could increase revenue by 25%.",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(IconData icon, Color color, String title, String description) {
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

  Color _getTierColor(String tier) {
    switch (tier) {
      case "VIP":
        return dangerColor;
      case "Gold":
        return warningColor;
      case "Silver":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
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

  void _exportData() {
    ss("Customer analytics data exported successfully");
  }
}
