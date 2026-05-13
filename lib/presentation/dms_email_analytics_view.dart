import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsEmailAnalyticsView extends StatefulWidget {
  const DmsEmailAnalyticsView({super.key});

  @override
  State<DmsEmailAnalyticsView> createState() => _DmsEmailAnalyticsViewState();
}

class _DmsEmailAnalyticsViewState extends State<DmsEmailAnalyticsView> {
  int selectedPeriod = 0;
  String selectedCampaign = "all";
  bool showAdvancedMetrics = false;

  List<Map<String, dynamic>> timeOptions = [
    {"label": "Last 7 Days", "value": 0},
    {"label": "Last 30 Days", "value": 1},
    {"label": "Last 90 Days", "value": 2},
    {"label": "Custom Range", "value": 3},
  ];

  List<Map<String, dynamic>> campaignOptions = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Holiday Sale 2024", "value": "holiday_2024"},
    {"label": "Product Launch", "value": "product_launch"},
    {"label": "Newsletter Weekly", "value": "newsletter"},
    {"label": "Abandoned Cart", "value": "abandoned_cart"},
  ];

  List<Map<String, dynamic>> emailMetrics = [
    {
      "title": "Total Sent",
      "value": 125000,
      "change": 8.5,
      "icon": Icons.send,
      "color": "#3B82F6"
    },
    {
      "title": "Delivered",
      "value": 122750,
      "change": 7.2,
      "icon": Icons.check_circle,
      "color": "#10B981"
    },
    {
      "title": "Open Rate",
      "value": 24.8,
      "change": 2.1,
      "icon": Icons.visibility,
      "color": "#F59E0B",
      "isPercentage": true
    },
    {
      "title": "Click Rate",
      "value": 4.2,
      "change": -0.3,
      "icon": Icons.mouse,
      "color": "#8B5CF6",
      "isPercentage": true
    },
    {
      "title": "Bounce Rate",
      "value": 1.8,
      "change": -0.5,
      "icon": Icons.error_outline,
      "color": "#EF4444",
      "isPercentage": true
    },
    {
      "title": "Unsubscribe Rate",
      "value": 0.3,
      "change": 0.1,
      "icon": Icons.unsubscribe,
      "color": "#6B7280",
      "isPercentage": true
    },
  ];

  List<Map<String, dynamic>> campaignPerformance = [
    {
      "name": "Holiday Sale 2024",
      "sent": 45000,
      "delivered": 44100,
      "opens": 11025,
      "clicks": 1986,
      "conversions": 298,
      "revenue": 89400.0,
      "status": "completed"
    },
    {
      "name": "Product Launch",
      "sent": 32000,
      "delivered": 31360,
      "opens": 8464,
      "clicks": 1567,
      "conversions": 234,
      "revenue": 70200.0,
      "status": "active"
    },
    {
      "name": "Newsletter Weekly",
      "sent": 28000,
      "delivered": 27440,
      "opens": 6584,
      "clicks": 986,
      "conversions": 147,
      "revenue": 44100.0,
      "status": "scheduled"
    },
    {
      "name": "Abandoned Cart",
      "sent": 20000,
      "delivered": 19600,
      "opens": 5292,
      "clicks": 1176,
      "conversions": 392,
      "revenue": 117600.0,
      "status": "active"
    },
  ];

  List<Map<String, dynamic>> topPerformingEmails = [
    {
      "subject": "🎄 Exclusive Holiday Deals - 50% Off Everything",
      "sent": 15000,
      "openRate": 32.5,
      "clickRate": 6.8,
      "revenue": 24500.0,
      "sentDate": "2024-12-15"
    },
    {
      "subject": "Your Cart is Waiting - Complete Your Purchase",
      "sent": 8500,
      "openRate": 28.9,
      "clickRate": 8.2,
      "revenue": 18900.0,
      "sentDate": "2024-12-14"
    },
    {
      "subject": "New Product Alert: Revolutionary Smart Watch",
      "sent": 12000,
      "openRate": 26.4,
      "clickRate": 5.1,
      "revenue": 15600.0,
      "sentDate": "2024-12-13"
    },
    {
      "subject": "Weekly Roundup: Tech News & Reviews",
      "sent": 22000,
      "openRate": 22.1,
      "clickRate": 3.8,
      "revenue": 8800.0,
      "sentDate": "2024-12-12"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Analytics"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            _buildOverviewMetrics(),
            _buildPerformanceChart(),
            _buildCampaignPerformance(),
            _buildTopPerformingEmails(),
            _buildAdvancedAnalytics(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Analytics Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: timeOptions,
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
                  label: "Campaign",
                  items: campaignOptions,
                  value: selectedCampaign,
                  onChanged: (value, label) {
                    selectedCampaign = value;
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
                      "label": "Show Advanced Metrics",
                      "value": true,
                      "checked": showAdvancedMetrics,
                    }
                  ],
                  value: [
                    if (showAdvancedMetrics)
                      {
                        "label": "Show Advanced Metrics",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showAdvancedMetrics = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                label: "Apply Filters",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewMetrics() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email Performance Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: emailMetrics.map((metric) {
            Color metricColor = Color(int.parse("0xFF${(metric["color"] as String).substring(1)}"));
            bool isPositive = (metric["change"] as double) >= 0;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: metricColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          metric["icon"] as IconData,
                          color: metricColor,
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
                          color: isPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isPositive ? Icons.trending_up : Icons.trending_down,
                              size: 12,
                              color: isPositive ? successColor : dangerColor,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "${(metric["change"] as double).abs().toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isPositive ? successColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${metric["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    metric["isPercentage"] == true
                        ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                        : "${(metric["value"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                    style: TextStyle(
                      fontSize: 20,
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
    );
  }

  Widget _buildPerformanceChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Performance Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "↗ 12.5% vs last period",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Interactive Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Open Rate, Click Rate & Conversion Trends",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              _buildChartLegend("Open Rate", Color(0xFF3B82F6)),
              SizedBox(width: spSm),
              _buildChartLegend("Click Rate", Color(0xFF8B5CF6)),
              SizedBox(width: spSm),
              _buildChartLegend("Conversion Rate", Color(0xFF10B981)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignPerformance() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Campaign Performance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: campaignPerformance.length,
            itemBuilder: (context, index) {
              final campaign = campaignPerformance[index];
              double openRate = ((campaign["opens"] as int) / (campaign["delivered"] as int)) * 100;
              double clickRate = ((campaign["clicks"] as int) / (campaign["delivered"] as int)) * 100;
              double conversionRate = ((campaign["conversions"] as int) / (campaign["clicks"] as int)) * 100;
              
              Color statusColor;
              switch (campaign["status"]) {
                case "completed":
                  statusColor = successColor;
                  break;
                case "active":
                  statusColor = primaryColor;
                  break;
                case "scheduled":
                  statusColor = warningColor;
                  break;
                default:
                  statusColor = disabledColor;
              }

              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${campaign["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
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
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${campaign["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCampaignStat("Sent", "${(campaign["sent"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                        ),
                        Expanded(
                          child: _buildCampaignStat("Open Rate", "${openRate.toStringAsFixed(1)}%"),
                        ),
                        Expanded(
                          child: _buildCampaignStat("Click Rate", "${clickRate.toStringAsFixed(1)}%"),
                        ),
                        Expanded(
                          child: _buildCampaignStat("Revenue", "\$${((campaign["revenue"] as double) / 1000).toStringAsFixed(1)}K"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignStat(String label, String value) {
    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTopPerformingEmails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Performing Emails",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: topPerformingEmails.length,
            itemBuilder: (context, index) {
              final email = topPerformingEmails[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${email["subject"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          "Sent: ${(email["sent"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${email["sentDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildEmailStat("Open Rate", "${(email["openRate"] as double).toStringAsFixed(1)}%", successColor),
                        ),
                        Expanded(
                          child: _buildEmailStat("Click Rate", "${(email["clickRate"] as double).toStringAsFixed(1)}%", primaryColor),
                        ),
                        Expanded(
                          child: _buildEmailStat("Revenue", "\$${((email["revenue"] as double) / 1000).toStringAsFixed(1)}K", warningColor),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmailStat(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedAnalytics() {
    if (!showAdvancedMetrics) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Advanced Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAdvancedMetric(
                "Email Client Analysis",
                "Most opens from mobile (68%)",
                Icons.devices,
                primaryColor,
              ),
              _buildAdvancedMetric(
                "Best Send Time",
                "Tuesday 10:00 AM",
                Icons.schedule,
                successColor,
              ),
              _buildAdvancedMetric(
                "Geographic Performance",
                "US leads with 42% opens",
                Icons.public,
                warningColor,
              ),
              _buildAdvancedMetric(
                "Engagement Score",
                "8.7/10 (Excellent)",
                Icons.star,
                Color(0xFFEF4444),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
