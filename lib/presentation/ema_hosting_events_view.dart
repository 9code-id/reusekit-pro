import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaHostingEventsView extends StatefulWidget {
  const EmaHostingEventsView({super.key});

  @override
  State<EmaHostingEventsView> createState() => _EmaHostingEventsViewState();
}

class _EmaHostingEventsViewState extends State<EmaHostingEventsView> {
  String statusFilter = "All";
  String sortBy = "recent";
  String searchQuery = "";
  
  List<Map<String, dynamic>> hostingEvents = [
    {
      "id": 1,
      "title": "Advanced Flutter Development Workshop",
      "category": "Technology",
      "date": "2024-02-15",
      "time": "10:00",
      "location": "Tech Hub Downtown",
      "image": "https://picsum.photos/400/300?random=201&keyword=flutter",
      "status": "active",
      "registrations": 85,
      "capacity": 100,
      "revenue": 12750.0,
      "ticketPrice": 150.0,
      "description": "Comprehensive Flutter development workshop covering advanced topics and best practices.",
      "type": "Workshop",
      "duration": "6 hours",
      "difficulty": "Advanced",
      "createdDate": "2024-01-10",
      "lastUpdated": "2024-01-28",
      "rating": 4.8,
      "reviewCount": 12,
      "checkedInCount": 0,
      "waitlistCount": 15,
      "refundRequests": 2,
      "isPromoted": true,
      "promotionBudget": 500.0,
      "views": 2340,
      "saves": 156,
      "shares": 23,
      "tags": ["Flutter", "Mobile Development", "UI/UX"],
      "requirements": ["Laptop", "Flutter SDK", "Basic Programming Knowledge"],
      "agenda": [
        {"time": "10:00-11:30", "topic": "Advanced State Management"},
        {"time": "11:45-13:00", "topic": "Custom Widgets & Animations"},
        {"time": "14:00-15:30", "topic": "Performance Optimization"},
        {"time": "15:45-17:00", "topic": "Testing & Deployment"}
      ]
    },
    {
      "id": 2,
      "title": "Digital Marketing Strategy Bootcamp",
      "category": "Business",
      "date": "2024-02-28",
      "time": "09:00",
      "location": "Business Center Plaza",
      "image": "https://picsum.photos/400/300?random=202&keyword=marketing",
      "status": "active",
      "registrations": 45,
      "capacity": 80,
      "revenue": 6750.0,
      "ticketPrice": 150.0,
      "description": "Intensive bootcamp covering modern digital marketing strategies and tools.",
      "type": "Bootcamp",
      "duration": "2 days",
      "difficulty": "Intermediate",
      "createdDate": "2024-01-15",
      "lastUpdated": "2024-01-25",
      "rating": 4.6,
      "reviewCount": 8,
      "checkedInCount": 0,
      "waitlistCount": 12,
      "refundRequests": 1,
      "isPromoted": false,
      "promotionBudget": 0.0,
      "views": 1890,
      "saves": 89,
      "shares": 15,
      "tags": ["Digital Marketing", "SEO", "Social Media"],
      "requirements": ["Laptop", "Marketing Background Preferred"],
      "agenda": [
        {"time": "Day 1", "topic": "SEO & Content Marketing"},
        {"time": "Day 2", "topic": "Social Media & Analytics"}
      ]
    },
    {
      "id": 3,
      "title": "Community Food Drive & Awareness",
      "category": "Community",
      "date": "2024-01-30",
      "time": "11:00",
      "location": "Central Community Park",
      "image": "https://picsum.photos/400/300?random=203&keyword=community",
      "status": "completed",
      "registrations": 150,
      "capacity": 200,
      "revenue": 0.0,
      "ticketPrice": 0.0,
      "description": "Community outreach event to raise awareness about food insecurity and collect donations.",
      "type": "Community Service",
      "duration": "4 hours",
      "difficulty": "All Levels",
      "createdDate": "2024-01-05",
      "lastUpdated": "2024-01-30",
      "rating": 4.9,
      "reviewCount": 45,
      "checkedInCount": 142,
      "waitlistCount": 0,
      "refundRequests": 0,
      "isPromoted": true,
      "promotionBudget": 200.0,
      "views": 3450,
      "saves": 234,
      "shares": 67,
      "tags": ["Community", "Volunteer", "Food Drive"],
      "requirements": ["Comfortable Clothing", "Water Bottle"],
      "agenda": [
        {"time": "11:00-12:00", "topic": "Setup & Registration"},
        {"time": "12:00-14:00", "topic": "Collection & Sorting"},
        {"time": "14:00-15:00", "topic": "Community Awareness Session"}
      ]
    },
    {
      "id": 4,
      "title": "Startup Funding Masterclass",
      "category": "Business",
      "date": "2024-01-20",
      "time": "14:00",
      "location": "Innovation Hub",
      "image": "https://picsum.photos/400/300?random=204&keyword=startup",
      "status": "completed",
      "registrations": 75,
      "capacity": 80,
      "revenue": 14250.0,
      "ticketPrice": 190.0,
      "description": "Comprehensive guide to securing funding for your startup venture.",
      "type": "Masterclass",
      "duration": "3 hours",
      "difficulty": "Intermediate",
      "createdDate": "2023-12-15",
      "lastUpdated": "2024-01-20",
      "rating": 4.7,
      "reviewCount": 32,
      "checkedInCount": 71,
      "waitlistCount": 0,
      "refundRequests": 4,
      "isPromoted": true,
      "promotionBudget": 800.0,
      "views": 2890,
      "saves": 178,
      "shares": 34,
      "tags": ["Startup", "Funding", "Investment"],
      "requirements": ["Business Plan", "Laptop", "Pitch Deck"],
      "agenda": [
        {"time": "14:00-15:00", "topic": "Funding Landscape Overview"},
        {"time": "15:15-16:15", "topic": "Pitch Preparation"},
        {"time": "16:30-17:00", "topic": "Q&A with Investors"}
      ]
    },
    {
      "id": 5,
      "title": "Meditation & Mindfulness Workshop",
      "category": "Health & Wellness",
      "date": "2024-01-10",
      "time": "18:00",
      "location": "Wellness Center",
      "image": "https://picsum.photos/400/300?random=205&keyword=meditation",
      "status": "completed",
      "registrations": 30,
      "capacity": 35,
      "revenue": 1800.0,
      "ticketPrice": 60.0,
      "description": "Learn meditation techniques and mindfulness practices for daily stress management.",
      "type": "Workshop",
      "duration": "2 hours",
      "difficulty": "Beginner",
      "createdDate": "2023-12-20",
      "lastUpdated": "2024-01-10",
      "rating": 4.9,
      "reviewCount": 18,
      "checkedInCount": 28,
      "waitlistCount": 0,
      "refundRequests": 2,
      "isPromoted": false,
      "promotionBudget": 0.0,
      "views": 1234,
      "saves": 67,
      "shares": 12,
      "tags": ["Meditation", "Mindfulness", "Stress Management"],
      "requirements": ["Comfortable Clothing", "Yoga Mat", "Water Bottle"],
      "agenda": [
        {"time": "18:00-18:30", "topic": "Introduction to Mindfulness"},
        {"time": "18:30-19:30", "topic": "Guided Meditation Practice"},
        {"time": "19:30-20:00", "topic": "Q&A and Resources"}
      ]
    },
    {
      "id": 6,
      "title": "Photography Fundamentals Course",
      "category": "Arts & Culture",
      "date": "2024-03-15",
      "time": "13:00",
      "location": "Creative Arts Studio",
      "image": "https://picsum.photos/400/300?random=206&keyword=photography",
      "status": "draft",
      "registrations": 0,
      "capacity": 25,
      "revenue": 0.0,
      "ticketPrice": 120.0,
      "description": "Learn the fundamentals of photography including composition, lighting, and editing.",
      "type": "Course",
      "duration": "4 hours",
      "difficulty": "Beginner",
      "createdDate": "2024-01-25",
      "lastUpdated": "2024-01-28",
      "rating": 0.0,
      "reviewCount": 0,
      "checkedInCount": 0,
      "waitlistCount": 0,
      "refundRequests": 0,
      "isPromoted": false,
      "promotionBudget": 0.0,
      "views": 156,
      "saves": 12,
      "shares": 3,
      "tags": ["Photography", "Basics", "Camera Techniques"],
      "requirements": ["Camera or Smartphone", "Laptop for Editing"],
      "agenda": [
        {"time": "13:00-14:00", "topic": "Camera Basics & Settings"},
        {"time": "14:15-15:15", "topic": "Composition Techniques"},
        {"time": "15:30-16:30", "topic": "Lighting & Exposure"},
        {"time": "16:45-17:00", "topic": "Basic Editing Introduction"}
      ]
    }
  ];

