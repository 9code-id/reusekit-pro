import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsConversionTrackingView extends StatefulWidget {
  const DmsConversionTrackingView({super.key});

  @override
  State<DmsConversionTrackingView> createState() => _DmsConversionTrackingViewState();
}

class _DmsConversionTrackingViewState extends State<DmsConversionTrackingView> {
  String selectedTimeframe = "30d";
  String selectedGoal = "all";
  String conversionName = "";
  String conversionValue = "";
  String selectedCategory = "purchase";
  String trackingMethod = "pixel";
  bool enableEnhancedEcommerce = false;
  bool enableCrossDomain = false;
  int currentTab = 0;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 90 Days", "value": "90d"},
    {"label": "Custom Range", "value": "custom"}
  ];

  List<Map<String, dynamic>> goalOptions = [
    {"label": "All Goals", "value": "all"},
    {"label": "Purchase", "value": "purchase"},
    {"label": "Lead Generation", "value": "lead"},
    {"label": "Sign Up", "value": "signup"},
    {"label": "Download", "value": "download"}
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Purchase", "value": "purchase"},
    {"label": "Lead Generation", "value": "lead"},
    {"label": "Sign Up", "value": "signup"},
    {"label": "Download", "value": "download"},
    {"label": "Page View", "value": "pageview"},
    {"label": "Custom Event", "value": "custom"}
  ];

  List<Map<String, dynamic>> trackingMethodOptions = [
    {"label": "Pixel Tracking", "value": "pixel"},
    {"label": "Google Analytics", "value": "ga"},
    {"label": "Facebook Pixel", "value": "fb"},
    {"label": "Custom Code", "value": "custom"}
  ];

  List<Map<String, dynamic>> conversionData = [
    {
      "id": "conv1",
      "name": "Purchase Complete",
      "category": "Purchase",
      "value": 85.50,
      "count": 156,
      "rate": 3.2,
      "totalValue": 13338.00,
      "source": "Google Ads",
      "status": "Active",
      "setupDate": "2024-05-01",
      "lastFired": "2024-06-18"
    },
    {
      "id": "conv2",
      "name": "Newsletter Signup",
      "category": "Lead Generation",
      "value": 5.00,
      "count": 423,
      "rate": 8.7,
      "totalValue": 2115.00,
      "source": "Facebook Ads",
      "status": "Active",
      "setupDate": "2024-04-15",
      "lastFired": "2024-06-18"
    },
    {
      "id": "conv3",
      "name": "Product Download",
      "category": "Download",
      "value": 15.00,
      "count": 89,
      "rate": 2.1,
      "totalValue": 1335.00,
      "source": "Organic",
      "status": "Active",
      "setupDate": "2024-05-10",
      "lastFired": "2024-06-17"
    },
    {
      "id": "conv4",
      "name": "Contact Form Submit",
      "category": "Lead Generation",
      "value": 25.00,
      "count": 67,
      "rate": 1.8,
      "totalValue": 1675.00,
      "source": "LinkedIn Ads",
      "status": "Paused",
      "setupDate": "2024-04-20",
      "lastFired": "2024-06-15"
    }
  ];

  List<Map<String, dynamic>> conversionFunnel = [
    {
      "step": "Landing Page Visit",
      "users": 15420,
      "rate": 100.0,
      "dropOff": 0
    },
    {
      "step": "Product View",
      "users": 8750,
      "rate": 56.8,
      "dropOff": 6670
    },
    {
      "step": "Add to Cart",
      "users": 3280,
      "rate": 21.3,
      "dropOff": 5470
    },
    {
      "step": "Checkout Started",
      "users": 1950,
      "rate": 12.6,
      "dropOff": 1330
    },
    {
      "step": "Purchase Complete",
      "users": 735,
      "rate": 4.8,
      "dropOff": 1215
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversion Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.code),
            onPressed: () {
              ss("Tracking code generated");
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              ss("Conversion analytics opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildConversionSetup(),
            _buildConversionOverview(),
            _buildConversionList(),
            _buildConversionFunnel(),
            _buildOptimizationTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.track_changes,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Conversion Tracking",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Monitor and optimize your conversion performance",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard("Total Conversions", "735", Icons.flag),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Conversion Rate", "4.8%", Icons.trending_up),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Total Value", "\$18.5K", Icons.attach_money),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha(204),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionSetup() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Set Up New Conversion",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Conversion Name",
            value: conversionName,
            hint: "e.g., Purchase Complete, Newsletter Signup",
            onChanged: (value) {
              conversionName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Value (\$)",
                  value: conversionValue,
                  onChanged: (value) {
                    conversionValue = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Tracking Method",
            items: trackingMethodOptions,
            value: trackingMethod,
            onChanged: (value, label) {
              trackingMethod = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Enhanced Ecommerce",
                      "value": true,
                      "checked": enableEnhancedEcommerce,
                    }
                  ],
                  value: [
                    if (enableEnhancedEcommerce)
                      {
                        "label": "Enhanced Ecommerce",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    enableEnhancedEcommerce = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Cross-Domain Tracking",
                      "value": true,
                      "checked": enableCrossDomain,
                    }
                  ],
                  value: [
                    if (enableCrossDomain)
                      {
                        "label": "Cross-Domain Tracking",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    enableCrossDomain = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Create Conversion",
                  size: bs.md,
                  onPressed: () {
                    if (conversionName.isNotEmpty) {
                      ss("Conversion '$conversionName' created successfully");
                      conversionName = "";
                      conversionValue = "";
                      setState(() {});
                    } else {
                      se("Please enter conversion name");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Generate Code",
                size: bs.md,
                onPressed: () {
                  si("Tracking code generated and copied to clipboard");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConversionOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.dashboard,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Conversion Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
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
                  label: "Goal Type",
                  items: goalOptions,
                  value: selectedGoal,
                  onChanged: (value, label) {
                    selectedGoal = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Total Conversions",
                "735",
                "+12.5%",
                Icons.flag,
                successColor,
              ),
              _buildOverviewCard(
                "Conversion Rate",
                "4.8%",
                "+0.8%",
                Icons.trending_up,
                infoColor,
              ),
              _buildOverviewCard(
                "Average Value",
                "\$25.17",
                "+\$3.20",
                Icons.attach_money,
                warningColor,
              ),
              _buildOverviewCard(
                "Total Revenue",
                "\$18.5K",
                "+\$2.1K",
                Icons.monetization_on,
                primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, String change, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(51),
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConversionList() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.list,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Active Conversions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...conversionData.map((conversion) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: conversion["status"] == "Active" 
                      ? successColor 
                      : disabledColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${conversion["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${conversion["category"]} • ${conversion["source"]}",
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
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: conversion["status"] == "Active" 
                              ? successColor 
                              : warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${conversion["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildConversionMetric(
                          "Count", 
                          "${conversion["count"]}"
                        ),
                      ),
                      Expanded(
                        child: _buildConversionMetric(
                          "Rate", 
                          "${(conversion["rate"] as double).toStringAsFixed(1)}%"
                        ),
                      ),
                      Expanded(
                        child: _buildConversionMetric(
                          "Avg Value", 
                          "\$${(conversion["value"] as double).toStringAsFixed(2)}"
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildConversionMetric(
                          "Total Value", 
                          "\$${((conversion["totalValue"] as double) / 1000).toStringAsFixed(1)}K"
                        ),
                      ),
                      Expanded(
                        child: _buildConversionMetric(
                          "Last Fired", 
                          "${conversion["lastFired"]}"
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening details for ${conversion["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          size: bs.sm,
                          onPressed: () {
                            si("Editing ${conversion["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("More options for ${conversion["name"]}");
                        },
                      ),
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

  Widget _buildConversionMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildConversionFunnel() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_list,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Conversion Funnel",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...conversionFunnel.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> step = entry.value;
            bool isLast = index == conversionFunnel.length - 1;

            return Column(
              spacing: spXs,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: primaryColor.withAlpha(51),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontSize: 14,
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
                          spacing: spXs,
                          children: [
                            Text(
                              "${step["step"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${((step["users"] as int) / 1000).toStringAsFixed(1)}K users",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(step["rate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (step["dropOff"] > 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "-${((step["dropOff"] as int) / 1000).toStringAsFixed(1)}K",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (!isLast)
                  Container(
                    height: 20,
                    width: 2,
                    color: primaryColor.withAlpha(51),
                    margin: EdgeInsets.only(left: 16),
                  ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOptimizationTips() {
    List<Map<String, dynamic>> tips = [
      {
        "title": "Improve Cart Abandonment",
        "description": "37% of users drop off at checkout. Consider simplifying the process.",
        "priority": "High",
        "impact": "Potential +15% conversion rate"
      },
      {
        "title": "Optimize Product Pages",
        "description": "43% drop-off from product view to cart. Enhance product descriptions.",
        "priority": "Medium",
        "impact": "Potential +8% conversion rate"
      },
      {
        "title": "Landing Page Enhancement",
        "description": "Strong top-funnel performance. Focus on mid-funnel optimization.",
        "priority": "Low",
        "impact": "Potential +3% conversion rate"
      }
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Optimization Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...tips.map((tip) {
            Color priorityColor = tip["priority"] == "High" 
                ? dangerColor 
                : tip["priority"] == "Medium" 
                    ? warningColor 
                    : infoColor;

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: priorityColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: priorityColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${tip["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: priorityColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${tip["priority"]} Priority",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${tip["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${tip["impact"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: priorityColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Learn More",
                      size: bs.sm,
                      onPressed: () {
                        si("Opening guide for: ${tip["title"]}");
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
