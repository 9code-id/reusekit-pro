import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStats10View extends StatefulWidget {
  @override
  State<GrlStats10View> createState() => _GrlStats10ViewState();
}

class _GrlStats10ViewState extends State<GrlStats10View> {
  String selectedCampaign = "all";
  String selectedChannel = "all";
  
  List<Map<String, dynamic>> campaignItems = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Summer Sale 2024", "value": "summer2024"},
    {"label": "Black Friday", "value": "blackfriday"},
    {"label": "Product Launch", "value": "productlaunch"},
  ];

  List<Map<String, dynamic>> channelItems = [
    {"label": "All Channels", "value": "all"},
    {"label": "Social Media", "value": "social"},
    {"label": "Email Marketing", "value": "email"},
    {"label": "Paid Ads", "value": "ads"},
    {"label": "Content Marketing", "value": "content"},
  ];

  List<Map<String, dynamic>> get marketingMetrics => [
    {
      "title": "Campaign ROI",
      "value": "245%",
      "trend": "+18.5%",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Lead Generation",
      "value": "3,247",
      "trend": "+24.7%",
      "icon": Icons.person_add,
      "color": primaryColor,
    },
    {
      "title": "Conversion Rate",
      "value": "4.8%",
      "trend": "+1.2%",
      "icon": Icons.transform,
      "color": infoColor,
    },
    {
      "title": "Cost Per Lead",
      "value": "\$42",
      "trend": "-8.3%",
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "title": "Email Open Rate",
      "value": "28.5%",
      "trend": "+3.1%",
      "icon": Icons.email,
      "color": warningColor,
    },
    {
      "title": "Social Engagement",
      "value": "12.4K",
      "trend": "+15.6%",
      "icon": Icons.favorite,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> get activeCampaigns => [
    {
      "name": "Summer Sale 2024",
      "type": "Seasonal Promotion",
      "budget": 45000,
      "spent": 32100,
      "leads": 1245,
      "conversions": 187,
      "roi": 278,
      "status": "Active",
      "daysLeft": 12,
      "channels": ["Social", "Email", "Ads"],
    },
    {
      "name": "Black Friday Campaign",
      "type": "Holiday Sale",
      "budget": 75000,
      "spent": 28400,
      "leads": 892,
      "conversions": 124,
      "roi": 198,
      "status": "Planning",
      "daysLeft": 85,
      "channels": ["All Channels"],
    },
    {
      "name": "Product Launch - Pro",
      "type": "Product Introduction",
      "budget": 35000,
      "spent": 31800,
      "leads": 567,
      "conversions": 89,
      "roi": 156,
      "status": "Active",
      "daysLeft": 6,
      "channels": ["Content", "Social"],
    },
    {
      "name": "Email Nurture Series",
      "type": "Lead Nurturing",
      "budget": 15000,
      "spent": 12300,
      "leads": 2145,
      "conversions": 234,
      "roi": 312,
      "status": "Active",
      "daysLeft": 28,
      "channels": ["Email"],
    },
  ];

  List<Map<String, dynamic>> get channelPerformance => [
    {
      "channel": "Social Media",
      "impressions": 1250000,
      "clicks": 18750,
      "ctr": 1.5,
      "cost": 12500,
      "conversions": 234,
      "cpc": 0.67,
      "color": primaryColor,
      "icon": Icons.share,
    },
    {
      "channel": "Email Marketing",
      "impressions": 85000,
      "clicks": 8920,
      "ctr": 10.5,
      "cost": 3400,
      "conversions": 456,
      "cpc": 0.38,
      "color": successColor,
      "icon": Icons.email,
    },
    {
      "channel": "Paid Advertising",
      "impressions": 890000,
      "clicks": 12650,
      "ctr": 1.42,
      "cost": 18900,
      "conversions": 189,
      "cpc": 1.49,
      "color": warningColor,
      "icon": Icons.ads_click,
    },
    {
      "channel": "Content Marketing",
      "impressions": 234000,
      "clicks": 5680,
      "ctr": 2.43,
      "cost": 8500,
      "conversions": 123,
      "cpc": 1.50,
      "color": infoColor,
      "icon": Icons.article,
    },
  ];

  Color _getCampaignStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Planning":
        return infoColor;
      case "Paused":
        return warningColor;
      case "Completed":
        return disabledBoldColor;
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
          IconButton(
            icon: Icon(Icons.campaign),
            onPressed: () {
              ss("Campaign manager opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Campaign",
                    items: campaignItems,
                    value: selectedCampaign,
                    onChanged: (value, label) {
                      selectedCampaign = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Channel",
                    items: channelItems,
                    value: selectedChannel,
                    onChanged: (value, label) {
                      selectedChannel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Marketing Metrics
            ResponsiveGridView(
              minItemWidth: 200,
              children: marketingMetrics.map((metric) {
                bool isPositive = !(metric["trend"] as String).startsWith('-') || 
                                 (metric["title"] == "Cost Per Lead" && (metric["trend"] as String).startsWith('-'));
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
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: isPositive ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                  color: isPositive ? successColor : dangerColor,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${metric["trend"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isPositive ? successColor : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Active Campaigns
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Active Campaigns",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: activeCampaigns.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final campaign = activeCampaigns[index];
                      Color statusColor = _getCampaignStatusColor(campaign["status"] as String);
                      return Padding(
                        padding: EdgeInsets.all(spMd),
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
                                        "${campaign["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${campaign["type"]}",
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
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: statusColor.withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${campaign["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: statusColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${campaign["daysLeft"]} days left",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
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
                                        "Budget Usage",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "\$${((campaign["spent"] as int).toDouble() / 1000).toStringAsFixed(1)}K / \$${((campaign["budget"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: disabledColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (campaign["spent"] as int) / (campaign["budget"] as int),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: (campaign["spent"] as int) / (campaign["budget"] as int) > 0.8 
                                                ? dangerColor 
                                                : (campaign["spent"] as int) / (campaign["budget"] as int) > 0.6 
                                                  ? warningColor 
                                                  : successColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spLg),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Performance",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Text(
                                            "${campaign["leads"]} leads • ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "${campaign["conversions"]} conv",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "ROI: ${campaign["roi"]}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Wrap(
                              spacing: spXs,
                              children: (campaign["channels"] as List<String>).map((channel) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    channel,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Channel Performance
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Channel Performance",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: channelPerformance.map((channel) {
                      return Container(
                        margin: EdgeInsets.only(left: spMd, right: spMd, bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(13),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
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
                                    channel["icon"] as IconData,
                                    color: channel["color"] as Color,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${channel["channel"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${((channel["cost"] as int).toDouble() / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
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
                                        "Impressions",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${((channel["impressions"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                        "Clicks",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${((channel["clicks"] as int).toDouble() / 1000).toStringAsFixed(1)}K",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                        "CTR",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${channel["ctr"]}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
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
                                        "Conversions",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${channel["conversions"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (channel["ctr"] as double) / 15,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: channel["color"] as Color,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "CPC: \$${channel["cpc"]}",
                                  style: TextStyle(
                                    fontSize: 10,
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
                  SizedBox(height: spMd),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Create Campaign",
                    icon: Icons.add_circle,
                    size: bs.md,
                    onPressed: () {
                      ss("New campaign created");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      ss("Marketing report exported");
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
}
