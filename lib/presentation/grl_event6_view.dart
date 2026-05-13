import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEvent6View extends StatefulWidget {
  @override
  State<GrlEvent6View> createState() => _GrlEvent6ViewState();
}

class _GrlEvent6ViewState extends State<GrlEvent6View> {
  int selectedTab = 0;
  bool showCalendarView = false;
  DateTime selectedDate = DateTime.now();
  
  List<Map<String, dynamic>> upcomingEvents = [
    {
      "id": 1,
      "title": "Annual Tech Conference 2024",
      "shortTitle": "Tech Conf",
      "date": "2024-08-15",
      "time": "09:00 AM",
      "endTime": "06:00 PM",
      "location": "San Francisco Convention Center",
      "city": "San Francisco",
      "price": 299.00,
      "image": "https://picsum.photos/150/100?random=1&keyword=conference",
      "category": "Technology",
      "status": "confirmed",
      "attendees": 2500,
      "isVirtual": false,
      "organizer": "TechWorld Inc.",
      "reminder": true,
    },
    {
      "id": 2,
      "title": "Digital Marketing Workshop",
      "shortTitle": "Marketing",
      "date": "2024-08-20",
      "time": "02:00 PM",
      "endTime": "05:00 PM",
      "location": "Online Event",
      "city": "Virtual",
      "price": 49.99,
      "image": "https://picsum.photos/150/100?random=2&keyword=marketing",
      "category": "Business",
      "status": "pending",
      "attendees": 150,
      "isVirtual": true,
      "organizer": "Digital Growth Academy",
      "reminder": false,
    },
    {
      "id": 3,
      "title": "Jazz Music Festival",
      "shortTitle": "Jazz Fest",
      "date": "2024-08-25",
      "time": "07:00 PM",
      "endTime": "11:00 PM",
      "location": "Central Park Amphitheater",
      "city": "New York",
      "price": 75.00,
      "image": "https://picsum.photos/150/100?random=3&keyword=jazz",
      "category": "Music",
      "status": "confirmed",
      "attendees": 800,
      "isVirtual": false,
      "organizer": "NYC Music Events",
      "reminder": true,
    },
  ];
  
  List<Map<String, dynamic>> pastEvents = [
    {
      "id": 4,
      "title": "Startup Pitch Competition",
      "shortTitle": "Startup Pitch",
      "date": "2024-07-10",
      "time": "10:00 AM",
      "endTime": "04:00 PM",
      "location": "Innovation Hub",
      "city": "Austin",
      "price": 25.00,
      "image": "https://picsum.photos/150/100?random=4&keyword=startup",
      "category": "Business",
      "status": "attended",
      "attendees": 300,
      "isVirtual": false,
      "organizer": "Startup Texas",
      "rating": 4.5,
      "feedback": "Great networking event with innovative startups",
    },
    {
      "id": 5,
      "title": "Photography Exhibition",
      "shortTitle": "Photo Exhibit",
      "date": "2024-06-25",
      "time": "06:00 PM",
      "endTime": "09:00 PM",
      "location": "Modern Art Gallery",
      "city": "Los Angeles",
      "price": 15.00,
      "image": "https://picsum.photos/150/100?random=5&keyword=photography",
      "category": "Art",
      "status": "attended",
      "attendees": 120,
      "isVirtual": false,
      "organizer": "LA Art Collective",
      "rating": 4.8,
      "feedback": "Beautiful collection of contemporary photography",
    },
    {
      "id": 6,
      "title": "Cooking Masterclass",
      "shortTitle": "Cooking Class",
      "date": "2024-06-15",
      "time": "11:00 AM",
      "endTime": "03:00 PM",
      "location": "Culinary Institute",
      "city": "Chicago",
      "price": 85.00,
      "image": "https://picsum.photos/150/100?random=6&keyword=cooking",
      "category": "Food",
      "status": "missed",
      "attendees": 50,
      "isVirtual": false,
      "organizer": "Chef's Academy",
      "rating": 0,
      "feedback": "",
    },
  ];

  List<Map<String, dynamic>> get calendarEvents {
    List<Map<String, dynamic>> allEvents = [...upcomingEvents, ...pastEvents];
    return allEvents.where((event) {
      DateTime eventDate = DateTime.parse(event["date"]);
      return eventDate.year == selectedDate.year && 
             eventDate.month == selectedDate.month;
    }).toList();
  }

