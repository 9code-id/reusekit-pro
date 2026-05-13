import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaPopularDestinationsView extends StatefulWidget {
  const TtaPopularDestinationsView({super.key});

  @override
  State<TtaPopularDestinationsView> createState() => _TtaPopularDestinationsViewState();
}

class _TtaPopularDestinationsViewState extends State<TtaPopularDestinationsView> {
  String selectedTimeframe = "This Week";
  
  final List<String> timeframes = [
    "This Week",
    "This Month",
    "This Year",
    "All Time"
  ];

  final List<Map<String, dynamic>> popularDestinations = [
    {
      "id": 1,
      "name": "Bali, Indonesia",
      "image": "https://picsum.photos/400/300?random=11&keyword=bali",
      "rating": 4.8,
      "reviews": 12450,
      "visitors": 85000,
      "trend": "up",
      "trendPercent": 15,
      "price": 1250,
      "category": "Beach & Culture",
      "isBookmarked": false,
    },
    {
      "id": 2,
      "name": "Tokyo, Japan",
      "image": "https://picsum.photos/400/300?random=12&keyword=tokyo",
      "rating": 4.9,
      "reviews": 9870,
      "visitors": 72000,
      "trend": "up",
      "trendPercent": 22,
      "price": 1800,
      "category": "City & Culture",
      "isBookmarked": true,
    },
    {
      "id": 3,
      "name": "Paris, France",
      "image": "https://picsum.photos/400/300?random=13&keyword=paris",
      "rating": 4.7,
      "reviews": 15600,
      "visitors": 68000,
      "trend": "stable",
      "trendPercent": 3,
      "price": 2100,
      "category": "Romance & Art",
      "isBookmarked": false,
    },
    {
      "id": 4,
      "name": "Maldives",
      "image": "https://picsum.photos/400/300?random=14&keyword=maldives",
      "rating": 4.9,
      "reviews": 7890,
      "visitors": 45000,
      "trend": "up",
      "trendPercent": 18,
      "price": 3500,
      "category": "Luxury Beach",
      "isBookmarked": true,
    },
    {
      "id": 5,
      "name": "New York, USA",
      "image": "https://picsum.photos/400/300?random=15&keyword=newyork",
      "rating": 4.6,
      "reviews": 11200,
      "visitors": 62000,
      "trend": "down",
      "trendPercent": -5,
      "price": 1950,
      "category": "Urban Adventure",
      "isBookmarked": false,
    },
    {
      "id": 6,
      "name": "Santorini, Greece",
      "image": "https://picsum.photos/400/300?random=16&keyword=santorini",
      "rating": 4.8,
      "reviews": 8950,
      "visitors": 38000,
      "trend": "up",
      "trendPercent": 12,
      "price": 2800,
      "category": "Romance & Views",
      "isBookmarked": true,
    },
  ];

  void toggleBookmark(int destinationId) {
    setState(() {
      final index = popularDestinations.indexWhere((dest) => dest["id"] == destinationId);
      if (index != -1) {
        popularDestinations[index]["isBookmarked"] = !popularDestinations[index]["isBookmarked"];
      }
    });
  }

  Widget _buildTrendIndicator(String trend, int percent) {
    Color trendColor;
    IconData trendIcon;
    
    if (trend == "up") {
      trendColor = successColor;
      trendIcon = Icons.trending_up;
    } else if (trend == "down") {
      trendColor = dangerColor;
      trendIcon = Icons.trending_down;
    } else {
      trendColor = warningColor;
      trendIcon = Icons.trending_flat;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
      decoration: BoxDecoration(
        color: trendColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            trendIcon,
            color: trendColor,
            size: 14,
          ),
          SizedBox(width: 4),
          Text(
            "${percent.abs()}%",
            style: TextStyle(
              color: trendColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Destinations"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.tune),
          ),
        ],
      ),
      body: Column(
        children: [
          // Timeframe Filter
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: QHorizontalScroll(
              children: timeframes.map((timeframe) {
                final isSelected = selectedTimeframe == timeframe;
                return GestureDetector(
                  onTap: () {
                    selectedTimeframe = timeframe;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      timeframe,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Stats Summary
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Total Visitors",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${((popularDestinations.map((d) => d["visitors"] as int).reduce((a, b) => a + b)) / 1000).toInt()}K",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Avg Rating",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${(popularDestinations.map((d) => d["rating"] as double).reduce((a, b) => a + b) / popularDestinations.length).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Trending Up",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${popularDestinations.where((d) => d["trend"] == "up").length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Destinations List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: popularDestinations.length,
              itemBuilder: (context, index) {
                final destination = popularDestinations[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image and Bookmark
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: AspectRatio(
                              aspectRatio: 16/9,
                              child: Image.network(
                                "${destination["image"]}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "#${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () => toggleBookmark(destination["id"] as int),
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  destination["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                  color: destination["isBookmarked"] ? primaryColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${destination["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _buildTrendIndicator(
                                  destination["trend"] as String,
                                  destination["trendPercent"] as int,
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${destination["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "(${destination["reviews"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${destination["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${((destination["visitors"] as int) / 1000).toInt()}K visitors",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Starting from",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(destination["price"] as int).toDouble().currency}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  label: "Explore",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
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
}