  List<String> statusOptions = ["All", "active", "completed", "draft", "cancelled"];
  
  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = hostingEvents.where((event) {
      bool matchesStatus = statusFilter == "All" || event["status"] == statusFilter;
      bool matchesSearch = searchQuery.isEmpty || 
          event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          event["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();

    // Sort events
    switch (sortBy) {
      case "recent":
        filtered.sort((a, b) => b["date"].compareTo(a["date"]));
        break;
      case "registrations":
        filtered.sort((a, b) => (b["registrations"] as int).compareTo(a["registrations"] as int));
        break;
      case "revenue":
        filtered.sort((a, b) => (b["revenue"] as double).compareTo(a["revenue"] as double));
        break;
      case "alphabetical":
        filtered.sort((a, b) => a["title"].compareTo(b["title"]));
        break;
    }

    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "completed":
        return primaryColor;
      case "draft":
        return warningColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "ACTIVE";
      case "completed":
        return "COMPLETED";
      case "draft":
        return "DRAFT";
      case "cancelled":
        return "CANCELLED";
      default:
        return status.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Hosting Events"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _createNewEvent(),
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () => _viewAnalytics(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Overview
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
                          "${hostingEvents.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Events",
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
                          "${hostingEvents.map((e) => e["registrations"] as int).fold(0, (sum, count) => sum + count)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Registrations",
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
                          "\$${((hostingEvents.map((e) => e["revenue"] as double).fold(0.0, (sum, revenue) => sum + revenue)).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Total Revenue",
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
                    label: "Search your events...",
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
                    label: "Status",
                    items: statusOptions.map((status) => {
                      "label": status == "All" ? "All Status" : getStatusLabel(status),
                      "value": status,
                    }).toList(),
                    value: statusFilter,
                    onChanged: (value, label) {
                      statusFilter = value;
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
                      {"label": "Most Registrations", "value": "registrations"},
                      {"label": "Highest Revenue", "value": "revenue"},
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
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Create Event",
                    size: bs.sm,
                    onPressed: () => _createNewEvent(),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Event Analytics",
                    size: bs.sm,
                    onPressed: () => _viewAnalytics(),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Bulk Actions",
                    size: bs.sm,
                    onPressed: () => _bulkActions(),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Events List
            Text(
              "Your Events (${filteredEvents.length})",
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
                  // Event Image with Status Badge
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
                            color: getStatusColor(event["status"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            getStatusLabel(event["status"]),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                      // Promotion Badge
                      if (event["isPromoted"] == true)
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
                              Icons.campaign,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      
                      // Event Type
                      Positioned(
                        bottom: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${event["type"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
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
                        
                        // Date, Time and Duration
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${DateTime.parse(event["date"]).dMMMy} at ${event["time"]} • ${event["duration"]}",
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
                        
                        // Event Metrics
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Registrations",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${event["registrations"]}/${event["capacity"]}",
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
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((event["revenue"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
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
                                    "Views",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${event["views"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (event["rating"] > 0)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: warningColor,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "${event["rating"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: warningColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        
                        // Progress Bar for Registration
                        Container(
                          margin: EdgeInsets.only(top: spXs),
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (event["registrations"] as int) / (event["capacity"] as int),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (event["registrations"] as int) >= (event["capacity"] as int) * 0.8 
                                    ? successColor : primaryColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: event["status"] == "draft" ? "Publish" : "Edit",
                                size: bs.sm,
                                onPressed: () => event["status"] == "draft" 
                                    ? _publishEvent(event) 
                                    : _editEvent(event),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Analytics",
                                size: bs.sm,
                                onPressed: () => _viewEventAnalytics(event),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Manage",
                                size: bs.sm,
                                onPressed: () => _manageEvent(event),
                              ),
                            ),
                          ],
                        ),
                        
                        // Additional Info
                        if (event["waitlistCount"] > 0 || event["refundRequests"] > 0)
                          Container(
                            margin: EdgeInsets.only(top: spXs),
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: warningColor.withAlpha(50)),
                            ),
                            child: Row(
                              children: [
                                if (event["waitlistCount"] > 0)
                                  Expanded(
                                    child: Text(
                                      "Waitlist: ${event["waitlistCount"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                if (event["refundRequests"] > 0)
                                  Expanded(
                                    child: Text(
                                      "Refund Requests: ${event["refundRequests"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        
                        // Tags
                        if (event["tags"] != null && (event["tags"] as List).isNotEmpty)
                          Container(
                            margin: EdgeInsets.only(top: spSm),
                            child: Wrap(
                              spacing: spXs,
                              runSpacing: 4,
                              children: (event["tags"] as List).map((tag) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: secondaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(color: secondaryColor.withAlpha(100)),
                                ),
                                child: Text(
                                  "${tag}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            // Empty State
            if (filteredEvents.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_note,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No hosting events found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Create your first event to start hosting",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Create Event",
                      size: bs.sm,
                      onPressed: () => _createNewEvent(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _createNewEvent() {
    // Navigate to event creation page
  }

  void _viewAnalytics() {
    // Navigate to analytics dashboard
  }

  void _bulkActions() {
    // Show bulk actions dialog
  }

  void _publishEvent(Map<String, dynamic> event) {
    ss("Event published successfully!");
  }

  void _editEvent(Map<String, dynamic> event) {
    // Navigate to event editing page
  }

  void _viewEventAnalytics(Map<String, dynamic> event) {
    // Navigate to individual event analytics
  }

  void _manageEvent(Map<String, dynamic> event) {
    // Navigate to event management page
  }
}
