import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFavorite6View extends StatefulWidget {
  @override
  State<GrlFavorite6View> createState() => _GrlFavorite6ViewState();
}

class _GrlFavorite6ViewState extends State<GrlFavorite6View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Recent";
  bool showOnlyAvailable = false;

  List<Map<String, dynamic>> favoriteEvents = [
    {
      "id": 1,
      "name": "Jazz Night Live",
      "category": "Music",
      "date": "2024-02-15",
      "time": "8:00 PM",
      "venue": "Blue Note Club",
      "location": "Downtown",
      "price": 45.0,
      "image": "https://picsum.photos/150/150?random=1&keyword=jazz",
      "rating": 4.8,
      "attendees": 120,
      "available": true,
      "ticketsLeft": 25,
      "description": "An evening of smooth jazz with renowned artists",
      "duration": "3 hours",
      "organizer": "Music Events Co",
      "tags": ["Live Music", "Jazz", "Premium"]
    },
    {
      "id": 2,
      "name": "Food Festival 2024",
      "category": "Food",
      "date": "2024-02-20",
      "time": "11:00 AM",
      "venue": "City Park",
      "location": "Central Park",
      "price": 25.0,
      "image": "https://picsum.photos/150/150?random=2&keyword=food",
      "rating": 4.6,
      "attendees": 450,
      "available": true,
      "ticketsLeft": 150,
      "description": "Taste the best food from local restaurants",
      "duration": "8 hours",
      "organizer": "Foodie Society",
      "tags": ["Food", "Family", "Outdoor"]
    },
    {
      "id": 3,
      "name": "Tech Conference 2024",
      "category": "Conference",
      "date": "2024-02-25",
      "time": "9:00 AM",
      "venue": "Convention Center",
      "location": "Business District",
      "price": 120.0,
      "image": "https://picsum.photos/150/150?random=3&keyword=tech",
      "rating": 4.9,
      "attendees": 200,
      "available": false,
      "ticketsLeft": 0,
      "description": "Latest trends in technology and innovation",
      "duration": "2 days",
      "organizer": "Tech Hub",
      "tags": ["Technology", "Networking", "Professional"]
    },
    {
      "id": 4,
      "name": "Art Exhibition Opening",
      "category": "Art",
      "date": "2024-02-18",
      "time": "6:00 PM",
      "venue": "Modern Art Gallery",
      "location": "Arts District",
      "price": 15.0,
      "image": "https://picsum.photos/150/150?random=4&keyword=art",
      "rating": 4.7,
      "attendees": 80,
      "available": true,
      "ticketsLeft": 40,
      "description": "Contemporary art from emerging artists",
      "duration": "4 hours",
      "organizer": "Gallery Arts",
      "tags": ["Art", "Culture", "Exhibition"]
    },
    {
      "id": 5,
      "name": "Marathon Championship",
      "category": "Sports",
      "date": "2024-03-01",
      "time": "7:00 AM",
      "venue": "City Streets",
      "location": "Starting Point: Stadium",
      "price": 35.0,
      "image": "https://picsum.photos/150/150?random=5&keyword=marathon",
      "rating": 4.5,
      "attendees": 300,
      "available": true,
      "ticketsLeft": 75,
      "description": "Annual city marathon with prizes",
      "duration": "6 hours",
      "organizer": "Sports Club",
      "tags": ["Sports", "Health", "Competition"]
    }
  ];

  List<Map<String, dynamic>> get filteredEvents {
    var filtered = favoriteEvents.where((event) {
      bool matchesSearch = event["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          event["venue"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || event["category"] == selectedCategory;
      bool matchesAvailability = !showOnlyAvailable || (event["available"] as bool);
      
      return matchesSearch && matchesCategory && matchesAvailability;
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case "Recent":
          return DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"]));
        case "Price":
          return (a["price"] as double).compareTo(b["price"] as double);
        case "Rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "Popular":
          return (b["attendees"] as int).compareTo(a["attendees"] as int);
        default:
          return a["name"].toString().compareTo(b["name"].toString());
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Events"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  _buildStatCard("Total Events", "${favoriteEvents.length}", Icons.event),
                  _buildStatCard("Available", "${favoriteEvents.where((e) => e["available"] as bool).length}", Icons.confirmation_number),
                  _buildStatCard("This Month", "${favoriteEvents.where((e) => DateTime.parse(e["date"]).month == DateTime.now().month).length}", Icons.calendar_month),
                ],
              ),
            ),

            // Search and Filters
            Row(
              spacing: spSm,
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            // Filter Options
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: [
                      {"label": "All Categories", "value": "All"},
                      {"label": "Music", "value": "Music"},
                      {"label": "Food", "value": "Food"},
                      {"label": "Conference", "value": "Conference"},
                      {"label": "Art", "value": "Art"},
                      {"label": "Sports", "value": "Sports"},
                    ],
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: [
                      {"label": "Recent", "value": "Recent"},
                      {"label": "Price", "value": "Price"},
                      {"label": "Rating", "value": "Rating"},
                      {"label": "Popular", "value": "Popular"},
                      {"label": "Name", "value": "Name"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Available Only Toggle
            QSwitch(
              items: [
                {
                  "label": "Show only available events",
                  "value": true,
                  "checked": showOnlyAvailable,
                }
              ],
              value: showOnlyAvailable ? [{"label": "Show only available events", "value": true, "checked": true}] : [],
              onChanged: (values, ids) {
                showOnlyAvailable = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Events List
            if (filteredEvents.isEmpty)
              Container(
                height: 200,
                child: Column(
                  spacing: spSm,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledColor,
                    ),
                    Text(
                      "No favorite events found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Browse Events",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            else
              ...filteredEvents.map((event) => _buildEventCard(event)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    bool isAvailable = event["available"] as bool;
    DateTime eventDate = DateTime.parse(event["date"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: spSm,
            children: [
              // Event Image
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${event["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),

              // Event Info
              Expanded(
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${event["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isAvailable ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isAvailable ? "Available" : "Sold Out",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${event["venue"]} • ${event["location"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "${event["rating"]} • ${event["attendees"]} attending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(event["price"] as double).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Event Details
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${eventDate.day}/${eventDate.month}/${eventDate.year}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${event["time"]}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                    Spacer(),
                    if (isAvailable)
                      Text(
                        "${event["ticketsLeft"]} tickets left",
                        style: TextStyle(
                          fontSize: 11,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Tags
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (event["tags"] as List).map((tag) => Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
          ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: isAvailable ? "Get Tickets" : "Join Waitlist",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              QButton(
                icon: Icons.favorite,
                size: bs.sm,
                color: dangerColor,
                onPressed: () async {
                  bool isConfirmed = await confirm("Remove '${event["name"]}' from favorites?");
                  if (isConfirmed) {
                    favoriteEvents.removeWhere((e) => e["id"] == event["id"]);
                    setState(() {});
                    ss("Event removed from favorites");
                  }
                },
              ),
              QButton(
                icon: Icons.event,
                size: bs.sm,
                color: infoColor,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
