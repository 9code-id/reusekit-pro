import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmEventsOverviewView extends StatefulWidget {
  const EcmEventsOverviewView({super.key});

  @override
  State<EcmEventsOverviewView> createState() => _EcmEventsOverviewViewState();
}

class _EcmEventsOverviewViewState extends State<EcmEventsOverviewView> {
  String selectedFilter = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> eventCategories = [
    {"label": "All Events", "value": "all", "count": 45},
    {"label": "Active", "value": "active", "count": 12},
    {"label": "Upcoming", "value": "upcoming", "count": 18},
    {"label": "Completed", "value": "completed", "count": 15},
  ];
  
  List<Map<String, dynamic>> events = [
    {
      "id": "1",
      "name": "Annual Tech Conference 2024",
      "date": "Dec 25, 2024",
      "time": "09:00 AM",
      "status": "active",
      "attendees": 450,
      "maxAttendees": 500,
      "location": "Convention Center",
      "type": "Conference",
      "revenue": 45000,
      "description": "The biggest tech conference of the year featuring latest innovations",
      "image": "https://picsum.photos/300/200?random=1&keyword=conference"
    },
    {
      "id": "2",
      "name": "Corporate Holiday Party",
      "date": "Dec 23, 2024",
      "time": "06:00 PM",
      "status": "upcoming",
      "attendees": 180,
      "maxAttendees": 200,
      "location": "Grand Hotel",
      "type": "Corporate",
      "revenue": 25000,
      "description": "Annual company celebration with dinner and entertainment",
      "image": "https://picsum.photos/300/200?random=2&keyword=party"
    },
    {
      "id": "3",
      "name": "Product Launch Event",
      "date": "Dec 20, 2024",
      "time": "02:00 PM",
      "status": "completed",
      "attendees": 300,
      "maxAttendees": 300,
      "location": "Innovation Hub",
      "type": "Launch",
      "revenue": 35000,
      "description": "Launching our revolutionary new product to the market",
      "image": "https://picsum.photos/300/200?random=3&keyword=launch"
    },
    {
      "id": "4",
      "name": "Wedding Reception",
      "date": "Dec 28, 2024",
      "time": "05:00 PM",
      "status": "upcoming",
      "attendees": 120,
      "maxAttendees": 150,
      "location": "Sunset Garden",
      "type": "Wedding",
      "revenue": 28000,
      "description": "Elegant wedding reception in beautiful garden setting",
      "image": "https://picsum.photos/300/200?random=4&keyword=wedding"
    },
    {
      "id": "5",
      "name": "Charity Fundraiser Gala",
      "date": "Dec 30, 2024",
      "time": "07:00 PM",
      "status": "upcoming",
      "attendees": 250,
      "maxAttendees": 300,
      "location": "City Hall",
      "type": "Charity",
      "revenue": 40000,
      "description": "Annual fundraising event for local children's hospital",
      "image": "https://picsum.photos/300/200?random=5&keyword=gala"
    },
    {
      "id": "6",
      "name": "Music Festival",
      "date": "Dec 18, 2024",
      "time": "12:00 PM",
      "status": "completed",
      "attendees": 2500,
      "maxAttendees": 3000,
      "location": "Central Park",
      "type": "Festival",
      "revenue": 150000,
      "description": "Three-day music festival featuring top artists",
      "image": "https://picsum.photos/300/200?random=6&keyword=music"
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = events;
    
    if (selectedFilter != "all") {
      filtered = filtered.where((event) => event["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((event) => 
        event["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        event["type"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        event["location"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events Overview"),
        actions: [
          GestureDetector(
            onTap: () {
              // ss('Next page'));
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(Icons.add, size: 24, color: primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search events...",
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
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    si("Search performed");
                  },
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            // Event categories
            QCategoryPicker(
              label: "Filter Events",
              items: eventCategories.map((category) => {
                "label": "${category["label"]} (${category["count"]})",
                "value": category["value"],
              }).toList(),
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            // Events summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
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
                              "Total Events",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${events.length}",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                              "Total Revenue",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${((events.fold(0, (sum, event) => sum + (event["revenue"] as int))) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                          Icons.event,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Events list
            Text(
              "Events (${filteredEvents.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            if (filteredEvents.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(sp2xl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 60,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No events found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
                  Color statusColor = primaryColor;
                  if (event["status"] == "active") statusColor = successColor;
                  if (event["status"] == "completed") statusColor = disabledBoldColor;
                  if (event["status"] == "upcoming") statusColor = warningColor;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event image
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            child: Stack(
                              children: [
                                Image.network(
                                  "${event["image"]}",
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: spMd,
                                  right: spMd,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Text(
                                      "${event["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: spMd,
                                  left: spMd,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(160),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Text(
                                      "${event["type"]}",
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
                          ),
                        ),
                        
                        // Event details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${event["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              
                              Text(
                                "${event["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spMd),
                              
                              // Event info
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["date"]} at ${event["time"]}",
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
                                  Icon(Icons.location_on, size: 16, color: disabledBoldColor),
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
                              SizedBox(height: spMd),
                              
                              // Stats row
                              Row(
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
                                          "Revenue",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "\$${((event["revenue"] as int) / 1000).toStringAsFixed(1)}K",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      si("Viewing event details");
                                    },
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
