import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics9View extends StatefulWidget {
  @override
  State<GrlAnalytics9View> createState() => _GrlAnalytics9ViewState();
}

class _GrlAnalytics9ViewState extends State<GrlAnalytics9View> {
  String selectedSource = "all";
  String selectedTimeframe = "week";

  List<Map<String, dynamic>> sources = [
    {"label": "All Sources", "value": "all"},
    {"label": "Organic Search", "value": "organic"},
    {"label": "Direct Traffic", "value": "direct"},
    {"label": "Social Media", "value": "social"},
    {"label": "Email", "value": "email"},
    {"label": "Paid Ads", "value": "paid"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 90 Days", "value": "90days"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> webMetrics = [
    {
      "title": "Total Visitors",
      "value": 125400,
      "change": 18.5,
      "icon": Icons.people,
      "color": Colors.blue
    },
    {
      "title": "Page Views",
      "value": 456800,
      "change": 12.3,
      "icon": Icons.visibility,
      "color": Colors.green
    },
    {
      "title": "Bounce Rate",
      "value": 34.2,
      "change": -8.7,
      "icon": Icons.exit_to_app,
      "color": Colors.orange
    },
    {
      "title": "Avg Session Duration",
      "value": 245.6,
      "change": 15.8,
      "icon": Icons.schedule,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> topPages = [
    {
      "page": "/home",
      "title": "Homepage",
      "views": 89450,
      "unique_visitors": 67800,
      "bounce_rate": 28.5,
      "avg_time": 185.4
    },
    {
      "page": "/products",
      "title": "Products Page",
      "views": 56230,
      "unique_visitors": 45600,
      "bounce_rate": 35.2,
      "avg_time": 298.7
    },
    {
      "page": "/about",
      "title": "About Us",
      "views": 34560,
      "unique_visitors": 28900,
      "bounce_rate": 42.1,
      "avg_time": 156.3
    },
    {
      "page": "/contact",
      "title": "Contact Page",
      "views": 28900,
      "unique_visitors": 24500,
      "bounce_rate": 31.8,
      "avg_time": 123.5
    },
    {
      "page": "/blog",
      "title": "Blog",
      "views": 23400,
      "unique_visitors": 19800,
      "bounce_rate": 38.7,
      "avg_time": 245.9
    },
  ];

  List<Map<String, dynamic>> trafficSources = [
    {
      "source": "Organic Search",
      "visitors": 45600,
      "percentage": 36.4,
      "bounce_rate": 32.1,
      "conversion": 3.8,
      "color": Colors.green
    },
    {
      "source": "Direct Traffic",
      "visitors": 34200,
      "percentage": 27.3,
      "bounce_rate": 28.5,
      "conversion": 4.2,
      "color": Colors.blue
    },
    {
      "source": "Social Media",
      "visitors": 23800,
      "percentage": 19.0,
      "bounce_rate": 45.6,
      "conversion": 2.1,
      "color": Colors.purple
    },
    {
      "source": "Email Campaigns",
      "visitors": 12900,
      "percentage": 10.3,
      "bounce_rate": 25.8,
      "conversion": 5.6,
      "color": Colors.orange
    },
    {
      "source": "Paid Advertising",
      "visitors": 8900,
      "percentage": 7.1,
      "bounce_rate": 38.2,
      "conversion": 3.4,
      "color": Colors.red
    },
  ];

  List<Map<String, dynamic>> deviceData = [
    {
      "device": "Desktop",
      "users": 67800,
      "percentage": 54.1,
      "bounce_rate": 31.2,
      "pages_per_session": 4.8,
      "icon": Icons.computer
    },
    {
      "device": "Mobile",
      "users": 45600,
      "percentage": 36.4,
      "bounce_rate": 38.7,
      "pages_per_session": 3.2,
      "icon": Icons.phone_android
    },
    {
      "device": "Tablet",
      "users": 12000,
      "percentage": 9.6,
      "bounce_rate": 35.4,
      "pages_per_session": 3.9,
      "icon": Icons.tablet
    },
  ];

  List<Map<String, dynamic>> conversionFunnels = [
    {
      "step": "Homepage Visit",
      "users": 125400,
      "percentage": 100.0,
      "drop_off": 0.0
    },
    {
      "step": "Product Page View",
      "users": 78900,
      "percentage": 62.9,
      "drop_off": 37.1
    },
    {
      "step": "Add to Cart",
      "users": 23400,
      "percentage": 18.7,
      "drop_off": 44.2
    },
    {
      "step": "Checkout Started",
      "users": 15600,
      "percentage": 12.4,
      "drop_off": 6.3
    },
    {
      "step": "Purchase Completed",
      "users": 8900,
      "percentage": 7.1,
      "drop_off": 5.3
    },
  ];

  List<Map<String, dynamic>> geographicData = [
    {
      "country": "United States",
      "users": 56800,
      "percentage": 45.3,
      "bounce_rate": 32.1,
      "flag": "🇺🇸"
    },
    {
      "country": "United Kingdom",
      "users": 23400,
      "percentage": 18.7,
      "bounce_rate": 35.6,
      "flag": "🇬🇧"
    },
    {
      "country": "Canada",
      "users": 15600,
      "percentage": 12.4,
      "bounce_rate": 29.8,
      "flag": "🇨🇦"
    },
    {
      "country": "Australia",
      "users": 12300,
      "percentage": 9.8,
      "bounce_rate": 31.2,
      "flag": "🇦🇺"
    },
    {
      "country": "Germany",
      "users": 8900,
      "percentage": 7.1,
      "bounce_rate": 33.4,
      "flag": "🇩🇪"
    },
    {
      "country": "France",
      "users": 5600,
      "percentage": 4.5,
      "bounce_rate": 36.8,
      "flag": "🇫🇷"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Website Analytics"),
        actions: [
          Icon(Icons.web),
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
                    label: "Traffic Source",
                    items: sources,
                    value: selectedSource,
                    onChanged: (value, label) {
                      selectedSource = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframes,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: webMetrics.map((metric) {
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
                        metric["title"] == "Bounce Rate"
                            ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                            : metric["title"] == "Avg Session Duration"
                            ? "${((metric["value"] as double) / 60).toStringAsFixed(1)}m"
                            : "${((metric["value"] as int) / 1000).toStringAsFixed(0)}K",
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
                    "Top Pages",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...topPages.map((page) {
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${page["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${page["page"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${((page["views"] as int) / 1000).toStringAsFixed(0)}K views",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
                                      "Unique Visitors",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${((page["unique_visitors"] as int) / 1000).toStringAsFixed(0)}K",
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
                                      "Bounce Rate",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(page["bounce_rate"] as double).toStringAsFixed(1)}%",
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
                                      "Avg Time",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${((page["avg_time"] as double) / 60).toStringAsFixed(1)}m",
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
                    "Traffic Sources",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...trafficSources.map((source) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (source["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: source["color"] as Color,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${source["source"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${(source["percentage"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: source["color"] as Color,
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
                                      "Visitors",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${((source["visitors"] as int) / 1000).toStringAsFixed(0)}K",
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
                                      "Bounce Rate",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(source["bounce_rate"] as double).toStringAsFixed(1)}%",
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
                                      "${(source["conversion"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
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

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
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
                          "Device Usage",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...deviceData.map((device) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Row(
                              children: [
                                Icon(
                                  device["icon"] as IconData,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${device["device"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${((device["users"] as int) / 1000).toStringAsFixed(0)}K users",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${(device["percentage"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                          "Geographic Data",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...geographicData.map((geo) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Row(
                              children: [
                                Text(
                                  "${geo["flag"]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${geo["country"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${((geo["users"] as int) / 1000).toStringAsFixed(0)}K users",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${(geo["percentage"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
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
                    "Conversion Funnel",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...conversionFunnels.map((funnel) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${funnel["step"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${((funnel["users"] as int) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${(funnel["percentage"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if ((funnel["drop_off"] as double) > 0) ...[
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Text(
                                  "${(funnel["drop_off"] as double).toStringAsFixed(1)}% drop-off",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
