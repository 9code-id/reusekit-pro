import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCompletedEventsView extends StatefulWidget {
  const EcmCompletedEventsView({super.key});

  @override
  State<EcmCompletedEventsView> createState() => _EcmCompletedEventsViewState();
}

class _EcmCompletedEventsViewState extends State<EcmCompletedEventsView> {
  String selectedFilter = "all";
  String searchQuery = "";
  String sortBy = "date";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Events", "value": "all"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date", "value": "date"},
    {"label": "Revenue", "value": "revenue"},
    {"label": "Attendees", "value": "attendees"},
    {"label": "Rating", "value": "rating"},
  ];
  
  List<Map<String, dynamic>> completedEvents = [
    {
      "id": "1",
      "name": "Product Launch Event",
      "date": "Dec 15, 2024",
      "duration": "4 hours",
      "location": "Innovation Hub",
      "type": "Launch",
      "status": "completed",
      "attendees": 300,
      "maxAttendees": 300,
      "revenue": 35000,
      "budget": 28000,
      "profit": 7000,
      "rating": 4.8,
      "reviews": 127,
      "description": "Successfully launched our revolutionary new product",
      "image": "https://picsum.photos/300/200?random=1&keyword=launch",
      "highlights": [
        "100% attendance rate",
        "Exceeded revenue target by 25%",
        "Featured in 15 media outlets",
        "Generated 500+ leads"
      ],
      "metrics": {
        "satisfaction": 96,
        "nps": 78,
        "socialShares": 342,
        "mediaReach": 50000,
        "leadGeneration": 523
      },
      "feedback": [
        {"comment": "Amazing event! Well organized and informative.", "rating": 5, "author": "John Smith"},
        {"comment": "Great product demo and networking opportunities.", "rating": 5, "author": "Sarah Johnson"},
        {"comment": "Excellent venue and catering. Highly recommend.", "rating": 4, "author": "Mike Davis"},
      ]
    },
    {
      "id": "2",
      "name": "Music Festival Summer 2024",
      "date": "Dec 10, 2024",
      "duration": "3 days",
      "location": "Central Park",
      "type": "Festival",
      "status": "completed",
      "attendees": 2500,
      "maxAttendees": 3000,
      "revenue": 150000,
      "budget": 120000,
      "profit": 30000,
      "rating": 4.6,
      "reviews": 456,
      "description": "Three-day music festival featuring top artists",
      "image": "https://picsum.photos/300/200?random=2&keyword=music",
      "highlights": [
        "83% attendance rate",
        "25% profit margin",
        "Zero major incidents",
        "Featured 30+ artists"
      ],
      "metrics": {
        "satisfaction": 92,
        "nps": 71,
        "socialShares": 1247,
        "mediaReach": 250000,
        "leadGeneration": 0
      },
      "feedback": [
        {"comment": "Best festival experience ever! Great lineup.", "rating": 5, "author": "Emily Chen"},
        {"comment": "Well organized but could use more food options.", "rating": 4, "author": "David Wilson"},
        {"comment": "Amazing atmosphere and sound quality.", "rating": 5, "author": "Lisa Park"},
      ]
    },
    {
      "id": "3",
      "name": "Corporate Team Building",
      "date": "Dec 5, 2024",
      "duration": "2 days",
      "location": "Mountain Resort",
      "type": "Corporate",
      "status": "completed",
      "attendees": 85,
      "maxAttendees": 100,
      "revenue": 18000,
      "budget": 15000,
      "profit": 3000,
      "rating": 4.9,
      "reviews": 78,
      "description": "Team building retreat for Fortune 500 company",
      "image": "https://picsum.photos/300/200?random=3&keyword=team-building",
      "highlights": [
        "85% attendance rate",
        "20% profit margin",
        "100% client satisfaction",
        "Repeat booking secured"
      ],
      "metrics": {
        "satisfaction": 98,
        "nps": 89,
        "socialShares": 45,
        "mediaReach": 5000,
        "leadGeneration": 12
      },
      "feedback": [
        {"comment": "Perfect venue and activities. Team loved it!", "rating": 5, "author": "Robert Taylor"},
        {"comment": "Excellent planning and execution. Highly professional.", "rating": 5, "author": "Amanda Brown"},
        {"comment": "Great balance of work and fun activities.", "rating": 5, "author": "Thomas Lee"},
      ]
    },
    {
      "id": "4",
      "name": "Charity Fundraiser Dinner",
      "date": "Nov 28, 2024",
      "duration": "5 hours",
      "location": "Grand Ballroom",
      "type": "Charity",
      "status": "completed",
      "attendees": 200,
      "maxAttendees": 250,
      "revenue": 45000,
      "budget": 20000,
      "profit": 25000,
      "rating": 4.7,
      "reviews": 89,
      "description": "Annual fundraising dinner for children's hospital",
      "image": "https://picsum.photos/300/200?random=4&keyword=charity",
      "highlights": [
        "80% attendance rate",
        "125% profit margin",
        "Raised \$45K for charity",
        "Celebrity guest speaker"
      ],
      "metrics": {
        "satisfaction": 94,
        "nps": 82,
        "socialShares": 189,
        "mediaReach": 75000,
        "leadGeneration": 0
      },
      "feedback": [
        {"comment": "Touching event for a great cause. Well organized.", "rating": 5, "author": "Maria Garcia"},
        {"comment": "Beautiful venue and meaningful presentations.", "rating": 5, "author": "Kevin Johnson"},
        {"comment": "Great auction items and entertainment.", "rating": 4, "author": "Nancy Wilson"},
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = completedEvents;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((event) => 
        event["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        event["type"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        event["location"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort events
    if (sortBy == "revenue") {
      filtered.sort((a, b) => (b["revenue"] as int).compareTo(a["revenue"] as int));
    } else if (sortBy == "attendees") {
      filtered.sort((a, b) => (b["attendees"] as int).compareTo(a["attendees"] as int));
    } else if (sortBy == "rating") {
      filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Events"),
        actions: [
          GestureDetector(
            onTap: () {
              si("Export report");
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(Icons.file_download, size: 24, color: primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search completed events...",
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
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {
                    _showSortDialog();
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Filter options
            QCategoryPicker(
              label: "Filter by Period",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            // Summary stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(200)],
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
                              "${completedEvents.length}",
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
                              "\$${((completedEvents.fold(0, (sum, event) => sum + (event["revenue"] as int))) / 1000).toStringAsFixed(0)}K",
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
                          Icons.check_circle,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Avg Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${(completedEvents.fold(0.0, (sum, event) => sum + (event["rating"] as double)) / completedEvents.length).toStringAsFixed(1)}⭐",
                              style: TextStyle(
                                fontSize: 16,
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
                              "Total Attendees",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${((completedEvents.fold(0, (sum, event) => sum + (event["attendees"] as int))) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 16,
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
                              "Profit Margin",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${((completedEvents.fold(0, (sum, event) => sum + (event["profit"] as int)) / completedEvents.fold(0, (sum, event) => sum + (event["revenue"] as int))) * 100).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
            
            // Events list
            Text(
              "Completed Events (${filteredEvents.length})",
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
                double profitMargin = ((event["profit"] as int) / (event["revenue"] as int)) * 100;
                
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
                      // Event image and basic info
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
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check, color: Colors.white, size: 12),
                                      SizedBox(width: spXs),
                                      Text(
                                        "COMPLETED",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                                Row(
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${event["rating"]} (${event["reviews"]})",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
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
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spMd),
                            
                            // Event info
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${event["date"]} • ${event["duration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
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
                            
                            // Key metrics
                            ResponsiveGridView(
                              padding: EdgeInsets.zero,
                              minItemWidth: 100,
                              children: [
                                _buildMetricItem("Attendees", "${event["attendees"]}/${event["maxAttendees"]}", primaryColor),
                                _buildMetricItem("Revenue", "\$${((event["revenue"] as int) / 1000).toStringAsFixed(1)}K", successColor),
                                _buildMetricItem("Profit", "\$${((event["profit"] as int) / 1000).toStringAsFixed(1)}K", infoColor),
                                _buildMetricItem("Margin", "${profitMargin.toStringAsFixed(1)}%", warningColor),
                              ],
                            ),
                            SizedBox(height: spMd),
                            
                            // Highlights
                            Text(
                              "Key Highlights",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (event["highlights"] as List).map((highlight) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "$highlight",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spMd),
                            
                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Report",
                                    size: bs.sm,
                                    onPressed: () {
                                      _showEventReport(event);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "View Feedback",
                                    size: bs.sm,
                                    onPressed: () {
                                      _showEventFeedback(event);
                                    },
                                  ),
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
        ),
      ),
    );
  }
  
  Widget _buildMetricItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
  
  void _showSortDialog() {
    si("Sort options: Date, Revenue, Attendees, Rating");
  }
  
  void _showEventReport(Map<String, dynamic> event) {
    si("Showing detailed report for ${event["name"]}");
  }
  
  void _showEventFeedback(Map<String, dynamic> event) {
    si("Showing feedback for ${event["name"]}");
  }
}
