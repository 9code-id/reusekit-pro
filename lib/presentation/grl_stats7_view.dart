import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStats7View extends StatefulWidget {
  @override
  State<GrlStats7View> createState() => _GrlStats7ViewState();
}

class _GrlStats7ViewState extends State<GrlStats7View> {
  String selectedPeriod = "month";
  String selectedSource = "all";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 7 Days", "value": "week"},
    {"label": "Last 30 Days", "value": "month"},
    {"label": "Last 90 Days", "value": "quarter"},
  ];

  List<Map<String, dynamic>> sourceItems = [
    {"label": "All Sources", "value": "all"},
    {"label": "Organic Search", "value": "organic"},
    {"label": "Direct Traffic", "value": "direct"},
    {"label": "Social Media", "value": "social"},
    {"label": "Paid Ads", "value": "paid"},
  ];

  List<Map<String, dynamic>> get webMetrics => [
    {
      "title": "Total Visitors",
      "value": "45.2K",
      "trend": "+12.5%",
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Page Views",
      "value": "128.7K",
      "trend": "+8.3%",
      "icon": Icons.visibility,
      "color": infoColor,
    },
    {
      "title": "Bounce Rate",
      "value": "32.4%",
      "trend": "-5.2%",
      "icon": Icons.exit_to_app,
      "color": successColor,
    },
    {
      "title": "Avg Session",
      "value": "4m 23s",
      "trend": "+15.7%",
      "icon": Icons.schedule,
      "color": warningColor,
    },
    {
      "title": "Conversion Rate",
      "value": "3.8%",
      "trend": "+2.1%",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Revenue",
      "value": "\$87.5K",
      "trend": "+18.9%",
      "icon": Icons.monetization_on,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> get trafficSources => [
    {
      "source": "Organic Search",
      "visitors": 18450,
      "percentage": 41.2,
      "growth": 15.3,
      "color": successColor,
      "icon": Icons.search,
    },
    {
      "source": "Direct Traffic",
      "visitors": 12680,
      "percentage": 28.4,
      "growth": 8.7,
      "color": primaryColor,
      "icon": Icons.link,
    },
    {
      "source": "Social Media",
      "visitors": 8920,
      "percentage": 20.0,
      "growth": 22.1,
      "color": infoColor,
      "icon": Icons.share,
    },
    {
      "source": "Paid Advertising",
      "visitors": 4650,
      "percentage": 10.4,
      "growth": 5.2,
      "color": warningColor,
      "icon": Icons.ads_click,
    },
  ];

  List<Map<String, dynamic>> get topPages => [
    {
      "page": "/home",
      "title": "Homepage",
      "views": 25680,
      "uniqueViews": 18420,
      "avgTime": "2m 45s",
      "bounceRate": 28.5,
    },
    {
      "page": "/products",
      "title": "Product Catalog",
      "views": 18920,
      "uniqueViews": 14650,
      "avgTime": "5m 12s",
      "bounceRate": 22.1,
    },
    {
      "page": "/about",
      "title": "About Us",
      "views": 12340,
      "uniqueViews": 9870,
      "avgTime": "3m 28s",
      "bounceRate": 35.7,
    },
    {
      "page": "/contact",
      "title": "Contact",
      "views": 8560,
      "uniqueViews": 7120,
      "avgTime": "1m 52s",
      "bounceRate": 42.3,
    },
    {
      "page": "/blog",
      "title": "Blog Posts",
      "views": 6780,
      "uniqueViews": 5240,
      "avgTime": "6m 35s",
      "bounceRate": 18.9,
    },
  ];

  List<Map<String, dynamic>> get deviceStats => [
    {
      "device": "Desktop",
      "visitors": 22650,
      "percentage": 50.8,
      "sessions": "4m 45s",
      "conversion": 4.2,
    },
    {
      "device": "Mobile",
      "visitors": 18920,
      "percentage": 42.4,
      "sessions": "3m 18s",
      "conversion": 3.1,
    },
    {
      "device": "Tablet",
      "visitors": 3030,
      "percentage": 6.8,
      "sessions": "5m 12s",
      "conversion": 3.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Website Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Analytics data refreshed");
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
                    label: "Period",
                    items: periodItems,
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
                    label: "Traffic Source",
                    items: sourceItems,
                    value: selectedSource,
                    onChanged: (value, label) {
                      selectedSource = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Web Metrics
            ResponsiveGridView(
              minItemWidth: 200,
              children: webMetrics.map((metric) {
                bool isPositive = !(metric["trend"] as String).startsWith('-') || 
                                 (metric["title"] == "Bounce Rate" && (metric["trend"] as String).startsWith('-'));
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

            // Traffic Sources
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
                          "Traffic Sources",
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
                    children: trafficSources.map((source) {
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
                                Icon(
                                  source["icon"] as IconData,
                                  color: source["color"] as Color,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${source["source"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${((source["visitors"] as int).toDouble() / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${source["percentage"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
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
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (source["percentage"] as double) / 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: source["color"] as Color,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "+${source["growth"]}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
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

            // Top Pages
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
                          "Top Pages",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: topPages.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final page = topPages[index];
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
                                        "${page["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${page["page"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${((page["views"] as int).toDouble() / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 18,
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
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.visibility,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${((page["uniqueViews"] as int).toDouble() / 1000).toStringAsFixed(1)}K unique",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${page["avgTime"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (page["bounceRate"] as double) < 30 
                                      ? successColor.withAlpha(51) 
                                      : (page["bounceRate"] as double) < 40 
                                        ? warningColor.withAlpha(51) 
                                        : dangerColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${page["bounceRate"]}% bounce",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: (page["bounceRate"] as double) < 30 
                                        ? successColor 
                                        : (page["bounceRate"] as double) < 40 
                                          ? warningColor 
                                          : dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
            ),

            // Device Statistics
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
                    child: Text(
                      "Device Statistics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Column(
                    children: deviceStats.map((device) {
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
                                Icon(
                                  device["device"] == "Desktop" 
                                    ? Icons.computer 
                                    : device["device"] == "Mobile" 
                                      ? Icons.phone_android 
                                      : Icons.tablet,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${device["device"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${((device["visitors"] as int).toDouble() / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 18,
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
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (device["percentage"] as double) / 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${device["percentage"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Avg Session: ${device["sessions"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Conv: ${device["conversion"]}%",
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
                  SizedBox(height: spMd),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      ss("Analytics report exported");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Setup Goals",
                    icon: Icons.flag,
                    size: bs.md,
                    onPressed: () {
                      ss("Goal setup opened");
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
