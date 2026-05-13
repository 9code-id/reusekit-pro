import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLibrary6View extends StatefulWidget {
  @override
  State<GrlLibrary6View> createState() => _GrlLibrary6ViewState();
}

class _GrlLibrary6ViewState extends State<GrlLibrary6View> {
  String searchQuery = "";
  bool isDetailView = true;

  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Author Meet & Greet: Sarah Johnson",
      "description": "Meet bestselling author Sarah Johnson and get your books signed",
      "date": "2024-12-28",
      "time": "14:00",
      "duration": "2 hours",
      "location": "Main Library Hall",
      "capacity": 50,
      "registered": 38,
      "category": "Author Event",
      "image": "https://picsum.photos/400/300?random=1&keyword=author",
      "price": 0.0,
      "isRegistered": true,
      "status": "Upcoming",
    },
    {
      "id": 2,
      "title": "Digital Literacy Workshop",
      "description": "Learn essential digital skills for modern life and work",
      "date": "2024-12-30",
      "time": "10:00",
      "duration": "3 hours",
      "location": "Computer Lab",
      "capacity": 25,
      "registered": 12,
      "category": "Workshop",
      "image": "https://picsum.photos/400/300?random=2&keyword=computer",
      "price": 15.0,
      "isRegistered": false,
      "status": "Open",
    },
    {
      "id": 3,
      "title": "Children's Story Time",
      "description": "Interactive storytelling session for kids aged 5-10",
      "date": "2025-01-02",
      "time": "15:30",
      "duration": "1 hour",
      "location": "Children's Section",
      "capacity": 30,
      "registered": 28,
      "category": "Children",
      "image": "https://picsum.photos/400/300?random=3&keyword=children",
      "price": 0.0,
      "isRegistered": false,
      "status": "Almost Full",
    },
    {
      "id": 4,
      "title": "Book Club Discussion: Quantum Physics",
      "description": "Monthly discussion of scientific literature and discoveries",
      "date": "2025-01-05",
      "time": "18:00",
      "duration": "2 hours",
      "location": "Discussion Room A",
      "capacity": 15,
      "registered": 8,
      "category": "Book Club",
      "image": "https://picsum.photos/400/300?random=4&keyword=science",
      "price": 0.0,
      "isRegistered": true,
      "status": "Open",
    },
    {
      "id": 5,
      "title": "Creative Writing Masterclass",
      "description": "Learn advanced techniques for fiction and non-fiction writing",
      "date": "2025-01-08",
      "time": "13:00",
      "duration": "4 hours",
      "location": "Seminar Room",
      "capacity": 20,
      "registered": 20,
      "category": "Workshop",
      "image": "https://picsum.photos/400/300?random=5&keyword=writing",
      "price": 25.0,
      "isRegistered": false,
      "status": "Full",
    },
    {
      "id": 6,
      "title": "Local History Exhibition Opening",
      "description": "Grand opening of our new local history exhibition",
      "date": "2025-01-10",
      "time": "17:00",
      "duration": "3 hours",
      "location": "Exhibition Hall",
      "capacity": 100,
      "registered": 45,
      "category": "Exhibition",
      "image": "https://picsum.photos/400/300?random=6&keyword=history",
      "price": 0.0,
      "isRegistered": false,
      "status": "Open",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return successColor;
      case "Almost Full":
        return warningColor;
      case "Full":
        return dangerColor;
      case "Upcoming":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Author Event":
        return primaryColor;
      case "Workshop":
        return successColor;
      case "Children":
        return warningColor;
      case "Book Club":
        return infoColor;
      case "Exhibition":
        return secondaryColor;
      default:
        return disabledColor;
    }
  }

  List<Map<String, dynamic>> get filteredEvents {
    if (searchQuery.isEmpty) return events;
    
    return events.where((event) =>
        (event["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (event["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (event["category"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Library Events"),
        actions: [
          IconButton(
            icon: Icon(isDetailView ? Icons.view_list : Icons.view_module),
            onPressed: () {
              isDetailView = !isDetailView;
              setState(() {});
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
            // Search Bar
            QTextField(
              label: "Search events",
              value: searchQuery,
              hint: "Search by title, description, or category",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Quick Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${events.length}",
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
                  Container(
                    height: 40,
                    width: 1,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${events.where((e) => e["isRegistered"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Registered",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${events.where((e) => e["status"] == "Open").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Category Filter
            Text(
              "Browse by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: ["All", "Author Event", "Workshop", "Children", "Book Club", "Exhibition"].map((category) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: category == "All" ? primaryColor : _getCategoryColor(category).withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: category == "All" ? primaryColor : _getCategoryColor(category),
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: category == "All" ? Colors.white : _getCategoryColor(category),
                    ),
                  ),
                );
              }).toList(),
            ),

            // Events List/Grid
            Text(
              "${filteredEvents.length} Events Found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),

            if (isDetailView)
              // Detailed List View
              Column(
                spacing: spSm,
                children: filteredEvents.map((event) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Image
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                          child: Stack(
                            children: [
                              Image.network(
                                "${event["image"]}",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(event["category"] as String),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${event["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(event["status"] as String),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${event["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              if (event["isRegistered"] == true)
                                Positioned(
                                  bottom: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 20,
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
                            spacing: spSm,
                            children: [
                              Text(
                                "${event["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${event["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),

                              // Event Info Row
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${DateTime.parse(event["date"] as String).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["time"]}",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                  Text(
                                    "${event["location"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["duration"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Capacity and Price
                              Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["registered"]}/${event["capacity"]} registered",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if ((event["price"] as double) > 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "\$${(event["price"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "FREE",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              // Action Button
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: event["isRegistered"] == true
                                      ? "Already Registered"
                                      : event["status"] == "Full"
                                          ? "Join Waitlist"
                                          : "Register Now",
                                  size: bs.md,
                                  onPressed: event["status"] != "Full" ? () {} : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              // Compact Grid View
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredEvents.map((event) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                          child: Stack(
                            children: [
                              Image.network(
                                "${event["image"]}",
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(event["category"] as String),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${event["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              if (event["isRegistered"] == true)
                                Positioned(
                                  top: spXs,
                                  right: spXs,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${event["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
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
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${DateTime.parse(event["date"] as String).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(event["status"] as String),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${event["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  if ((event["price"] as double) > 0)
                                    Text(
                                      "\$${(event["price"] as double).toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    )
                                  else
                                    Text(
                                      "FREE",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: event["isRegistered"] == true ? "Registered" : "Register",
                                  size: bs.sm,
                                  onPressed: event["status"] != "Full" ? () {} : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
