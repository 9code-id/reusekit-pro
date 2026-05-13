import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsBidManagementView extends StatefulWidget {
  const DmsBidManagementView({super.key});

  @override
  State<DmsBidManagementView> createState() => _DmsBidManagementViewState();
}

class _DmsBidManagementViewState extends State<DmsBidManagementView> {
  String selectedCampaign = "campaign1";
  String selectedBidStrategy = "manual";
  String maxBid = "2.50";
  String targetCpa = "25.00";
  String targetRoas = "400";
  bool autoBidding = false;
  int currentTab = 0;

  List<Map<String, dynamic>> campaigns = [
    {
      "id": "campaign1",
      "name": "Summer Sale Campaign",
      "status": "Active",
      "currentBid": 2.15,
      "targetBid": 2.50,
      "performance": "Good",
      "impressions": 125000,
      "clicks": 3200,
      "conversions": 84,
      "spend": 6800.50,
      "ctr": 2.56,
      "cpc": 2.13,
      "cpa": 80.96
    },
    {
      "id": "campaign2",
      "name": "Brand Awareness Drive",
      "status": "Active", 
      "currentBid": 1.85,
      "targetBid": 2.00,
      "performance": "Excellent",
      "impressions": 98000,
      "clicks": 2850,
      "conversions": 76,
      "spend": 5270.25,
      "ctr": 2.91,
      "cpc": 1.85,
      "cpa": 69.35
    },
    {
      "id": "campaign3",
      "name": "Product Launch",
      "status": "Paused",
      "currentBid": 3.20,
      "targetBid": 3.50,
      "performance": "Poor",
      "impressions": 45000,
      "clicks": 980,
      "conversions": 18,
      "spend": 3136.00,
      "ctr": 2.18,
      "cpc": 3.20,
      "cpa": 174.22
    }
  ];

  List<Map<String, dynamic>> bidStrategies = [
    {"label": "Manual CPC", "value": "manual"},
    {"label": "Enhanced CPC", "value": "enhanced"},
    {"label": "Target CPA", "value": "target_cpa"},
    {"label": "Target ROAS", "value": "target_roas"},
    {"label": "Maximize Clicks", "value": "max_clicks"},
    {"label": "Maximize Conversions", "value": "max_conversions"}
  ];

  List<Map<String, dynamic>> campaignOptions = [
    {"label": "Summer Sale Campaign", "value": "campaign1"},
    {"label": "Brand Awareness Drive", "value": "campaign2"},
    {"label": "Product Launch", "value": "campaign3"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bid Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Bid data refreshed");
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
            _buildBidStrategySection(),
            _buildCampaignPerformance(),
            _buildBidOptimization(),
            _buildRecommendations(),
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
                Icons.trending_up,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bid Management Dashboard",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Optimize your ad spend and maximize ROI",
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
                child: _buildMetricCard("Active Campaigns", "3", Icons.campaign),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Total Spend", "\$15.2K", Icons.attach_money),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Avg. CPC", "\$2.06", Icons.mouse),
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

  Widget _buildBidStrategySection() {
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
                "Bid Strategy Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Campaign",
            items: campaignOptions,
            value: selectedCampaign,
            onChanged: (value, label) {
              selectedCampaign = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Bid Strategy",
            items: bidStrategies,
            value: selectedBidStrategy,
            onChanged: (value, label) {
              selectedBidStrategy = value;
              setState(() {});
            },
          ),
          if (selectedBidStrategy == "manual" || selectedBidStrategy == "enhanced")
            QNumberField(
              label: "Max CPC Bid (\$)",
              value: maxBid,
              onChanged: (value) {
                maxBid = value;
                setState(() {});
              },
            ),
          if (selectedBidStrategy == "target_cpa")
            QNumberField(
              label: "Target CPA (\$)",
              value: targetCpa,
              onChanged: (value) {
                targetCpa = value;
                setState(() {});
              },
            ),
          if (selectedBidStrategy == "target_roas")
            QNumberField(
              label: "Target ROAS (%)",
              value: targetRoas,
              onChanged: (value) {
                targetRoas = value;
                setState(() {});
              },
            ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Enable Auto-bidding",
                      "value": true,
                      "checked": autoBidding,
                    }
                  ],
                  value: [
                    if (autoBidding)
                      {
                        "label": "Enable Auto-bidding",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoBidding = values.isNotEmpty;
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
                  label: "Apply Changes",
                  size: bs.md,
                  onPressed: () {
                    ss("Bid strategy updated successfully");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reset",
                  size: bs.md,
                  onPressed: () {
                    selectedBidStrategy = "manual";
                    maxBid = "2.50";
                    targetCpa = "25.00";
                    targetRoas = "400";
                    autoBidding = false;
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

  Widget _buildCampaignPerformance() {
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
                Icons.analytics,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Campaign Performance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: campaigns.map((campaign) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: campaign["status"] == "Active" 
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
                            color: campaign["status"] == "Active" 
                                ? successColor 
                                : warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${campaign["status"]}",
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
                          child: _buildPerformanceMetric(
                            "Current Bid", 
                            "\$${(campaign["currentBid"] as double).toStringAsFixed(2)}"
                          ),
                        ),
                        Expanded(
                          child: _buildPerformanceMetric(
                            "Target Bid", 
                            "\$${(campaign["targetBid"] as double).toStringAsFixed(2)}"
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPerformanceMetric(
                            "CTR", 
                            "${(campaign["ctr"] as double).toStringAsFixed(2)}%"
                          ),
                        ),
                        Expanded(
                          child: _buildPerformanceMetric(
                            "CPC", 
                            "\$${(campaign["cpc"] as double).toStringAsFixed(2)}"
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPerformanceMetric(
                            "Conversions", 
                            "${campaign["conversions"]}"
                          ),
                        ),
                        Expanded(
                          child: _buildPerformanceMetric(
                            "CPA", 
                            "\$${(campaign["cpa"] as double).toStringAsFixed(2)}"
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Adjust Bids",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening bid adjustment for ${campaign["name"]}");
                        },
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

  Widget _buildPerformanceMetric(String label, String value) {
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

  Widget _buildBidOptimization() {
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
                Icons.psychology,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "AI Bid Optimization",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "AI Analysis Results",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Based on performance data, we recommend increasing bids by 15% for Summer Sale Campaign to capture more high-intent traffic during peak hours.",
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Accept Recommendation",
                        size: bs.sm,
                        onPressed: () {
                          ss("AI recommendation applied");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Dismiss",
                      size: bs.sm,
                      onPressed: () {
                        si("Recommendation dismissed");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    List<Map<String, dynamic>> recommendations = [
      {
        "title": "Increase Mobile Bids",
        "description": "Mobile traffic shows 23% higher conversion rate",
        "impact": "High",
        "action": "increase_mobile"
      },
      {
        "title": "Reduce Evening Bids",
        "description": "Low performance during 8-11 PM time slot",
        "impact": "Medium",
        "action": "reduce_evening"
      },
      {
        "title": "Pause Low-Performing Keywords",
        "description": "5 keywords with CPA above target by 150%",
        "impact": "High",
        "action": "pause_keywords"
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
                Icons.recommend,
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
          ...recommendations.map((rec) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: rec["impact"] == "High" ? dangerColor : warningColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${rec["title"]}",
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
                          color: rec["impact"] == "High" ? dangerColor : warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${rec["impact"]} Impact",
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
                    "${rec["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Apply",
                          size: bs.sm,
                          onPressed: () {
                            ss("Applied: ${rec["title"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Learn More",
                        size: bs.sm,
                        onPressed: () {
                          si("Opening details for ${rec["title"]}");
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
}
