import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary10View extends StatefulWidget {
  @override
  State<GrlSummary10View> createState() => _GrlSummary10ViewState();
}

class _GrlSummary10ViewState extends State<GrlSummary10View> {
  List<Map<String, dynamic>> marketingChannels = [
    {
      "channel": "Google Ads",
      "impressions": 245000,
      "clicks": 8750,
      "conversions": 892,
      "ctr": 3.57,
      "conversion_rate": 10.2,
      "cost": 12500.0,
      "revenue": 89400.0,
      "roas": 7.15,
      "color": primaryColor,
    },
    {
      "channel": "Facebook Ads",
      "impressions": 180000,
      "clicks": 6800,
      "conversions": 645,
      "ctr": 3.78,
      "conversion_rate": 9.5,
      "cost": 8900.0,
      "revenue": 64500.0,
      "roas": 7.25,
      "color": infoColor,
    },
    {
      "channel": "Email Marketing",
      "impressions": 95000,
      "clicks": 4200,
      "conversions": 567,
      "ctr": 4.42,
      "conversion_rate": 13.5,
      "cost": 1200.0,
      "revenue": 45600.0,
      "roas": 38.0,
      "color": successColor,
    },
    {
      "channel": "SEO/Organic",
      "impressions": 520000,
      "clicks": 18200,
      "conversions": 1456,
      "ctr": 3.5,
      "conversion_rate": 8.0,
      "cost": 3500.0,
      "revenue": 142000.0,
      "roas": 40.57,
      "color": warningColor,
    },
    {
      "channel": "Social Media",
      "impressions": 340000,
      "clicks": 12400,
      "conversions": 734,
      "ctr": 3.65,
      "conversion_rate": 5.9,
      "cost": 5200.0,
      "revenue": 52800.0,
      "roas": 10.15,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> campaignPerformance = [
    {
      "campaign": "Holiday Sale 2024",
      "channel": "Google Ads",
      "budget": 15000.0,
      "spent": 13250.0,
      "impressions": 185000,
      "clicks": 7200,
      "conversions": 892,
      "revenue": 76500.0,
      "status": "active",
      "end_date": "2024-12-31",
    },
    {
      "campaign": "Brand Awareness Q4",
      "channel": "Facebook Ads",
      "budget": 8000.0,
      "spent": 7850.0,
      "impressions": 420000,
      "clicks": 14200,
      "conversions": 345,
      "revenue": 28900.0,
      "status": "active",
      "end_date": "2024-12-30",
    },
    {
      "campaign": "Newsletter Conversion",
      "channel": "Email Marketing",
      "budget": 500.0,
      "spent": 480.0,
      "impressions": 45000,
      "clicks": 2850,
      "conversions": 456,
      "revenue": 34200.0,
      "status": "completed",
      "end_date": "2024-12-15",
    },
    {
      "campaign": "Content Marketing Push",
      "channel": "SEO/Organic",
      "budget": 2000.0,
      "spent": 1890.0,
      "impressions": 680000,
      "clicks": 24500,
      "conversions": 1250,
      "revenue": 125000.0,
      "status": "active",
      "end_date": "2025-01-15",
    },
  ];

  List<Map<String, dynamic>> keyMetrics = [
    {
      "metric": "Cost Per Acquisition",
      "value": 18.50,
      "previous": 22.30,
      "unit": "\$",
      "trend": "down",
      "target": 15.0,
    },
    {
      "metric": "Return on Ad Spend",
      "value": 12.5,
      "previous": 9.8,
      "unit": "x",
      "trend": "up",
      "target": 10.0,
    },
    {
      "metric": "Click-Through Rate",
      "value": 3.68,
      "previous": 3.42,
      "unit": "%",
      "trend": "up",
      "target": 4.0,
    },
    {
      "metric": "Conversion Rate",
      "value": 9.2,
      "previous": 8.6,
      "unit": "%",
      "trend": "up",
      "target": 10.0,
    },
  ];

  List<Map<String, dynamic>> audienceInsights = [
    {
      "segment": "Age 25-34",
      "percentage": 35.5,
      "conversions": 1245,
      "avg_order_value": 89.50,
      "top_interest": "Technology",
    },
    {
      "segment": "Age 35-44",
      "percentage": 28.2,
      "conversions": 892,
      "avg_order_value": 125.30,
      "top_interest": "Business",
    },
    {
      "segment": "Age 18-24",
      "percentage": 20.8,
      "conversions": 567,
      "avg_order_value": 67.80,
      "top_interest": "Fashion",
    },
    {
      "segment": "Age 45-54",
      "percentage": 12.3,
      "conversions": 345,
      "avg_order_value": 156.90,
      "top_interest": "Home & Garden",
    },
    {
      "segment": "Age 55+",
      "percentage": 3.2,
      "conversions": 98,
      "avg_order_value": 198.70,
      "top_interest": "Health",
    },
  ];

  String selectedView = "overview";

  @override
  Widget build(BuildContext context) {
    final totalSpent = marketingChannels.fold(0.0, (sum, channel) => sum + (channel["cost"] as double));
    final totalRevenue = marketingChannels.fold(0.0, (sum, channel) => sum + (channel["revenue"] as double));
    final totalConversions = marketingChannels.fold(0, (sum, channel) => sum + (channel["conversions"] as int));
    final avgROAS = totalRevenue / totalSpent;

    return Scaffold(
      appBar: AppBar(
        title: Text("Marketing Performance Summary"),
        actions: [
          Icon(Icons.campaign, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.analytics, color: primaryColor),
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
                      Icon(Icons.trending_up, color: Colors.white, size: 28),
                      SizedBox(width: spSm),
                      Text(
                        "Marketing Performance Overview",
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
                              "Total Spend",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${totalSpent.currency}",
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
                              "Revenue Generated",
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
                              "ROAS",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${avgROAS.toStringAsFixed(1)}x",
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
                {"label": "Channels", "value": "channels"},
                {"label": "Campaigns", "value": "campaigns"},
                {"label": "Audience", "value": "audience"},
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
              children: keyMetrics.map((metric) {
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

            if (selectedView == "overview" || selectedView == "channels") ...[
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
                      "Marketing Channel Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      spacing: spSm,
                      children: marketingChannels.map((channel) {
                        final efficiency = (channel["revenue"] as double) / (channel["cost"] as double);
                        
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
                                      color: channel["color"] as Color,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
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
                                    "ROAS: ${(channel["roas"] as double).toStringAsFixed(1)}x",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: channel["color"] as Color,
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
                                          "Impressions: ${(channel["impressions"] as int).toString()}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Clicks: ${channel["clicks"]} (${(channel["ctr"] as double).toStringAsFixed(2)}% CTR)",
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
                                        "\$${(channel["cost"] as double).currency} spent",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "\$${(channel["revenue"] as double).currency} revenue",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${channel["conversions"]} conversions (${(channel["conversion_rate"] as double).toStringAsFixed(1)}%)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Efficiency: ${efficiency.toStringAsFixed(1)}x",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: efficiency > 5 ? successColor : warningColor,
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

            if (selectedView == "campaigns") ...[
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
                      "Active Campaigns Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      spacing: spSm,
                      children: campaignPerformance.map((campaign) {
                        final budgetUsed = ((campaign["spent"] as double) / (campaign["budget"] as double)) * 100;
                        final roas = (campaign["revenue"] as double) / (campaign["spent"] as double);
                        final isActive = campaign["status"] == "active";
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${campaign["campaign"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: isActive ? successColor.withAlpha(26) : disabledColor.withAlpha(26),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${campaign["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isActive ? successColor : disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${campaign["channel"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    " • Ends: ${DateTime.parse(campaign["end_date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
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
                                          "Budget: \$${(campaign["budget"] as double).currency} (${budgetUsed.toStringAsFixed(0)}% used)",
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
                                            widthFactor: (budgetUsed / 100).clamp(0.0, 1.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: budgetUsed > 90 ? dangerColor : primaryColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "ROAS: ${roas.toStringAsFixed(1)}x",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: roas > 5 ? successColor : warningColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(campaign["revenue"] as double).currency} revenue",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${campaign["impressions"]} impressions • ${campaign["clicks"]} clicks",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${campaign["conversions"]} conversions",
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
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            if (selectedView == "audience") ...[
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
                          "Audience Demographics & Insights",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Icon(Icons.people, color: primaryColor, size: 20),
                      ],
                    ),
                    Column(
                      spacing: spSm,
                      children: audienceInsights.map((segment) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
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
                                    "${(segment["percentage"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: ((segment["percentage"] as double) / 100).clamp(0.0, 1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${segment["conversions"]} conversions",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "AOV: \$${(segment["avg_order_value"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Interest: ${segment["top_interest"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
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

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Create Campaign",
                    icon: Icons.add_circle,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Report",
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
