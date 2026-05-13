import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEvent5View extends StatefulWidget {
  @override
  State<GrlEvent5View> createState() => _GrlEvent5ViewState();
}

class _GrlEvent5ViewState extends State<GrlEvent5View> {
  String selectedCategory = "All";
  String selectedLocation = "All";
  DateTime selectedDate = DateTime.now();
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Music", "value": "Music"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Business", "value": "Business"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Art", "value": "Art"},
  ];
  
  List<Map<String, dynamic>> locations = [
    {"label": "All", "value": "All"},
    {"label": "New York", "value": "New York"},
    {"label": "Los Angeles", "value": "Los Angeles"},
    {"label": "Chicago", "value": "Chicago"},
    {"label": "Online", "value": "Online"},
  ];

  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Tech Innovation Summit 2024",
      "description": "Join industry leaders to explore the latest innovations in technology and digital transformation",
      "category": "Technology",
      "date": "2024-08-15",
      "time": "09:00 AM",
      "endTime": "06:00 PM",
      "location": "New York",
      "venue": "Manhattan Convention Center",
      "address": "123 Tech Ave, New York, NY 10001",
      "image": "https://picsum.photos/400/250?random=1&keyword=technology",
      "price": 299.99,
      "originalPrice": 399.99,
      "isFree": false,
      "organizer": "Tech Innovators Inc",
      "organizerImage": "https://picsum.photos/60/60?random=11&keyword=organizer",
      "attendees": 1250,
      "capacity": 1500,
      "rating": 4.8,
      "tags": ["Innovation", "Networking", "AI", "Blockchain"],
      "isOnline": false,
      "isFeatured": true,
      "speakers": [
        {"name": "Dr. Sarah Johnson", "title": "AI Research Director", "image": "https://picsum.photos/50/50?random=21&keyword=speaker"},
        {"name": "Mark Chen", "title": "Blockchain Expert", "image": "https://picsum.photos/50/50?random=22&keyword=speaker"},
      ],
    },
    {
      "id": 2,
      "title": "Summer Music Festival",
      "description": "Experience amazing live performances from top artists in a beautiful outdoor setting",
      "category": "Music",
      "date": "2024-07-28",
      "time": "02:00 PM",
      "endTime": "11:00 PM",
      "location": "Los Angeles",
      "venue": "Sunset Park Amphitheater",
      "address": "456 Music Blvd, Los Angeles, CA 90210",
      "image": "https://picsum.photos/400/250?random=2&keyword=music",
      "price": 89.99,
      "originalPrice": 120.00,
      "isFree": false,
      "organizer": "Sunset Events",
      "organizerImage": "https://picsum.photos/60/60?random=12&keyword=organizer",
      "attendees": 3200,
      "capacity": 4000,
      "rating": 4.6,
      "tags": ["Live Music", "Outdoor", "Festival", "Food"],
      "isOnline": false,
      "isFeatured": true,
      "speakers": [
        {"name": "The Stellar Band", "title": "Headliner", "image": "https://picsum.photos/50/50?random=23&keyword=band"},
        {"name": "DJ Cosmic", "title": "Electronic Set", "image": "https://picsum.photos/50/50?random=24&keyword=dj"},
      ],
    },
    {
      "id": 3,
      "title": "Digital Marketing Masterclass",
      "description": "Learn advanced digital marketing strategies from industry experts and boost your business growth",
      "category": "Business",
      "date": "2024-08-05",
      "time": "10:00 AM",
      "endTime": "04:00 PM",
      "location": "Online",
      "venue": "Virtual Conference Room",
      "address": "Online Event",
      "image": "https://picsum.photos/400/250?random=3&keyword=marketing",
      "price": 0.00,
      "originalPrice": 199.99,
      "isFree": true,
      "organizer": "Marketing Pro Academy",
      "organizerImage": "https://picsum.photos/60/60?random=13&keyword=organizer",
      "attendees": 850,
      "capacity": 1000,
      "rating": 4.9,
      "tags": ["Marketing", "Online", "Business Growth", "Strategy"],
      "isOnline": true,
      "isFeatured": false,
      "speakers": [
        {"name": "Jessica Miller", "title": "Marketing Director", "image": "https://picsum.photos/50/50?random=25&keyword=speaker"},
        {"name": "Tom Wilson", "title": "Growth Hacker", "image": "https://picsum.photos/50/50?random=26&keyword=speaker"},
      ],
    },
    {
      "id": 4,
      "title": "Art Gallery Opening",
      "description": "Discover contemporary art from emerging artists in an exclusive gallery opening event",
      "category": "Art",
      "date": "2024-08-10",
      "time": "07:00 PM",
      "endTime": "10:00 PM",
      "location": "Chicago",
      "venue": "Modern Art Gallery",
      "address": "789 Art District, Chicago, IL 60601",
      "image": "https://picsum.photos/400/250?random=4&keyword=art",
      "price": 25.00,
      "originalPrice": 35.00,
      "isFree": false,
      "organizer": "Chicago Art Collective",
      "organizerImage": "https://picsum.photos/60/60?random=14&keyword=organizer",
      "attendees": 180,
      "capacity": 250,
      "rating": 4.7,
      "tags": ["Art", "Gallery", "Contemporary", "Networking"],
      "isOnline": false,
      "isFeatured": false,
      "speakers": [
        {"name": "Maria Rodriguez", "title": "Curator", "image": "https://picsum.photos/50/50?random=27&keyword=speaker"},
        {"name": "David Kim", "title": "Artist", "image": "https://picsum.photos/50/50?random=28&keyword=speaker"},
      ],
    },
    {
      "id": 5,
      "title": "Professional Basketball Championship",
      "description": "Watch the most exciting basketball championship with top teams competing for the ultimate title",
      "category": "Sports",
      "date": "2024-08-20",
      "time": "07:30 PM",
      "endTime": "10:30 PM",
      "location": "Chicago",
      "venue": "United Center Arena",
      "address": "1901 W Madison St, Chicago, IL 60612",
      "image": "https://picsum.photos/400/250?random=5&keyword=basketball",
      "price": 159.99,
      "originalPrice": 199.99,
      "isFree": false,
      "organizer": "Sports Entertainment LLC",
      "organizerImage": "https://picsum.photos/60/60?random=15&keyword=organizer",
      "attendees": 18500,
      "capacity": 20000,
      "rating": 4.5,
      "tags": ["Basketball", "Championship", "Sports", "Live"],
      "isOnline": false,
      "isFeatured": true,
      "speakers": [
        {"name": "Coach Johnson", "title": "Team Coach", "image": "https://picsum.photos/50/50?random=29&keyword=coach"},
        {"name": "Mike Stevens", "title": "Sports Commentator", "image": "https://picsum.photos/50/50?random=30&keyword=commentator"},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    return events.where((event) {
      bool matchesSearch = "${event["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${event["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || event["category"] == selectedCategory;
      bool matchesLocation = selectedLocation == "All" || event["location"] == selectedLocation;
      return matchesSearch && matchesCategory && matchesLocation;
    }).toList();
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    double attendanceRate = (event["attendees"] as int) / (event["capacity"] as int);
    bool isNearCapacity = attendanceRate > 0.8;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: event["isFeatured"] == true ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${event["image"]}",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Featured Badge
              if (event["isFeatured"] == true)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "FEATURED",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              // Online Badge
              if (event["isOnline"] == true)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "ONLINE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              // Price Badge
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: event["isFree"] == true ? successColor : primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    event["isFree"] == true ? "FREE" : "\$${((event["price"] as double)).currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content Section
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Time
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${event["date"]} at ${event["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spSm),
                
                // Title and Category
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${event["title"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${event["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Description
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                // Location and Organizer
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            event["isOnline"] == true ? Icons.computer : Icons.location_on,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${event["venue"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("${event["organizerImage"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${event["organizer"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Attendees and Rating
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["attendees"]}/${event["capacity"]} attending",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (isNearCapacity) ...[
                      SizedBox(width: spXs),
                      Text(
                        "• Almost Full!",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    Spacer(),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Progress Bar
                LinearProgressIndicator(
                  value: attendanceRate,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isNearCapacity ? dangerColor : successColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (event["tags"] as List).map((tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),
                
                SizedBox(height: spSm),
                
                // Speakers
                if ((event["speakers"] as List).isNotEmpty) ...[
                  Text(
                    "Speakers:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: (event["speakers"] as List).take(3).map((speaker) => 
                      Container(
                        margin: EdgeInsets.only(right: spSm),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage("${speaker["image"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${speaker["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).toList(),
                  ),
                  SizedBox(height: spSm),
                ],
                
                // Price and Action
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (event["isFree"] == false && (event["originalPrice"] as double) > (event["price"] as double)) ...[
                            Text(
                              "\$${((event["originalPrice"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(height: spXs),
                          ],
                          Text(
                            event["isFree"] == true ? "FREE" : "\$${((event["price"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: event["isFree"] == true ? successColor : primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: isNearCapacity ? "Join Waitlist" : "Register Now",
                      size: bs.md,
                      onPressed: () {
                        if (isNearCapacity) {
                          ss("Added to waitlist!");
                        } else {
                          ss("Registration successful!");
                        }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
        actions: [
          Icon(Icons.favorite_border, color: disabledBoldColor),
          SizedBox(width: spSm),
          Icon(Icons.filter_list, color: disabledBoldColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search events...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locations,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Results Header
            Row(
              children: [
                Text(
                  "Upcoming Events",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredEvents.length} events",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Events List
            if (filteredEvents.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.event,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Events Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredEvents.map((event) => _buildEventCard(event)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
