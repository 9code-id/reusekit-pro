import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmNetworkingHubView extends StatefulWidget {
  const EcmNetworkingHubView({super.key});

  @override
  State<EcmNetworkingHubView> createState() => _EcmNetworkingHubViewState();
}

class _EcmNetworkingHubViewState extends State<EcmNetworkingHubView> {
  String selectedFilter = "all";
  String selectedInterest = "all";
  bool showActiveOnly = false;

  List<Map<String, dynamic>> networkingAreas = [
    {
      "id": 1,
      "name": "Tech Innovation Lounge",
      "category": "Technology",
      "capacity": 50,
      "current_occupancy": 35,
      "description": "Connect with fellow tech enthusiasts and innovators",
      "active_sessions": [
        {"title": "AI Startup Discussions", "host": "Dr. Sarah Chen", "participants": 12},
        {"title": "Blockchain Networking", "host": "Michael Rodriguez", "participants": 8},
      ],
      "featured_attendees": [
        {"name": "Alex Johnson", "role": "Senior Developer", "avatar": "https://picsum.photos/40/40?random=1&face"},
        {"name": "Emma Wilson", "role": "Product Manager", "avatar": "https://picsum.photos/40/40?random=2&face"},
        {"name": "David Chen", "role": "CTO", "avatar": "https://picsum.photos/40/40?random=3&face"},
      ],
      "amenities": ["High-speed WiFi", "Charging stations", "Whiteboards", "Coffee station"],
    },
    {
      "id": 2,
      "name": "Business Leaders Corner",
      "category": "Business",
      "capacity": 30,
      "current_occupancy": 18,
      "description": "Executive networking space for C-level discussions",
      "active_sessions": [
        {"title": "Investment Opportunities", "host": "James Wilson", "participants": 15},
      ],
      "featured_attendees": [
        {"name": "Robert Martinez", "role": "Managing Director", "avatar": "https://picsum.photos/40/40?random=4&face"},
        {"name": "Lisa Rodriguez", "role": "CEO", "avatar": "https://picsum.photos/40/40?random=5&face"},
      ],
      "amenities": ["Private meeting pods", "Premium refreshments", "Secretary service", "Presentation screens"],
    },
    {
      "id": 3,
      "name": "Startup Pitch Arena",
      "category": "Entrepreneurship",
      "capacity": 40,
      "current_occupancy": 28,
      "description": "Perfect space for startup founders and investors to connect",
      "active_sessions": [
        {"title": "Pitch Practice Sessions", "host": "Maria Garcia", "participants": 10},
        {"title": "Investor Meetup", "host": "Tom Anderson", "participants": 18},
      ],
      "featured_attendees": [
        {"name": "Sophie Kim", "role": "Startup Founder", "avatar": "https://picsum.photos/40/40?random=6&face"},
        {"name": "Mark Thompson", "role": "Angel Investor", "avatar": "https://picsum.photos/40/40?random=7&face"},
      ],
      "amenities": ["Projection equipment", "Sound system", "Flip charts", "Networking tables"],
    },
    {
      "id": 4,
      "name": "Creative Collaboration Space",
      "category": "Design",
      "capacity": 25,
      "current_occupancy": 12,
      "description": "For designers, artists, and creative professionals",
      "active_sessions": [
        {"title": "UX Design Workshop", "host": "Amanda Foster", "participants": 12},
      ],
      "featured_attendees": [
        {"name": "Chris Lee", "role": "UI Designer", "avatar": "https://picsum.photos/40/40?random=8&face"},
        {"name": "Nina Patel", "role": "Creative Director", "avatar": "https://picsum.photos/40/40?random=9&face"},
      ],
      "amenities": ["Design tools", "Sketch pads", "Color palettes", "Inspiration boards"],
    },
  ];

  List<Map<String, dynamic>> upcomingEvents = [
    {
      "id": 1,
      "title": "Speed Networking Session",
      "time": "02:00 PM - 03:00 PM",
      "location": "Main Networking Hall",
      "participants": 45,
      "max_participants": 60,
      "category": "Networking",
      "description": "Quick 5-minute networking rounds with fellow attendees",
    },
    {
      "id": 2,
      "title": "Investor Panel Q&A",
      "time": "03:30 PM - 04:30 PM",
      "location": "Business Leaders Corner",
      "participants": 28,
      "max_participants": 30,
      "category": "Investment",
      "description": "Direct access to leading investors for your questions",
    },
    {
      "id": 3,
      "title": "Tech Talk: Future of AI",
      "time": "04:45 PM - 05:45 PM",
      "location": "Tech Innovation Lounge",
      "participants": 32,
      "max_participants": 40,
      "category": "Technology",
      "description": "Interactive discussion on AI trends and opportunities",
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Areas", "value": "all"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Business", "value": "Business"},
    {"label": "Entrepreneurship", "value": "Entrepreneurship"},
    {"label": "Design", "value": "Design"},
  ];

