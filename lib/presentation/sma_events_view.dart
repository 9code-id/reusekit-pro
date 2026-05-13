import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaEventsView extends StatefulWidget {
  const SmaEventsView({super.key});

  @override
  State<SmaEventsView> createState() => _SmaEventsViewState();
}

class _SmaEventsViewState extends State<SmaEventsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedDate = "";
  
  List<String> categories = ["All", "Conference", "Workshop", "Meetup", "Party", "Sports", "Concert"];
  
  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Tech Innovation Summit 2024",
      "category": "Conference",
      "date": "2024-06-20",
      "time": "09:00",
      "location": "San Francisco Convention Center",
      "image": "https://picsum.photos/400/200?random=1&keyword=conference",
      "organizer": "TechCorp",
      "organizerImage": "https://picsum.photos/40/40?random=1&keyword=tech",
      "attendees": 1250,
      "price": 0,
      "isInterested": true,
      "isGoing": false,
      "description": "Join industry leaders for a day of innovation and networking. Explore the latest trends in AI, blockchain, and cloud computing."
    },
    {
      "id": 2,
      "title": "UI/UX Design Workshop",
      "category": "Workshop",
      "date": "2024-06-22",
      "time": "14:00",
      "location": "Design Studio Downtown",
      "image": "https://picsum.photos/400/200?random=2&keyword=design",
      "organizer": "Creative Studios",
      "organizerImage": "https://picsum.photos/40/40?random=2&keyword=art",
      "attendees": 45,
      "price": 75,
      "isInterested": false,
      "isGoing": true,
      "description": "Learn modern UI/UX design principles and tools. Hands-on workshop with expert designers."
    },
    {
      "id": 3,
      "title": "Startup Networking Meetup",
      "category": "Meetup",
      "date": "2024-06-25",
      "time": "18:30",
      "location": "Innovation Hub",
      "image": "https://picsum.photos/400/200?random=3&keyword=networking",
      "organizer": "Startup Community",
      "organizerImage": "https://picsum.photos/40/40?random=3&keyword=startup",
      "attendees": 89,
      "price": 0,
      "isInterested": true,
      "isGoing": true,
      "description": "Connect with fellow entrepreneurs and investors. Share ideas and build meaningful connections in the startup ecosystem."
    },
    {
      "id": 4,
      "title": "Summer Music Festival",
      "category": "Concert",
      "date": "2024-06-28",
      "time": "16:00",
      "location": "Golden Gate Park",
      "image": "https://picsum.photos/400/200?random=4&keyword=music",
      "organizer": "Music Events Co",
      "organizerImage": "https://picsum.photos/40/40?random=4&keyword=music",
      "attendees": 5000,
      "price": 45,
      "isInterested": false,
      "isGoing": false,
      "description": "Enjoy live performances from top artists across multiple genres. Food trucks and activities for the whole family."
    },
    {
      "id": 5,
      "title": "Marathon Training Group",
      "category": "Sports",
      "date": "2024-06-30",
      "time": "07:00",
      "location": "Marina Green",
      "image": "https://picsum.photos/400/200?random=5&keyword=running",
      "organizer": "SF Runners Club",
      "organizerImage": "https://picsum.photos/40/40?random=5&keyword=running",
      "attendees": 125,
      "price": 0,
      "isInterested": true,
      "isGoing": false,
      "description": "Join our weekly training sessions for the upcoming San Francisco Marathon. All fitness levels welcome."
    }
  ];

  List<Map<String, dynamic>> get filteredEvents {
    var filtered = events.where((event) {
      final matchesSearch = (event["title"] as String)
          .toLowerCase()
          .contains(searchQuery.toLowerCase()) ||
          (event["location"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      
      final matchesCategory = selectedCategory == "All" || 
          event["category"] == selectedCategory;
      
      bool matchesDate = true;
      if (selectedDate.isNotEmpty) {
        matchesDate = event["date"] == selectedDate;
      }
      
      return matchesSearch && matchesCategory && matchesDate;
    }).toList();
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
        actions: [
          IconButton(
            onPressed: () {
              //navigateTo(SmaCreateEventView())
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Card(
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Search Events",
                      value: searchQuery,
                      hint: "Search by title or location...",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            value: selectedCategory,
                            items: categories.map((category) => {
                              "label": category,
                              "value": category,
                            }).toList(),
                            onChanged: (value, label) {
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Date",
                            value: selectedDate.isNotEmpty 
                                ? DateTime.parse(selectedDate) 
                                : null,
                            onChanged: (value) {
                              selectedDate = value != null 
                                  ? value.toString().split(' ')[0] 
                                  : "";
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Quick Stats
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${events.length}",
                            style: TextStyle(
                              fontSize: fsH5,
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
                      width: 1,
                      height: 40,
                      color: disabledColor,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${events.where((e) => e["isGoing"] as bool).length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Going",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledColor,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${events.where((e) => e["isInterested"] as bool).length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Interested",
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
            ),

            // Results Count
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: spXs),
              child: Text(
                "${filteredEvents.length} events found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Events List
            ...filteredEvents.map((event) {
              DateTime eventDate = DateTime.parse("${event["date"]} ${event["time"]}:00");
              bool isPast = eventDate.isBefore(DateTime.now());
              
              return Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Event Image
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${event["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.black.withAlpha(128),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(153),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${event["category"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              if (isPast) ...[
                                Positioned(
                                  bottom: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: disabledBoldColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Past Event",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      // Event Info
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${event["organizerImage"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${event["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "by ${event["organizer"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Price
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (event["price"] as int) > 0 
                                  ? warningColor.withAlpha(25)
                                  : successColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              (event["price"] as int) > 0 
                                  ? "\$${event["price"]}"
                                  : "Free",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (event["price"] as int) > 0 
                                    ? warningColor
                                    : successColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Date, Time, Location
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${DateTime.parse(event["date"] as String).dMMMy} at ${event["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${event["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${event["attendees"]} attendees",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Description
                      Text(
                        "${event["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),

                      // Action Buttons
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            flex: 2,
                            child: QButton(
                              label: (event["isGoing"] as bool) ? "Going" : "Join Event",
                              size: bs.sm,
                              onPressed: isPast ? null : () {
                                if (!(event["isGoing"] as bool)) {
                                  event["isGoing"] = true;
                                  event["attendees"] = (event["attendees"] as int) + 1;
                                  ss("You're going to ${event["title"]}!");
                                } else {
                                  event["isGoing"] = false;
                                  event["attendees"] = (event["attendees"] as int) - 1;
                                  si("Cancelled attendance for ${event["title"]}");
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          QButton(
                            icon: (event["isInterested"] as bool) ? Icons.star : Icons.star_border,
                            size: bs.sm,
                            onPressed: () {
                              event["isInterested"] = !(event["isInterested"] as bool);
                              if (event["isInterested"] as bool) {
                                ss("Added to interested events");
                              } else {
                                si("Removed from interested events");
                              }
                              setState(() {});
                            },
                          ),
                          QButton(
                            icon: Icons.share,
                            size: bs.sm,
                            onPressed: () {
                              si("Event shared successfully");
                            },
                          ),
                          QButton(
                            icon: Icons.info,
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo(SmaEventDetailView(eventId: event["id"]))
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            // Load More
            if (filteredEvents.length >= 5) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Events",
                  size: bs.md,
                  onPressed: () {
                    si("Loading more events...");
                  },
                ),
              ),
            ],

            // Empty State
            if (filteredEvents.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_note,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No events found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
