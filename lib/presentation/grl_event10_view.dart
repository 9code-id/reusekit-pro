import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEvent10View extends StatefulWidget {
  @override
  State<GrlEvent10View> createState() => _GrlEvent10ViewState();
}

class _GrlEvent10ViewState extends State<GrlEvent10View> {
  int currentTab = 0;

  Map organizerProfile = {
    "name": "EventMasters Inc.",
    "description": "Premier event organizer specializing in music festivals, corporate events, and entertainment experiences.",
    "logo": "https://picsum.photos/100/100?random=1&keyword=logo",
    "coverImage": "https://picsum.photos/400/200?random=2&keyword=events",
    "rating": 4.8,
    "totalReviews": 2847,
    "totalEvents": 156,
    "yearsActive": 8,
    "location": "New York, NY",
    "website": "www.eventmasters.com",
    "email": "info@eventmasters.com",
    "phone": "+1 (555) 123-4567",
    "followers": 12540,
    "isFollowing": false,
    "verified": true,
    "specialties": ["Music Festivals", "Corporate Events", "Art Exhibitions", "Sports Events"],
  };

  List upcomingEvents = [
    {
      "id": 1,
      "title": "Summer Jazz Festival 2024",
      "subtitle": "3-Day Musical Experience",
      "date": "2024-08-15",
      "time": "18:00",
      "location": "Central Park Amphitheater",
      "price": 150.0,
      "originalPrice": 200.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=jazz",
      "category": "Music",
      "rating": 4.9,
      "attendees": 5000,
      "status": "selling_fast",
      "ticketsLeft": 245,
    },
    {
      "id": 2,
      "title": "Tech Innovation Summit",
      "subtitle": "Future of Technology",
      "date": "2024-08-25",
      "time": "09:00",
      "location": "Convention Center",
      "price": 295.0,
      "originalPrice": 350.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=tech",
      "category": "Business",
      "rating": 4.8,
      "attendees": 1200,
      "status": "available",
      "ticketsLeft": 850,
    },
    {
      "id": 3,
      "title": "Art & Culture Expo",
      "subtitle": "Contemporary Art Showcase",
      "date": "2024-09-10",
      "time": "10:00",
      "location": "Museum of Modern Art",
      "price": 45.0,
      "originalPrice": 60.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=art",
      "category": "Art",
      "rating": 4.7,
      "attendees": 800,
      "status": "early_bird",
      "ticketsLeft": 1200,
    },
  ];

  List pastEvents = [
    {
      "title": "Food & Wine Festival",
      "date": "2024-06-15",
      "location": "Harbor Front",
      "image": "https://picsum.photos/120/80?random=6&keyword=food",
      "rating": 4.6,
      "attendees": 3200,
      "revenue": 125000.0,
    },
    {
      "title": "Rock Concert Live",
      "date": "2024-05-20",
      "location": "Stadium Arena",
      "image": "https://picsum.photos/120/80?random=7&keyword=rock",
      "rating": 4.8,
      "attendees": 8500,
      "revenue": 275000.0,
    },
    {
      "title": "Comedy Night Special",
      "date": "2024-04-10",
      "location": "Comedy Club",
      "image": "https://picsum.photos/120/80?random=8&keyword=comedy",
      "rating": 4.5,
      "attendees": 400,
      "revenue": 18000.0,
    },
    {
      "title": "Classical Music Evening",
      "date": "2024-03-25",
      "location": "Symphony Hall",
      "image": "https://picsum.photos/120/80?random=9&keyword=classical",
      "rating": 4.9,
      "attendees": 1200,
      "revenue": 85000.0,
    },
  ];

  List reviews = [
    {
      "id": 1,
      "userName": "Sarah Johnson",
      "userAvatar": "https://picsum.photos/50/50?random=10&keyword=person",
      "rating": 5,
      "comment": "Absolutely amazing experience! The organization was flawless and the venue was perfect. Will definitely attend more events by EventMasters.",
      "eventName": "Summer Jazz Festival 2023",
      "date": "2024-06-20",
      "helpful": 24,
    },
    {
      "id": 2,
      "userName": "Michael Chen",
      "userAvatar": "https://picsum.photos/50/50?random=11&keyword=person",
      "rating": 4,
      "comment": "Great event overall. The sound quality was excellent and the lineup was fantastic. Food options could be improved.",
      "eventName": "Rock Concert Live",
      "date": "2024-05-22",
      "helpful": 18,
    },
    {
      "id": 3,
      "userName": "Emily Rodriguez",
      "userAvatar": "https://picsum.photos/50/50?random=12&keyword=person",
      "rating": 5,
      "comment": "Professional organization and attention to detail. The venue was beautiful and staff were very helpful throughout the event.",
      "eventName": "Art & Culture Expo 2023",
      "date": "2024-04-15",
      "helpful": 31,
    },
    {
      "id": 4,
      "userName": "David Wilson",
      "userAvatar": "https://picsum.photos/50/50?random=13&keyword=person",
      "rating": 4,
      "comment": "Good event with interesting speakers. Registration process was smooth and venue was easily accessible.",
      "eventName": "Tech Innovation Summit",
      "date": "2024-03-30",
      "helpful": 12,
    },
  ];

