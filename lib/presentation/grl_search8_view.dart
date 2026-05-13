import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSearch8View extends StatefulWidget {
  @override
  State<GrlSearch8View> createState() => _GrlSearch8ViewState();
}

class _GrlSearch8ViewState extends State<GrlSearch8View> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedLocation = "all";
  String selectedPriceRange = "all";
  String selectedDate = "all";
  bool isNearMeOnly = false;

  List<String> popularSearches = [
    "music concert",
    "food festival",
    "art exhibition",
    "sports game",
    "comedy show"
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Music & Concerts", "value": "music"},
    {"label": "Food & Drink", "value": "food"},
    {"label": "Arts & Culture", "value": "arts"},
    {"label": "Sports & Fitness", "value": "sports"},
    {"label": "Technology", "value": "tech"},
    {"label": "Business", "value": "business"}
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "all"},
    {"label": "New York", "value": "new_york"},
    {"label": "Los Angeles", "value": "los_angeles"},
    {"label": "Chicago", "value": "chicago"},
    {"label": "Miami", "value": "miami"},
    {"label": "Online", "value": "online"}
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "all"},
    {"label": "Free", "value": "free"},
    {"label": "Under \$25", "value": "under_25"},
    {"label": "\$25 - \$100", "value": "25_100"},
    {"label": "Over \$100", "value": "over_100"}
  ];

  List<Map<String, dynamic>> dateRanges = [
    {"label": "All Dates", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "Tomorrow", "value": "tomorrow"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"}
  ];

  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Summer Music Festival 2024",
      "category": "Music & Concerts",
      "date": "2024-07-15",
      "time": "6:00 PM",
      "location": "Central Park, New York",
      "venue": "Great Lawn",
      "price": 75.00,
      "originalPrice": 95.00,
      "image": "https://picsum.photos/400/250?random=1&keyword=concert",
      "organizer": "Live Nation",
      "capacity": 50000,
      "attendees": 12500,
      "featured": true,
      "soldOut": false,
      "earlyBird": false,
      "description": "Join us for an unforgettable night of music featuring top artists from around the world.",
      "artists": ["The Midnight", "Electric Youth", "FM-84"],
      "duration": "6 hours",
      "ageRestriction": "All Ages",
      "tags": ["Music", "Festival", "Outdoor", "Live Performance"]
    },
    {
      "id": 2,
      "title": "Food & Wine Expo",
      "category": "Food & Drink",
      "date": "2024-07-20",
      "time": "12:00 PM",
      "location": "Convention Center, Los Angeles",
      "venue": "Hall A",
      "price": 0.00,
      "originalPrice": 0.00,
      "image": "https://picsum.photos/400/250?random=2&keyword=food",
      "organizer": "Culinary Events LA",
      "capacity": 5000,
      "attendees": 2800,
      "featured": false,
      "soldOut": false,
      "earlyBird": true,
      "description": "Taste amazing dishes from the city's best restaurants and discover new flavors.",
      "chefs": ["Gordon Ramsay", "Martha Stewart", "Anthony Bourdain"],
      "duration": "4 hours",
      "ageRestriction": "21+",
      "tags": ["Food", "Wine", "Tasting", "Culinary"]
    },
    {
      "id": 3,
      "title": "Tech Innovation Summit",
      "category": "Technology",
      "date": "2024-07-25",
      "time": "9:00 AM",
      "location": "Online Event",
      "venue": "Virtual Platform",
      "price": 149.00,
      "originalPrice": 199.00,
      "image": "https://picsum.photos/400/250?random=3&keyword=technology",
      "organizer": "TechCorp",
      "capacity": 10000,
      "attendees": 7500,
      "featured": true,
      "soldOut": false,
      "earlyBird": true,
      "description": "Discover the latest innovations in AI, blockchain, and emerging technologies.",
      "speakers": ["Elon Musk", "Sundar Pichai", "Satya Nadella"],
      "duration": "8 hours",
      "ageRestriction": "Professional",
      "tags": ["Technology", "AI", "Innovation", "Business"]
    },
    {
      "id": 4,
      "title": "Art Gallery Opening",
      "category": "Arts & Culture",
      "date": "2024-07-18",
      "time": "7:00 PM",
      "location": "Modern Art Museum, Chicago",
      "venue": "Gallery Floor 2",
      "price": 25.00,
      "originalPrice": 35.00,
      "image": "https://picsum.photos/400/250?random=4&keyword=art",
      "organizer": "Chicago Arts Foundation",
      "capacity": 300,
      "attendees": 275,
      "featured": false,
      "soldOut": true,
      "earlyBird": false,
      "description": "Exclusive opening of contemporary art exhibition featuring local and international artists.",
      "artists": ["Pablo Picasso", "Vincent van Gogh", "Andy Warhol"],
      "duration": "3 hours",
      "ageRestriction": "All Ages",
      "tags": ["Art", "Exhibition", "Culture", "Opening"]
    },
    {
      "id": 5,
      "title": "Startup Pitch Competition",
      "category": "Business",
      "date": "2024-07-22",
      "time": "2:00 PM",
      "location": "Innovation Hub, Miami",
      "venue": "Auditorium",
      "price": 50.00,
      "originalPrice": 75.00,
      "image": "https://picsum.photos/400/250?random=5&keyword=business",
      "organizer": "Startup Miami",
      "capacity": 500,
      "attendees": 350,
      "featured": true,
      "soldOut": false,
      "earlyBird": true,
      "description": "Watch innovative startups pitch their ideas to top investors and win funding.",
      "judges": ["Mark Cuban", "Barbara Corcoran", "Kevin O'Leary"],
      "duration": "4 hours",
      "ageRestriction": "Professional",
      "tags": ["Business", "Startup", "Investment", "Competition"]
    }
  ];

  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = events;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((event) => 
        event["category"].toString().toLowerCase().contains(selectedCategory.toLowerCase())
      ).toList();
    }
    
    if (selectedLocation != "all") {
      filtered = filtered.where((event) => 
        event["location"].toString().toLowerCase().contains(selectedLocation.replaceAll("_", " "))
      ).toList();
    }
    
    return filtered;
  }

  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case "music & concerts":
        return Colors.purple;
      case "food & drink":
        return warningColor;
      case "arts & culture":
        return infoColor;
      case "sports & fitness":
        return successColor;
      case "technology":
        return primaryColor;
      case "business":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Show calendar view
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // Show map view
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
            // Search Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Discover Amazing Events",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Find concerts, festivals, workshops and more near you",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  
                  // Search Input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: spSm),
                        Icon(
                          Icons.search,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Search events...",
                            value: searchQuery,
                            hint: "e.g. music festival, art show",
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(spXs),
                          child: QButton(
                            icon: Icons.search,
                            size: bs.sm,
                            onPressed: () {
                              // Perform search
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Quick Filters
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

            // Additional Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Price",
                    items: priceRanges,
                    value: selectedPriceRange,
                    onChanged: (value, label) {
                      selectedPriceRange = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Date",
                    items: dateRanges,
                    value: selectedDate,
                    onChanged: (value, label) {
                      selectedDate = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Near Me Toggle
            QSwitch(
              items: [
                {
                  "label": "Events Near Me",
                  "value": true,
                  "checked": isNearMeOnly,
                }
              ],
              value: [if (isNearMeOnly) {"label": "Events Near Me", "value": true, "checked": true}],
              onChanged: (values, ids) {
                isNearMeOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Content based on search state
            if (searchQuery.isEmpty) ...[
              // Popular Searches
              Text(
                "Popular Searches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: popularSearches.map((search) {
                    return GestureDetector(
                      onTap: () {
                        searchQuery = search;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor.withAlpha(200), primaryColor.withAlpha(150)],
                          ),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_up,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              search,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Featured Events
              SizedBox(height: spMd),
              Text(
                "Featured Events",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: events.where((event) => event["featured"] as bool).map((event) {
                  return Container(
                    width: 300,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowMd],
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Featured Badge
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Featured Event",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Event Image
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(radiusSm),
                                bottomRight: Radius.circular(radiusSm),
                              ),
                              child: Image.network(
                                "${event["image"]}",
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (event["earlyBird"] as bool) ...[
                              Positioned(
                                top: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Early Bird",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            if (event["soldOut"] as bool) ...[
                              Positioned(
                                top: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Sold Out",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        // Event Details
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getCategoryColor(event["category"]).withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${event["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: getCategoryColor(event["category"]),
                                  ),
                                ),
                              ),
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
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
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
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${event["location"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if ((event["price"] as double) > 0) ...[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "\$${((event["price"] as double)).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                        if ((event["originalPrice"] as double) > (event["price"] as double)) ...[
                                          Text(
                                            "\$${((event["originalPrice"] as double)).currency}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ] else ...[
                                    Text(
                                      "FREE",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                  Text(
                                    "${((event["attendees"] as int) / 1000).toStringAsFixed(1)}K going",
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
                  );
                }).toList(),
              ),

              // Event Categories
              SizedBox(height: spMd),
              Text(
                "Browse by Category",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.all(spXs),
                minItemWidth: 200,
                children: [
                  {
                    "title": "Music & Concerts",
                    "icon": Icons.music_note,
                    "count": 245,
                    "color": Colors.purple
                  },
                  {
                    "title": "Food & Drink",
                    "icon": Icons.restaurant,
                    "count": 156,
                    "color": warningColor
                  },
                  {
                    "title": "Arts & Culture",
                    "icon": Icons.palette,
                    "count": 89,
                    "color": infoColor
                  },
                  {
                    "title": "Sports & Fitness",
                    "icon": Icons.sports_soccer,
                    "count": 67,
                    "color": successColor
                  },
                  {
                    "title": "Technology",
                    "icon": Icons.computer,
                    "count": 134,
                    "color": primaryColor
                  },
                  {
                    "title": "Business",
                    "icon": Icons.business,
                    "count": 78,
                    "color": dangerColor
                  }
                ].map((category) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (category["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            size: 32,
                            color: category["color"] as Color,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${category["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(category["count"] as int)} events",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            // Search Results
            if (searchQuery.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredEvents.length} events found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Sort by: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),

              // Event Results
              Column(
                spacing: spSm,
                children: filteredEvents.map((event) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: (event["featured"] as bool)
                          ? Border.all(color: primaryColor, width: 1)
                          : null,
                    ),
                    child: Column(
                      children: [
                        // Status Badges
                        if ((event["featured"] as bool) || (event["soldOut"] as bool) || (event["earlyBird"] as bool)) ...[
                          Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                if (event["featured"] as bool) ...[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(radiusSm),
                                          topRight: ((event["soldOut"] as bool) || (event["earlyBird"] as bool)) 
                                              ? Radius.zero 
                                              : Radius.circular(radiusSm),
                                        ),
                                      ),
                                      child: Text(
                                        "Featured",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                if (event["earlyBird"] as bool) ...[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: (event["featured"] as bool) 
                                              ? Radius.zero 
                                              : Radius.circular(radiusSm),
                                          topRight: (event["soldOut"] as bool) 
                                              ? Radius.zero 
                                              : Radius.circular(radiusSm),
                                        ),
                                      ),
                                      child: Text(
                                        "Early Bird",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                if (event["soldOut"] as bool) ...[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: ((event["featured"] as bool) || (event["earlyBird"] as bool)) 
                                              ? Radius.zero 
                                              : Radius.circular(radiusSm),
                                          topRight: Radius.circular(radiusSm),
                                        ),
                                      ),
                                      child: Text(
                                        "Sold Out",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],

                        // Event Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              // Event Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${event["image"]}",
                                  width: 120,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),

                              // Event Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getCategoryColor(event["category"]).withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${event["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: getCategoryColor(event["category"]),
                                        ),
                                      ),
                                    ),
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
                                          Icons.calendar_today,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${event["date"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${event["time"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            "${event["location"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        if ((event["price"] as double) > 0) ...[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "\$${((event["price"] as double)).currency}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: successColor,
                                                ),
                                              ),
                                              if ((event["originalPrice"] as double) > (event["price"] as double)) ...[
                                                Text(
                                                  "\$${((event["originalPrice"] as double)).currency}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: disabledBoldColor,
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ] else ...[
                                          Text(
                                            "FREE EVENT",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${((event["attendees"] as int) / 1000).toStringAsFixed(1)}K",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "going",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
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
                        ),

                        // Tags
                        if (event["tags"] != null) ...[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: spSm),
                            child: Wrap(
                              spacing: spXs,
                              children: (event["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: spSm),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
