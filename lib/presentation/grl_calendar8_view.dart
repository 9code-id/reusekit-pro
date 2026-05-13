import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCalendar8View extends StatefulWidget {
  @override
  State<GrlCalendar8View> createState() => _GrlCalendar8ViewState();
}

class _GrlCalendar8ViewState extends State<GrlCalendar8View> {
  DateTime selectedDate = DateTime.now();
  String selectedCategory = 'all';
  
  List<Map<String, dynamic>> socialEvents = [
    {
      "id": 1,
      "title": "Team Building Workshop",
      "date": DateTime.now(),
      "time": "14:00 - 17:00",
      "location": "Conference Center",
      "attendees": 25,
      "category": "corporate",
      "organizer": "HR Department",
      "description": "Interactive team building activities and networking",
      "status": "attending",
      "image": "https://picsum.photos/300/200?random=1",
    },
    {
      "id": 2,
      "title": "Community Charity Gala",
      "date": DateTime.now().add(Duration(days: 2)),
      "time": "19:00 - 23:00",
      "location": "Grand Ballroom",
      "attendees": 150,
      "category": "charity",
      "organizer": "Local Community Center",
      "description": "Annual fundraising event for local charities",
      "status": "interested",
      "image": "https://picsum.photos/300/200?random=2",
    },
    {
      "id": 3,
      "title": "Art Gallery Opening",
      "date": DateTime.now().add(Duration(days: 5)),
      "time": "18:30 - 21:30",
      "location": "Modern Art Gallery",
      "attendees": 80,
      "category": "cultural",
      "organizer": "Gallery Curator",
      "description": "Contemporary art exhibition featuring local artists",
      "status": "maybe",
      "image": "https://picsum.photos/300/200?random=3",
    },
    {
      "id": 4,
      "title": "Networking Mixer",
      "date": DateTime.now().add(Duration(days: 7)),
      "time": "17:30 - 20:00",
      "location": "Rooftop Bar",
      "attendees": 60,
      "category": "professional",
      "organizer": "Business Association",
      "description": "Professional networking event for industry leaders",
      "status": "attending",
      "image": "https://picsum.photos/300/200?random=4",
    },
    {
      "id": 5,
      "title": "Food Festival",
      "date": DateTime.now().add(Duration(days: 10)),
      "time": "12:00 - 20:00",
      "location": "City Park",
      "attendees": 500,
      "category": "entertainment",
      "organizer": "City Council",
      "description": "Local restaurants showcase their best dishes",
      "status": "interested",
      "image": "https://picsum.photos/300/200?random=5",
    },
  ];

  List<Map<String, dynamic>> friends = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=10",
      "mutualEvents": 12,
      "status": "online",
    },
    {
      "id": 2,
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/100/100?random=11",
      "mutualEvents": 8,
      "status": "busy",
    },
    {
      "id": 3,
      "name": "Emma Wilson",
      "avatar": "https://picsum.photos/100/100?random=12",
      "mutualEvents": 15,
      "status": "online",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Events"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover Events",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Connect with your community through amazing events",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${socialEvents.where((e) => e["status"] == "attending").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Attending",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white30,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${socialEvents.where((e) => e["status"] == "interested").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Interested",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white30,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${friends.length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Friends",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
            
            // Category Filter
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QHorizontalScroll(
                    children: [
                      'all', 'corporate', 'charity', 'cultural', 'professional', 'entertainment'
                    ].map((category) => GestureDetector(
                      onTap: () {
                        selectedCategory = category;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCategory == category ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: Border.all(
                            color: selectedCategory == category ? primaryColor : disabledColor,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: selectedCategory == category ? Colors.white : primaryColor,
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
            
            // Events List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Upcoming Events",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // navigateTo(AllEventsView());
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  ...socialEvents.where((event) {
                    if (selectedCategory == 'all') return true;
                    return event["category"] == selectedCategory;
                  }).map((event) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Image
                        Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            image: DecorationImage(
                              image: NetworkImage("${event["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black.withAlpha(100)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getCategoryColor(event["category"]),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${event["category"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(200),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Icon(
                                          Icons.bookmark_border,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "${(event["date"] as DateTime).day}",
                                    style: TextStyle(
                                      fontSize: fsH3,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "${_getMonthName((event["date"] as DateTime).month).substring(0, 3).toUpperCase()}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
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
                                    Icons.access_time,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["time"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(event["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${event["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(event["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spMd),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: event["status"] == "attending" ? "Attending" : "Join Event",
                                      size: bs.sm,
                                      onPressed: () {
                                        if (event["status"] != "attending") {
                                          event["status"] = "attending";
                                          setState(() {});
                                          ss("You're now attending this event!");
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QButton(
                                      label: "Details",
                                      size: bs.sm,
                                      onPressed: () {
                                        // navigateTo(EventDetailsView());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            // Friends Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Friends Activity",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // navigateTo(FriendsView());
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QHorizontalScroll(
                    children: friends.map((friend) => Container(
                      width: 120,
                      margin: EdgeInsets.only(right: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage("${friend["avatar"]}"),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: friend["status"] == "online" ? successColor : warningColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${friend["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${friend["mutualEvents"]} mutual events",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(CreateEventView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'corporate':
        return primaryColor;
      case 'charity':
        return successColor;
      case 'cultural':
        return warningColor;
      case 'professional':
        return infoColor;
      case 'entertainment':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'attending':
        return successColor;
      case 'interested':
        return warningColor;
      case 'maybe':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getMonthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }
}
