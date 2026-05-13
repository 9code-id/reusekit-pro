import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard7View extends StatefulWidget {
  @override
  State<GrlDashboard7View> createState() => _GrlDashboard7ViewState();
}

class _GrlDashboard7ViewState extends State<GrlDashboard7View> {
  bool loading = false;
  String selectedCampaign = "All Campaigns";
  
  List<Map<String, dynamic>> marketingMetrics = [
    {"metric": "Campaign ROI", "value": 285.5, "change": 18.3, "icon": Icons.trending_up, "unit": "%"},
    {"metric": "Cost Per Click", "value": 2.45, "change": -12.8, "icon": Icons.mouse, "unit": "\$"},
    {"metric": "Conversion Rate", "value": 8.7, "change": 24.5, "icon": Icons.trending_up, "unit": "%"},
    {"metric": "Email Open Rate", "value": 34.2, "change": 6.9, "icon": Icons.email, "unit": "%"},
  ];

  List<Map<String, dynamic>> campaignData = [
    {"name": "Summer Sale 2024", "budget": 15000.0, "spent": 12800.0, "clicks": 8950, "conversions": 342, "status": "Active", "roi": 285.5},
    {"name": "Product Launch", "budget": 25000.0, "spent": 24100.0, "clicks": 12450, "conversions": 478, "status": "Active", "roi": 342.8},
    {"name": "Holiday Special", "budget": 8000.0, "spent": 8000.0, "clicks": 5620, "conversions": 189, "status": "Completed", "roi": 195.2},
    {"name": "Brand Awareness", "budget": 18000.0, "spent": 15600.0, "clicks": 18950, "conversions": 89, "status": "Active", "roi": 125.4},
    {"name": "Retargeting Campaign", "budget": 12000.0, "spent": 9800.0, "clicks": 6780, "conversions": 256, "status": "Active", "roi": 298.7},
  ];

  List<Map<String, dynamic>> socialMetrics = [
    {"platform": "Facebook", "followers": 45320, "engagement": 8.5, "reach": 156000, "posts": 28, "color": "info"},
    {"platform": "Instagram", "followers": 32890, "engagement": 12.3, "reach": 98000, "posts": 35, "color": "warning"},
    {"platform": "Twitter", "followers": 18960, "engagement": 5.8, "reach": 67000, "posts": 42, "color": "primary"},
    {"platform": "LinkedIn", "followers": 12450, "engagement": 7.2, "reach": 34000, "posts": 18, "color": "success"},
  ];

  List<Map<String, dynamic>> emailCampaigns = [
    {"subject": "Weekly Newsletter #15", "sent": 15420, "opened": 5268, "clicked": 842, "date": "2024-01-15", "status": "Sent"},
    {"subject": "Product Update Alert", "sent": 8950, "opened": 3580, "clicked": 428, "date": "2024-01-14", "status": "Sent"},
    {"subject": "Special Offer Inside", "sent": 12340, "opened": 4691, "clicked": 967, "date": "2024-01-13", "status": "Sent"},
    {"subject": "Monthly Report", "sent": 6780, "opened": 2440, "clicked": 186, "date": "2024-01-12", "status": "Sent"},
  ];

  List<Map<String, dynamic>> adPerformance = [
    {"platform": "Google Ads", "impressions": 456789, "clicks": 8950, "cost": 12800.0, "conversions": 342, "ctr": 1.96},
    {"platform": "Facebook Ads", "impressions": 298456, "clicks": 6780, "cost": 9600.0, "conversions": 256, "ctr": 2.27},
    {"platform": "Instagram Ads", "impressions": 189567, "clicks": 4320, "cost": 7200.0, "conversions": 178, "ctr": 2.28},
    {"platform": "LinkedIn Ads", "impressions": 89456, "clicks": 1890, "cost": 5400.0, "conversions": 89, "ctr": 2.11},
  ];

