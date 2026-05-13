import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaRewardsView extends StatefulWidget {
  const TtaRewardsView({super.key});

  @override
  State<TtaRewardsView> createState() => _TtaRewardsViewState();
}

class _TtaRewardsViewState extends State<TtaRewardsView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Hotels", "value": "Hotels"},
    {"label": "Flights", "value": "Flights"},
    {"label": "Experiences", "value": "Experiences"},
    {"label": "Dining", "value": "Dining"},
  ];

  List<Map<String, dynamic>> rewards = [
    {
      "id": 1,
      "title": "Free Night Stay",
      "description": "Get one free night at participating hotels worldwide",
      "points": 50000,
      "category": "Hotels",
      "image": "https://picsum.photos/300/200?random=1&keyword=hotel",
      "available": true,
      "expiryDays": 365,
      "popularity": "Most Popular",
      "terms": "Valid for stays of 2+ nights. Blackout dates apply.",
    },
    {
      "id": 2,
      "title": "Flight Upgrade",
      "description": "Upgrade to business class on your next flight",
      "points": 30000,
      "category": "Flights",
      "image": "https://picsum.photos/300/200?random=2&keyword=airplane",
      "available": true,
      "expiryDays": 180,
      "popularity": "Limited Time",
      "terms": "Subject to availability. Applicable on select routes.",
    },
    {
      "id": 3,
      "title": "Spa Day Package",
      "description": "Relax with a full day spa experience",
      "points": 25000,
      "category": "Experiences",
      "image": "https://picsum.photos/300/200?random=3&keyword=spa",
      "available": true,
      "expiryDays": 90,
      "popularity": "New",
      "terms": "Valid at participating spa locations only.",
    },
    {
      "id": 4,
      "title": "Dining Credit",
      "description": "\$100 credit for fine dining restaurants",
      "points": 15000,
      "category": "Dining",
      "image": "https://picsum.photos/300/200?random=4&keyword=restaurant",
      "available": true,
      "expiryDays": 120,
      "popularity": "",
      "terms": "Cannot be combined with other offers.",
    },
    {
      "id": 5,
      "title": "City Tour Experience",
      "description": "Guided city tour for 2 people in major destinations",
      "points": 20000,
      "category": "Experiences",
      "image": "https://picsum.photos/300/200?random=5&keyword=tour",
      "available": false,
      "expiryDays": 60,
      "popularity": "Sold Out",
      "terms": "Available in select cities. Advance booking required.",
    },
    {
      "id": 6,
      "title": "Airport Lounge Access",
      "description": "Complimentary access to premium airport lounges",
      "points": 8000,
      "category": "Flights",
      "image": "https://picsum.photos/300/200?random=6&keyword=lounge",
      "available": true,
      "expiryDays": 30,
      "popularity": "",
      "terms": "Valid for single use. Check participating lounges.",
    },
  ];

  List<Map<String, dynamic>> get filteredRewards {
    if (selectedCategory == "All") {
      return rewards;
    }
    return rewards.where((reward) => reward["category"] == selectedCategory).toList();
  }

  Color _getPopularityColor(String popularity) {
    switch (popularity) {
      case "Most Popular":
        return dangerColor;
      case "Limited Time":
        return warningColor;
      case "New":
        return successColor;
      case "Sold Out":
        return disabledColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rewards Catalog"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Filter functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Points",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "127,500",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.card_giftcard,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),

            // Category Filter
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Rewards Grid
            Text(
              "Available Rewards",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 300,
              children: filteredRewards.map((reward) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Reward Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${reward["image"]}",
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (reward["popularity"].isNotEmpty)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getPopularityColor(reward["popularity"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${reward["popularity"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Reward Title
                            Text(
                              "${reward["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),

                            // Description
                            Text(
                              "${reward["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Points Required
                            Row(
                              children: [
                                Icon(
                                  Icons.stars,
                                  color: warningColor,
                                  size: 18,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(reward["points"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} points",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Expires in ${reward["expiryDays"]} days",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            // Terms Preview
                            Text(
                              "${reward["terms"]}",
                              style: TextStyle(
                                color: disabledColor,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Action Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: reward["available"] as bool 
                                    ? "Redeem Now" 
                                    : "Not Available",
                                size: bs.sm,
                                color: reward["available"] as bool 
                                    ? primaryColor 
                                    : disabledColor,
                                onPressed: reward["available"] as bool 
                                    ? () {
                                        // Handle redeem
                                      }
                                    : null,
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

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Earn More Points",
                          icon: Icons.add_circle,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to earn points
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Transfer Points",
                          icon: Icons.swap_horiz,
                          size: bs.sm,
                          color: secondaryColor,
                          onPressed: () {
                            // Navigate to transfer points
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
      ),
    );
  }
}
