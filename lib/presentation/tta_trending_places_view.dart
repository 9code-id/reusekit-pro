import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaTrendingPlacesView extends StatefulWidget {
  const TtaTrendingPlacesView({super.key});

  @override
  State<TtaTrendingPlacesView> createState() => _TtaTrendingPlacesViewState();
}

class _TtaTrendingPlacesViewState extends State<TtaTrendingPlacesView> {
  String selectedFilter = "Rising Fast";
  
  final List<String> filters = [
    "Rising Fast",
    "Most Searched",
    "Recently Added",
    "Hidden Gems"
  ];

  final List<Map<String, dynamic>> trendingPlaces = [
    {
      "id": 1,
      "name": "Faroe Islands",
      "country": "Denmark",
      "image": "https://picsum.photos/400/300?random=21&keyword=faroe",
      "trendScore": 98,
      "growthRate": 245,
      "searchVolume": 15600,
      "timeToTrend": "3 days",
      "category": "Nature",
      "description": "Remote islands with dramatic cliffs and Nordic charm",
      "avgPrice": 2800,
      "difficulty": "Moderate",
      "bestSeason": "May-Sep",
      "isNew": true,
    },
    {
      "id": 2,
      "name": "Socotra Island",
      "country": "Yemen",
      "image": "https://picsum.photos/400/300?random=22&keyword=socotra",
      "trendScore": 95,
      "growthRate": 189,
      "searchVolume": 8900,
      "timeToTrend": "1 week",
      "category": "Adventure",
      "description": "Alien-like landscapes with unique flora and fauna",
      "avgPrice": 3200,
      "difficulty": "Challenging",
      "bestSeason": "Oct-Apr",
      "isNew": false,
    },
    {
      "id": 3,
      "name": "Raja Ampat",
      "country": "Indonesia",
      "image": "https://picsum.photos/400/300?random=23&keyword=diving",
      "trendScore": 92,
      "growthRate": 167,
      "searchVolume": 12300,
      "timeToTrend": "2 weeks",
      "category": "Marine",
      "description": "World's richest marine biodiversity for diving",
      "avgPrice": 2100,
      "difficulty": "Moderate",
      "bestSeason": "Oct-Apr",
      "isNew": true,
    },
    {
      "id": 4,
      "name": "Lofoten Islands",
      "country": "Norway",
      "image": "https://picsum.photos/400/300?random=24&keyword=lofoten",
      "trendScore": 88,
      "growthRate": 134,
      "searchVolume": 18700,
      "timeToTrend": "5 days",
      "category": "Nature",
      "description": "Arctic beauty with fishing villages and Northern Lights",
      "avgPrice": 3500,
      "difficulty": "Easy",
      "bestSeason": "May-Sep",
      "isNew": false,
    },
    {
      "id": 5,
      "name": "Azores",
      "country": "Portugal",
      "image": "https://picsum.photos/400/300?random=25&keyword=azores",
      "trendScore": 85,
      "growthRate": 156,
      "searchVolume": 21400,
      "timeToTrend": "1 week",
      "category": "Volcanic",
      "description": "Volcanic islands with hot springs and crater lakes",
      "avgPrice": 1800,
      "difficulty": "Easy",
      "bestSeason": "Apr-Oct",
      "isNew": true,
    },
    {
      "id": 6,
      "name": "Sark Island",
      "country": "Channel Islands",
      "image": "https://picsum.photos/400/300?random=26&keyword=sark",
      "trendScore": 82,
      "growthRate": 178,
      "searchVolume": 5600,
      "timeToTrend": "4 days",
      "category": "Heritage",
      "description": "Car-free island with dark sky preserve status",
      "avgPrice": 2200,
      "difficulty": "Easy",
      "bestSeason": "Apr-Oct",
      "isNew": false,
    },
  ];

  Color _getTrendScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 80) return warningColor;
    return infoColor;
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Challenging":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Places"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.trending_up),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: QHorizontalScroll(
              children: filters.map((filter) {
                final isSelected = selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    selectedFilter = filter;
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
                      filter,
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

          // Trending Stats
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withValues(alpha: 0.1),
                  successColor.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Trending Algorithm",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Based on search volume, bookings, and social mentions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "LIVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Trending Places List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: trendingPlaces.length,
              itemBuilder: (context, index) {
                final place = trendingPlaces[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Image Header
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
                                "${place["image"]}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          
                          // Trending Rank
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getTrendScoreColor(place["trendScore"] as int),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${place["trendScore"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // New Badge
                          if (place["isNew"])
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "NEW",
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

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Country
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${place["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: disabledBoldColor,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "${place["country"]}",
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
                                    "${place["category"]}",
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

                            // Description
                            Text(
                              "${place["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: spMd),

                            // Stats Row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Growth Rate",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "+${place["growthRate"]}%",
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
                                        "Searches",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${((place["searchVolume"] as int) / 1000).toStringAsFixed(1)}K",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: infoColor,
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
                                        "Time to Trend",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${place["timeToTrend"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spMd),

                            // Details Row
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor(place["difficulty"] as String).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${place["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getDifficultyColor(place["difficulty"] as String),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${place["bestSeason"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "From \$${(place["avgPrice"] as int).toDouble().currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spMd),

                            // Action Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Learn More",
                                size: bs.sm,
                                onPressed: () {},
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
}
