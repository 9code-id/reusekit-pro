import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerSatisfactionView extends StatefulWidget {
  const FsmCustomerSatisfactionView({super.key});

  @override
  State<FsmCustomerSatisfactionView> createState() => _FsmCustomerSatisfactionViewState();
}

class _FsmCustomerSatisfactionViewState extends State<FsmCustomerSatisfactionView> {
  String selectedPeriod = "Last 30 Days";
  String selectedServiceType = "All Services";
  String selectedRating = "All Ratings";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> serviceTypeItems = [
    {"label": "All Services", "value": "All Services"},
    {"label": "Installation", "value": "Installation"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Repair", "value": "Repair"},
    {"label": "Emergency", "value": "Emergency"},
  ];

  List<Map<String, dynamic>> ratingItems = [
    {"label": "All Ratings", "value": "All Ratings"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4 Stars", "value": "4"},
    {"label": "3 Stars", "value": "3"},
    {"label": "2 Stars", "value": "2"},
    {"label": "1 Star", "value": "1"},
  ];

  List<Map<String, dynamic>> satisfactionMetrics = [
    {
      "metric": "Overall Rating",
      "value": 4.7,
      "target": 4.5,
      "change": 5.2,
      "total": 1248,
      "icon": Icons.star,
      "color": warningColor,
    },
    {
      "metric": "Response Rate",
      "value": 87.3,
      "target": 85.0,
      "change": 3.1,
      "total": 1089,
      "icon": Icons.reply,
      "color": infoColor,
    },
    {
      "metric": "Net Promoter Score",
      "value": 72,
      "target": 70,
      "change": 8.4,
      "total": 1248,
      "icon": Icons.thumb_up,
      "color": successColor,
    },
    {
      "metric": "Resolution Rate",
      "value": 94.2,
      "target": 90.0,
      "change": 2.8,
      "total": 1175,
      "icon": Icons.check_circle,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> ratingDistribution = [
    {"rating": 5, "count": 624, "percentage": 50.0, "color": successColor},
    {"rating": 4, "count": 374, "percentage": 30.0, "color": warningColor},
    {"rating": 3, "count": 125, "percentage": 10.0, "color": infoColor},
    {"rating": 2, "count": 75, "percentage": 6.0, "color": Colors.orange},
    {"rating": 1, "count": 50, "percentage": 4.0, "color": dangerColor},
  ];

  List<Map<String, dynamic>> recentFeedback = [
    {
      "customerName": "John Anderson",
      "service": "HVAC Installation",
      "technician": "Mike Johnson",
      "rating": 5,
      "comment": "Excellent service! Very professional and completed the job ahead of schedule. Highly recommend.",
      "date": "2024-01-15",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=customer",
    },
    {
      "customerName": "Sarah Martinez",
      "service": "Plumbing Repair",
      "technician": "David Brown",
      "rating": 4,
      "comment": "Good work overall. The technician was knowledgeable and fixed the issue quickly.",
      "date": "2024-01-14",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=woman",
    },
    {
      "customerName": "Robert Wilson",
      "service": "Electrical Maintenance",
      "technician": "John Smith",
      "rating": 5,
      "comment": "Outstanding service! Very thorough inspection and explained everything clearly.",
      "date": "2024-01-13",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=client",
    },
    {
      "customerName": "Lisa Thompson",
      "service": "Emergency Repair",
      "technician": "Sarah Wilson",
      "rating": 3,
      "comment": "Service was okay but took longer than expected. Could improve communication.",
      "date": "2024-01-12",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=customer",
    },
  ];

  List<Map<String, dynamic>> serviceRatings = [
    {"service": "Installation", "rating": 4.8, "count": 245, "improvement": 6.2},
    {"service": "Maintenance", "rating": 4.6, "count": 418, "improvement": 3.1},
    {"service": "Repair", "rating": 4.7, "count": 385, "improvement": 4.8},
    {"service": "Emergency", "rating": 4.9, "count": 200, "improvement": 8.9},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Satisfaction"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.filter_list, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Satisfaction Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
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
                          label: "Service Type",
                          items: serviceTypeItems,
                          value: selectedServiceType,
                          onChanged: (value, label) {
                            selectedServiceType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Rating Filter",
                    items: ratingItems,
                    value: selectedRating,
                    onChanged: (value, label) {
                      selectedRating = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Key Metrics
            Text(
              "Satisfaction Metrics",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: satisfactionMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spSm),
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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(25),
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
                              color: (metric["change"] as double) >= 0 ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) >= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["metric"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${metric["value"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if (metric["metric"] == "Overall Rating")
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 12,
                                  color: index < (metric["value"] as double).floor() ? warningColor : disabledColor,
                                );
                              }),
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Based on ${metric["total"]} responses",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Rating Distribution
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.bar_chart, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Rating Distribution",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: ratingDistribution.map((rating) {
                      return Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${rating["rating"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.star, color: warningColor, size: 16),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: (rating["percentage"] as double) / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: rating["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${rating["count"]} (${(rating["percentage"] as double).toStringAsFixed(1)}%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Service Ratings
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.build, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Service Type Ratings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: serviceRatings.map((service) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${service["service"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${service["count"]} reviews",
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
                                Row(
                                  children: [
                                    Text(
                                      "${service["rating"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(Icons.star, color: warningColor, size: 16),
                                  ],
                                ),
                                Text(
                                  "+${(service["improvement"] as double).toStringAsFixed(1)}% improvement",
                                  style: TextStyle(
                                    fontSize: 10,
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
                ],
              ),
            ),

            // Recent Feedback
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.feedback, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Customer Feedback",
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
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: recentFeedback.map((feedback) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage("${feedback["avatar"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${feedback["customerName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${feedback["service"]} • ${feedback["technician"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star,
                                      size: 12,
                                      color: index < (feedback["rating"] as int) ? warningColor : disabledColor,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${feedback["comment"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${feedback["date"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Send Survey",
                    icon: Icons.send,
                    size: bs.md,
                    onPressed: () {},
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
