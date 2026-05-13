import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSearchResultsView extends StatefulWidget {
  const EmaSearchResultsView({super.key});

  @override
  State<EmaSearchResultsView> createState() => _EmaSearchResultsViewState();
}

class _EmaSearchResultsViewState extends State<EmaSearchResultsView> {
  String searchQuery = "tech events";
  String selectedSortBy = "relevance";
  String selectedCategory = "All";
  String selectedLocation = "All Locations";
  bool showMapView = false;
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Relevance", "value": "relevance"},
    {"label": "Date (Nearest first)", "value": "date_asc"},
    {"label": "Date (Furthest first)", "value": "date_desc"},
    {"label": "Price (Low to High)", "value": "price_asc"},
    {"label": "Price (High to Low)", "value": "price_desc"},
    {"label": "Rating", "value": "rating"},
    {"label": "Popularity", "value": "popularity"},
  ];

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Food & Drinks", "value": "Food"},
    {"label": "Business", "value": "Business"},
    {"label": "Arts", "value": "Arts"},
    {"label": "Health", "value": "Health"},
  ];

  List<Map<String, dynamic>> searchResults = [
    {
      "id": "result1",
      "title": "Tech Innovation Summit 2024",
      "description": "Annual conference showcasing the latest in technology and innovation.",
      "date": "2024-07-15",
      "time": "09:00",
      "endTime": "18:00",
      "location": "Convention Center",
      "city": "San Francisco",
      "price": 299.00,
      "image": "https://picsum.photos/400/250?random=50&keyword=technology",
      "category": "Technology",
      "attendees": 2500,
      "rating": 4.9,
      "organizer": "Tech Innovators",
      "distance": "2.3 km",
      "tags": ["AI", "Innovation", "Networking"],
      "isEarlyBird": true,
      "earlyBirdDiscount": 30.0,
      "relevanceScore": 95,
    },
    {
      "id": "result2",
      "title": "JavaScript Developers Meetup",
      "description": "Monthly meetup for JavaScript developers and enthusiasts.",
      "date": "2024-07-20",
      "time": "18:30",
      "endTime": "21:00",
      "location": "Tech Hub",
      "city": "San Francisco",
      "price": 0.00,
      "image": "https://picsum.photos/400/250?random=51&keyword=programming",
      "category": "Technology",
      "attendees": 150,
      "rating": 4.7,
      "organizer": "JS Community",
      "distance": "1.8 km",
      "tags": ["JavaScript", "Programming", "Community"],
      "isEarlyBird": false,
      "earlyBirdDiscount": 0.0,
      "relevanceScore": 90,
    },
    {
      "id": "result3",
      "title": "Mobile App Development Workshop",
      "description": "Hands-on workshop covering modern mobile app development.",
      "date": "2024-07-25",
      "time": "10:00",
      "endTime": "16:00",
      "location": "Learning Center",
      "city": "San Francisco",
      "price": 149.00,
      "image": "https://picsum.photos/400/250?random=52&keyword=mobile",
      "category": "Technology",
      "attendees": 80,
      "rating": 4.8,
      "organizer": "Mobile Devs",
      "distance": "3.1 km",
      "tags": ["Mobile", "Workshop", "Development"],
      "isEarlyBird": true,
      "earlyBirdDiscount": 20.0,
      "relevanceScore": 85,
    },
    {
      "id": "result4",
      "title": "Startup Pitch Competition",
      "description": "Entrepreneurs pitch their innovative startups to investors.",
      "date": "2024-08-01",
      "time": "14:00",
      "endTime": "18:00",
      "location": "Business District",
      "city": "San Francisco",
      "price": 25.00,
      "image": "https://picsum.photos/400/250?random=53&keyword=startup",
      "category": "Business",
      "attendees": 300,
      "rating": 4.6,
      "organizer": "Startup Hub",
      "distance": "4.5 km",
      "tags": ["Startup", "Pitch", "Investment"],
      "isEarlyBird": false,
      "earlyBirdDiscount": 0.0,
      "relevanceScore": 75,
    },
    {
      "id": "result5",
      "title": "UI/UX Design Bootcamp",
      "description": "Intensive bootcamp covering user interface and experience design.",
      "date": "2024-08-10",
      "time": "09:00",
      "endTime": "17:00",
      "location": "Design Studio",
      "city": "San Francisco",
      "price": 399.00,
      "image": "https://picsum.photos/400/250?random=54&keyword=design",
      "category": "Technology",
      "attendees": 60,
      "rating": 4.9,
      "organizer": "Design Academy",
      "distance": "2.7 km",
      "tags": ["UI", "UX", "Design", "Bootcamp"],
      "isEarlyBird": true,
      "earlyBirdDiscount": 25.0,
      "relevanceScore": 80,
    },
    {
      "id": "result6",
      "title": "Blockchain & Cryptocurrency Summit",
      "description": "Exploring the future of blockchain technology and digital currencies.",
      "date": "2024-08-15",
      "time": "10:00",
      "endTime": "18:00",
      "location": "Financial District",
      "city": "San Francisco",
      "price": 199.00,
      "image": "https://picsum.photos/400/250?random=55&keyword=blockchain",
      "category": "Technology",
      "attendees": 800,
      "rating": 4.7,
      "organizer": "Crypto Alliance",
      "distance": "5.2 km",
      "tags": ["Blockchain", "Cryptocurrency", "Finance"],
      "isEarlyBird": false,
      "earlyBirdDiscount": 0.0,
      "relevanceScore": 70,
    },
  ];

  List<Map<String, dynamic>> get filteredResults {
    List<Map<String, dynamic>> filtered = searchResults;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((event) => event["category"] == selectedCategory).toList();
    }
    
    // Sort results
    switch (selectedSortBy) {
      case "date_asc":
        filtered.sort((a, b) => a["date"].compareTo(b["date"]));
        break;
      case "date_desc":
        filtered.sort((a, b) => b["date"].compareTo(a["date"]));
        break;
      case "price_asc":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_desc":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "popularity":
        filtered.sort((a, b) => (b["attendees"] as int).compareTo(a["attendees"] as int));
        break;
      default: // relevance
        filtered.sort((a, b) => (b["relevanceScore"] as int).compareTo(a["relevanceScore"] as int));
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
        actions: [
          GestureDetector(
            onTap: () {
              showMapView = !showMapView;
              setState(() {});
            },
            child: Icon(
              showMapView ? Icons.list : Icons.map,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Header
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
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Search Results",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "\"$searchQuery\"",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(220),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
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
                              Icons.event,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${filteredResults.length} events found",
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
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "San Francisco",
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

            // Search and Filter Bar
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
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
                      SizedBox(width: spMd),
                      QButton(
                        icon: Icons.tune,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo filter view
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: sortOptions,
                          value: selectedSortBy,
                          onChanged: (value, label) {
                            selectedSortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryFilters,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Results Stats
            Row(
              children: [
                Text(
                  "Found ${filteredResults.length} events",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Sorted by ${sortOptions.firstWhere((opt) => opt["value"] == selectedSortBy)["label"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Search Results
            if (!showMapView)
              Column(
                children: filteredResults.map((event) => _buildSearchResultCard(event)).toList(),
              ),

            // Map View Placeholder
            if (showMapView)
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Map View",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Interactive map showing event locations",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            if (filteredResults.isEmpty && !showMapView)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No events found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search criteria or filters",
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

  Widget _buildSearchResultCard(Map<String, dynamic> event) {
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
          // Event Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
              image: DecorationImage(
                image: NetworkImage("${event["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Category Badge
                Positioned(
                  top: spMd,
                  left: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${event["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Early Bird Badge
                if (event["isEarlyBird"] == true)
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Early Bird",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                // Price Badge
                Positioned(
                  bottom: spMd,
                  right: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      (event["price"] as double) == 0 ? "Free" : "\$${((event["price"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Event Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                // Event Info
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${event["date"]} • ${event["time"]}",
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
                                "${event["location"]} • ${event["distance"]}",
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
                                "${event["attendees"]} attending",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(
                                Icons.star,
                                color: warningColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${event["rating"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
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

                SizedBox(height: spMd),

                // Tags
                QHorizontalScroll(
                  children: (event["tags"] as List).map((tag) => Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(100)),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ),

                SizedBox(height: spMd),

                // Actions
                Row(
                  children: [
                    Text(
                      "by ${event["organizer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.sm,
                      onPressed: () {
                        ss("Added to favorites!");
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo event detail view
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
}
