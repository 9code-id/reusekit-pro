import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaLocalNewsView extends StatefulWidget {
  const NmaLocalNewsView({super.key});

  @override
  State<NmaLocalNewsView> createState() => _NmaLocalNewsViewState();
}

class _NmaLocalNewsViewState extends State<NmaLocalNewsView> {
  String selectedCategory = "All";
  String selectedCity = "New York";
  
  List<Map<String, dynamic>> localNews = [
    {
      "id": 1,
      "title": "New Community Center Opens Downtown",
      "summary": "Mayor announces grand opening of state-of-the-art facility",
      "category": "Community",
      "imageUrl": "https://picsum.photos/300/200?random=1&keyword=community",
      "timestamp": "2 hours ago",
      "source": "Local News Network",
      "priority": "High",
      "author": "Sarah Johnson",
      "readTime": "3 min read",
      "comments": 45,
      "likes": 123,
      "location": "Downtown District"
    },
    {
      "id": 2,
      "title": "Local School District Wins State Award",
      "summary": "Recognition for innovative STEM education programs",
      "category": "Education",
      "imageUrl": "https://picsum.photos/300/200?random=2&keyword=school",
      "timestamp": "4 hours ago",
      "source": "Education Today",
      "priority": "Medium",
      "author": "Michael Chen",
      "readTime": "2 min read",
      "comments": 32,
      "likes": 89,
      "location": "Central School District"
    },
    {
      "id": 3,
      "title": "Road Construction Begins on Main Street",
      "summary": "Traffic detours in effect for next 3 months",
      "category": "Traffic",
      "imageUrl": "https://picsum.photos/300/200?random=3&keyword=construction",
      "timestamp": "6 hours ago",
      "source": "City Transportation",
      "priority": "High",
      "author": "Lisa Rodriguez",
      "readTime": "1 min read",
      "comments": 78,
      "likes": 34,
      "location": "Main Street Corridor"
    },
    {
      "id": 4,
      "title": "Annual Food Festival This Weekend",
      "summary": "50+ local vendors to showcase regional cuisine",
      "category": "Events",
      "imageUrl": "https://picsum.photos/300/200?random=4&keyword=food",
      "timestamp": "8 hours ago",
      "source": "Events Calendar",
      "priority": "Medium",
      "author": "David Park",
      "readTime": "2 min read",
      "comments": 156,
      "likes": 287,
      "location": "City Park"
    },
    {
      "id": 5,
      "title": "Local Business Receives Environmental Award",
      "summary": "Green practices recognized by state committee",
      "category": "Business",
      "imageUrl": "https://picsum.photos/300/200?random=5&keyword=environment",
      "timestamp": "10 hours ago",
      "source": "Business Weekly",
      "priority": "Low",
      "author": "Emily Watson",
      "readTime": "3 min read",
      "comments": 23,
      "likes": 67,
      "location": "Industrial District"
    },
    {
      "id": 6,
      "title": "Weather Alert: Heavy Rain Expected",
      "summary": "Flooding possible in low-lying areas",
      "category": "Weather",
      "imageUrl": "https://picsum.photos/300/200?random=6&keyword=rain",
      "timestamp": "12 hours ago",
      "source": "Weather Service",
      "priority": "High",
      "author": "Tom Wilson",
      "readTime": "1 min read",
      "comments": 89,
      "likes": 45,
      "location": "Citywide"
    }
  ];

