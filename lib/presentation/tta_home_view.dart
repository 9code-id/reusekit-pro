import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaHomeView extends StatefulWidget {
  const TtaHomeView({super.key});

  @override
  State<TtaHomeView> createState() => _TtaHomeViewState();
}

class _TtaHomeViewState extends State<TtaHomeView> {
  String searchQuery = "";
  int selectedTabIndex = 0;

  List<Map<String, dynamic>> featuredDestinations = [
    {
      "id": 1,
      "name": "Bali, Indonesia",
      "image": "https://picsum.photos/350/200?random=1&keyword=bali",
      "rating": 4.9,
      "reviews": 2847,
      "price": 1299,
      "duration": "7 days",
      "category": "Beach",
      "discount": 20,
    },
    {
      "id": 2,
      "name": "Tokyo, Japan",
      "image": "https://picsum.photos/350/200?random=2&keyword=tokyo",
      "rating": 4.8,
      "reviews": 1923,
      "price": 2199,
      "duration": "5 days",
      "category": "Culture",
      "discount": 15,
    },
    {
      "id": 3,
      "name": "Santorini, Greece",
      "image": "https://picsum.photos/350/200?random=3&keyword=santorini",
      "rating": 4.9,
      "reviews": 3241,
      "price": 1599,
      "duration": "6 days",
      "category": "Romance",
      "discount": 25,
    },
  ];

  List<Map<String, dynamic>> popularCategories = [
    {
      "name": "Beach",
      "icon": Icons.beach_access,
      "color": Colors.orange,
      "count": 127,
    },
    {
      "name": "Mountain",
      "icon": Icons.terrain,
      "color": Colors.green,
      "count": 89,
    },
    {
      "name": "City",
      "icon": Icons.location_city,
      "color": Colors.blue,
      "count": 156,
    },
    {
      "name": "Culture",
      "icon": Icons.museum,
      "color": Colors.purple,
      "count": 203,
    },
    {
      "name": "Adventure",
      "icon": Icons.hiking,
      "color": Colors.red,
      "count": 94,
    },
    {
      "name": "Food",
      "icon": Icons.restaurant,
      "color": Colors.amber,
      "count": 178,
    },
  ];

  List<Map<String, dynamic>> recentBookings = [
    {
      "destination": "Paris, France",
      "date": "March 15-22, 2024",
      "status": "Confirmed",
      "image": "https://picsum.photos/80/80?random=4&keyword=paris",
    },
    {
      "destination": "Rome, Italy",
      "date": "April 8-15, 2024",
      "status": "Pending",
      "image": "https://picsum.photos/80/80?random=5&keyword=rome",
    },
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "title": "Best Time to Visit Thailand",
      "image": "https://picsum.photos/120/80?random=6&keyword=thailand",
      "type": "Guide",
      "readTime": "5 min",
    },
    {
      "title": "Budget Travel Tips for Europe",
      "image": "https://picsum.photos/120/80?random=7&keyword=europe",
      "type": "Tips",
      "readTime": "8 min",
    },
    {
      "title": "Hidden Gems in Southeast Asia",
      "image": "https://picsum.photos/120/80?random=8&keyword=asia",
      "type": "Discovery",
      "readTime": "12 min",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Search
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  spacing: spMd,
                  children: [
                    // Top Bar
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Morning",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "Sarah Johnson",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "https://picsum.photos/40/40?random=10&keyword=person",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Search Bar
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                              boxShadow: [shadowSm],
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
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Where do you want to go?",
                                      hintStyle: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      searchQuery = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.tune,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spLg,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explore Categories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 100,
                        children: popularCategories.map((category) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: (category["color"] as Color).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusMd),
                                  ),
                                  child: Icon(
                                    category["icon"] as IconData,
                                    color: category["color"] as Color,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${category["name"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${category["count"]} places",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  // Featured Destinations
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Featured Destinations",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              // View all destinations
                            },
                            child: Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      QHorizontalScroll(
                        children: featuredDestinations.map((destination) {
                          return Container(
                            width: 280,
                            margin: EdgeInsets.only(right: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowMd],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                                      child: Image.network(
                                        "${destination["image"]}",
                                        width: double.infinity,
                                        height: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    if ((destination["discount"] as int) > 0)
                                      Positioned(
                                        top: spSm,
                                        left: spSm,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "${destination["discount"]}% OFF",
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
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(200),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.favorite_border,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Content
                                Padding(
                                  padding: EdgeInsets.all(spSm),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${destination["name"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${destination["category"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: primaryColor,
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
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 14,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${destination["rating"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "(${destination["reviews"]} reviews)",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Text(
                                            "\$${((destination["price"] as int).toDouble()).currency}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "/ ${destination["duration"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Spacer(),
                                          QButton(
                                            label: "Book Now",
                                            size: bs.sm,
                                            onPressed: () {
                                              // Book destination
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
                        }).toList(),
                      ),
                    ],
                  ),

                  // Recent Bookings
                  if (recentBookings.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Upcoming Trips",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Column(
                          spacing: spSm,
                          children: recentBookings.map((booking) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: [shadowSm],
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      "${booking["image"]}",
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${booking["destination"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "${booking["date"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: booking["status"] == "Confirmed" 
                                              ? successColor.withAlpha(20)
                                              : warningColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${booking["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: booking["status"] == "Confirmed" 
                                                ? successColor
                                                : warningColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                  // Travel Tips & Recommendations
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Travel Tips & Guides",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              // View all tips
                            },
                            child: Text(
                              "See More",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Column(
                        spacing: spSm,
                        children: recommendations.map((tip) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${tip["image"]}",
                                    width: 80,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${tip["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: infoColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${tip["type"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: infoColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Icon(
                                            Icons.access_time,
                                            size: 12,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${tip["readTime"]}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.bookmark_border,
                                  size: 20,
                                  color: disabledBoldColor,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
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
}
