import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStream8View extends StatefulWidget {
  @override
  State<GrlStream8View> createState() => _GrlStream8ViewState();
}

class _GrlStream8ViewState extends State<GrlStream8View> {
  String selectedPeriod = "Last 30 Days";
  String selectedMetric = "Views";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Views", "value": "Views"},
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Followers", "value": "Followers"},
    {"label": "Watch Time", "value": "Watch Time"},
  ];

  List<Map<String, dynamic>> analyticsCards = [
    {
      "title": "Total Views",
      "value": "2.4M",
      "change": "+12.5%",
      "isPositive": true,
      "icon": Icons.visibility,
      "color": primaryColor,
    },
    {
      "title": "Watch Time",
      "value": "185K hrs",
      "change": "+8.2%",
      "isPositive": true,
      "icon": Icons.access_time,
      "color": successColor,
    },
    {
      "title": "Revenue",
      "value": "\$8,945",
      "change": "+15.7%",
      "isPositive": true,
      "icon": Icons.attach_money,
      "color": warningColor,
    },
    {
      "title": "New Followers",
      "value": "1,234",
      "change": "-2.1%",
      "isPositive": false,
      "icon": Icons.person_add,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> topStreams = [
    {
      "title": "Flutter Development Tutorial",
      "thumbnail": "https://picsum.photos/60/40?random=1001&keyword=flutter",
      "views": 89500,
      "revenue": 450.25,
      "duration": "3:45:20",
      "date": "March 15, 2024",
    },
    {
      "title": "React Hooks Deep Dive",
      "thumbnail": "https://picsum.photos/60/40?random=1002&keyword=react",
      "views": 67800,
      "revenue": 340.80,
      "duration": "2:30:15",
      "date": "March 12, 2024",
    },
    {
      "title": "Node.js API Development",
      "thumbnail": "https://picsum.photos/60/40?random=1003&keyword=nodejs",
      "views": 45200,
      "revenue": 225.60,
      "duration": "2:15:45",
      "date": "March 10, 2024",
    },
    {
      "title": "Database Design Principles",
      "thumbnail": "https://picsum.photos/60/40?random=1004&keyword=database",
      "views": 38900,
      "revenue": 195.40,
      "duration": "1:55:30",
      "date": "March 8, 2024",
    },
  ];

  List<Map<String, dynamic>> revenueBreakdown = [
    {"source": "Super Chat", "amount": 3420.50, "percentage": 38.2},
    {"source": "Channel Memberships", "amount": 2680.30, "percentage": 30.0},
    {"source": "Ad Revenue", "amount": 1890.75, "percentage": 21.1},
    {"source": "Donations", "amount": 954.20, "percentage": 10.7},
  ];

  List<Map<String, dynamic>> audienceData = [
    {"country": "United States", "percentage": 45.2, "flag": "🇺🇸"},
    {"country": "United Kingdom", "percentage": 12.8, "flag": "🇬🇧"},
    {"country": "Canada", "percentage": 8.5, "flag": "🇨🇦"},
    {"country": "Australia", "percentage": 6.3, "flag": "🇦🇺"},
    {"country": "Germany", "percentage": 4.8, "flag": "🇩🇪"},
    {"country": "Others", "percentage": 22.4, "flag": "🌍"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Analytics"),
        actions: [
          Icon(Icons.download, size: 24),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period and Metric Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Period",
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
                    label: "Metric",
                    items: metricOptions,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Analytics Cards
            Text(
              "Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: analyticsCards.map((card) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
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
                              color: (card["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              card["icon"] as IconData,
                              color: card["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (card["isPositive"] as bool) 
                                  ? successColor.withAlpha(51) 
                                  : dangerColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${card["change"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: (card["isPositive"] as bool) ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${card["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${card["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: card["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Performance Chart Placeholder
            Text(
              "Performance Trend",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    color: primaryColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$selectedMetric Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Interactive chart for $selectedPeriod",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Top Performing Streams
            Text(
              "Top Performing Streams",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: topStreams.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> stream = entry.value;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index < topStreams.length - 1 
                          ? Border(bottom: BorderSide(color: disabledOutlineBorderColor))
                          : null,
                    ),
                    child: Row(
                      children: [
                        // Rank
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: index < 3 ? primaryColor : disabledColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),

                        // Thumbnail
                        Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusXs),
                            image: DecorationImage(
                              image: NetworkImage("${stream["thumbnail"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),

                        // Stream Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${stream["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${((stream["views"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.attach_money,
                                    size: 12,
                                    color: warningColor,
                                  ),
                                  Text(
                                    "\$${(stream["revenue"] as double).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Text(
                          "${stream["duration"]}",
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
            ),
            SizedBox(height: spMd),

            // Revenue Breakdown
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Revenue Sources",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),

                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: revenueBreakdown.map((source) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
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
                                            widthFactor: (source["percentage"] as double) / 100,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\$${(source["amount"] as double).toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${(source["percentage"] as double).toStringAsFixed(1)}%",
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
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),

                // Audience Geography
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Audience Geography",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),

                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: audienceData.map((country) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              child: Row(
                                children: [
                                  Text(
                                    "${country["flag"]}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${country["country"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
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
                                            widthFactor: (country["percentage"] as double) / 100,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: infoColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${(country["percentage"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
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
    );
  }
}
