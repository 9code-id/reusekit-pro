import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics2View extends StatefulWidget {
  @override
  State<GrlAnalytics2View> createState() => _GrlAnalytics2ViewState();
}

class _GrlAnalytics2ViewState extends State<GrlAnalytics2View> {
  int currentTab = 0;
  String selectedRegion = "all";

  List<Map<String, dynamic>> regions = [
    {"label": "All Regions", "value": "all"},
    {"label": "North America", "value": "na"},
    {"label": "Europe", "value": "eu"},
    {"label": "Asia Pacific", "value": "ap"},
  ];

  List<Map<String, dynamic>> userStats = [
    {
      "title": "Total Users",
      "value": 45230,
      "change": 18.2,
      "icon": Icons.people,
      "color": Colors.blue
    },
    {
      "title": "Active Users",
      "value": 32450,
      "change": 12.8,
      "icon": Icons.person,
      "color": Colors.green
    },
    {
      "title": "New Signups",
      "value": 1250,
      "change": -5.2,
      "icon": Icons.person_add,
      "color": Colors.orange
    },
    {
      "title": "Retention Rate",
      "value": 78.5,
      "change": 4.1,
      "icon": Icons.repeat,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> demographics = [
    {
      "age_group": "18-24",
      "percentage": 28.5,
      "count": 12890,
      "color": Colors.blue
    },
    {
      "age_group": "25-34",
      "percentage": 35.2,
      "count": 15920,
      "color": Colors.green
    },
    {
      "age_group": "35-44",
      "percentage": 22.8,
      "count": 10310,
      "color": Colors.orange
    },
    {
      "age_group": "45-54",
      "percentage": 9.5,
      "count": 4300,
      "color": Colors.purple
    },
    {
      "age_group": "55+",
      "percentage": 4.0,
      "count": 1810,
      "color": Colors.red
    },
  ];

  List<Map<String, dynamic>> deviceTypes = [
    {
      "device": "Mobile",
      "users": 28340,
      "percentage": 62.7,
      "icon": Icons.phone_android
    },
    {
      "device": "Desktop",
      "users": 12890,
      "percentage": 28.5,
      "icon": Icons.computer
    },
    {
      "device": "Tablet",
      "users": 3980,
      "percentage": 8.8,
      "icon": Icons.tablet
    },
  ];

  List<Map<String, dynamic>> trafficSources = [
    {
      "source": "Organic Search",
      "users": 18450,
      "percentage": 40.8,
      "color": Colors.green
    },
    {
      "source": "Direct",
      "users": 12330,
      "percentage": 27.3,
      "color": Colors.blue
    },
    {
      "source": "Social Media",
      "users": 8920,
      "percentage": 19.7,
      "color": Colors.purple
    },
    {
      "source": "Paid Ads",
      "users": 3850,
      "percentage": 8.5,
      "color": Colors.orange
    },
    {
      "source": "Email",
      "users": 1680,
      "percentage": 3.7,
      "color": Colors.red
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "User Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Demographics", icon: Icon(Icons.bar_chart)),
        Tab(text: "Traffic", icon: Icon(Icons.timeline)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDemographicsTab(),
        _buildTrafficTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          QDropdownField(
            label: "Region",
            items: regions,
            value: selectedRegion,
            onChanged: (value, label) {
              selectedRegion = value;
              setState(() {});
            },
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: userStats.map((stat) {
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
                            color: (stat["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            stat["icon"] as IconData,
                            color: stat["color"] as Color,
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
                            color: (stat["change"] as double) >= 0
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(stat["change"] as double) >= 0 ? '+' : ''}${(stat["change"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              color: (stat["change"] as double) >= 0
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
                      "${stat["title"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      stat["title"] == "Retention Rate"
                          ? "${(stat["value"] as double).toStringAsFixed(1)}%"
                          : "${(stat["value"] as int).toString()}",
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
                  "Device Usage",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...deviceTypes.map((device) {
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
                                "${(device["users"] as int)} users",
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
        ],
      ),
    );
  }

  Widget _buildDemographicsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
                  "Age Demographics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...demographics.map((demo) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${demo["age_group"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(demo["percentage"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: demo["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 
                                    (demo["percentage"] as double) / 100 * 0.6,
                                decoration: BoxDecoration(
                                  color: demo["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${(demo["count"] as int)} users",
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
          ),
        ],
      ),
    );
  }

  Widget _buildTrafficTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${source["source"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${(source["users"] as int)} users",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${(source["percentage"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: source["color"] as Color,
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
      ),
    );
  }
}
