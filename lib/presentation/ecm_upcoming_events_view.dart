import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmUpcomingEventsView extends StatefulWidget {
  const EcmUpcomingEventsView({super.key});

  @override
  State<EcmUpcomingEventsView> createState() => _EcmUpcomingEventsViewState();
}

class _EcmUpcomingEventsViewState extends State<EcmUpcomingEventsView> {
  String selectedTimeRange = "week";
  String searchQuery = "";
  
  List<Map<String, dynamic>> timeRanges = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Next 3 Months", "value": "quarter"},
    {"label": "All Upcoming", "value": "all"},
  ];
  
  List<Map<String, dynamic>> upcomingEvents = [
    {
      "id": "1",
      "name": "Corporate Holiday Party",
      "date": "Dec 23, 2024",
      "time": "06:00 PM",
      "daysUntil": 4,
      "attendees": 180,
      "maxAttendees": 200,
      "location": "Grand Hotel",
      "type": "Corporate",
      "priority": "high",
      "budget": 25000,
      "progress": 85,
      "image": "https://picsum.photos/300/200?random=1&keyword=party",
      "tasks": [
        {"name": "Finalize menu", "completed": true},
        {"name": "Send invitations", "completed": true},
        {"name": "Setup decorations", "completed": false},
        {"name": "Sound system check", "completed": false},
      ],
      "teamMembers": ["Sarah Wilson", "Mike Johnson", "Emily Davis"]
    },
    {
      "id": "2",
      "name": "Wedding Reception",
      "date": "Dec 28, 2024",
      "time": "05:00 PM",
      "daysUntil": 9,
      "attendees": 120,
      "maxAttendees": 150,
      "location": "Sunset Garden",
      "type": "Wedding",
      "priority": "high",
      "budget": 28000,
      "progress": 75,
      "image": "https://picsum.photos/300/200?random=2&keyword=wedding",
      "tasks": [
        {"name": "Venue setup", "completed": true},
        {"name": "Catering confirmation", "completed": true},
        {"name": "Flowers arrangement", "completed": false},
        {"name": "Photography briefing", "completed": false},
      ],
      "teamMembers": ["Anna Smith", "David Brown", "Lisa Chen"]
    },
    {
      "id": "3",
      "name": "Charity Fundraiser Gala",
      "date": "Dec 30, 2024",
      "time": "07:00 PM",
      "daysUntil": 11,
      "attendees": 250,
      "maxAttendees": 300,
      "location": "City Hall",
      "type": "Charity",
      "priority": "medium",
      "budget": 40000,
      "progress": 60,
      "image": "https://picsum.photos/300/200?random=3&keyword=gala",
      "tasks": [
        {"name": "Sponsor confirmations", "completed": true},
        {"name": "Auction items secured", "completed": false},
        {"name": "Program design", "completed": false},
        {"name": "Media invitations", "completed": false},
      ],
      "teamMembers": ["Robert Taylor", "Jennifer Lee", "Mark Anderson"]
    },
    {
      "id": "4",
      "name": "New Year Concert",
      "date": "Dec 31, 2024",
      "time": "08:00 PM",
      "daysUntil": 12,
      "attendees": 800,
      "maxAttendees": 1000,
      "location": "Concert Hall",
      "type": "Entertainment",
      "priority": "high",
      "budget": 60000,
      "progress": 45,
      "image": "https://picsum.photos/300/200?random=4&keyword=concert",
      "tasks": [
        {"name": "Artist contracts", "completed": true},
        {"name": "Sound equipment", "completed": false},
        {"name": "Security arrangements", "completed": false},
        {"name": "Ticket sales", "completed": false},
      ],
      "teamMembers": ["Alex Johnson", "Maria Garcia", "Tom Wilson", "Kate Davis"]
    },
    {
      "id": "5",
      "name": "Business Conference 2025",
      "date": "Jan 15, 2025",
      "time": "09:00 AM",
      "daysUntil": 27,
      "attendees": 300,
      "maxAttendees": 400,
      "location": "Convention Center",
      "type": "Conference",
      "priority": "medium",
      "budget": 35000,
      "progress": 30,
      "image": "https://picsum.photos/300/200?random=5&keyword=conference",
      "tasks": [
        {"name": "Speaker confirmations", "completed": false},
        {"name": "Venue booking", "completed": true},
        {"name": "Catering arrangements", "completed": false},
        {"name": "Registration system", "completed": false},
      ],
      "teamMembers": ["Steven Clark", "Rachel White", "James Miller"]
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = upcomingEvents;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((event) => 
        event["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        event["type"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        event["location"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort by days until event
    filtered.sort((a, b) => (a["daysUntil"] as int).compareTo(b["daysUntil"] as int));
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Events"),
        actions: [
          GestureDetector(
            onTap: () {
              si("Calendar view");
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(Icons.calendar_month, size: 24, color: primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search upcoming events...",
                    value: searchQuery,
                    hint: "Search by name, type, or location",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    si("Filter options");
                  },
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            // Time range filter
            QCategoryPicker(
              label: "Time Range",
              items: timeRanges,
              value: selectedTimeRange,
              onChanged: (index, label, value, item) {
                selectedTimeRange = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            // Events overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [warningColor, warningColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Event",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${upcomingEvents.first["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "In ${upcomingEvents.first["daysUntil"]} days",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.event_available,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Quick stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard(
                  "Total Events",
                  "${filteredEvents.length}",
                  Icons.event,
                  primaryColor,
                ),
                _buildStatCard(
                  "This Week",
                  "${filteredEvents.where((e) => (e["daysUntil"] as int) <= 7).length}",
                  Icons.date_range,
                  infoColor,
                ),
                _buildStatCard(
                  "High Priority",
                  "${filteredEvents.where((e) => e["priority"] == "high").length}",
                  Icons.priority_high,
                  dangerColor,
                ),
                _buildStatCard(
                  "Total Budget",
                  "\$${((filteredEvents.fold(0, (sum, event) => sum + (event["budget"] as int))) / 1000).toStringAsFixed(0)}K",
                  Icons.monetization_on,
                  successColor,
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            // Events list
            Text(
              "Upcoming Events (${filteredEvents.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                Color priorityColor = infoColor;
                if (event["priority"] == "high") priorityColor = dangerColor;
                if (event["priority"] == "medium") priorityColor = warningColor;
                
                int completedTasks = (event["tasks"] as List).where((task) => task["completed"] == true).length;
                int totalTasks = (event["tasks"] as List).length;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event header
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusMd),
                              child: Image.network(
                                "${event["image"]}",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${event["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: priorityColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: Text(
                                          "${event["priority"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: priorityColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "In ${event["daysUntil"]} days • ${event["date"]} at ${event["time"]}",
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
                                      Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${event["location"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Progress and stats
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Progress: ${event["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Tasks: $completedTasks/$totalTasks",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: (event["progress"] as int) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),
                      
                      // Stats row
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusMd)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Attendees",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${event["attendees"]}/${event["maxAttendees"]}",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                    "Budget",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "\$${((event["budget"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
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
                                    "Team",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${(event["teamMembers"] as List).length} members",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              label: "Manage",
                              size: bs.sm,
                              onPressed: () {
                                si("Managing event: ${event["name"]}");
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