  List organizerStats = [
    {
      "label": "Total Events",
      "value": "156",
      "icon": Icons.event,
      "color": primaryColor,
    },
    {
      "label": "Total Attendees",
      "value": "125K+",
      "icon": Icons.people,
      "color": successColor,
    },
    {
      "label": "Average Rating",
      "value": "4.8",
      "icon": Icons.star,
      "color": warningColor,
    },
    {
      "label": "Years Active",
      "value": "8",
      "icon": Icons.timeline,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            _buildTabSection(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.network(
            "${organizerProfile["coverImage"]}",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withAlpha(179),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: spMd,
          child: Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(128),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: spMd,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(128),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(128),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: spMd,
          left: spMd,
          right: spMd,
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${organizerProfile["logo"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${organizerProfile["name"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (organizerProfile["verified"] as bool)
                          Icon(
                            Icons.verified,
                            color: successColor,
                            size: 20,
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${(organizerProfile["rating"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "(${organizerProfile["totalReviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${organizerProfile["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${organizerProfile["followers"]} followers",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    List tabs = ["Events", "About", "Reviews"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: organizerProfile["isFollowing"] as bool ? "Following" : "Follow",
                  size: bs.md,
                  onPressed: () {
                    organizerProfile["isFollowing"] = !(organizerProfile["isFollowing"] as bool);
                    if (organizerProfile["isFollowing"] as bool) {
                      organizerProfile["followers"] = (organizerProfile["followers"] as int) + 1;
                      ss("Now following ${organizerProfile["name"]}");
                    } else {
                      organizerProfile["followers"] = (organizerProfile["followers"] as int) - 1;
                      ss("Unfollowed ${organizerProfile["name"]}");
                    }
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: QButton(
                  label: "Contact",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: tabs.asMap().entries.map((entry) {
              int index = entry.key;
              String tab = entry.value;
              bool isSelected = currentTab == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    currentTab = index;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? primaryColor : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      tab,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildEventsTab();
      case 1:
        return _buildAboutTab();
      case 2:
        return _buildReviewsTab();
      default:
        return _buildEventsTab();
    }
  }

  Widget _buildEventsTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: upcomingEvents.map((event) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            child: Image.network(
                              "${event["image"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: event["status"] == "selling_fast" 
                                ? dangerColor 
                                : event["status"] == "early_bird" 
                                  ? successColor 
                                  : primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              event["status"] == "selling_fast" 
                                ? "Selling Fast" 
                                : event["status"] == "early_bird" 
                                  ? "Early Bird" 
                                  : "Available",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.favorite_border,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(179),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "\$${(event["price"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "\$${(event["originalPrice"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(179),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
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
                          SizedBox(height: spXs),
                          Text(
                            "${event["subtitle"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "${DateTime.parse(event["date"]).dMMMy} at ${event["time"]}",
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
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  "${event["location"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    "${(event["rating"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${event["attendees"]} interested",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${event["ticketsLeft"]} tickets left",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: event["status"] == "selling_fast" ? dangerColor : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Book Now",
                              size: bs.md,
                              onPressed: () {},
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
          SizedBox(height: spMd),
          Text(
            "Past Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            minItemWidth: 200,
            children: pastEvents.map((event) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                        child: Image.network(
                          "${event["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${event["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${DateTime.parse(event["date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 12,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${(event["rating"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${event["attendees"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
          SizedBox(height: spMd),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            minItemWidth: 200,
            children: organizerStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (stat["color"] as Color).withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        stat["icon"] as IconData,
                        color: stat["color"] as Color,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["label"]}",
                      textAlign: TextAlign.center,
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
          SizedBox(height: spMd),
          Text(
            "About",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Text(
              "${organizerProfile["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Specialties",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (organizerProfile["specialties"] as List).map((specialty) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "$specialty",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${organizerProfile["website"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${organizerProfile["email"]}",
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
                      Icons.phone,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${organizerProfile["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "${(organizerProfile["rating"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (organizerProfile["rating"] as double).round() ? Icons.star : Icons.star_border,
                          color: warningColor,
                          size: 16,
                        );
                      }),
                    ),
                    Text(
                      "${organizerProfile["totalReviews"]} reviews",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    children: List.generate(5, (index) {
                      int stars = 5 - index;
                      int count = (organizerProfile["totalReviews"] as int) ~/ (index + 1);
                      double percentage = count / (organizerProfile["totalReviews"] as int);
                      
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Text(
                              "$stars",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Icon(
                              Icons.star,
                              size: 12,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: percentage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "$count",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Recent Reviews",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: reviews.map((review) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${review["userAvatar"]}",
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
                                "${review["userName"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${review["eventName"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                                  color: warningColor,
                                  size: 14,
                                );
                              }),
                            ),
                            Text(
                              "${DateTime.parse(review["date"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${review["comment"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${review["helpful"]} helpful",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Helpful?",
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
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
        ],
      ),
    );
  }
}
