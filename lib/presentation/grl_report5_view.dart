import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport5View extends StatefulWidget {
  @override
  State<GrlReport5View> createState() => _GrlReport5ViewState();
}

class _GrlReport5ViewState extends State<GrlReport5View> {
  int selectedTab = 0;
  String selectedCampaign = "all";
  
  List<Map<String, dynamic>> campaigns = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Email Marketing", "value": "email"},
    {"label": "Social Media", "value": "social"},
    {"label": "Google Ads", "value": "google"},
    {"label": "Content Marketing", "value": "content"},
  ];

  List<Map<String, dynamic>> campaignData = [
    {
      "name": "Summer Sale 2024",
      "type": "email",
      "status": "active",
      "budget": 15000.0,
      "spent": 12450.0,
      "impressions": 145000,
      "clicks": 8900,
      "conversions": 234,
      "revenue": 45600.0,
      "startDate": "2024-12-01",
      "endDate": "2024-12-31",
      "ctr": 6.1,
      "cpc": 1.40,
      "roas": 3.66,
    },
    {
      "name": "Holiday Social Campaign",
      "type": "social",
      "status": "active",
      "budget": 8000.0,
      "spent": 7250.0,
      "impressions": 89000,
      "clicks": 4500,
      "conversions": 156,
      "revenue": 28900.0,
      "startDate": "2024-12-15",
      "endDate": "2024-12-25",
      "ctr": 5.1,
      "cpc": 1.61,
      "roas": 3.99,
    },
    {
      "name": "Product Launch Ads",
      "type": "google",
      "status": "completed",
      "budget": 25000.0,
      "spent": 24800.0,
      "impressions": 234000,
      "clicks": 12300,
      "conversions": 456,
      "revenue": 89500.0,
      "startDate": "2024-11-01",
      "endDate": "2024-11-30",
      "ctr": 5.3,
      "cpc": 2.02,
      "roas": 3.61,
    },
    {
      "name": "Content Marketing Blog",
      "type": "content",
      "status": "active",
      "budget": 5000.0,
      "spent": 3200.0,
      "impressions": 56000,
      "clicks": 2800,
      "conversions": 89,
      "revenue": 12400.0,
      "startDate": "2024-12-01",
      "endDate": "2024-12-31",
      "ctr": 5.0,
      "cpc": 1.14,
      "roas": 3.88,
    },
    {
      "name": "Black Friday Email",
      "type": "email",
      "status": "completed",
      "budget": 12000.0,
      "spent": 11500.0,
      "impressions": 198000,
      "clicks": 15600,
      "conversions": 678,
      "revenue": 125000.0,
      "startDate": "2024-11-25",
      "endDate": "2024-11-29",
      "ctr": 7.9,
      "cpc": 0.74,
      "roas": 10.87,
    },
  ];

  List<Map<String, dynamic>> audienceData = [
    {
      "segment": "18-24 Years",
      "impressions": 125000,
      "clicks": 7800,
      "conversions": 189,
      "ctr": 6.2,
      "conversionRate": 2.4,
      "revenue": 28900.0,
    },
    {
      "segment": "25-34 Years",
      "impressions": 234000,
      "clicks": 14500,
      "conversions": 456,
      "ctr": 6.2,
      "conversionRate": 3.1,
      "revenue": 67800.0,
    },
    {
      "segment": "35-44 Years",
      "impressions": 189000,
      "clicks": 11200,
      "conversions": 398,
      "ctr": 5.9,
      "conversionRate": 3.6,
      "revenue": 89500.0,
    },
    {
      "segment": "45-54 Years",
      "impressions": 156000,
      "clicks": 8900,
      "conversions": 267,
      "ctr": 5.7,
      "conversionRate": 3.0,
      "revenue": 56700.0,
    },
    {
      "segment": "55+ Years",
      "impressions": 98000,
      "clicks": 4900,
      "conversions": 134,
      "ctr": 5.0,
      "conversionRate": 2.7,
      "revenue": 34500.0,
    },
  ];

  List<Map<String, dynamic>> channelPerformance = [
    {
      "channel": "Email Marketing",
      "campaigns": 12,
      "totalSpent": 45000.0,
      "totalRevenue": 189000.0,
      "avgROAS": 4.2,
      "avgCTR": 6.8,
      "totalConversions": 1245,
      "color": primaryColor,
    },
    {
      "channel": "Google Ads",
      "campaigns": 8,
      "totalSpent": 67000.0,
      "totalRevenue": 234000.0,
      "avgROAS": 3.5,
      "avgCTR": 5.2,
      "totalConversions": 1867,
      "color": successColor,
    },
    {
      "channel": "Social Media",
      "campaigns": 15,
      "totalSpent": 34000.0,
      "totalRevenue": 123000.0,
      "avgROAS": 3.6,
      "avgCTR": 4.9,
      "totalConversions": 987,
      "color": infoColor,
    },
    {
      "channel": "Content Marketing",
      "campaigns": 6,
      "totalSpent": 18000.0,
      "totalRevenue": 56000.0,
      "avgROAS": 3.1,
      "avgCTR": 5.1,
      "totalConversions": 456,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Marketing Report",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Audience", icon: Icon(Icons.people)),
        Tab(text: "Channels", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCampaignsTab(),
        _buildAudienceTab(),
        _buildChannelsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMarketingMetrics(),
          _buildTopPerformingCampaigns(),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildMarketingMetrics() {
    double totalSpent = campaignData.fold(0.0, (sum, campaign) => sum + (campaign["spent"] as double));
    double totalRevenue = campaignData.fold(0.0, (sum, campaign) => sum + (campaign["revenue"] as double));
    int totalConversions = campaignData.fold(0, (sum, campaign) => sum + (campaign["conversions"] as int));
    double avgROAS = totalSpent > 0 ? totalRevenue / totalSpent : 0.0;

    List<Map<String, dynamic>> metrics = [
      {
        "title": "Total Spent",
        "value": "\$${totalSpent.currency}",
        "subtitle": "Marketing budget",
        "icon": Icons.attach_money,
        "color": dangerColor,
      },
      {
        "title": "Total Revenue",
        "value": "\$${totalRevenue.currency}",
        "subtitle": "Generated from campaigns",
        "icon": Icons.trending_up,
        "color": successColor,
      },
      {
        "title": "Total Conversions",
        "value": totalConversions.toString(),
        "subtitle": "Successful actions",
        "icon": Icons.trending_up,
        "color": primaryColor,
      },
      {
        "title": "Average ROAS",
        "value": "${avgROAS.toStringAsFixed(2)}x",
        "subtitle": "Return on ad spend",
        "icon": Icons.analytics,
        "color": infoColor,
      },
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: metrics.map((metric) {
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
                      color: (metric["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      metric["icon"] as IconData,
                      color: metric["color"] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${metric["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${metric["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${metric["subtitle"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTopPerformingCampaigns() {
    List<Map<String, dynamic>> topCampaigns = List.from(campaignData);
    topCampaigns.sort((a, b) => (b["roas"] as double).compareTo(a["roas"] as double));
    topCampaigns = topCampaigns.take(3).toList();

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
          Text(
            "Top Performing Campaigns",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: topCampaigns.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> campaign = entry.value;
              
              Color typeColor = campaign["type"] == "email" ? primaryColor :
                              campaign["type"] == "social" ? infoColor :
                              campaign["type"] == "google" ? successColor : warningColor;

              return Container(
                margin: EdgeInsets.only(bottom: index < topCampaigns.length - 1 ? spSm : 0),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: typeColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: typeColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${campaign["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${campaign["type"]}".toUpperCase() + " • ${(campaign["conversions"] as int)} conversions",
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
                          "${(campaign["roas"] as double).toStringAsFixed(2)}x",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "ROAS",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
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

  Widget _buildRecentActivity() {
    List<Map<String, dynamic>> activities = [
      {
        "type": "Campaign Launched",
        "description": "Summer Sale 2024 campaign started",
        "date": "2024-12-22",
        "icon": Icons.rocket_launch,
        "color": successColor,
      },
      {
        "type": "Budget Alert",
        "description": "Holiday Social Campaign reached 90% budget",
        "date": "2024-12-21",
        "icon": Icons.warning,
        "color": warningColor,
      },
      {
        "type": "Campaign Completed",
        "description": "Product Launch Ads campaign ended",
        "date": "2024-12-20",
        "icon": Icons.check_circle,
        "color": infoColor,
      },
      {
        "type": "High Performance",
        "description": "Black Friday Email exceeded ROAS target",
        "date": "2024-12-19",
        "icon": Icons.trending_up,
        "color": primaryColor,
      },
    ];

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
          Text(
            "Recent Marketing Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: activities.map((activity) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (activity["color"] as Color).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        activity["icon"] as IconData,
                        color: activity["color"] as Color,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${activity["type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${activity["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${activity["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
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

  Widget _buildCampaignsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCampaignFilter(),
          _buildCampaignsList(),
        ],
      ),
    );
  }

  Widget _buildCampaignFilter() {
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
          Text(
            "Filter by Campaign Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: campaigns,
            value: selectedCampaign,
            onChanged: (index, label, value, item) {
              selectedCampaign = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsList() {
    List<Map<String, dynamic>> filteredCampaigns = selectedCampaign == "all" 
        ? campaignData 
        : campaignData.where((campaign) => campaign["type"] == selectedCampaign).toList();

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
          Text(
            "Campaign Performance (${filteredCampaigns.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: filteredCampaigns.map((campaign) {
              Color statusColor = campaign["status"] == "active" ? successColor : infoColor;
              Color typeColor = campaign["type"] == "email" ? primaryColor :
                              campaign["type"] == "social" ? infoColor :
                              campaign["type"] == "google" ? successColor : warningColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
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
                                "${campaign["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: typeColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${campaign["type"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${campaign["status"]}".toUpperCase(),
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
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${((campaign["revenue"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "${(campaign["roas"] as double).toStringAsFixed(2)}x ROAS",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      minItemWidth: 100,
                      children: [
                        _buildCampaignMetric("Impressions", "${((campaign["impressions"] as int) / 1000).toStringAsFixed(0)}K"),
                        _buildCampaignMetric("Clicks", "${(campaign["clicks"] as int)}"),
                        _buildCampaignMetric("CTR", "${(campaign["ctr"] as double).toStringAsFixed(1)}%"),
                        _buildCampaignMetric("CPC", "\$${(campaign["cpc"] as double).toStringAsFixed(2)}"),
                        _buildCampaignMetric("Conversions", "${(campaign["conversions"] as int)}"),
                        _buildCampaignMetric("Spent", "\$${((campaign["spent"] as double)).currency}"),
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

  Widget _buildCampaignMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAudienceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAudienceOverview(),
          _buildAudienceSegments(),
        ],
      ),
    );
  }

  Widget _buildAudienceOverview() {
    int totalImpressions = audienceData.fold(0, (sum, segment) => sum + (segment["impressions"] as int));
    int totalClicks = audienceData.fold(0, (sum, segment) => sum + (segment["clicks"] as int));
    int totalConversions = audienceData.fold(0, (sum, segment) => sum + (segment["conversions"] as int));
    double avgCTR = totalImpressions > 0 ? (totalClicks / totalImpressions) * 100 : 0.0;

    List<Map<String, dynamic>> overviewData = [
      {
        "title": "Total Impressions",
        "value": "${(totalImpressions / 1000).toStringAsFixed(0)}K",
        "icon": Icons.visibility,
        "color": infoColor,
      },
      {
        "title": "Total Clicks",
        "value": "${(totalClicks / 1000).toStringAsFixed(1)}K",
        "icon": Icons.mouse,
        "color": primaryColor,
      },
      {
        "title": "Total Conversions",
        "value": totalConversions.toString(),
        "icon": Icons.trending_up,
        "color": successColor,
      },
      {
        "title": "Average CTR",
        "value": "${avgCTR.toStringAsFixed(1)}%",
        "icon": Icons.trending_up,
        "color": warningColor,
      },
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: overviewData.map((data) {
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
                      color: (data["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      data["icon"] as IconData,
                      color: data["color"] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${data["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${data["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAudienceSegments() {
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
          Text(
            "Audience Segments Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: audienceData.map((segment) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: primaryColor,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
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
                          "\$${((segment["revenue"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      minItemWidth: 100,
                      children: [
                        _buildAudienceMetric("Impressions", "${((segment["impressions"] as int) / 1000).toStringAsFixed(0)}K"),
                        _buildAudienceMetric("Clicks", "${((segment["clicks"] as int) / 1000).toStringAsFixed(1)}K"),
                        _buildAudienceMetric("CTR", "${(segment["ctr"] as double).toStringAsFixed(1)}%"),
                        _buildAudienceMetric("Conversions", "${(segment["conversions"] as int)}"),
                        _buildAudienceMetric("Conv. Rate", "${(segment["conversionRate"] as double).toStringAsFixed(1)}%"),
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

  Widget _buildAudienceMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildChannelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildChannelComparison(),
          _buildChannelDetails(),
        ],
      ),
    );
  }

  Widget _buildChannelComparison() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: channelPerformance.map((channel) {
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
                      color: (channel["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      channel["channel"] == "Email Marketing" ? Icons.email :
                      channel["channel"] == "Google Ads" ? Icons.search :
                      channel["channel"] == "Social Media" ? Icons.share : Icons.article,
                      color: channel["color"] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${channel["channel"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "\$${((channel["totalRevenue"] as double)).currency}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${(channel["avgROAS"] as double).toStringAsFixed(1)}x ROAS",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChannelDetails() {
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
          Text(
            "Channel Performance Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: channelPerformance.map((channel) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (channel["color"] as Color).withAlpha(25),
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
                          child: Text(
                            "${channel["channel"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(channel["campaigns"] as int)} campaigns",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      minItemWidth: 100,
                      children: [
                        _buildChannelMetric("Total Spent", "\$${((channel["totalSpent"] as double)).currency}"),
                        _buildChannelMetric("Total Revenue", "\$${((channel["totalRevenue"] as double)).currency}"),
                        _buildChannelMetric("Avg ROAS", "${(channel["avgROAS"] as double).toStringAsFixed(1)}x"),
                        _buildChannelMetric("Avg CTR", "${(channel["avgCTR"] as double).toStringAsFixed(1)}%"),
                        _buildChannelMetric("Conversions", "${(channel["totalConversions"] as int)}"),
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

  Widget _buildChannelMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }
}
