import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsTrendingServicesView extends StatefulWidget {
  const BrsTrendingServicesView({super.key});

  @override
  State<BrsTrendingServicesView> createState() => _BrsTrendingServicesViewState();
}

class _BrsTrendingServicesViewState extends State<BrsTrendingServicesView> {
  String selectedTab = "This Week";
  
  List<String> tabs = ["This Week", "This Month", "All Time"];
  
  List<Map<String, dynamic>> trendingServices = [
    {
      "id": 1,
      "name": "Fade Cut & Style",
      "category": "Modern Styling",
      "price": 35,
      "duration": "45 min",
      "description": "The most popular modern haircut with perfect fade transitions",
      "image": "https://picsum.photos/300/200?random=1&keyword=fade",
      "rating": 4.9,
      "bookings": 342,
      "growth": "+45%",
      "rank": 1,
      "barbersOffering": 12,
      "trendscore": 95,
    },
    {
      "id": 2,
      "name": "Classic Gentleman's Cut",
      "category": "Classic Cuts",
      "price": 28,
      "duration": "35 min",
      "description": "Timeless classic cut that never goes out of style",
      "image": "https://picsum.photos/300/200?random=2&keyword=classic",
      "rating": 4.8,
      "bookings": 298,
      "growth": "+32%",
      "rank": 2,
      "barbersOffering": 15,
      "trendscore": 88,
    },
    {
      "id": 3,
      "name": "Beard Trim & Design",
      "category": "Beard Styling",
      "price": 22,
      "duration": "30 min",
      "description": "Professional beard shaping and precision trimming",
      "image": "https://picsum.photos/300/200?random=3&keyword=beard",
      "rating": 4.7,
      "bookings": 276,
      "growth": "+28%",
      "rank": 3,
      "barbersOffering": 18,
      "trendscore": 82,
    },
    {
      "id": 4,
      "name": "Hot Towel Shave",
      "category": "Traditional Shave",
      "price": 32,
      "duration": "40 min",
      "description": "Luxurious traditional shave with hot towel treatment",
      "image": "https://picsum.photos/300/200?random=4&keyword=shave",
      "rating": 4.9,
      "bookings": 234,
      "growth": "+52%",
      "rank": 4,
      "barbersOffering": 8,
      "trendscore": 79,
    },
    {
      "id": 5,
      "name": "Buzz Cut",
      "category": "Short Cuts",
      "price": 18,
      "duration": "15 min",
      "description": "Clean and simple buzz cut for a fresh look",
      "image": "https://picsum.photos/300/200?random=5&keyword=buzzcut",
      "rating": 4.6,
      "bookings": 198,
      "growth": "+15%",
      "rank": 5,
      "barbersOffering": 20,
      "trendscore": 76,
    },
    {
      "id": 6,
      "name": "Undercut Style",
      "category": "Modern Styling",
      "price": 38,
      "duration": "50 min",
      "description": "Trendy undercut with styled top for a modern edge",
      "image": "https://picsum.photos/300/200?random=6&keyword=undercut",
      "rating": 4.8,
      "bookings": 167,
      "growth": "+38%",
      "rank": 6,
      "barbersOffering": 10,
      "trendscore": 73,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Services"),
        actions: [
          IconButton(
            icon: Icon(Icons.insights),
            onPressed: () {
              si("View detailed analytics");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "1,543",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Bookings",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "+35%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Growth Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Discover what's trending in grooming",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          
          // Time Period Tabs
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: tabs.map((tab) {
                bool isSelected = selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = tab;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Trending Services List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: trendingServices.length,
              itemBuilder: (context, index) {
                final service = trendingServices[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Header with Rank
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getRankColor(service["rank"] as int).withAlpha(50),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _getRankColor(service["rank"] as int),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Center(
                                child: Text(
                                  "#${service["rank"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Trending #${service["rank"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getRankColor(service["rank"] as int),
                                    ),
                                  ),
                                  Text(
                                    "Trend Score: ${service["trendscore"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${service["growth"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Service Details
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${service["image"]}",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${service["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${service["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${service["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Stats Row
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusMd),
                            bottomRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildStatItem(Icons.star, "${service["rating"]}", "Rating"),
                            _buildStatItem(Icons.bookmark, "${service["bookings"]}", "Bookings"),
                            _buildStatItem(Icons.schedule, "${service["duration"]}", "Duration"),
                            _buildStatItem(Icons.store, "${service["barbersOffering"]}", "Barbers"),
                            Spacer(),
                            Text(
                              "\$${service["price"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Action Buttons
                      Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  si("Viewing ${service["name"]} details");
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Book Now",
                                size: bs.sm,
                                onPressed: () {
                                  si("Booking ${service["name"]}");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Color(0xFFFFD700); // Gold
      case 2:
        return Color(0xFFC0C0C0); // Silver
      case 3:
        return Color(0xFFCD7F32); // Bronze
      default:
        return primaryColor;
    }
  }
}