  List<Map<String, dynamic>> campaignItems = [
    {"label": "All Campaigns", "value": "All Campaigns"},
    {"label": "Summer Sale 2024", "value": "Summer Sale 2024"},
    {"label": "Product Launch", "value": "Product Launch"},
    {"label": "Holiday Special", "value": "Holiday Special"},
    {"label": "Brand Awareness", "value": "Brand Awareness"},
  ];

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Marketing Dashboard"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.campaign,
              size: bs.sm,
              onPressed: () {
                si("Creating new marketing campaign");
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campaign Filter
            Row(
              children: [
                Text(
                  "Campaign:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Campaign",
                    items: campaignItems,
                    value: selectedCampaign,
                    onChanged: (value, label) {
                      selectedCampaign = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Marketing Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: marketingMetrics.map((metric) {
                String displayValue;
                if (metric["unit"] == "\$") {
                  displayValue = "\$${(metric["value"] as double).toStringAsFixed(2)}";
                } else if (metric["unit"] == "%") {
                  displayValue = "${(metric["value"] as double).toStringAsFixed(1)}%";
                } else {
                  displayValue = "${(metric["value"] as double).toStringAsFixed(0)}";
                }
                
                return _buildMetricCard(
                  metric["metric"],
                  displayValue,
                  metric["icon"],
                  primaryColor,
                  "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                );
              }).toList(),
            ),

            // Campaign Performance
            Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Campaign Performance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening campaign management");
                        },
                        child: Text(
                          "Manage",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: campaignData.map((campaign) {
                      double spentPercentage = (campaign["spent"] as double) / (campaign["budget"] as double);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getCampaignStatusColor(campaign["status"]),
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${campaign["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getCampaignStatusColor(campaign["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${campaign["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getCampaignStatusColor(campaign["status"]),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getROIColor(campaign["roi"] as double).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "ROI: ${(campaign["roi"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getROIColor(campaign["roi"] as double),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      widthFactor: spentPercentage > 1.0 ? 1.0 : spentPercentage,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: spentPercentage > 0.9 ? warningColor : primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Spent: \$${((campaign["spent"] as double) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Budget: \$${((campaign["budget"] as double) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Clicks: ${((campaign["clicks"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Conv: ${campaign["conversions"]}",
                                  style: TextStyle(
                                    fontSize: 11,
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
            ),

            // Social Media Performance
            Container(
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
                    "Social Media Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: socialMetrics.map((platform) {
                      IconData platformIcon;
                      switch (platform["platform"]) {
                        case "Facebook":
                          platformIcon = Icons.facebook;
                          break;
                        case "Instagram":
                          platformIcon = Icons.camera_alt;
                          break;
                        case "Twitter":
                          platformIcon = Icons.alternate_email;
                          break;
                        case "LinkedIn":
                          platformIcon = Icons.business;
                          break;
                        default:
                          platformIcon = Icons.share;
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getColorFromString(platform["color"]),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  platformIcon,
                                  color: _getColorFromString(platform["color"]),
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${platform["platform"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${((platform["followers"] as int) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _getColorFromString(platform["color"]),
                              ),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${(platform["engagement"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Engagement",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${platform["posts"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        fontSize: 10,
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
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Email Campaign Performance
            Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Email Campaigns",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening email campaign manager");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: emailCampaigns.map((email) {
                      double openRate = (email["opened"] as int) / (email["sent"] as int) * 100;
                      double clickRate = (email["clicked"] as int) / (email["opened"] as int) * 100;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.email,
                                    color: infoColor,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${email["subject"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Sent: ${((email["sent"] as int) / 1000).toStringAsFixed(1)}K • ${email["date"]}",
                                        style: TextStyle(
                                          fontSize: 11,
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
                                      "${openRate.toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "Open Rate",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spSm),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${clickRate.toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      "Click Rate",
                                      style: TextStyle(
                                        fontSize: 10,
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
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "New Campaign",
                    icon: Icons.add_circle,
                    size: bs.md,
                    onPressed: () {
                      si("Creating new marketing campaign");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Analytics Report",
                    icon: Icons.analytics,
                    size: bs.md,
                    onPressed: () {
                      ss("Marketing analytics report generated");
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

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+') ? successColor.withAlpha(20) : 
                        change.startsWith('-') ? (title.contains("Cost") ? successColor.withAlpha(20) : dangerColor.withAlpha(20)) : 
                        warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: change.startsWith('+') ? successColor : 
                          change.startsWith('-') ? (title.contains("Cost") ? successColor : dangerColor) : 
                          warningColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "success":
        return successColor;
      case "danger":
        return dangerColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getCampaignStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Completed":
        return infoColor;
      case "Paused":
        return warningColor;
      case "Draft":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getROIColor(double roi) {
    if (roi >= 200) return successColor;
    if (roi >= 150) return warningColor;
    return dangerColor;
  }
}
