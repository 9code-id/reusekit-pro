import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCampaignAnalyticsView extends StatefulWidget {
  const CmaCampaignAnalyticsView({super.key});

  @override
  State<CmaCampaignAnalyticsView> createState() => _CmaCampaignAnalyticsViewState();
}

class _CmaCampaignAnalyticsViewState extends State<CmaCampaignAnalyticsView> {
  String selectedPeriod = "7days";
  String selectedCampaign = "all";
  int selectedTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "7days"},
    {"label": "Last 30 Days", "value": "30days"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "Last Year", "value": "year"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> campaignOptions = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Holiday Sale 2024", "value": "holiday_2024"},
    {"label": "Product Launch", "value": "product_launch"},
    {"label": "Newsletter Campaign", "value": "newsletter"},
    {"label": "Welcome Series", "value": "welcome"},
  ];

  List<Map<String, dynamic>> overviewStats = [
    {
      "title": "Total Campaigns",
      "value": 24,
      "change": "+12%",
      "icon": Icons.campaign,
      "color": Colors.blue,
      "trend": "up"
    },
    {
      "title": "Emails Sent",
      "value": 156890,
      "change": "+28%",
      "icon": Icons.mail,
      "color": Colors.green,
      "trend": "up"
    },
    {
      "title": "Open Rate",
      "value": 24.5,
      "change": "-2.1%",
      "icon": Icons.visibility,
      "color": Colors.orange,
      "trend": "down",
      "suffix": "%"
    },
    {
      "title": "Click Rate",
      "value": 3.8,
      "change": "+0.8%",
      "icon": Icons.mouse,
      "color": Colors.purple,
      "trend": "up",
      "suffix": "%"
    },
  ];

  List<Map<String, dynamic>> campaignPerformance = [
    {
      "name": "Holiday Sale 2024",
      "sent": 25400,
      "opened": 6858,
      "clicked": 1016,
      "converted": 284,
      "revenue": 142850.0,
      "status": "completed",
      "date": "2024-12-15"
    },
    {
      "name": "Product Launch",
      "sent": 18650,
      "opened": 4662,
      "clicked": 745,
      "converted": 167,
      "revenue": 89340.0,
      "status": "active",
      "date": "2024-12-10"
    },
    {
      "name": "Newsletter Dec",
      "sent": 12340,
      "opened": 3209,
      "clicked": 425,
      "converted": 89,
      "revenue": 23670.0,
      "status": "completed",
      "date": "2024-12-05"
    },
    {
      "name": "Welcome Series",
      "sent": 8970,
      "opened": 3588,
      "clicked": 627,
      "converted": 142,
      "revenue": 35680.0,
      "status": "active",
      "date": "2024-12-01"
    },
  ];

  List<Map<String, dynamic>> topPerformers = [
    {
      "subject": "50% Off Holiday Sale - Limited Time!",
      "campaign": "Holiday Sale 2024",
      "openRate": 32.4,
      "clickRate": 5.8,
      "revenue": 45600.0
    },
    {
      "subject": "Introducing Our New Product Line",
      "campaign": "Product Launch",
      "openRate": 28.9,
      "clickRate": 4.2,
      "revenue": 32400.0
    },
    {
      "subject": "Your Weekly Newsletter is Here",
      "campaign": "Newsletter Dec",
      "openRate": 26.1,
      "clickRate": 3.4,
      "revenue": 12800.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaign Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              si("Exporting analytics report...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFiltersSection(),
            _buildOverviewStats(),
            _buildPerformanceChart(),
            _buildTabSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
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
        ],
      ),
    );
  }

  Widget _buildOverviewStats() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: overviewStats.map((stat) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (stat["color"] as Color).withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      stat["icon"],
                      color: stat["color"],
                      size: 24,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        stat["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                        color: stat["trend"] == "up" ? successColor : dangerColor,
                        size: 16,
                      ),
                      SizedBox(width: spXxs),
                      Text(
                        "${stat["change"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: stat["trend"] == "up" ? successColor : dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                stat["suffix"] != null 
                  ? "${(stat["value"] as num).toStringAsFixed(1)}${stat["suffix"]}"
                  : "${(stat["value"] as num) >= 1000 ? '${((stat["value"] as num) / 1000).toStringAsFixed(1)}K' : stat["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${stat["title"]}",
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

  Widget _buildPerformanceChart() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Performance Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  _buildLegendItem("Sent", Colors.blue),
                  SizedBox(width: spSm),
                  _buildLegendItem("Opened", Colors.green),
                  SizedBox(width: spSm),
                  _buildLegendItem("Clicked", Colors.orange),
                ],
              ),
            ],
          ),
          Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Performance Chart",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Interactive chart showing campaign trends",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
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

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                _buildTabButton("Campaigns", 0),
                _buildTabButton("Top Performers", 1),
                _buildTabButton("Audience", 2),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: selectedTab == 0
                ? _buildCampaignsTab()
                : selectedTab == 1
                    ? _buildTopPerformersTab()
                    : _buildAudienceTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? primaryColor : disabledBoldColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignsTab() {
    return Column(
      spacing: spSm,
      children: campaignPerformance.map((campaign) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                        Text(
                          "${campaign["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: campaign["status"] == "active" ? successColor.withAlpha(26) : disabledColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${campaign["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        color: campaign["status"] == "active" ? successColor : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildCampaignStat("Sent", "${campaign["sent"]}", Icons.send),
                  ),
                  Expanded(
                    child: _buildCampaignStat("Opened", "${campaign["opened"]}", Icons.visibility),
                  ),
                  Expanded(
                    child: _buildCampaignStat("Clicked", "${campaign["clicked"]}", Icons.mouse),
                  ),
                  Expanded(
                    child: _buildCampaignStat("Revenue", "\$${((campaign["revenue"] as double) / 1000).toStringAsFixed(1)}K", Icons.monetization_on),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCampaignStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 16),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTopPerformersTab() {
    return Column(
      spacing: spSm,
      children: topPerformers.map((performer) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "${performer["subject"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "${performer["campaign"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${(performer["openRate"] as num).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${(performer["clickRate"] as num).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
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
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "\$${((performer["revenue"] as double) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Revenue",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
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
    );
  }

  Widget _buildAudienceTab() {
    return Column(
      spacing: spMd,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAudienceCard("Total Subscribers", "45,678", Icons.people, Colors.blue),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildAudienceCard("Active Users", "32,456", Icons.person, Colors.green),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildAudienceCard("New This Month", "2,345", Icons.person_add, Colors.orange),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildAudienceCard("Unsubscribed", "1,234", Icons.person_remove, Colors.red),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Audience Segments",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              _buildSegmentBar("VIP Customers", 0.35, Colors.purple),
              _buildSegmentBar("Regular Customers", 0.45, Colors.blue),
              _buildSegmentBar("New Leads", 0.20, Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAudienceCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentBar(String label, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "${(percentage * 100).toInt()}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(51),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
