import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaPastEventsView extends StatefulWidget {
  const EmaPastEventsView({super.key});

  @override
  State<EmaPastEventsView> createState() => _EmaPastEventsViewState();
}

class _EmaPastEventsViewState extends State<EmaPastEventsView> {
  String selectedFilter = "All";
  String selectedSort = "recent";
  bool showRatedOnly = false;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Events", "value": "All"},
    {"label": "Last Week", "value": "week"},
    {"label": "Last Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Food", "value": "Food"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Recent", "value": "recent"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Most Attended", "value": "attendees"},
  ];

  List<Map<String, dynamic>> pastEvents = [
    {
      "id": "past1",
      "title": "Tech Innovation Summit 2024",
      "date": "2024-06-10",
      "time": "09:00",
      "location": "Convention Center",
      "price": 299.00,
      "image": "https://picsum.photos/400/250?random=41&keyword=tech",
      "category": "Technology",
      "attendees": 1250,
      "actualAttendees": 1180,
      "rating": 4.8,
      "organizer": "TechCorp Events",
      "status": "Completed",
      "myRating": 5,
      "hasReview": true,
      "myReview": "Excellent speakers and great networking opportunities!",
      "highlights": ["Keynote by tech leaders", "AI workshop", "Networking lunch"],
      "photos": 45,
      "certificate": true,
      "tags": ["AI", "Innovation", "Networking"],
      "feedback": "Event exceeded expectations with high-quality content.",
      "wouldRecommend": true,
    },
    {
      "id": "past2",
      "title": "Summer Music Festival",
      "date": "2024-05-25",
      "time": "16:00",
      "location": "Central Park",
      "price": 85.00,
      "image": "https://picsum.photos/400/250?random=42&keyword=festival",
      "category": "Music",
      "attendees": 5000,
      "actualAttendees": 4850,
      "rating": 4.9,
      "organizer": "Music Events Co",
      "status": "Completed",
      "myRating": 0,
      "hasReview": false,
      "myReview": "",
      "highlights": ["3 stages", "15 artists", "Food trucks"],
      "photos": 120,
      "certificate": false,
      "tags": ["Live Music", "Outdoor", "Festival"],
      "feedback": "Amazing atmosphere and great sound quality.",
      "wouldRecommend": true,
    },
    {
      "id": "past3",
      "title": "Marathon Championship",
      "date": "2024-05-15",
      "time": "06:00",
      "location": "City Stadium",
      "price": 75.00,
      "image": "https://picsum.photos/400/250?random=43&keyword=marathon",
      "category": "Sports",
      "attendees": 2000,
      "actualAttendees": 1850,
      "rating": 4.7,
      "organizer": "Running Club",
      "status": "Completed",
      "myRating": 4,
      "hasReview": true,
      "myReview": "Well organized event, good support throughout the race.",
      "highlights": ["42.2km race", "Medal ceremony", "Post-race meal"],
      "photos": 80,
      "certificate": true,
      "tags": ["Running", "Competition", "Achievement"],
      "feedback": "Great organization and enthusiastic crowd support.",
      "wouldRecommend": true,
    },
    {
      "id": "past4",
      "title": "Food & Wine Tasting",
      "date": "2024-04-20",
      "time": "18:00",
      "location": "Grand Hotel",
      "price": 150.00,
      "image": "https://picsum.photos/400/250?random=44&keyword=wine",
      "category": "Food",
      "attendees": 300,
      "actualAttendees": 285,
      "rating": 4.6,
      "organizer": "Culinary Society",
      "status": "Completed",
      "myRating": 5,
      "hasReview": true,
      "myReview": "Exceptional wine selection and delicious food pairings.",
      "highlights": ["Wine expert talks", "Gourmet tasting", "Chef demonstrations"],
      "photos": 35,
      "certificate": false,
      "tags": ["Wine", "Gourmet", "Tasting"],
      "feedback": "Premium experience with excellent service.",
      "wouldRecommend": true,
    },
    {
      "id": "past5",
      "title": "Photography Workshop",
      "date": "2024-04-08",
      "time": "10:00",
      "location": "Studio Arts",
      "price": 120.00,
      "image": "https://picsum.photos/400/250?random=45&keyword=photography",
      "category": "Arts",
      "attendees": 80,
      "actualAttendees": 75,
      "rating": 4.9,
      "organizer": "Pro Photo Academy",
      "status": "Completed",
      "myRating": 0,
      "hasReview": false,
      "myReview": "",
      "highlights": ["Professional tips", "Hands-on practice", "Portfolio review"],
      "photos": 25,
      "certificate": true,
      "tags": ["Photography", "Workshop", "Learning"],
      "feedback": "Comprehensive course with excellent instructor guidance.",
      "wouldRecommend": true,
    },
    {
      "id": "past6",
      "title": "Business Networking Dinner",
      "date": "2024-03-30",
      "time": "19:00",
      "location": "Business Club",
      "price": 95.00,
      "image": "https://picsum.photos/400/250?random=46&keyword=business",
      "category": "Business",
      "attendees": 150,
      "actualAttendees": 140,
      "rating": 4.4,
      "organizer": "Business Network",
      "status": "Completed",
      "myRating": 3,
      "hasReview": true,
      "myReview": "Good networking opportunity but food could be better.",
      "highlights": ["Guest speaker", "Networking session", "3-course dinner"],
      "photos": 20,
      "certificate": false,
      "tags": ["Networking", "Business", "Dinner"],
      "feedback": "Valuable connections made, venue was professional.",
      "wouldRecommend": false,
    },
  ];

  List<Map<String, dynamic>> get filteredAndSortedEvents {
    List<Map<String, dynamic>> filtered = pastEvents;
    
    // Apply filter
    if (selectedFilter != "All") {
      if (["Technology", "Music", "Sports", "Food", "Arts", "Business"].contains(selectedFilter)) {
        filtered = filtered.where((event) => event["category"] == selectedFilter).toList();
      }
    }
    
    if (showRatedOnly) {
      filtered = filtered.where((event) => (event["myRating"] as int) > 0).toList();
    }
    
    // Apply sorting
    switch (selectedSort) {
      case "recent":
        filtered.sort((a, b) => (b["date"] as String).compareTo(a["date"] as String));
        break;
      case "oldest":
        filtered.sort((a, b) => (a["date"] as String).compareTo(b["date"] as String));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "attendees":
        filtered.sort((a, b) => (b["actualAttendees"] as int).compareTo(a["actualAttendees"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Events"),
        actions: [
          Icon(
            Icons.history,
            color: primaryColor,
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
                        Icons.check_circle,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Past Events",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Your event history & memories",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Text(
                          "📸 ${pastEvents.fold(0, (sum, event) => sum + (event["photos"] as int))} photos",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Text(
                          "🏆 ${pastEvents.where((e) => e["certificate"] == true).length} certificates",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Show Rated Only Toggle
            QSwitch(
              items: [
                {
                  "label": "Show only rated events",
                  "value": true,
                  "checked": showRatedOnly,
                }
              ],
              value: [if (showRatedOnly) {"label": "Show only rated events", "value": true, "checked": true}],
              onChanged: (values, ids) {
                showRatedOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Summary Stats
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Events", "${filteredAndSortedEvents.length}", Icons.event, primaryColor),
                _buildStatCard("Avg Rating", "${filteredAndSortedEvents.isEmpty ? 0 : (filteredAndSortedEvents.fold(0.0, (sum, event) => sum + (event["rating"] as double)) / filteredAndSortedEvents.length).toStringAsFixed(1)}", Icons.star, warningColor),
                _buildStatCard("My Reviews", "${filteredAndSortedEvents.where((e) => e["hasReview"] == true).length}", Icons.rate_review, infoColor),
                _buildStatCard("Certificates", "${filteredAndSortedEvents.where((e) => e["certificate"] == true).length}", Icons.workspace_premium, successColor),
              ],
            ),

            SizedBox(height: spLg),

            // Events List Header
            Row(
              children: [
                Text(
                  "Event History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredAndSortedEvents.length} events",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Past Events List
            Column(
              children: filteredAndSortedEvents.map((event) => _buildPastEventCard(event)).toList(),
            ),

            if (filteredAndSortedEvents.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No past events found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters to see more events",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
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
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastEventCard(Map<String, dynamic> event) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image with Status Badge
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  image: DecorationImage(
                    image: NetworkImage("${event["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: spMd,
                left: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 4),
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
              if (event["certificate"] == true)
                Positioned(
                  top: spMd,
                  right: spMd,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.workspace_premium,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              Positioned(
                bottom: spMd,
                right: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "${event["photos"]} photos",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Event Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${event["category"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 14,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${event["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                SizedBox(height: spSm),

                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${event["date"]} at ${event["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${event["location"]} • ${event["organizer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Event Stats
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(15),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${event["actualAttendees"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Attended",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((event["price"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Paid",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${event["highlights"].length}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Highlights",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spMd),

                // My Rating Section
                if ((event["myRating"] as int) > 0) ...[
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(100)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "My Rating:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Row(
                              children: List.generate(5, (index) => Icon(
                                index < (event["myRating"] as int) ? Icons.star : Icons.star_border,
                                color: warningColor,
                                size: 16,
                              )),
                            ),
                          ],
                        ),
                        if (event["hasReview"] == true) ...[
                          SizedBox(height: spSm),
                          Text(
                            "${event["myReview"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: warningColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),
                ],

                // Highlights
                Text(
                  "Event Highlights:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  children: (event["highlights"] as List).map((highlight) => Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "$highlight",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),

                SizedBox(height: spMd),

                // Action Buttons
                Row(
                  children: [
                    if ((event["myRating"] as int) == 0)
                      Expanded(
                        child: QButton(
                          label: "Rate Event",
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening rating dialog...");
                          },
                        ),
                      ),
                    if ((event["myRating"] as int) == 0) SizedBox(width: spMd),
                    Expanded(
                      child: QButton(
                        label: "View Photos",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening photo gallery...");
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QButton(
                        label: "Share",
                        size: bs.sm,
                        onPressed: () {
                          ss("Sharing event memory...");
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
  }
}
