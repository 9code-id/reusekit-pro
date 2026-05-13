import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome6View extends StatefulWidget {
  @override
  State<GrlHome6View> createState() => _GrlHome6ViewState();
}

class _GrlHome6ViewState extends State<GrlHome6View> {
  String searchQuery = "";
  int selectedCategory = 0;
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All Events", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "Online", "value": "online"},
  ];

  final List<Map<String, dynamic>> upcomingEvents = [
    {
      "id": 1,
      "title": "Tech Conference 2024",
      "subtitle": "The Future of Technology",
      "date": "2024-02-15",
      "time": "09:00 AM",
      "location": "Convention Center",
      "type": "Conference",
      "price": 299.00,
      "image": "https://picsum.photos/300/200?random=1&keyword=conference",
      "attendees": 1245,
      "rating": 4.8,
      "isOnline": false,
      "isFeatured": true,
    },
    {
      "id": 2,
      "title": "Digital Marketing Masterclass",
      "subtitle": "Boost Your Online Presence",
      "date": "2024-02-18",
      "time": "02:00 PM",
      "location": "Online Event",
      "type": "Workshop",
      "price": 149.00,
      "image": "https://picsum.photos/300/200?random=2&keyword=marketing",
      "attendees": 567,
      "rating": 4.9,
      "isOnline": true,
      "isFeatured": false,
    },
    {
      "id": 3,
      "title": "Startup Networking Night",
      "subtitle": "Connect with Entrepreneurs",
      "date": "2024-02-20",
      "time": "06:00 PM",
      "location": "Business Hub",
      "type": "Networking",
      "price": 0.00,
      "image": "https://picsum.photos/300/200?random=3&keyword=networking",
      "attendees": 89,
      "rating": 4.7,
      "isOnline": false,
      "isFeatured": true,
    },
    {
      "id": 4,
      "title": "AI & Machine Learning Summit",
      "subtitle": "Exploring AI Applications",
      "date": "2024-02-25",
      "time": "10:00 AM",
      "location": "Tech Campus",
      "type": "Summit",
      "price": 449.00,
      "image": "https://picsum.photos/300/200?random=4&keyword=artificial-intelligence",
      "attendees": 2134,
      "rating": 4.9,
      "isOnline": false,
      "isFeatured": true,
    },
  ];

  final List<Map<String, dynamic>> eventCategories = [
    {
      "name": "Technology",
      "icon": Icons.computer,
      "color": infoColor,
      "eventCount": 45,
    },
    {
      "name": "Business",
      "icon": Icons.business_center,
      "color": primaryColor,
      "eventCount": 23,
    },
    {
      "name": "Education",
      "icon": Icons.school,
      "color": successColor,
      "eventCount": 67,
    },
    {
      "name": "Health",
      "icon": Icons.health_and_safety,
      "color": warningColor,
      "eventCount": 34,
    },
    {
      "name": "Arts",
      "icon": Icons.palette,
      "color": dangerColor,
      "eventCount": 18,
    },
    {
      "name": "Sports",
      "icon": Icons.sports,
      "color": infoColor,
      "eventCount": 29,
    },
  ];

  final List<Map<String, dynamic>> quickStats = [
    {
      "title": "Events Attended",
      "value": "24",
      "subtitle": "This year",
      "icon": Icons.event_available,
      "color": primaryColor,
    },
    {
      "title": "Upcoming",
      "value": "8",
      "subtitle": "Next 30 days",
      "icon": Icons.schedule,
      "color": infoColor,
    },
    {
      "title": "Certificates",
      "value": "12",
      "subtitle": "Earned",
      "icon": Icons.verified,
      "color": successColor,
    },
    {
      "title": "Network",
      "value": "156",
      "subtitle": "Connections",
      "icon": Icons.people,
      "color": warningColor,
    },
  ];

  final List<Map<String, dynamic>> featuredSpeakers = [
    {
      "name": "Dr. Sarah Chen",
      "title": "AI Research Director",
      "company": "TechCorp",
      "image": "https://picsum.photos/100/100?random=5&keyword=person",
      "expertise": "Machine Learning",
    },
    {
      "name": "Mark Johnson",
      "title": "Startup Founder",
      "company": "InnovateLab",
      "image": "https://picsum.photos/100/100?random=6&keyword=person",
      "expertise": "Entrepreneurship",
    },
    {
      "name": "Lisa Rodriguez",
      "title": "Marketing Director",
      "company": "BrandCo",
      "image": "https://picsum.photos/100/100?random=7&keyword=person",
      "expertise": "Digital Marketing",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Hub"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [warningColor, warningColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discover Events",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Join amazing events and expand your network",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.event,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      QButton(
                        label: "Browse Events",
                        color: Colors.white,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "My Events",
                        color: Colors.white.withAlpha(100),
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search events...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.tune,
                  color: infoColor,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 140,
              children: quickStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              size: 20,
                              color: stat["color"] as Color,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${stat["subtitle"]}",
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

            // Event Categories
            Text(
              "Event Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QCategoryPicker(
              items: categories,
              value: categories[selectedCategory]["value"],
              onChanged: (index, label, value, item) {
                selectedCategory = index;
                setState(() {});
              },
            ),

            // Browse by Category
            Text(
              "Browse by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 100,
              children: eventCategories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          category["icon"] as IconData,
                          size: 22,
                          color: category["color"] as Color,
                        ),
                      ),
                      Text(
                        "${category["name"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${category["eventCount"]} events",
                        style: TextStyle(
                          fontSize: 9,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Upcoming Events
            Row(
              children: [
                Text(
                  "Upcoming Events",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: upcomingEvents.map((event) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                            child: Image.network(
                              "${event["image"]}",
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (event["isFeatured"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "FEATURED",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          if (event["isOnline"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "ONLINE",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${event["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  spacing: 2,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    Text(
                                      "${(event["rating"] as num).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "${event["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${event["subtitle"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  spacing: 4,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 12,
                                      color: disabledColor,
                                    ),
                                    Text(
                                      "${event["date"]} • ${event["time"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  spacing: 4,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: disabledColor,
                                    ),
                                    Text(
                                      "${event["location"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  "${event["attendees"]} attendees",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    (event["price"] as num) > 0 
                                        ? "\$${((event["price"] as num).toDouble()).currency}"
                                        : "FREE",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: (event["price"] as num) > 0 ? primaryColor : successColor,
                                    ),
                                  ),
                                ),
                                QButton(
                                  label: "Register",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Featured Speakers
            Row(
              children: [
                Text(
                  "Featured Speakers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            QHorizontalScroll(
              children: featuredSpeakers.map((speaker) {
                return Container(
                  width: 150,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${speaker["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "${speaker["name"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${speaker["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${speaker["company"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9,
                          color: disabledColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${speaker["expertise"]}",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
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
    );
  }
}
