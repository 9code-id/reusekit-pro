import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSessionManagementView extends StatefulWidget {
  const EcmSessionManagementView({super.key});

  @override
  State<EcmSessionManagementView> createState() => _EcmSessionManagementViewState();
}

class _EcmSessionManagementViewState extends State<EcmSessionManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String selectedDate = "All";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Published", "value": "Published"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All"},
    {"label": "Keynote", "value": "Keynote"},
    {"label": "Workshop", "value": "Workshop"},
    {"label": "Presentation", "value": "Presentation"},
    {"label": "Panel", "value": "Panel"},
    {"label": "Networking", "value": "Networking"},
  ];

  List<Map<String, dynamic>> dateOptions = [
    {"label": "All Dates", "value": "All"},
    {"label": "Today", "value": "2024-01-15"},
    {"label": "Tomorrow", "value": "2024-01-16"},
    {"label": "This Week", "value": "Week"},
  ];

  List<Map<String, dynamic>> sessions = [
    {
      "id": "1",
      "title": "Opening Keynote: Future of Technology",
      "description": "Explore the cutting-edge technologies shaping our future",
      "date": "2024-01-15",
      "start_time": "09:00",
      "end_time": "10:00",
      "type": "Keynote",
      "location": "Main Auditorium",
      "speaker": "Dr. Sarah Johnson",
      "speaker_title": "Chief Technology Officer",
      "speaker_company": "TechCorp",
      "speaker_avatar": "https://picsum.photos/100/100?random=1&keyword=speaker",
      "capacity": 1500,
      "registered": 1247,
      "waitlist": 89,
      "status": "Published",
      "created_date": "2024-01-10",
      "last_modified": "2024-01-14",
      "resources": ["Audio/Visual", "Live Streaming", "Recording"],
      "tags": ["technology", "innovation", "future"],
      "rating": 4.8,
      "feedback_count": 156
    },
    {
      "id": "2",
      "title": "Building Scalable Web Applications",
      "description": "Best practices for creating web apps that handle millions of users",
      "date": "2024-01-15",
      "start_time": "10:30",
      "end_time": "11:30",
      "type": "Workshop",
      "location": "Tech Hall A",
      "speaker": "Michael Chen",
      "speaker_title": "Senior Software Engineer",
      "speaker_company": "DevStudio",
      "speaker_avatar": "https://picsum.photos/100/100?random=2&keyword=speaker",
      "capacity": 100,
      "registered": 98,
      "waitlist": 45,
      "status": "Active",
      "created_date": "2024-01-08",
      "last_modified": "2024-01-13",
      "resources": ["Computers", "Audio/Visual", "Projector"],
      "tags": ["web-development", "scalability", "architecture"],
      "rating": 4.6,
      "feedback_count": 42
    },
    {
      "id": "3",
      "title": "Design Thinking Workshop",
      "description": "Hands-on workshop on applying design thinking to product development",
      "date": "2024-01-15",
      "start_time": "13:00",
      "end_time": "15:00",
      "type": "Workshop",
      "location": "Design Studio",
      "speaker": "Emily Rodriguez",
      "speaker_title": "Head of Design",
      "speaker_company": "Creative Solutions",
      "speaker_avatar": "https://picsum.photos/100/100?random=3&keyword=speaker",
      "capacity": 80,
      "registered": 76,
      "waitlist": 23,
      "status": "Published",
      "created_date": "2024-01-09",
      "last_modified": "2024-01-12",
      "resources": ["Whiteboards", "Markers", "Sticky Notes"],
      "tags": ["design-thinking", "workshop", "creativity"],
      "rating": 4.7,
      "feedback_count": 38
    },
    {
      "id": "4",
      "title": "AI in Business Applications",
      "description": "How artificial intelligence is transforming business operations",
      "date": "2024-01-16",
      "start_time": "09:30",
      "end_time": "10:30",
      "type": "Presentation",
      "location": "Conference Room B",
      "speaker": "David Wilson",
      "speaker_title": "AI Research Director",
      "speaker_company": "Innovation Labs",
      "speaker_avatar": "https://picsum.photos/100/100?random=4&keyword=speaker",
      "capacity": 120,
      "registered": 89,
      "waitlist": 12,
      "status": "Draft",
      "created_date": "2024-01-11",
      "last_modified": "2024-01-14",
      "resources": ["Audio/Visual", "Demo Setup"],
      "tags": ["artificial-intelligence", "business", "automation"],
      "rating": 0,
      "feedback_count": 0
    },
    {
      "id": "5",
      "title": "Leadership Panel Discussion",
      "description": "Industry leaders discuss challenges and opportunities",
      "date": "2024-01-16",
      "start_time": "11:00",
      "end_time": "12:00",
      "type": "Panel",
      "location": "Main Hall",
      "speaker": "Various Speakers",
      "speaker_title": "Industry Leaders",
      "speaker_company": "Multiple Companies",
      "speaker_avatar": "https://picsum.photos/100/100?random=5&keyword=team",
      "capacity": 300,
      "registered": 267,
      "waitlist": 56,
      "status": "Active",
      "created_date": "2024-01-07",
      "last_modified": "2024-01-13",
      "resources": ["Audio/Visual", "Microphones", "Recording"],
      "tags": ["leadership", "panel", "industry"],
      "rating": 4.5,
      "feedback_count": 78
    },
  ];

  List<Map<String, dynamic>> get filteredSessions {
    List<Map<String, dynamic>> filtered = sessions;
    
    if (selectedStatus != "All") {
      filtered = filtered.where((session) => session["status"] == selectedStatus).toList();
    }
    
    if (selectedType != "All") {
      filtered = filtered.where((session) => session["type"] == selectedType).toList();
    }
    
    if (selectedDate != "All") {
      if (selectedDate == "Week") {
        // Filter sessions in this week
        filtered = filtered.where((session) {
          DateTime sessionDate = DateTime.parse(session["date"]);
          DateTime now = DateTime.now();
          DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
          DateTime weekEnd = weekStart.add(Duration(days: 6));
          return sessionDate.isAfter(weekStart.subtract(Duration(days: 1))) && 
                 sessionDate.isBefore(weekEnd.add(Duration(days: 1)));
        }).toList();
      } else {
        filtered = filtered.where((session) => session["date"] == selectedDate).toList();
      }
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((session) {
        return session["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               session["description"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               session["speaker"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               (session["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Sort by date and time
    filtered.sort((a, b) {
      int dateComparison = a["date"].compareTo(b["date"]);
      if (dateComparison != 0) return dateComparison;
      return a["start_time"].compareTo(b["start_time"]);
    });
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Published":
        return primaryColor;
      case "Draft":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Keynote":
        return primaryColor;
      case "Workshop":
        return successColor;
      case "Presentation":
        return infoColor;
      case "Panel":
        return warningColor;
      case "Networking":
        return secondaryColor;
      default:
        return disabledColor;
    }
  }

  double _getCapacityPercentage(int registered, int capacity) {
    return (registered / capacity * 100).clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.analytics),
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
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.event_note,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Session Management",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Manage all your conference sessions and events",
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
            ),

            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.event,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${sessions.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Sessions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${sessions.fold(0, (sum, session) => sum + (session["registered"] as int))}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Registered",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.hourglass_empty,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${sessions.fold(0, (sum, session) => sum + (session["waitlist"] as int))}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Total Waitlist",
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

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search sessions",
                    value: searchQuery,
                    hint: "Search by title, speaker, or tags",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: typeOptions,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Date Filter",
              items: dateOptions,
              value: selectedDate,
              onChanged: (value, label) {
                selectedDate = value;
                setState(() {});
              },
            ),

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
                      Icon(
                        Icons.list,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Session List",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${filteredSessions.length} sessions",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (filteredSessions.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No sessions found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filters",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...List.generate(filteredSessions.length, (index) {
                      final session = filteredSessions[index];
                      final statusColor = _getStatusColor(session["status"]);
                      final typeColor = _getTypeColor(session["type"]);
                      final capacityPercentage = _getCapacityPercentage(
                        session["registered"], 
                        session["capacity"]
                      );
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: statusColor.withAlpha(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${session["speaker_avatar"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${session["title"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: statusColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${session["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: statusColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${session["speaker"]} • ${session["speaker_title"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${session["speaker_company"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${session["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${DateTime.parse(session["date"]).dMMMy} • ${session["start_time"]} - ${session["end_time"]}",
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
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${session["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: typeColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${session["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: typeColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            // Capacity Progress Bar
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Registration: ${session["registered"]}/${session["capacity"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${capacityPercentage.toInt()}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: capacityPercentage > 90 ? dangerColor : successColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: capacityPercentage / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: capacityPercentage > 90 ? dangerColor : successColor,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            if (session["waitlist"] > 0) ...[
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.hourglass_empty,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${session["waitlist"]} people on waitlist",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            
                            if (session["rating"] > 0) ...[
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 12,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${session["rating"]}/5.0",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "(${session["feedback_count"]} reviews)",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 32,
                                    child: QButton(
                                      label: "Edit",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