  void _toggleReminder(int eventId) {
    int index = upcomingEvents.indexWhere((event) => event["id"] == eventId);
    if (index != -1) {
      upcomingEvents[index]["reminder"] = !(upcomingEvents[index]["reminder"] as bool);
      setState(() {});
      if (upcomingEvents[index]["reminder"] == true) {
        ss("Reminder set for event");
      } else {
        si("Reminder removed");
      }
    }
  }

  Widget _buildUpcomingEventCard(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: event["status"] == "confirmed" 
            ? Border.all(color: successColor.withAlpha(100), width: 1) 
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Row(
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
            
            SizedBox(width: spSm),
            
            // Event Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${event["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: event["status"] == "confirmed" ? successColor : warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${event["status"]}".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${event["date"]} at ${event["time"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Row(
                    children: [
                      Icon(
                        event["isVirtual"] == true ? Icons.computer : Icons.location_on,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${event["city"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (event["isVirtual"] == true)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "VIRTUAL",
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
                  
                  Row(
                    children: [
                      Text(
                        "\$${((event["price"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _toggleReminder(event["id"] as int),
                        child: Icon(
                          event["reminder"] == true ? Icons.notifications : Icons.notifications_none,
                          color: event["reminder"] == true ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Details",
                        size: bs.sm,
                        onPressed: () {
                          si("Event details opened");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastEventCard(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Row(
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
            
            SizedBox(width: spSm),
            
            // Event Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${event["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: event["status"] == "attended" 
                              ? successColor 
                              : event["status"] == "missed" 
                                  ? dangerColor 
                                  : disabledBoldColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${event["status"]}".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${event["date"]} at ${event["time"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spXs),
                  
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
                          "${event["city"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  if (event["status"] == "attended") ...[
                    SizedBox(height: spXs),
                    Row(
                      children: [
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
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${event["feedback"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                  SizedBox(height: spXs),
                  
                  Row(
                    children: [
                      Text(
                        "\$${((event["price"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (event["status"] == "attended")
                        QButton(
                          label: "Review",
                          size: bs.sm,
                          onPressed: () {
                            si("Review form opened");
                          },
                        )
                      else if (event["status"] == "missed")
                        QButton(
                          label: "Book Again",
                          size: bs.sm,
                          onPressed: () {
                            ss("Redirected to similar events");
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarView() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Calendar Header
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
                  setState(() {});
                },
                child: Icon(Icons.chevron_left, color: primaryColor),
              ),
              Expanded(
                child: Text(
                  "${selectedDate.month}/${selectedDate.year}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
                  setState(() {});
                },
                child: Icon(Icons.chevron_right, color: primaryColor),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Calendar Events for Selected Month
          if (calendarEvents.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No events this month",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: calendarEvents.map((event) {
                bool isUpcoming = upcomingEvents.any((e) => e["id"] == event["id"]);
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isUpcoming ? primaryColor.withAlpha(10) : disabledColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isUpcoming ? primaryColor : disabledBoldColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusXs),
                          image: DecorationImage(
                            image: NetworkImage("${event["image"]}"),
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
                              "${event["shortTitle"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isUpcoming ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${event["date"]} ${event["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: isUpcoming ? successColor : disabledBoldColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          isUpcoming ? "UPCOMING" : "PAST",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Events"),
        actions: [
          GestureDetector(
            onTap: () {
              showCalendarView = !showCalendarView;
              setState(() {});
            },
            child: Icon(
              showCalendarView ? Icons.list : Icons.calendar_today,
              color: disabledBoldColor,
            ),
          ),
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
            if (showCalendarView) ...[
              _buildCalendarView(),
            ] else ...[
              // Tab Selection
              Container(
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedTab = 0;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == 0 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Upcoming (${upcomingEvents.length})",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedTab = 1;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == 1 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Past (${pastEvents.length})",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Events List
              if (selectedTab == 0) ...[
                if (upcomingEvents.isEmpty)
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
                          "No Upcoming Events",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Discover new events to join",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Browse Events",
                          size: bs.md,
                          onPressed: () {
                            si("Redirected to event discovery");
                          },
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    children: upcomingEvents.map((event) => _buildUpcomingEventCard(event)).toList(),
                  ),
              ] else ...[
                if (pastEvents.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No Past Events",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Your event history will appear here",
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
                    children: pastEvents.map((event) => _buildPastEventCard(event)).toList(),
                  ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
