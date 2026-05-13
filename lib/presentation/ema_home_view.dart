import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaHomeView extends StatefulWidget {
  const EmaHomeView({super.key});

  @override
  State<EmaHomeView> createState() => _EmaHomeViewState();
}

class _EmaHomeViewState extends State<EmaHomeView> {
  int currentIndex = 0;
  String searchQuery = "";
  String selectedLocation = "New York";

  List<Map<String, dynamic>> featuredEvents = [
    {
      "id": "event1",
      "title": "Tech Conference 2024",
      "date": "2024-06-25",
      "time": "09:00",
      "location": "Convention Center",
      "price": 150.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=conference",
      "category": "Technology",
      "attendees": 250,
      "rating": 4.8,
    },
    {
      "id": "event2",
      "title": "Summer Music Festival",
      "date": "2024-07-01",
      "time": "18:00",
      "location": "Central Park",
      "price": 75.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=music",
      "category": "Music",
      "attendees": 500,
      "rating": 4.9,
    },
    {
      "id": "event3",
      "title": "Food & Wine Expo",
      "date": "2024-06-28",
      "time": "12:00",
      "location": "Grand Hotel",
      "price": 85.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=food",
      "category": "Food",
      "attendees": 180,
      "rating": 4.7,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "Music", "icon": Icons.music_note, "color": Colors.purple, "count": 25},
    {"name": "Tech", "icon": Icons.computer, "color": Colors.blue, "count": 18},
    {"name": "Food", "icon": Icons.restaurant, "color": Colors.orange, "count": 32},
    {"name": "Sports", "icon": Icons.sports_soccer, "color": Colors.green, "count": 15},
    {"name": "Arts", "icon": Icons.palette, "color": Colors.pink, "count": 22},
    {"name": "Business", "icon": Icons.business, "color": Colors.teal, "count": 12},
  ];

  List<Map<String, dynamic>> upcomingEvents = [
    {
      "id": "upcoming1",
      "title": "Morning Yoga Session",
      "date": "2024-06-20",
      "time": "07:00",
      "location": "Wellness Center",
      "price": 25.0,
      "category": "Health",
      "attendees": 30,
    },
    {
      "id": "upcoming2",
      "title": "Photography Workshop",
      "date": "2024-06-22",
      "time": "14:00",
      "location": "Art Studio",
      "price": 45.0,
      "category": "Arts",
      "attendees": 15,
    },
    {
      "id": "upcoming3",
      "title": "Startup Networking",
      "date": "2024-06-24",
      "time": "19:00",
      "location": "Business Hub",
      "price": 0.0,
      "category": "Business",
      "attendees": 85,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "EventHub",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_number),
          label: "Tickets",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildExploreTab(),
        _buildFavoritesTab(),
        _buildTicketsTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                        Text(
                          "Discover Events",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spLg),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      selectedLocation,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Search Bar
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Search events...",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),

          SizedBox(height: spLg),

          // Categories
          Row(
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  //navigateTo('EmaEventCategoriesView')
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
            children: categories.map((category) => _buildCategoryCard(category)).toList(),
          ),

          SizedBox(height: spLg),

          // Featured Events
          Row(
            children: [
              Text(
                "Featured Events",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  //navigateTo('EmaEventListView')
                },
                child: Text(
                  "See All",
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
            children: featuredEvents.map((event) => _buildFeaturedEventCard(event)).toList(),
          ),

          SizedBox(height: spLg),

          // Upcoming Events
          Text(
            "Upcoming This Week",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Column(
            children: upcomingEvents.map((event) => _buildUpcomingEventCard(event)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreTab() {
    return Center(
      child: Text(
        "Explore Tab",
        style: TextStyle(fontSize: 18, color: primaryColor),
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return Center(
      child: Text(
        "Favorites Tab",
        style: TextStyle(fontSize: 18, color: primaryColor),
      ),
    );
  }

  Widget _buildTicketsTab() {
    return Center(
      child: Text(
        "Tickets Tab",
        style: TextStyle(fontSize: 18, color: primaryColor),
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Text(
        "Profile Tab",
        style: TextStyle(fontSize: 18, color: primaryColor),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: spMd),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: (category["color"] as Color).withAlpha(25),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              category["icon"] as IconData,
              color: category["color"] as Color,
              size: 28,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${category["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "${category["count"]} events",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedEventCard(Map<String, dynamic> event) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Image.network(
              "${event["image"]}",
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${event["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${event["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
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
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${event["date"]} • ${event["time"]}",
                      style: TextStyle(
                        fontSize: 12,
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
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${event["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Text(
                      "\$${((event["price"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${event["attendees"]} going",
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
  }

  Widget _buildUpcomingEventCard(Map<String, dynamic> event) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${DateTime.parse(event["date"]).day}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${DateTime.parse(event["date"]).month.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${event["time"]} • ${event["location"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      (event["price"] as double) > 0 
                          ? "\$${((event["price"] as double).toDouble()).currency}"
                          : "Free",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "${event["attendees"]} attending",
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
          Icon(
            Icons.chevron_right,
            color: disabledBoldColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
