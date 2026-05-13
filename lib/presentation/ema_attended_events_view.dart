import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaAttendedEventsView extends StatefulWidget {
  const EmaAttendedEventsView({super.key});

  @override
  State<EmaAttendedEventsView> createState() => _EmaAttendedEventsViewState();
}

class _EmaAttendedEventsViewState extends State<EmaAttendedEventsView> {
  String filterCategory = "All";
  String sortBy = "recent";
  String searchQuery = "";
  
  List<Map<String, dynamic>> attendedEvents = [
    {
      "id": 1,
      "title": "Tech Innovation Summit 2024",
      "category": "Technology",
      "date": "2024-01-15",
      "time": "09:00",
      "location": "San Francisco Convention Center",
      "image": "https://picsum.photos/400/300?random=101&keyword=tech",
      "organizer": "TechCorp Inc.",
      "attendees": 2500,
      "rating": 4.8,
      "userRating": 5,
      "hasReviewed": true,
      "hasPhotos": true,
      "hasCertificate": true,
      "status": "completed",
      "ticketType": "VIP",
      "price": 299.0,
      "experience": "Amazing event with great networking opportunities and cutting-edge technology showcases.",
      "highlights": ["Keynote by CEO", "Networking Session", "Product Demo"],
      "photoCount": 15,
      "certificateUrl": "https://certificates.example.com/tech-summit-2024",
      "reviewDate": "2024-01-16",
      "recommendedSimilar": 5
    },
    {
      "id": 2,
      "title": "Digital Marketing Masterclass",
      "category": "Business",
      "date": "2024-01-10",
      "time": "14:00",
      "location": "Business Hub Downtown",
      "image": "https://picsum.photos/400/300?random=102&keyword=marketing",
      "organizer": "Marketing Pro Academy",
      "attendees": 450,
      "rating": 4.6,
      "userRating": 4,
      "hasReviewed": true,
      "hasPhotos": false,
      "hasCertificate": true,
      "status": "completed",
      "ticketType": "Standard",
      "price": 149.0,
      "experience": "Comprehensive coverage of modern digital marketing strategies and tools.",
      "highlights": ["SEO Strategies", "Social Media Marketing", "Analytics Deep Dive"],
      "photoCount": 0,
      "certificateUrl": "https://certificates.example.com/marketing-masterclass",
      "reviewDate": "2024-01-11",
      "recommendedSimilar": 3
    },
    {
      "id": 3,
      "title": "Annual Food & Wine Festival",
      "category": "Food & Drink",
      "date": "2024-01-05",
      "time": "18:00",
      "location": "Riverside Park",
      "image": "https://picsum.photos/400/300?random=103&keyword=food",
      "organizer": "Culinary Association",
      "attendees": 3200,
      "rating": 4.9,
      "userRating": 0,
      "hasReviewed": false,
      "hasPhotos": true,
      "hasCertificate": false,
      "status": "completed",
      "ticketType": "Premium",
      "price": 89.0,
      "experience": "",
      "highlights": ["Wine Tasting", "Chef Demonstrations", "Live Music"],
      "photoCount": 24,
      "certificateUrl": "",
      "reviewDate": "",
      "recommendedSimilar": 8
    },
    {
      "id": 4,
      "title": "Startup Pitch Competition",
      "category": "Business",
      "date": "2023-12-20",
      "time": "10:00",
      "location": "Innovation Hub",
      "image": "https://picsum.photos/400/300?random=104&keyword=startup",
      "organizer": "Entrepreneur Network",
      "attendees": 800,
      "rating": 4.7,
      "userRating": 5,
      "hasReviewed": true,
      "hasPhotos": true,
      "hasCertificate": true,
      "status": "completed",
      "ticketType": "VIP",
      "price": 199.0,
      "experience": "Inspiring event showcasing innovative startups and connecting with fellow entrepreneurs.",
      "highlights": ["Pitch Presentations", "Investor Panel", "Networking"],
      "photoCount": 18,
      "certificateUrl": "https://certificates.example.com/startup-pitch-2023",
      "reviewDate": "2023-12-21",
      "recommendedSimilar": 6
    },
    {
      "id": 5,
      "title": "Wellness & Mindfulness Retreat",
      "category": "Health & Wellness",
      "date": "2023-12-15",
      "time": "08:00",
      "location": "Mountain View Resort",
      "image": "https://picsum.photos/400/300?random=105&keyword=wellness",
      "organizer": "Mindful Living Institute",
      "attendees": 120,
      "rating": 4.9,
      "userRating": 5,
      "hasReviewed": true,
      "hasPhotos": true,
      "hasCertificate": true,
      "status": "completed",
      "ticketType": "All-Inclusive",
      "price": 599.0,
      "experience": "Life-changing experience with meditation, yoga, and wellness workshops in beautiful surroundings.",
      "highlights": ["Meditation Sessions", "Yoga Classes", "Healthy Cuisine"],
      "photoCount": 32,
      "certificateUrl": "https://certificates.example.com/wellness-retreat-2023",
      "reviewDate": "2023-12-16",
      "recommendedSimilar": 4
    },
    {
      "id": 6,
      "title": "Photography Workshop: Street Art",
      "category": "Arts & Culture",
      "date": "2023-12-08",
      "time": "13:00",
      "location": "Arts District",
      "image": "https://picsum.photos/400/300?random=106&keyword=photography",
      "organizer": "Creative Vision Studio",
      "attendees": 25,
      "rating": 4.8,
      "userRating": 4,
      "hasReviewed": true,
      "hasPhotos": true,
      "hasCertificate": false,
      "status": "completed",
      "ticketType": "Standard",
      "price": 75.0,
      "experience": "Hands-on workshop exploring street art photography with expert guidance.",
      "highlights": ["Camera Techniques", "Composition Tips", "Editing Workshop"],
      "photoCount": 28,
      "certificateUrl": "",
      "reviewDate": "2023-12-09",
      "recommendedSimilar": 7
    }
  ];

