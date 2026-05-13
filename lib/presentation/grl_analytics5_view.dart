import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics5View extends StatefulWidget {
  @override
  State<GrlAnalytics5View> createState() => _GrlAnalytics5ViewState();
}

class _GrlAnalytics5ViewState extends State<GrlAnalytics5View> {
  String selectedCampaign = "all";
  String selectedChannel = "all";

  List<Map<String, dynamic>> campaigns = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Summer Sale 2024", "value": "summer2024"},
    {"label": "Black Friday", "value": "blackfriday"},
    {"label": "Holiday Special", "value": "holiday"},
  ];

  List<Map<String, dynamic>> channels = [
    {"label": "All Channels", "value": "all"},
    {"label": "Google Ads", "value": "google"},
    {"label": "Facebook", "value": "facebook"},
    {"label": "Instagram", "value": "instagram"},
    {"label": "Email", "value": "email"},
  ];

  List<Map<String, dynamic>> marketingMetrics = [
    {
      "title": "Total Impressions",
      "value": 2450000,
      "change": 24.8,
      "icon": Icons.visibility,
      "color": Colors.blue
    },
    {
      "title": "Click-through Rate",
      "value": 3.42,
      "change": 12.5,
      "icon": Icons.ads_click,
      "color": Colors.green
    },
    {
      "title": "Cost per Click",
      "value": 1.25,
      "change": -8.3,
      "icon": Icons.attach_money,
      "color": Colors.orange
    },
    {
      "title": "Conversion Rate",
      "value": 2.8,
      "change": 18.7,
      "icon": Icons.trending_up,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> campaignPerformance = [
    {
      "name": "Summer Sale 2024",
      "status": "active",
      "budget": 15000.00,
      "spent": 12450.00,
      "impressions": 890000,
      "clicks": 28400,
      "conversions": 756,
      "roas": 3.4
    },
    {
      "name": "Black Friday Campaign",
      "status": "completed",
      "budget": 25000.00,
      "spent": 24800.00,
      "impressions": 1560000,
      "clicks": 52300,
      "conversions": 1420,
      "roas": 4.2
    },
    {
      "name": "Holiday Special",
      "status": "active",
      "budget": 8000.00,
      "spent": 3200.00,
      "impressions": 420000,
      "clicks": 15600,
      "conversions": 380,
      "roas": 2.8
    },
    {
      "name": "Spring Collection",
      "status": "paused",
      "budget": 12000.00,
      "spent": 8900.00,
      "impressions": 650000,
      "clicks": 21800,
      "conversions": 590,
      "roas": 3.1
    },
  ];

  List<Map<String, dynamic>> channelBreakdown = [
    {
      "channel": "Google Ads",
      "spend": 45200.00,
      "impressions": 1240000,
      "clicks": 38500,
      "conversions": 1080,
      "ctr": 3.1,
      "cpc": 1.17,
      "color": Colors.blue
    },
    {
      "channel": "Facebook Ads",
      "spend": 32800.00,
      "impressions": 890000,
      "clicks": 24600,
      "conversions": 720,
      "ctr": 2.8,
      "cpc": 1.33,
      "color": Colors.indigo
    },
    {
      "channel": "Instagram Ads",
      "spend": 28500.00,
      "impressions": 750000,
      "clicks": 22800,
      "conversions": 650,
      "ctr": 3.0,
      "cpc": 1.25,
      "color": Colors.pink
    },
    {
      "channel": "Email Marketing",
      "spend": 5400.00,
      "impressions": 180000,
      "clicks": 8900,
      "conversions": 380,
      "ctr": 4.9,
      "cpc": 0.61,
      "color": Colors.green
    },
  ];

  List<Map<String, dynamic>> audienceInsights = [
    {
      "segment": "Tech Enthusiasts",
      "size": 125000,
      "engagement": 4.2,
      "conversion": 3.8,
      "value": 185.50
    },
    {
      "segment": "Young Professionals",
      "size": 98500,
      "engagement": 3.9,
      "conversion": 3.2,
      "value": 165.30
    },
    {
      "segment": "Students",
      "size": 76200,
      "engagement": 5.1,
      "conversion": 2.1,
      "value": 85.20
    },
    {
      "segment": "Parents",
      "size": 156800,
      "engagement": 3.1,
      "conversion": 4.2,
      "value": 220.80
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "paused":
        return warningColor;
      case "completed":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketing Analytics"),
        actions: [
          Icon(Icons.campaign),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Campaign",
                    items: campaigns,
                    value: selectedCampaign,
                    onChanged: (value, label) {
                      selectedCampaign = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Channel",
                    items: channels,
                    value: selectedChannel,
                    onChanged: (value, label) {
                      selectedChannel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: marketingMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
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
                              borderRadius: BorderRadius.circular(radiusSm),
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
                              vertical: 2,
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
                                color: (metric["change"] as double) >= 0
                                    ? successColor
                                    : dangerColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        metric["title"] == "Total Impressions"
                            ? "${((metric["value"] as int) / 1000).toStringAsFixed(0)}K"
                            : metric["title"] == "Cost per Click"
                            ? "\$${(metric["value"] as double).toStringAsFixed(2)}"
                            : "${(metric["value"] as double).toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Campaign Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...campaignPerformance.map((campaign) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor(campaign["status"] as String).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: _getStatusColor(campaign["status"] as String),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${campaign["name"]}",
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
                                  color: _getStatusColor(campaign["status"] as String).withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${campaign["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    color: _getStatusColor(campaign["status"] as String),
                                    fontSize: 10,
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
                                      "Budget",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(campaign["budget"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                                      "Spent",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(campaign["spent"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                                      "ROAS",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(campaign["roas"] as double).toStringAsFixed(1)}x",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: (campaign["roas"] as double) >= 3.0 
                                            ? successColor 
                                            : warningColor,
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
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Channel Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...channelBreakdown.map((channel) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (channel["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: channel["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${channel["channel"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${(channel["spend"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: channel["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "CTR",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(channel["ctr"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "CPC",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(channel["cpc"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Conversions",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(channel["conversions"] as int)}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                  }).toList(),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Audience Insights",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...audienceInsights.map((audience) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${audience["segment"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${(audience["size"] as int)} users",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                      "Engagement",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(audience["engagement"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Conversion",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(audience["conversion"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Avg Value",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(audience["value"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
