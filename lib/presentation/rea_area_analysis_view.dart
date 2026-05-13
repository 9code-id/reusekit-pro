import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaAreaAnalysisView extends StatefulWidget {
  const ReaAreaAnalysisView({super.key});

  @override
  State<ReaAreaAnalysisView> createState() => _ReaAreaAnalysisViewState();
}

class _ReaAreaAnalysisViewState extends State<ReaAreaAnalysisView> {
  String selectedTimeframe = "6_months";
  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "3 Months", "value": "3_months"},
    {"label": "6 Months", "value": "6_months"},
    {"label": "1 Year", "value": "1_year"},
    {"label": "3 Years", "value": "3_years"},
    {"label": "5 Years", "value": "5_years"},
  ];

  List<Map<String, dynamic>> areaMetrics = [
    {
      "title": "Average Price per Sq Ft",
      "value": 450.25,
      "currency": true,
      "change": 12.5,
      "icon": Icons.square_foot,
      "color": Colors.blue,
    },
    {
      "title": "Price Growth Rate",
      "value": 8.5,
      "percentage": true,
      "change": 2.1,
      "icon": Icons.trending_up,
      "color": Colors.green,
    },
    {
      "title": "Market Demand",
      "value": 85.0,
      "percentage": true,
      "change": -3.2,
      "icon": Icons.bar_chart,
      "color": Colors.orange,
    },
    {
      "title": "Days on Market",
      "value": 28.0,
      "suffix": " days",
      "change": -5.5,
      "icon": Icons.schedule,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> priceRanges = [
    {
      "range": "Under \$300K",
      "properties": 45,
      "percentage": 15.2,
      "avgPrice": 275000,
    },
    {
      "range": "\$300K - \$500K",
      "properties": 128,
      "percentage": 43.2,
      "avgPrice": 425000,
    },
    {
      "range": "\$500K - \$700K",
      "properties": 87,
      "percentage": 29.4,
      "avgPrice": 625000,
    },
    {
      "range": "\$700K - \$1M",
      "properties": 28,
      "percentage": 9.5,
      "avgPrice": 850000,
    },
    {
      "range": "Above \$1M",
      "properties": 8,
      "percentage": 2.7,
      "avgPrice": 1250000,
    },
  ];

  List<Map<String, dynamic>> comparativeAreas = [
    {
      "area": "Downtown Core",
      "avgPrice": 525.50,
      "growth": 15.2,
      "distance": "2.5 km",
    },
    {
      "area": "Riverside District",
      "avgPrice": 398.75,
      "growth": 8.7,
      "distance": "4.2 km",
    },
    {
      "area": "Heritage Heights",
      "avgPrice": 612.25,
      "growth": 6.3,
      "distance": "3.8 km",
    },
    {
      "area": "Garden Valley",
      "avgPrice": 445.80,
      "growth": 11.5,
      "distance": "5.1 km",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Area Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share analysis report
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
            // Area Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.location_city,
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
                          "Midtown Business District",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Comprehensive market analysis for this area",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Timeframe Selector
            QDropdownField(
              label: "Analysis Period",
              items: timeframeOptions,
              value: selectedTimeframe,
              onChanged: (value, label) {
                selectedTimeframe = value;
                setState(() {});
              },
            ),

            // Key Metrics
            Text(
              "Key Market Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: areaMetrics.map((metric) {
                String formattedValue;
                if (metric["currency"] == true) {
                  formattedValue = "\$${(metric["value"] as double).toStringAsFixed(2)}";
                } else if (metric["percentage"] == true) {
                  formattedValue = "${(metric["value"] as double).toStringAsFixed(1)}%";
                } else {
                  formattedValue = "${(metric["value"] as double).toStringAsFixed(0)}${metric["suffix"] ?? ""}";
                }

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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: spXxs,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) >= 0 
                                  ? successColor.withAlpha(20) 
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) >= 0 
                                    ? successColor 
                                    : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        formattedValue,
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["title"]}",
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

            // Price Range Distribution
            Text(
              "Price Range Distribution",
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
                children: priceRanges.map((range) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${range["range"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${range["properties"]} properties",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • Avg: \$${((range["avgPrice"] as int) / 1000).toStringAsFixed(0)}K",
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
                              "${(range["percentage"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (range["percentage"] as double) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Comparative Analysis
            Text(
              "Comparative Areas",
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
                children: comparativeAreas.map((area) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${area["area"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${area["distance"]} away",
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
                              "\$${(area["avgPrice"] as double).toStringAsFixed(2)}/sq ft",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: spXxs,
                              ),
                              decoration: BoxDecoration(
                                color: (area["growth"] as double) >= 10 
                                    ? successColor.withAlpha(20) 
                                    : warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "+${(area["growth"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: (area["growth"] as double) >= 10 
                                      ? successColor 
                                      : warningColor,
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
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Detailed Report",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to detailed report
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Compare Areas",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to area comparison
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
