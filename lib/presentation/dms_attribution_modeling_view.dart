import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsAttributionModelingView extends StatefulWidget {
  const DmsAttributionModelingView({super.key});

  @override
  State<DmsAttributionModelingView> createState() => _DmsAttributionModelingViewState();
}

class _DmsAttributionModelingViewState extends State<DmsAttributionModelingView> {
  int currentTab = 0;
  String selectedTimeframe = "Last 30 Days";
  String selectedModel = "Data-Driven";
  String selectedChannel = "All Channels";
  bool showModelComparison = true;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> modelOptions = [
    {"label": "Data-Driven", "value": "Data-Driven"},
    {"label": "Last Click", "value": "Last Click"},
    {"label": "First Click", "value": "First Click"},
    {"label": "Linear", "value": "Linear"},
    {"label": "Time Decay", "value": "Time Decay"},
    {"label": "Position Based", "value": "Position Based"},
  ];

  List<Map<String, dynamic>> channelOptions = [
    {"label": "All Channels", "value": "All Channels"},
    {"label": "Paid Search", "value": "Paid Search"},
    {"label": "Organic Search", "value": "Organic Search"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Email Marketing", "value": "Email Marketing"},
    {"label": "Display Ads", "value": "Display Ads"},
  ];

  List<Map<String, dynamic>> attributionMetrics = [
    {
      "title": "Total Conversions",
      "value": 1567,
      "change": 12.4,
      "icon": Icons.trending_up,
      "color": primaryColor,
    },
    {
      "title": "Revenue Attributed",
      "value": 234500,
      "change": 18.7,
      "icon": Icons.attach_money,
      "color": successColor,
      "prefix": "\$",
    },
    {
      "title": "Avg. Path Length",
      "value": 4.2,
      "change": -5.3,
      "icon": Icons.timeline,
      "color": infoColor,
      "suffix": " touchpoints",
    },
    {
      "title": "Time to Convert",
      "value": 12.5,
      "change": 2.1,
      "icon": Icons.schedule,
      "color": warningColor,
      "suffix": " days",
    },
  ];

  List<Map<String, dynamic>> channelAttribution = [
    {
      "channel": "Paid Search",
      "conversions": 456,
      "revenue": 68400,
      "attribution_percentage": 29.1,
      "avg_position": 2.3,
      "cost_per_conversion": 45.50,
      "roas": 3.2,
      "color": primaryColor,
    },
    {
      "channel": "Organic Search",
      "conversions": 389,
      "revenue": 58350,
      "attribution_percentage": 24.8,
      "avg_position": 1.8,
      "cost_per_conversion": 0.0,
      "roas": 0.0,
      "color": successColor,
    },
    {
      "channel": "Social Media",
      "conversions": 298,
      "revenue": 44700,
      "attribution_percentage": 19.0,
      "avg_position": 3.1,
      "cost_per_conversion": 28.75,
      "roas": 2.8,
      "color": infoColor,
    },
    {
      "channel": "Email Marketing",
      "conversions": 234,
      "revenue": 35100,
      "attribution_percentage": 14.9,
      "avg_position": 2.7,
      "cost_per_conversion": 12.30,
      "roas": 4.5,
      "color": warningColor,
    },
    {
      "channel": "Display Ads",
      "conversions": 123,
      "revenue": 18450,
      "attribution_percentage": 7.8,
      "avg_position": 4.2,
      "cost_per_conversion": 52.80,
      "roas": 1.9,
      "color": dangerColor,
    },
    {
      "channel": "Direct Traffic",
      "conversions": 67,
      "revenue": 10050,
      "attribution_percentage": 4.3,
      "avg_position": 1.0,
      "cost_per_conversion": 0.0,
      "roas": 0.0,
      "color": disabledBoldColor,
    },
  ];

  List<Map<String, dynamic>> modelComparison = [
    {
      "model": "Data-Driven",
      "description": "Algorithm-based attribution using machine learning",
      "total_conversions": 1567,
      "paid_search": 456,
      "organic_search": 389,
      "social_media": 298,
      "email": 234,
      "display": 123,
      "direct": 67,
      "accuracy_score": 94.2,
      "recommended": true,
    },
    {
      "model": "Last Click",
      "description": "100% credit to the last touchpoint before conversion",
      "total_conversions": 1567,
      "paid_search": 623,
      "organic_search": 445,
      "social_media": 201,
      "email": 156,
      "display": 89,
      "direct": 53,
      "accuracy_score": 67.8,
      "recommended": false,
    },
    {
      "model": "First Click",
      "description": "100% credit to the first touchpoint in the journey",
      "total_conversions": 1567,
      "paid_search": 289,
      "organic_search": 534,
      "social_media": 378,
      "email": 198,
      "display": 134,
      "direct": 34,
      "accuracy_score": 72.1,
      "recommended": false,
    },
    {
      "model": "Linear",
      "description": "Equal credit distributed across all touchpoints",
      "total_conversions": 1567,
      "paid_search": 398,
      "organic_search": 412,
      "social_media": 334,
      "email": 267,
      "display": 112,
      "direct": 44,
      "accuracy_score": 78.5,
      "recommended": false,
    },
  ];

  List<Map<String, dynamic>> customerJourneys = [
    {
      "journey_id": "J001",
      "conversion_value": 1200.0,
      "touchpoints": 5,
      "duration": 18,
      "path": [
        {"channel": "Organic Search", "timestamp": "Day 1", "interaction": "Landing Page Visit"},
        {"channel": "Social Media", "timestamp": "Day 3", "interaction": "Ad Click"},
        {"channel": "Email Marketing", "timestamp": "Day 8", "interaction": "Newsletter Click"},
        {"channel": "Paid Search", "timestamp": "Day 15", "interaction": "Product Search"},
        {"channel": "Direct Traffic", "timestamp": "Day 18", "interaction": "Purchase"},
      ],
      "attribution_breakdown": {
        "Organic Search": 0.25,
        "Social Media": 0.15,
        "Email Marketing": 0.20,
        "Paid Search": 0.30,
        "Direct Traffic": 0.10,
      }
    },
    {
      "journey_id": "J002",
      "conversion_value": 850.0,
      "touchpoints": 3,
      "duration": 7,
      "path": [
        {"channel": "Paid Search", "timestamp": "Day 1", "interaction": "Ad Click"},
        {"channel": "Email Marketing", "timestamp": "Day 4", "interaction": "Promotional Email"},
        {"channel": "Direct Traffic", "timestamp": "Day 7", "interaction": "Purchase"},
      ],
      "attribution_breakdown": {
        "Paid Search": 0.50,
        "Email Marketing": 0.30,
        "Direct Traffic": 0.20,
      }
    },
  ];

  List<Map<String, dynamic>> topPerformingPaths = [
    {
      "path": "Organic Search → Email → Direct",
      "frequency": 234,
      "avg_conversion_value": 945.0,
      "conversion_rate": 18.5,
      "avg_time_to_convert": 12.3,
    },
    {
      "path": "Paid Search → Social → Email → Direct",
      "frequency": 189,
      "avg_conversion_value": 1125.0,
      "conversion_rate": 22.1,
      "avg_time_to_convert": 15.7,
    },
    {
      "path": "Social → Organic Search → Direct",
      "frequency": 156,
      "avg_conversion_value": 678.0,
      "conversion_rate": 14.2,
      "avg_time_to_convert": 8.9,
    },
    {
      "path": "Display → Paid Search → Direct",
      "frequency": 123,
      "avg_conversion_value": 834.0,
      "conversion_rate": 16.8,
      "avg_time_to_convert": 11.2,
    },
  ];

  Widget _buildAttributionOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframeOptions,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Attribution Model",
                  items: modelOptions,
                  value: selectedModel,
                  onChanged: (value, label) {
                    selectedModel = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Metrics Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: attributionMetrics.map((metric) {
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
                            color: (metric["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (metric["change"] as double) >= 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (metric["change"] as double) >= 0 ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      metric["title"] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${metric["prefix"] ?? ''}${metric["value"]}${metric["suffix"] ?? ''}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Channel Attribution
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
                  "Channel Attribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...channelAttribution.map((channel) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (channel["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: channel["color"] as Color,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    channel["channel"] as String,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${(channel["attribution_percentage"] as double).toStringAsFixed(1)}% attribution",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: channel["color"] as Color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${channel["conversions"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Conversions",
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((channel["revenue"] as int).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Revenue",
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
                        SizedBox(height: spSm),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 100,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Avg Position",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(channel["avg_position"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            if ((channel["cost_per_conversion"] as double) > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cost/Conv",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(channel["cost_per_conversion"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            if ((channel["roas"] as double) > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ROAS",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(channel["roas"] as double).toStringAsFixed(1)}x",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModelComparisonTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Toggle Switch
          QSwitch(
            items: [
              {
                "label": "Show Model Comparison",
                "value": true,
                "checked": showModelComparison,
              }
            ],
            value: [
              if (showModelComparison)
                {
                  "label": "Show Model Comparison",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              showModelComparison = values.isNotEmpty;
              setState(() {});
            },
          ),

          if (showModelComparison)
            ...modelComparison.map((model) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: model["recommended"] as bool
                      ? Border.all(color: successColor, width: 2)
                      : null,
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
                              Row(
                                children: [
                                  Text(
                                    model["model"] as String,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (model["recommended"] as bool) ...[
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "RECOMMENDED",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                model["description"] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Accuracy",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(model["accuracy_score"] as double).toStringAsFixed(1)}%",
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
                    SizedBox(height: spMd),
                    
                    // Channel Attribution Breakdown
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 120,
                      children: [
                        _buildChannelMetric("Paid Search", model["paid_search"] as int, primaryColor),
                        _buildChannelMetric("Organic Search", model["organic_search"] as int, successColor),
                        _buildChannelMetric("Social Media", model["social_media"] as int, infoColor),
                        _buildChannelMetric("Email", model["email"] as int, warningColor),
                        _buildChannelMetric("Display", model["display"] as int, dangerColor),
                        _buildChannelMetric("Direct", model["direct"] as int, disabledBoldColor),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildChannelMetric(String channel, int value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          channel,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerJourneysTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Top Performing Paths
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
                  "Top Performing Paths",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...topPerformingPaths.map((path) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          path["path"] as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 100,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Frequency",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${path["frequency"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Avg Value",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((path["avg_conversion_value"] as double).toInt()).toString()}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Conv Rate",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(path["conversion_rate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Avg Time",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(path["avg_time_to_convert"] as double).toStringAsFixed(1)}d",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Sample Customer Journeys
          ...customerJourneys.map((journey) {
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
                      Expanded(
                        child: Text(
                          "Journey ${journey["journey_id"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "\$${((journey["conversion_value"] as double).toInt()).toString()}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${journey["touchpoints"]} touchpoints • ${journey["duration"]} days",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Journey Path
                  ...(journey["path"] as List).asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> touchpoint = entry.value;
                    bool isLast = index == (journey["path"] as List).length - 1;
                    
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? successColor
                                    : isLast
                                        ? primaryColor
                                        : infoColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
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
                                    touchpoint["channel"] as String,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    touchpoint["interaction"] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              touchpoint["timestamp"] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (!isLast)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: spSm),
                            child: Row(
                              children: [
                                SizedBox(width: 15),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Attribution Modeling",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.analytics)),
        Tab(text: "Models", icon: Icon(Icons.compare)),
        Tab(text: "Journeys", icon: Icon(Icons.timeline)),
      ],
      tabChildren: [
        _buildAttributionOverviewTab(),
        _buildModelComparisonTab(),
        _buildCustomerJourneysTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
