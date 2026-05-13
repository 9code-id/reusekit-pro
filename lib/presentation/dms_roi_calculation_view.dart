import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsRoiCalculationView extends StatefulWidget {
  const DmsRoiCalculationView({super.key});

  @override
  State<DmsRoiCalculationView> createState() => _DmsRoiCalculationViewState();
}

class _DmsRoiCalculationViewState extends State<DmsRoiCalculationView> {
  int currentTab = 0;
  String selectedTimeframe = "This Quarter";
  String selectedChannel = "All Channels";
  String selectedCampaign = "All Campaigns";
  bool showCostBreakdown = true;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> channelOptions = [
    {"label": "All Channels", "value": "All Channels"},
    {"label": "Paid Search", "value": "Paid Search"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Email Marketing", "value": "Email Marketing"},
    {"label": "Display Ads", "value": "Display Ads"},
    {"label": "Content Marketing", "value": "Content Marketing"},
  ];

  List<Map<String, dynamic>> campaignOptions = [
    {"label": "All Campaigns", "value": "All Campaigns"},
    {"label": "Summer Sale 2024", "value": "Summer Sale 2024"},
    {"label": "Black Friday", "value": "Black Friday"},
    {"label": "Product Launch", "value": "Product Launch"},
    {"label": "Brand Awareness", "value": "Brand Awareness"},
  ];

  List<Map<String, dynamic>> roiMetrics = [
    {
      "title": "Total ROI",
      "value": 245.8,
      "change": 18.5,
      "icon": Icons.trending_up,
      "color": primaryColor,
      "suffix": "%",
    },
    {
      "title": "Total Revenue",
      "value": 487500,
      "change": 22.3,
      "icon": Icons.attach_money,
      "color": successColor,
      "prefix": "\$",
    },
    {
      "title": "Total Investment",
      "value": 140850,
      "change": 12.7,
      "icon": Icons.payment,
      "color": warningColor,
      "prefix": "\$",
    },
    {
      "title": "Profit Margin",
      "value": 71.1,
      "change": 5.2,
      "icon": Icons.account_balance,
      "color": infoColor,
      "suffix": "%",
    },
  ];

  List<Map<String, dynamic>> channelRoi = [
    {
      "channel": "Email Marketing",
      "investment": 12500,
      "revenue": 89750,
      "roi": 618.0,
      "roas": 7.18,
      "conversions": 1247,
      "cost_per_conversion": 10.02,
      "profit": 77250,
      "color": successColor,
    },
    {
      "channel": "Organic Search",
      "investment": 18750,
      "revenue": 125400,
      "roi": 568.8,
      "roas": 6.69,
      "conversions": 892,
      "cost_per_conversion": 21.02,
      "profit": 106650,
      "color": primaryColor,
    },
    {
      "channel": "Social Media",
      "investment": 25600,
      "revenue": 98750,
      "roi": 285.7,
      "roas": 3.86,
      "conversions": 743,
      "cost_per_conversion": 34.46,
      "profit": 73150,
      "color": infoColor,
    },
    {
      "channel": "Paid Search",
      "investment": 45000,
      "revenue": 134500,
      "roi": 198.9,
      "roas": 2.99,
      "conversions": 1156,
      "cost_per_conversion": 38.93,
      "profit": 89500,
      "color": warningColor,
    },
    {
      "channel": "Display Ads",
      "investment": 32500,
      "revenue": 67250,
      "roi": 106.9,
      "roas": 2.07,
      "conversions": 389,
      "cost_per_conversion": 83.55,
      "profit": 34750,
      "color": dangerColor,
    },
    {
      "channel": "Content Marketing",
      "investment": 6500,
      "revenue": 12850,
      "roi": 97.7,
      "roas": 1.98,
      "conversions": 156,
      "cost_per_conversion": 41.67,
      "profit": 6350,
      "color": disabledBoldColor,
    },
  ];

  List<Map<String, dynamic>> campaignRoi = [
    {
      "campaign": "Summer Sale 2024",
      "channel": "Multi-channel",
      "investment": 45750,
      "revenue": 165400,
      "roi": 261.5,
      "duration": "30 days",
      "start_date": "2024-06-01",
      "end_date": "2024-06-30",
      "conversions": 1876,
      "impression": 2450000,
      "ctr": 3.2,
      "conversion_rate": 7.8,
    },
    {
      "campaign": "Black Friday",
      "channel": "Paid Search + Social",
      "investment": 67500,
      "revenue": 234750,
      "roi": 247.8,
      "duration": "7 days",
      "start_date": "2023-11-24",
      "end_date": "2023-11-30",
      "conversions": 2145,
      "impression": 3120000,
      "ctr": 4.1,
      "conversion_rate": 9.2,
    },
    {
      "campaign": "Product Launch",
      "channel": "Email + Content",
      "investment": 23400,
      "revenue": 78950,
      "roi": 237.4,
      "duration": "45 days",
      "start_date": "2024-03-01",
      "end_date": "2024-04-15",
      "conversions": 567,
      "impression": 890000,
      "ctr": 2.8,
      "conversion_rate": 5.4,
    },
    {
      "campaign": "Brand Awareness",
      "channel": "Display + Social",
      "investment": 34200,
      "revenue": 45600,
      "roi": 33.3,
      "duration": "60 days",
      "start_date": "2024-01-01",
      "end_date": "2024-03-01",
      "conversions": 234,
      "impression": 5670000,
      "ctr": 1.2,
      "conversion_rate": 2.1,
    },
  ];

  List<Map<String, dynamic>> costBreakdown = [
    {
      "category": "Ad Spend",
      "amount": 85600,
      "percentage": 60.8,
      "description": "Direct advertising costs across all channels",
      "color": primaryColor,
    },
    {
      "category": "Content Creation",
      "amount": 18750,
      "percentage": 13.3,
      "description": "Graphics, videos, copywriting, and creative assets",
      "color": infoColor,
    },
    {
      "category": "Marketing Tools",
      "amount": 12400,
      "percentage": 8.8,
      "description": "Software subscriptions and analytics tools",
      "color": warningColor,
    },
    {
      "category": "Staff Costs",
      "amount": 15300,
      "percentage": 10.9,
      "description": "Marketing team salaries and contractor fees",
      "color": successColor,
    },
    {
      "category": "Other Expenses",
      "amount": 8800,
      "percentage": 6.2,
      "description": "Events, training, and miscellaneous costs",
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> roiTrends = [
    {"month": "Jan", "roi": 165.2, "investment": 12500, "revenue": 33150},
    {"month": "Feb", "roi": 198.7, "investment": 14750, "revenue": 44100},
    {"month": "Mar", "roi": 234.1, "investment": 16200, "revenue": 54120},
    {"month": "Apr", "roi": 189.4, "investment": 18900, "revenue": 54700},
    {"month": "May", "roi": 276.8, "investment": 15600, "revenue": 58800},
    {"month": "Jun", "roi": 312.5, "investment": 19200, "revenue": 79200},
  ];

  List<Map<String, dynamic>> profitabilityAnalysis = [
    {
      "metric": "Customer Acquisition Cost (CAC)",
      "value": 45.25,
      "benchmark": 38.50,
      "status": "Above Target",
      "trend": "Increasing",
      "recommendation": "Optimize targeting and creative efficiency",
    },
    {
      "metric": "Customer Lifetime Value (CLV)",
      "value": 287.50,
      "benchmark": 250.00,
      "status": "Above Target",
      "trend": "Stable",
      "recommendation": "Focus on retention and upselling strategies",
    },
    {
      "metric": "CLV/CAC Ratio",
      "value": 6.35,
      "benchmark": 6.49,
      "status": "On Target",
      "trend": "Decreasing",
      "recommendation": "Improve acquisition efficiency or increase CLV",
    },
    {
      "metric": "Payback Period",
      "value": 3.2,
      "benchmark": 2.8,
      "status": "Below Target",
      "trend": "Stable",
      "recommendation": "Accelerate customer activation and engagement",
    },
  ];

  Widget _buildRoiOverviewTab() {
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
                  label: "Channel",
                  items: channelOptions,
                  value: selectedChannel,
                  onChanged: (value, label) {
                    selectedChannel = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // ROI Metrics Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: roiMetrics.map((metric) {
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

          // Channel ROI Performance
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
                  "ROI by Channel",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...channelRoi.map((channel) {
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
                                    "${(channel["roi"] as double).toStringAsFixed(1)}% ROI",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                    "\$${((channel["investment"] as int).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                  Text(
                                    "Investment",
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
                                      fontSize: 14,
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
                                  "ROAS",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(channel["roas"] as double).toStringAsFixed(2)}x",
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
                                  "Conversions",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${channel["conversions"]}",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Profit",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((channel["profit"] as int).toDouble()).currency}",
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

  Widget _buildCampaignRoiTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Campaign Filter
          QDropdownField(
            label: "Campaign",
            items: campaignOptions,
            value: selectedCampaign,
            onChanged: (value, label) {
              selectedCampaign = value;
              setState(() {});
            },
          ),

          // Campaign ROI Cards
          ...campaignRoi.map((campaign) {
            double roiValue = campaign["roi"] as double;
            Color roiColor = roiValue >= 200 ? successColor : roiValue >= 100 ? warningColor : dangerColor;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: roiColor,
                  ),
                ),
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
                            Text(
                              campaign["campaign"] as String,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              campaign["channel"] as String,
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
                          color: roiColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "ROI",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${roiValue.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: roiColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Campaign Details
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Investment",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((campaign["investment"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Revenue",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((campaign["revenue"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Duration",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            campaign["duration"] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Conversions",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${campaign["conversions"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CTR",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(campaign["ctr"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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
                            "${(campaign["conversion_rate"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Campaign Duration
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${campaign["start_date"]} to ${campaign["end_date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildCostAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Toggle Switch
          QSwitch(
            items: [
              {
                "label": "Show Cost Breakdown",
                "value": true,
                "checked": showCostBreakdown,
              }
            ],
            value: [
              if (showCostBreakdown)
                {
                  "label": "Show Cost Breakdown",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              showCostBreakdown = values.isNotEmpty;
              setState(() {});
            },
          ),

          if (showCostBreakdown) ...[
            // Cost Breakdown
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
                    "Cost Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...costBreakdown.map((cost) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (cost["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: cost["color"] as Color,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  cost["category"] as String,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${(cost["percentage"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: cost["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            cost["description"] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "\$${((cost["amount"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: cost["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // ROI Trends
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
                    "ROI Trends",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...roiTrends.map((trend) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            child: Text(
                              trend["month"] as String,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${(trend["roi"] as double).toStringAsFixed(1)}% ROI",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "\$${((trend["investment"] as int).toDouble()).currency} → \$${((trend["revenue"] as int).toDouble()).currency}",
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
                    );
                  }).toList(),
                ],
              ),
            ),

            // Profitability Analysis
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
                    "Profitability Analysis",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...profitabilityAnalysis.map((analysis) {
                    Color statusColor = analysis["status"] == "Above Target"
                        ? successColor
                        : analysis["status"] == "On Target"
                            ? warningColor
                            : dangerColor;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: statusColor,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  analysis["metric"] as String,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  analysis["status"] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
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
                                      "Current",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${analysis["value"]}",
                                      style: TextStyle(
                                        fontSize: 16,
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
                                      "Benchmark",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${analysis["benchmark"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: disabledBoldColor,
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
                                      "Trend",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      analysis["trend"] as String,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: analysis["trend"] == "Increasing"
                                            ? successColor
                                            : analysis["trend"] == "Decreasing"
                                                ? dangerColor
                                                : warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lightbulb,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    analysis["recommendation"] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "ROI Calculator",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.trending_up)),
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Cost Analysis", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildRoiOverviewTab(),
        _buildCampaignRoiTab(),
        _buildCostAnalysisTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
