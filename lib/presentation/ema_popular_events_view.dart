import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaPopularEventsView extends StatefulWidget {
  const EmaPopularEventsView({super.key});

  @override
  State<EmaPopularEventsView> createState() => _EmaPopularEventsViewState();
}

class _EmaPopularEventsViewState extends State<EmaPopularEventsView> {
  String selectedSort = "attendees";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Attendees", "value": "attendees"},
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Most Recent", "value": "date"},
    {"label": "Lowest Price", "value": "price"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Events", "value": "All"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
  ];

  List<Map<String, dynamic>> popularEvents = [
    {
      "id": "pop1",
      "title": "Global Tech Conference 2024",
      "date": "2024-07-20",
      "time": "09:00",
      "location": "Tech Arena",
      "price": 450.00,
      "image": "https://picsum.photos/400/250?random=11&keyword=technology",
      "category": "Technology",
      "attendees": 12500,
      "rating": 4.9,
      "organizer": "TechGlobal Inc",
      "popularity": 98,
      "trending": true,
      "tags": ["AI", "Innovation", "Networking"],
      "description": "The world's largest technology conference featuring industry leaders.",
    },
    {
      "id": "pop2",
      "title": "Rock Music Festival",
      "date": "2024-08-15",
      "time": "16:00",
      "location": "Stadium Arena",
      "price": 125.00,
      "image": "https://picsum.photos/400/250?random=12&keyword=music",
      "category": "Music",
      "attendees": 50000,
      "rating": 4.8,
      "organizer": "Rock Events Ltd",
      "popularity": 95,
      "trending": true,
      "tags": ["Live Music", "Festival", "Rock"],
      "description": "Three days of non-stop rock music from international artists.",
    },
    {
      "id": "pop3",
      "title": "World Cup Viewing Party",
      "date": "2024-07-30",
      "time": "19:00",
      "location": "Sports Bar Central",
      "price": 35.00,
      "image": "https://picsum.photos/400/250?random=13&keyword=sports",
      "category": "Sports",
      "attendees": 8500,
      "rating": 4.7,
      "organizer": "Sports Central",
      "popularity": 92,
      "trending": false,
      "tags": ["Football", "Viewing", "Social"],
      "description": "Watch the biggest matches with fellow sports enthusiasts.",
    },
    {
      "id": "pop4",
      "title": "Startup Meetup Silicon Valley",
      "date": "2024-08-05",
      "time": "18:30",
      "location": "Innovation Hub",
      "price": 25.00,
      "image": "https://picsum.photos/400/250?random=14&keyword=business",
      "category": "Business",
      "attendees": 2500,
      "rating": 4.8,
      "organizer": "SV Entrepreneurs",
      "popularity": 88,
      "trending": true,
      "tags": ["Startups", "Networking", "Pitch"],
      "description": "Connect with entrepreneurs and investors in Silicon Valley.",
    },
    {
      "id": "pop5",
      "title": "Food Truck Festival",
      "date": "2024-08-12",
      "time": "11:00",
      "location": "City Park",
      "price": 15.00,
      "image": "https://picsum.photos/400/250?random=15&keyword=food",
      "category": "Food",
      "attendees": 15000,
      "rating": 4.6,
      "organizer": "City Events",
      "popularity": 85,
      "trending": false,
      "tags": ["Food", "Family", "Outdoor"],
      "description": "Taste delicious food from the city's best food trucks.",
    },
    {
      "id": "pop6",
      "title": "Photography Workshop",
      "date": "2024-09-01",
      "time": "10:00",
      "location": "Creative Studio",
      "price": 85.00,
      "image": "https://picsum.photos/400/250?random=16&keyword=photography",
      "category": "Arts",
      "attendees": 150,
      "rating": 4.9,
      "organizer": "Pro Photo Academy",
      "popularity": 82,
      "trending": false,
      "tags": ["Workshop", "Photography", "Learning"],
      "description": "Learn professional photography techniques from experts.",
    },
  ];

  List<Map<String, dynamic>> get filteredAndSortedEvents {
    List<Map<String, dynamic>> filtered = popularEvents;
    
    // Apply filter
    if (selectedFilter != "All") {
      if (["Technology", "Music", "Sports", "Business", "Food", "Arts"].contains(selectedFilter)) {
        filtered = filtered.where((event) => event["category"] == selectedFilter).toList();
      }
    }
    
    // Apply sorting
    switch (selectedSort) {
      case "attendees":
        filtered.sort((a, b) => (b["attendees"] as int).compareTo(a["attendees"] as int));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "price":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "date":
        filtered.sort((a, b) => (b["date"] as String).compareTo(a["date"] as String));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Events"),
        actions: [
          Icon(
            Icons.search,
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
            // Header Section with Trending Indicator
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Popular Events",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Most attended events this month",
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
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "🔥 ${popularEvents.where((e) => e["trending"] == true).length} Trending Now",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
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

            // Filter and Sort Controls
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

            SizedBox(height: spLg),

            // Popular Events Stats
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Events", "${filteredAndSortedEvents.length}", Icons.event, primaryColor),
                _buildStatCard("Total Attendees", "${filteredAndSortedEvents.fold(0, (sum, event) => sum + (event["attendees"] as int)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}+", Icons.people, successColor),
                _buildStatCard("Avg Rating", "${(filteredAndSortedEvents.fold(0.0, (sum, event) => sum + (event["rating"] as double)) / filteredAndSortedEvents.length).toStringAsFixed(1)}", Icons.star, warningColor),
                _buildStatCard("Trending", "${filteredAndSortedEvents.where((e) => e["trending"] == true).length}", Icons.trending_up, infoColor),
              ],
            ),

            SizedBox(height: spLg),

            // Events List Header
            Row(
              children: [
                Text(
                  "All Popular Events",
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

            // Popular Events List
            Column(
              children: filteredAndSortedEvents.map((event) => _buildPopularEventCard(event)).toList(),
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

  Widget _buildPopularEventCard(Map<String, dynamic> event) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Event Image with Popularity Badge
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusMd)),
                  image: DecorationImage(
                    image: NetworkImage("${event["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (event["trending"] == true)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "🔥",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${event["popularity"]}%",
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
          Expanded(
            child: Padding(
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
                            fontSize: 10,
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
                            size: 12,
                          ),
                          Text(
                            " ${event["rating"]}",
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

                  SizedBox(height: spSm),

                  Text(
                    "${event["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: spSm),

                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: disabledBoldColor,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${((event["attendees"] as int) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.calendar_today,
                        color: disabledBoldColor,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${event["date"]}",
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
                      Text(
                        "\$${((event["price"] as double).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Join",
                        size: bs.sm,
                        onPressed: () {
                          ss("Joining popular event!");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