  List<Map<String, dynamic>> interestOptions = [
    {"label": "All Interests", "value": "all"},
    {"label": "Artificial Intelligence", "value": "ai"},
    {"label": "Blockchain", "value": "blockchain"},
    {"label": "Investment", "value": "investment"},
    {"label": "Startup", "value": "startup"},
    {"label": "Design", "value": "design"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Networking Hub"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              si("QR Scanner not implemented");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildNetworkingStats(),
            _buildFilters(),
            _buildUpcomingEvents(),
            _buildNetworkingAreas(),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkingStats() {
    int totalCapacity = networkingAreas.fold(0, (sum, area) => sum + (area["capacity"] as int));
    int totalOccupancy = networkingAreas.fold(0, (sum, area) => sum + (area["current_occupancy"] as int));
    int activeAreas = networkingAreas.where((area) => (area["current_occupancy"] as int) > 0).length;
    int upcomingEventsCount = upcomingEvents.length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.people,
                  size: 28,
                  color: primaryColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalOccupancy",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Active Users",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.location_on,
                  size: 28,
                  color: successColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$activeAreas",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Active Areas",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.event,
                  size: 28,
                  color: infoColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$upcomingEventsCount",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Upcoming",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.trending_up,
                  size: 28,
                  color: warningColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "${((totalOccupancy / totalCapacity) * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Utilization",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Interest",
                  items: interestOptions,
                  value: selectedInterest,
                  onChanged: (value, label) {
                    selectedInterest = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Show active areas only",
                "value": true,
                "checked": showActiveOnly,
              }
            ],
            value: [
              if (showActiveOnly)
                {
                  "label": "Show active areas only",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              showActiveOnly = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Upcoming Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: upcomingEvents.map((event) => _buildEventCard(event)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    int participants = event["participants"] as int;
    int maxParticipants = event["max_participants"] as int;
    double occupancyRate = participants / maxParticipants;
    Color occupancyColor = occupancyRate > 0.8 ? dangerColor : occupancyRate > 0.6 ? warningColor : successColor;

    return Container(
      width: 280,
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${event["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${event["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: primaryColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${event["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 14,
                color: infoColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${event["location"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: infoColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 14,
                color: occupancyColor,
              ),
              SizedBox(width: spXs),
              Text(
                "$participants / $maxParticipants participants",
                style: TextStyle(
                  fontSize: 12,
                  color: occupancyColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: participants >= maxParticipants ? "Full" : "Join Event",
              size: bs.sm,
              onPressed: participants >= maxParticipants ? null : () {
                event["participants"] = participants + 1;
                setState(() {});
                ss("Joined ${event["title"]}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkingAreas() {
    List<Map<String, dynamic>> filteredAreas = networkingAreas.where((area) {
      bool categoryMatch = selectedFilter == "all" || area["category"] == selectedFilter;
      bool activeMatch = !showActiveOnly || (area["current_occupancy"] as int) > 0;
      return categoryMatch && activeMatch;
    }).toList();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Networking Areas",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredAreas.length} areas",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...filteredAreas.map((area) => _buildNetworkingAreaCard(area)),
        ],
      ),
    );
  }

  Widget _buildNetworkingAreaCard(Map<String, dynamic> area) {
    String category = area["category"];
    int capacity = area["capacity"] as int;
    int occupancy = area["current_occupancy"] as int;
    double occupancyRate = occupancy / capacity;
    
    Color categoryColor = category == "Technology" ? infoColor :
                         category == "Business" ? primaryColor :
                         category == "Entrepreneurship" ? successColor :
                         warningColor;

    Color occupancyColor = occupancyRate > 0.8 ? dangerColor : 
                          occupancyRate > 0.6 ? warningColor : successColor;

    List<Map<String, dynamic>> sessions = (area["active_sessions"] as List).cast<Map<String, dynamic>>();
    List<Map<String, dynamic>> attendees = (area["featured_attendees"] as List).cast<Map<String, dynamic>>();
    List<String> amenities = (area["amenities"] as List).cast<String>();

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${area["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${area["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          
          // Occupancy Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: occupancyColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
              border: Border.all(color: occupancyColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: occupancyColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "$occupancy / $capacity people",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: occupancyColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${(occupancyRate * 100).toInt()}% occupied",
                  style: TextStyle(
                    fontSize: 12,
                    color: occupancyColor,
                  ),
                ),
              ],
            ),
          ),

          // Active Sessions
          if (sessions.isNotEmpty) ...[
            Text(
              "Active Sessions",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...sessions.map((session) => Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${session["title"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Host: ${session["host"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${session["participants"]} people",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],

          // Featured Attendees
          if (attendees.isNotEmpty) ...[
            Text(
              "Featured Attendees",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: attendees.map((attendee) => Container(
                width: 120,
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("${attendee["avatar"]}"),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${attendee["name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${attendee["role"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )).toList(),
            ),
          ],

          // Amenities
          if (amenities.isNotEmpty) ...[
            Text(
              "Amenities",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: amenities.map((amenity) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Text(
                  amenity,
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Join Area",
                  size: bs.sm,
                  onPressed: () {
                    area["current_occupancy"] = (area["current_occupancy"] as int) + 1;
                    setState(() {});
                    ss("Joined ${area["name"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("Area details not implemented");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {
                  ss("Shared ${area["name"]} location");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