  List<Map<String, dynamic>> breakingNews = [
    {
      "title": "City Council Emergency Meeting Called",
      "time": "30 min ago",
      "urgency": "Breaking"
    },
    {
      "title": "Local Hospital Receives Major Donation",
      "time": "1 hour ago",
      "urgency": "Developing"
    },
    {
      "title": "New Public Transit Route Announced",
      "time": "2 hours ago",
      "urgency": "Update"
    }
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "type": "Flood Warning",
      "severity": "High",
      "area": "Downtown & Riverside",
      "expires": "6:00 PM Today"
    },
    {
      "type": "Traffic Advisory",
      "severity": "Medium", 
      "area": "Highway 101",
      "expires": "Tomorrow 8:00 AM"
    }
  ];

  List<Map<String, dynamic>> localEvents = [
    {
      "name": "Farmers Market",
      "date": "Saturday 8:00 AM",
      "location": "Town Square",
      "category": "Community"
    },
    {
      "name": "City Council Meeting",
      "date": "Monday 7:00 PM",
      "location": "City Hall",
      "category": "Government"
    },
    {
      "name": "Youth Soccer Tournament",
      "date": "Sunday 10:00 AM",
      "location": "Sports Complex",
      "category": "Sports"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local News"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Navigate to location settings
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // City Selection
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_city, color: primaryColor),
                  SizedBox(width: spSm),
                  Text(
                    "Current Location: ${selectedCity}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Change",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to location picker
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Breaking News Banner
            if (breakingNews.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: dangerColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.emergency, color: dangerColor),
                        SizedBox(width: spSm),
                        Text(
                          "Breaking News",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...breakingNews.map((news) => Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getUrgencyColor(news["urgency"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${news["urgency"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${news["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "${news["time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
              SizedBox(height: spMd),
            ],
            
            // Weather Alerts
            if (weatherAlerts.isNotEmpty) ...[
              Text(
                "Weather & Traffic Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...weatherAlerts.map((alert) => Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getSeverityColor(alert["severity"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: _getSeverityColor(alert["severity"]).withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getAlertIcon(alert["type"]),
                      color: _getSeverityColor(alert["severity"]),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${alert["type"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _getSeverityColor(alert["severity"]),
                            ),
                          ),
                          Text(
                            "${alert["area"]}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Expires: ${alert["expires"]}",
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
              )).toList(),
              SizedBox(height: spMd),
            ],
            
            // Category Filter
            QCategoryPicker(
              items: [
                {"label": "All", "value": "All"},
                {"label": "Community", "value": "Community"},
                {"label": "Education", "value": "Education"},
                {"label": "Traffic", "value": "Traffic"},
                {"label": "Events", "value": "Events"},
                {"label": "Business", "value": "Business"},
                {"label": "Weather", "value": "Weather"},
              ],
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Local News Stories
            Text(
              "Local Stories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: localNews.where((news) => 
                selectedCategory == "All" || news["category"] == selectedCategory
              ).map((news) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      child: Image.network(
                        "${news["imageUrl"]}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(news["category"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${news["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(news["priority"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${news["priority"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${news["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${news["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${news["summary"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Text(
                                "By ${news["author"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${news["readTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${news["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.favorite_border, size: 16, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${(news["likes"] as int)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: spSm),
                              Row(
                                children: [
                                  Icon(Icons.comment_outlined, size: 16, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${(news["comments"] as int)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  QButton(
                                    icon: Icons.share,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Share news
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.bookmark_border,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Bookmark news
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Upcoming Local Events
            Text(
              "Upcoming Local Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: localEvents.map((event) => Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(event["category"]).withAlpha(100),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        _getEventIcon(event["category"]),
                        color: _getCategoryColor(event["category"]),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${event["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${event["date"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${event["location"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.arrow_forward,
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to event details
                      },
                    ),
                  ],
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "Breaking":
        return dangerColor;
      case "Developing":
        return warningColor;
      case "Update":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getAlertIcon(String type) {
    switch (type) {
      case "Flood Warning":
        return Icons.water;
      case "Traffic Advisory":
        return Icons.traffic;
      default:
        return Icons.warning;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Community":
        return primaryColor;
      case "Education":
        return infoColor;
      case "Traffic":
        return warningColor;
      case "Events":
        return successColor;
      case "Business":
        return secondaryColor;
      case "Weather":
        return infoColor;
      case "Government":
        return primaryColor;
      case "Sports":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  IconData _getEventIcon(String category) {
    switch (category) {
      case "Community":
        return Icons.people;
      case "Government":
        return Icons.account_balance;
      case "Sports":
        return Icons.sports_soccer;
      default:
        return Icons.event;
    }
  }
}
