import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary9View extends StatefulWidget {
  @override
  State<GrlSummary9View> createState() => _GrlSummary9ViewState();
}

class _GrlSummary9ViewState extends State<GrlSummary9View> {
  List<Map<String, dynamic>> customerData = [
    {
      "segment": "Premium Customers",
      "count": 2850,
      "revenue": 1450000.0,
      "avg_order_value": 285.50,
      "retention_rate": 89.2,
      "churn_rate": 3.8,
      "lifetime_value": 4250.0,
      "color": primaryColor,
    },
    {
      "segment": "Regular Customers",
      "count": 8900,
      "revenue": 2150000.0,
      "avg_order_value": 125.30,
      "retention_rate": 72.5,
      "churn_rate": 8.2,
      "lifetime_value": 1850.0,
      "color": successColor,
    },
    {
      "segment": "New Customers",
      "count": 4200,
      "revenue": 520000.0,
      "avg_order_value": 89.90,
      "retention_rate": 45.8,
      "churn_rate": 25.5,
      "lifetime_value": 650.0,
      "color": infoColor,
    },
    {
      "segment": "Inactive Customers",
      "count": 1800,
      "revenue": 85000.0,
      "avg_order_value": 67.80,
      "retention_rate": 12.5,
      "churn_rate": 85.0,
      "lifetime_value": 320.0,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> customerMetrics = [
    {
      "metric": "Customer Acquisition Cost",
      "value": 45.80,
      "previous": 52.30,
      "unit": "\$",
      "trend": "down",
      "target": 40.0,
    },
    {
      "metric": "Customer Satisfaction Score",
      "value": 4.3,
      "previous": 4.1,
      "unit": "/5.0",
      "trend": "up",
      "target": 4.5,
    },
    {
      "metric": "Net Promoter Score",
      "value": 72.0,
      "previous": 68.0,
      "unit": "",
      "trend": "up",
      "target": 75.0,
    },
    {
      "metric": "Customer Lifetime Value",
      "value": 1850.0,
      "previous": 1720.0,
      "unit": "\$",
      "trend": "up",
      "target": 2000.0,
    },
  ];

  List<Map<String, dynamic>> recentFeedback = [
    {
      "customer": "Sarah Johnson",
      "rating": 5,
      "feedback": "Excellent service and fast delivery. The product quality exceeded my expectations!",
      "date": "2024-12-18",
      "category": "Product Quality",
      "sentiment": "positive",
    },
    {
      "customer": "Mike Chen",
      "rating": 4,
      "feedback": "Good overall experience, but the checkout process could be simplified.",
      "date": "2024-12-17",
      "category": "User Experience",
      "sentiment": "positive",
    },
    {
      "customer": "Emma Wilson",
      "rating": 2,
      "feedback": "Order arrived late and packaging was damaged. Customer service was helpful though.",
      "date": "2024-12-16",
      "category": "Shipping",
      "sentiment": "negative",
    },
    {
      "customer": "David Brown",
      "rating": 5,
      "feedback": "Amazing customer support! They resolved my issue within minutes.",
      "date": "2024-12-15",
      "category": "Customer Service",
      "sentiment": "positive",
    },
    {
      "customer": "Lisa Davis",
      "rating": 3,
      "feedback": "Product is okay but not as described. Expected better quality for the price.",
      "date": "2024-12-14",
      "category": "Product Quality",
      "sentiment": "neutral",
    },
  ];

  List<Map<String, dynamic>> topCustomers = [
    {
      "name": "TechCorp Solutions",
      "type": "Business",
      "total_spent": 125000.0,
      "orders": 45,
      "last_order": "2024-12-15",
      "status": "Premium",
    },
    {
      "name": "Jennifer Martinez",
      "type": "Individual",
      "total_spent": 8950.0,
      "orders": 28,
      "last_order": "2024-12-18",
      "status": "VIP",
    },
    {
      "name": "Global Retail Inc",
      "type": "Business",
      "total_spent": 89000.0,
      "orders": 32,
      "last_order": "2024-12-12",
      "status": "Premium",
    },
    {
      "name": "Robert Johnson",
      "type": "Individual",
      "total_spent": 6750.0,
      "orders": 19,
      "last_order": "2024-12-17",
      "status": "Regular",
    },
    {
      "name": "Fashion Hub Ltd",
      "type": "Business",
      "total_spent": 67500.0,
      "orders": 25,
      "last_order": "2024-12-14",
      "status": "Premium",
    },
  ];

  String selectedView = "overview";

  @override
  Widget build(BuildContext context) {
    final totalCustomers = customerData.fold(0, (sum, segment) => sum + (segment["count"] as int));
    final totalRevenue = customerData.fold(0.0, (sum, segment) => sum + (segment["revenue"] as double));
    final avgRetentionRate = customerData.fold(0.0, (sum, segment) => sum + (segment["retention_rate"] as double)) / customerData.length;
    final avgLifetimeValue = customerData.fold(0.0, (sum, segment) => sum + (segment["lifetime_value"] as double)) / customerData.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Analytics Summary"),
        actions: [
          Icon(Icons.people, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.insights, color: primaryColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(179)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.groups, color: Colors.white, size: 28),
                      SizedBox(width: spSm),
                      Text(
                        "Customer Portfolio Overview",
                        style: TextStyle(
                          fontSize: fsH5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Customers",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${totalCustomers.toString()}",
                              style: TextStyle(
                                fontSize: fsH4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                              "Total Revenue",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${totalRevenue.currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                              "Avg CLV",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${avgLifetimeValue.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: fsH4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            QCategoryPicker(
              items: [
                {"label": "Overview", "value": "overview"},
                {"label": "Segments", "value": "segments"},
                {"label": "Feedback", "value": "feedback"},
                {"label": "Top Customers", "value": "top_customers"},
              ],
              value: selectedView,
              onChanged: (index, label, value, item) {
                selectedView = value;
                setState(() {});
              },
            ),

            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: customerMetrics.map((metric) {
                final isPositiveTrend = metric["trend"] == "up";
                final changePercent = (((metric["value"] as double) - (metric["previous"] as double)) / (metric["previous"] as double)) * 100;
                final progressToTarget = ((metric["value"] as double) / (metric["target"] as double)).clamp(0.0, 1.0);
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${metric["metric"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${metric["unit"] == "\$" ? "\$" : ""}${metric["value"]}${metric["unit"] != "\$" ? metric["unit"] : ""}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Row(
                            children: [
                              Icon(
                                isPositiveTrend ? Icons.trending_up : Icons.trending_down,
                                color: isPositiveTrend ? successColor : dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${isPositiveTrend ? '+' : ''}${changePercent.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isPositiveTrend ? successColor : dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progressToTarget,
                          child: Container(
                            decoration: BoxDecoration(
                              color: progressToTarget >= 0.8 ? successColor : warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Target: ${metric["unit"] == "\$" ? "\$" : ""}${metric["target"]}${metric["unit"] != "\$" ? metric["unit"] : ""}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            if (selectedView == "overview" || selectedView == "segments") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer Segmentation Analysis",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      spacing: spSm,
                      children: customerData.map((segment) {
                        final revenuePercentage = ((segment["revenue"] as double) / totalRevenue) * 100;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Row(
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${segment["count"]} customers",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Revenue: \$${(segment["revenue"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Container(
                                          height: 4,
                                          margin: EdgeInsets.only(top: spXs),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: revenuePercentage / 100,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: segment["color"] as Color,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Text(
                                    "${revenuePercentage.toStringAsFixed(1)}% of total",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: segment["color"] as Color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "AOV: \$${(segment["avg_order_value"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Retention: ${(segment["retention_rate"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "CLV: \$${(segment["lifetime_value"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
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
                  ],
                ),
              ),
            ],

            if (selectedView == "top_customers") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Customers by Value",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Icon(Icons.star, color: warningColor, size: 20),
                      ],
                    ),
                    Column(
                      spacing: spSm,
                      children: topCustomers.map((customer) {
                        Color statusColor = primaryColor;
                        if (customer["status"] == "VIP") statusColor = warningColor;
                        if (customer["status"] == "Premium") statusColor = successColor;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(26),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  customer["type"] == "Business" ? Icons.business : Icons.person,
                                  color: statusColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${customer["name"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: statusColor.withAlpha(26),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${customer["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: statusColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${customer["orders"]} orders • Last: ${DateTime.parse(customer["last_order"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "\$${(customer["total_spent"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
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
              ),
            ],

            if (selectedView == "feedback") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Customer Feedback",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.sentiment_satisfied, color: successColor, size: 16),
                            Text(
                              " ${recentFeedback.where((f) => f["sentiment"] == "positive").length}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.sentiment_dissatisfied, color: dangerColor, size: 16),
                            Text(
                              " ${recentFeedback.where((f) => f["sentiment"] == "negative").length}",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      spacing: spSm,
                      children: recentFeedback.map((feedback) {
                        Color sentimentColor = primaryColor;
                        IconData sentimentIcon = Icons.sentiment_neutral;
                        
                        switch (feedback["sentiment"]) {
                          case "positive":
                            sentimentColor = successColor;
                            sentimentIcon = Icons.sentiment_satisfied;
                            break;
                          case "negative":
                            sentimentColor = dangerColor;
                            sentimentIcon = Icons.sentiment_dissatisfied;
                            break;
                          case "neutral":
                            sentimentColor = warningColor;
                            sentimentIcon = Icons.sentiment_neutral;
                            break;
                        }
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: sentimentColor,
                              ),
                            ),
                          ),
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${feedback["customer"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Row(
                                          children: List.generate(5, (index) {
                                            return Icon(
                                              index < (feedback["rating"] as int) ? Icons.star : Icons.star_border,
                                              color: warningColor,
                                              size: 12,
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(sentimentIcon, color: sentimentColor, size: 16),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${feedback["category"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                "${feedback["feedback"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(feedback["date"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Customer Survey",
                    icon: Icons.poll,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Analytics",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {},
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