  List<String> categories = ["All", "Technology", "Business", "Food & Drink", "Health & Wellness", "Arts & Culture", "Sports", "Education"];
  
  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = attendedEvents.where((event) {
      bool matchesCategory = filterCategory == "All" || event["category"] == filterCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          event["organizer"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    // Sort events
    switch (sortBy) {
      case "recent":
        filtered.sort((a, b) => b["date"].compareTo(a["date"]));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "alphabetical":
        filtered.sort((a, b) => a["title"].compareTo(b["title"]));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Attended Events"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${attendedEvents.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Events Attended",
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${attendedEvents.where((e) => e["hasReviewed"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Reviews Given",
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${attendedEvents.where((e) => e["hasCertificate"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Certificates",
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
            ),
            
            SizedBox(height: spMd),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search attended events...",
                    value: searchQuery,
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
                  onPressed: () {},
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: filterCategory,
                    onChanged: (value, label) {
                      filterCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: [
                      {"label": "Most Recent", "value": "recent"},
                      {"label": "Highest Rated", "value": "rating"},
                      {"label": "Alphabetical", "value": "alphabetical"},
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
            
            SizedBox(height: spMd),
            
            // Events List
            Text(
              "Attended Events (${filteredEvents.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            ...filteredEvents.map((event) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Image with Badges
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusSm),
                          topRight: Radius.circular(radiusSm),
                        ),
                        child: Image.network(
                          "${event["image"]}",
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      // Status Badge
                      Positioned(
                        top: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "ATTENDED",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                      // Certificate Badge
                      if (event["hasCertificate"] == true)
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.verified,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      
                      // Photo Count
                      if (event["hasPhotos"] == true)
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${event["photoCount"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  // Event Details
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Category
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${event["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: infoColor.withAlpha(100)),
                              ),
                              child: Text(
                                "${event["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spXs),
                        
                        // Date, Time and Location
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${DateTime.parse(event["date"]).dMMMy} at ${event["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 4),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "${event["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spXs),
                        
                        // Rating and User Rating
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${event["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  " (${event["attendees"]} attendees)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            if (event["userRating"] > 0)
                              Row(
                                children: [
                                  Text(
                                    "Your rating: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(5, (index) => Icon(
                                      index < event["userRating"] ? Icons.star : Icons.star_border,
                                      size: 14,
                                      color: warningColor,
                                    )),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        
                        // Experience/Review
                        if (event["experience"].toString().isNotEmpty)
                          Container(
                            margin: EdgeInsets.only(top: spXs),
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: primaryColor.withAlpha(50)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Experience:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${event["experience"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        SizedBox(height: spSm),
                        
                        // Action Buttons
                        Row(
                          children: [
                            if (!event["hasReviewed"])
                              Expanded(
                                child: QButton(
                                  label: "Write Review",
                                  size: bs.sm,
                                  onPressed: () => _writeReview(event),
                                ),
                              ),
                            
                            if (event["hasReviewed"] && !event["hasReviewed"])
                              SizedBox(width: spSm),
                            
                            if (event["hasReviewed"])
                              Expanded(
                                child: QButton(
                                  label: "Edit Review",
                                  size: bs.sm,
                                  onPressed: () => _editReview(event),
                                ),
                              ),
                            
                            SizedBox(width: spSm),
                            
                            if (event["hasPhotos"])
                              Expanded(
                                child: QButton(
                                  label: "View Photos",
                                  size: bs.sm,
                                  onPressed: () => _viewPhotos(event),
                                ),
                              ),
                            
                            if (event["hasPhotos"])
                              SizedBox(width: spSm),
                            
                            if (event["hasCertificate"])
                              Expanded(
                                child: QButton(
                                  label: "Certificate",
                                  size: bs.sm,
                                  onPressed: () => _downloadCertificate(event),
                                ),
                              ),
                          ],
                        ),
                        
                        // Highlights
                        if (event["highlights"] != null && (event["highlights"] as List).isNotEmpty)
                          Container(
                            margin: EdgeInsets.only(top: spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Event Highlights:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: 4,
                                  children: (event["highlights"] as List).map((highlight) => Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(color: secondaryColor.withAlpha(100)),
                                    ),
                                    child: Text(
                                      "${highlight}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )).toList(),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            // Load More or Empty State
            if (filteredEvents.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No attended events found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Start attending events to see them here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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

  void _showFilterOptions() {
    // Show filter dialog
  }

  void _writeReview(Map<String, dynamic> event) {
    // Navigate to review writing page
  }

  void _editReview(Map<String, dynamic> event) {
    // Navigate to review editing page
  }

  void _viewPhotos(Map<String, dynamic> event) {
    // Navigate to photo gallery
  }

  void _downloadCertificate(Map<String, dynamic> event) {
    // Download or view certificate
    ss("Certificate downloaded successfully!");
  }
}
