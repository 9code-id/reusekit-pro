import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSavedEventsView extends StatefulWidget {
  const EmaSavedEventsView({super.key});

  @override
  State<EmaSavedEventsView> createState() => _EmaSavedEventsViewState();
}

class _EmaSavedEventsViewState extends State<EmaSavedEventsView> {
  String selectedFilter = "All";
  String selectedSort = "recent";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Categories", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Food & Drinks", "value": "Food"},
    {"label": "Business", "value": "Business"},
    {"label": "Arts", "value": "Arts"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recently Saved", "value": "recent"},
    {"label": "Event Date", "value": "date"},
    {"label": "Price: Low to High", "value": "price_low"},
    {"label": "Price: High to Low", "value": "price_high"},
    {"label": "Popularity", "value": "popularity"},
  ];

  List<Map<String, dynamic>> savedEvents = [
    {
      "id": "saved1",
      "title": "AI & Machine Learning Summit",
      "date": "2024-08-15",
      "time": "09:00",
      "location": "Tech Convention Center",
      "price": 299.00,
      "originalPrice": 399.00,
      "image": "https://picsum.photos/400/250?random=61&keyword=ai",
      "category": "Technology",
      "attendees": 2500,
      "rating": 4.9,
      "organizer": "AI Research Institute",
      "savedDate": "2024-06-15",
      "isUpcoming": true,
      "daysSaved": 2,
      "tags": ["AI", "Machine Learning", "Technology"],
      "description": "Comprehensive summit on the latest AI and ML technologies.",
      "isEarlyBird": true,
      "earlyBirdEnds": "2024-07-01",
      "availability": "Few spots left",
      "reminderSet": true,
    },
    {
      "id": "saved2",
      "title": "Indie Music Festival 2024",
      "date": "2024-07-20",
      "time": "16:00",
      "location": "Central Park Amphitheater",
      "price": 85.00,
      "originalPrice": 85.00,
      "image": "https://picsum.photos/400/250?random=62&keyword=indie",
      "category": "Music",
      "attendees": 8000,
      "rating": 4.7,
      "organizer": "Indie Music Collective",
      "savedDate": "2024-06-10",
      "isUpcoming": true,
      "daysSaved": 7,
      "tags": ["Indie", "Live Music", "Festival"],
      "description": "Three days of amazing indie music from emerging artists.",
      "isEarlyBird": false,
      "earlyBirdEnds": "",
      "availability": "Available",
      "reminderSet": false,
    },
    {
      "id": "saved3",
      "title": "Professional Photography Workshop",
      "date": "2024-09-10",
      "time": "10:00",
      "location": "Photo Studio Pro",
      "price": 180.00,
      "originalPrice": 220.00,
      "image": "https://picsum.photos/400/250?random=63&keyword=photography",
      "category": "Arts",
      "attendees": 50,
      "rating": 4.8,
      "organizer": "Professional Photographers Guild",
      "savedDate": "2024-06-12",
      "isUpcoming": true,
      "daysSaved": 5,
      "tags": ["Photography", "Professional", "Workshop"],
      "description": "Advanced photography techniques with industry professionals.",
      "isEarlyBird": true,
      "earlyBirdEnds": "2024-08-01",
      "availability": "Limited seats",
      "reminderSet": true,
    },
    {
      "id": "saved4",
      "title": "Startup Networking Dinner",
      "date": "2024-07-05",
      "time": "19:00",
      "location": "Business District Hotel",
      "price": 125.00,
      "originalPrice": 125.00,
      "image": "https://picsum.photos/400/250?random=64&keyword=networking",
      "category": "Business",
      "attendees": 200,
      "rating": 4.5,
      "organizer": "Entrepreneur Network",
      "savedDate": "2024-06-08",
      "isUpcoming": true,
      "daysSaved": 9,
      "tags": ["Networking", "Startups", "Business"],
      "description": "Exclusive networking event for startup founders and investors.",
      "isEarlyBird": false,
      "earlyBirdEnds": "",
      "availability": "Available",
      "reminderSet": false,
    },
    {
      "id": "saved5",
      "title": "Marathon Training Workshop",
      "date": "2024-08-03",
      "time": "06:00",
      "location": "City Sports Complex",
      "price": 45.00,
      "originalPrice": 60.00,
      "image": "https://picsum.photos/400/250?random=65&keyword=marathon",
      "category": "Sports",
      "attendees": 300,
      "rating": 4.6,
      "organizer": "City Running Club",
      "savedDate": "2024-06-14",
      "isUpcoming": true,
      "daysSaved": 3,
      "tags": ["Running", "Marathon", "Training"],
      "description": "Professional marathon training for all skill levels.",
      "isEarlyBird": true,
      "earlyBirdEnds": "2024-07-15",
      "availability": "Available",
      "reminderSet": true,
    },
    {
      "id": "saved6",
      "title": "Gourmet Cooking Masterclass",
      "date": "2024-07-28",
      "time": "14:00",
      "location": "Culinary Institute",
      "price": 250.00,
      "originalPrice": 300.00,
      "image": "https://picsum.photos/400/250?random=66&keyword=cooking",
      "category": "Food",
      "attendees": 40,
      "rating": 4.9,
      "organizer": "Master Chef Academy",
      "savedDate": "2024-06-16",
      "isUpcoming": true,
      "daysSaved": 1,
      "tags": ["Cooking", "Gourmet", "Masterclass"],
      "description": "Learn from Michelin-starred chefs in this exclusive masterclass.",
      "isEarlyBird": true,
      "earlyBirdEnds": "2024-06-30",
      "availability": "Almost full",
      "reminderSet": true,
    },
  ];

  List<Map<String, dynamic>> get filteredAndSortedEvents {
    List<Map<String, dynamic>> filtered = savedEvents;
    
    // Apply filter
    if (selectedFilter != "All") {
      filtered = filtered.where((event) => event["category"] == selectedFilter).toList();
    }
    
    // Apply sorting
    switch (selectedSort) {
      case "recent":
        filtered.sort((a, b) => (a["daysSaved"] as int).compareTo(b["daysSaved"] as int));
        break;
      case "date":
        filtered.sort((a, b) => (a["date"] as String).compareTo(b["date"] as String));
        break;
      case "price_low":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "popularity":
        filtered.sort((a, b) => (b["attendees"] as int).compareTo(a["attendees"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Events"),
        actions: [
          Icon(
            Icons.bookmark,
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
                  colors: [successColor, successColor.withAlpha(180)],
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
                        Icons.bookmark_added,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Saved Events",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Your bookmarked events collection",
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_offer,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${savedEvents.where((e) => e["isEarlyBird"] == true).length} early bird offers",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spMd),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${savedEvents.where((e) => e["reminderSet"] == true).length} with reminders",
                              style: TextStyle(
                                fontSize: 14,
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

            // Filter and Sort Controls
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

            // Saved Events Stats
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Saved", "${filteredAndSortedEvents.length}", Icons.bookmark, successColor),
                _buildStatCard("Total Value", "\$${((filteredAndSortedEvents.fold(0.0, (sum, event) => sum + (event["price"] as double))).toDouble()).currency}", Icons.attach_money, primaryColor),
                _buildStatCard("Early Birds", "${filteredAndSortedEvents.where((e) => e["isEarlyBird"] == true).length}", Icons.local_offer, warningColor),
                _buildStatCard("With Reminders", "${filteredAndSortedEvents.where((e) => e["reminderSet"] == true).length}", Icons.notifications, infoColor),
              ],
            ),

            SizedBox(height: spLg),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pro Tip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Set reminders for early bird offers to save more!",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Events List Header
            Row(
              children: [
                Text(
                  "Your Saved Events",
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

            // Saved Events List
            Column(
              children: filteredAndSortedEvents.map((event) => _buildSavedEventCard(event)).toList(),
            ),

            if (filteredAndSortedEvents.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No saved events found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Start exploring events to build your collection",
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

  Widget _buildSavedEventCard(Map<String, dynamic> event) {
    bool hasDiscount = (event["originalPrice"] as double) > (event["price"] as double);
    double discountPercent = hasDiscount ? (((event["originalPrice"] as double) - (event["price"] as double)) / (event["originalPrice"] as double)) * 100 : 0;

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
          // Event Image with Badges
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
                        Icons.bookmark,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "SAVED",
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
              if (event["isEarlyBird"] == true)
                Positioned(
                  top: spMd,
                  right: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "EARLY BIRD",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (hasDiscount)
                Positioned(
                  bottom: spMd,
                  left: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "-${discountPercent.toStringAsFixed(0)}% OFF",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: spMd,
                right: spMd,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (event["reminderSet"] == true)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.notifications_active,
                          color: warningColor,
                          size: 16,
                        ),
                      ),
                  ],
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
                        SizedBox(width: spSm),
                        Text(
                          "Saved ${event["daysSaved"]}d ago",
                          style: TextStyle(
                            fontSize: 11,
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

                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: disabledBoldColor,
                      size: 16,
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
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${event["location"]}",
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
                      Icons.people,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${event["attendees"]} attending • ${event["availability"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Early Bird Reminder
                if (event["isEarlyBird"] == true && event["earlyBirdEnds"].isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(100)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Text(
                            "Early bird offer ends on ${event["earlyBirdEnds"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (event["isEarlyBird"] == true && event["earlyBirdEnds"].isNotEmpty) 
                  SizedBox(height: spMd),

                // Tags
                QHorizontalScroll(
                  children: (event["tags"] as List).map((tag) => Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(100)),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  )).toList(),
                ),

                SizedBox(height: spMd),

                // Price and Actions
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hasDiscount) ...[
                          Text(
                            "\$${((event["originalPrice"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "\$${((event["price"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Save \$${(((event["originalPrice"] as double) - (event["price"] as double)).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          Text(
                            "\$${((event["price"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                        Text(
                          "By ${event["organizer"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        QButton(
                          icon: Icons.bookmark_remove,
                          size: bs.sm,
                          onPressed: () {
                            ss("Event removed from saved list");
                          },
                        ),
                        SizedBox(width: spSm),
                        if (event["reminderSet"] == false)
                          QButton(
                            icon: Icons.notifications,
                            size: bs.sm,
                            onPressed: () {
                              ss("Reminder set for this event!");
                            },
                          ),
                        if (event["reminderSet"] == false) SizedBox(width: spSm),
                        QButton(
                          label: "Book Now",
                          size: bs.sm,
                          onPressed: () {
                            ss("Booking saved event!");
                          },
                        ),
                      ],
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
