import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaTimelineView extends StatefulWidget {
  const EmaTimelineView({super.key});

  @override
  State<EmaTimelineView> createState() => _EmaTimelineViewState();
}

class _EmaTimelineViewState extends State<EmaTimelineView> {
  String selectedDay = "today";
  String timeFilter = "all";
  
  List<Map<String, dynamic>> timelineEvents = [
    {
      "id": "1",
      "title": "Opening Ceremony",
      "time": "09:00",
      "endTime": "10:30",
      "type": "ceremony",
      "location": "Main Hall A",
      "description": "Welcome address and keynote presentation",
      "status": "upcoming",
      "speakers": ["Dr. Sarah Johnson", "Mark Thompson"],
      "attendees": 1500,
      "category": "General",
      "duration": 90,
      "isLive": false,
      "isFeatured": true,
    },
    {
      "id": "2", 
      "title": "AI in Healthcare: Future Perspectives",
      "time": "11:00",
      "endTime": "12:00",
      "type": "presentation",
      "location": "Conference Room B",
      "description": "Exploring the latest advancements in AI-driven healthcare solutions",
      "status": "live",
      "speakers": ["Dr. Michael Chen", "Prof. Lisa Rodriguez"],
      "attendees": 300,
      "category": "Technology",
      "duration": 60,
      "isLive": true,
      "isFeatured": false,
    },
    {
      "id": "3",
      "title": "Networking Lunch Break",
      "time": "12:00",
      "endTime": "13:30",
      "type": "break",
      "location": "Grand Ballroom",
      "description": "Connect with fellow attendees over lunch",
      "status": "upcoming",
      "speakers": [],
      "attendees": 800,
      "category": "Networking",
      "duration": 90,
      "isLive": false,
      "isFeatured": false,
    },
    {
      "id": "4",
      "title": "Workshop: Digital Marketing Strategies",
      "time": "14:00",
      "endTime": "16:00",
      "type": "workshop",
      "location": "Workshop Room C",
      "description": "Hands-on session covering modern digital marketing techniques",
      "status": "upcoming", 
      "speakers": ["Jennifer Walsh", "David Park"],
      "attendees": 150,
      "category": "Marketing",
      "duration": 120,
      "isLive": false,
      "isFeatured": true,
    },
    {
      "id": "5",
      "title": "Panel Discussion: Sustainability",
      "time": "16:30",
      "endTime": "17:30",
      "type": "panel",
      "location": "Main Hall A",
      "description": "Expert panel on sustainable business practices",
      "status": "completed",
      "speakers": ["Emma Thompson", "Robert Kim", "Dr. Amanda White"],
      "attendees": 500,
      "category": "Environment",
      "duration": 60,
      "isLive": false,
      "isFeatured": false,
    },
    {
      "id": "6",
      "title": "Closing Remarks & Awards",
      "time": "18:00",
      "endTime": "19:00",
      "type": "ceremony",
      "location": "Main Hall A",
      "description": "Conference wrap-up and recognition ceremony",
      "status": "upcoming",
      "speakers": ["Conference Organizers"],
      "attendees": 1200,
      "category": "General",
      "duration": 60,
      "isLive": false,
      "isFeatured": true,
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    return timelineEvents.where((event) {
      if (timeFilter == "live") return event["isLive"] == true;
      if (timeFilter == "featured") return event["isFeatured"] == true;
      if (timeFilter == "upcoming") return event["status"] == "upcoming";
      if (timeFilter == "completed") return event["status"] == "completed";
      return true;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "live":
        return dangerColor;
      case "upcoming":
        return primaryColor;
      case "completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "ceremony":
        return dangerColor;
      case "presentation":
        return primaryColor;
      case "workshop":
        return warningColor;
      case "panel":
        return infoColor;
      case "break":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Icon _getTypeIcon(String type) {
    switch (type) {
      case "ceremony":
        return Icon(Icons.celebration, color: dangerColor, size: 20);
      case "presentation":
        return Icon(Icons.slideshow, color: primaryColor, size: 20);
      case "workshop":
        return Icon(Icons.handyman, color: warningColor, size: 20);
      case "panel":
        return Icon(Icons.group, color: infoColor, size: 20);
      case "break":
        return Icon(Icons.coffee, color: successColor, size: 20);
      default:
        return Icon(Icons.event, color: disabledBoldColor, size: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Timeline"),
        actions: [
          GestureDetector(
            onTap: () {
              //navigateTo EmaCalendarView
            },
            child: Icon(
              Icons.calendar_today,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Schedule",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${filteredEvents.length} events planned",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.live_tv, color: dangerColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${timelineEvents.where((e) => e["isLive"] == true).length} Live",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${timelineEvents.where((e) => e["isFeatured"] == true).length} Featured",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
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

            SizedBox(height: spLg),

            // Filter Options
            Text(
              "Filter Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            QHorizontalScroll(
              children: [
                _buildFilterChip("All Events", "all"),
                _buildFilterChip("Live Now", "live"),
                _buildFilterChip("Featured", "featured"),
                _buildFilterChip("Upcoming", "upcoming"),
                _buildFilterChip("Completed", "completed"),
              ],
            ),

            SizedBox(height: spLg),

            // Timeline
            Text(
              "Timeline",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            ...filteredEvents.map((event) => _buildTimelineItem(event)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    bool isSelected = timeFilter == value;
    
    return GestureDetector(
      onTap: () {
        timeFilter = value;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spMd),
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time column
          Container(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["time"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${event["endTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Timeline line
          Container(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _getStatusColor(event["status"]),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [shadowSm],
                  ),
                ),
                if (filteredEvents.indexOf(event) != filteredEvents.length - 1)
                  Container(
                    width: 2,
                    height: 80,
                    color: disabledOutlineBorderColor,
                  ),
              ],
            ),
          ),

          // Event content
          Expanded(
            child: GestureDetector(
              onTap: () {
                //navigateTo event detail view
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: event["isLive"] == true ? dangerColor : disabledOutlineBorderColor,
                    width: event["isLive"] == true ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _getTypeIcon(event["type"]),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${event["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (event["isLive"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "LIVE",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (event["isFeatured"] == true)
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 16,
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${event["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${event["location"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.people,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${event["attendees"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if ((event["speakers"] as List).isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              (event["speakers"] as List).join(", "),
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
