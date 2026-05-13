import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaRecommendationsView extends StatefulWidget {
  const SpaRecommendationsView({Key? key}) : super(key: key);

  @override
  State<SpaRecommendationsView> createState() => _SpaRecommendationsViewState();
}

class _SpaRecommendationsViewState extends State<SpaRecommendationsView> {
  String selectedCategory = "for_you";
  bool showExplanations = true;

  Map<String, List<Map<String, dynamic>>> recommendations = {
    "for_you": [
      {
        "id": 1,
        "title": "Hydrating Oxygen Facial",
        "price": 185.0,
        "image": "https://picsum.photos/300/200?random=1&keyword=oxygen",
        "spa": "Rejuvenation Spa Center",
        "rating": 4.8,
        "reviews": 156,
        "category": "facial",
        "duration": "60 min",
        "reasonType": "previous_booking",
        "reason": "Based on your previous facial bookings",
        "matchPercentage": 95,
        "benefits": ["Hydrates dry skin", "Improves skin texture", "Anti-aging effects"],
        "distance": 2.1,
        "availability": "Available today",
        "isFavorite": false,
      },
      {
        "id": 2,
        "title": "Deep Tissue Massage",
        "price": 220.0,
        "image": "https://picsum.photos/300/200?random=2&keyword=massage",
        "spa": "Muscle Relief Studio",
        "rating": 4.9,
        "reviews": 289,
        "category": "massage",
        "duration": "90 min",
        "reasonType": "profile_preference",
        "reason": "Matches your preference for therapeutic treatments",
        "matchPercentage": 92,
        "benefits": ["Relieves muscle tension", "Improves circulation", "Reduces stress"],
        "distance": 1.8,
        "availability": "Book for tomorrow",
        "isFavorite": true,
      },
      {
        "id": 3,
        "title": "Couples Romance Package",
        "price": 450.0,
        "image": "https://picsum.photos/300/200?random=3&keyword=couple",
        "spa": "Love & Luxury Spa",
        "rating": 4.7,
        "reviews": 98,
        "category": "package",
        "duration": "2.5 hours",
        "reasonType": "seasonal",
        "reason": "Perfect for Valentine's season",
        "matchPercentage": 88,
        "benefits": ["Private couple suite", "Champagne included", "Rose petal bath"],
        "distance": 3.2,
        "availability": "Weekend slots available",
        "isFavorite": false,
      },
    ],
    "trending": [
      {
        "id": 4,
        "title": "HydraFacial MD",
        "price": 299.0,
        "image": "https://picsum.photos/300/200?random=4&keyword=hydrafacial",
        "spa": "Modern Skin Clinic",
        "rating": 4.9,
        "reviews": 234,
        "category": "facial",
        "duration": "45 min",
        "reasonType": "trending",
        "reason": "Most booked treatment this month",
        "matchPercentage": 0,
        "benefits": ["Instant results", "No downtime", "Suits all skin types"],
        "distance": 2.7,
        "availability": "Available today",
        "isFavorite": false,
      },
      {
        "id": 5,
        "title": "Lymphatic Drainage Massage",
        "price": 190.0,
        "image": "https://picsum.photos/300/200?random=5&keyword=lymphatic",
        "spa": "Wellness Recovery Center",
        "rating": 4.6,
        "reviews": 167,
        "category": "massage",
        "duration": "75 min",
        "reasonType": "trending",
        "reason": "Gaining popularity for health benefits",
        "matchPercentage": 0,
        "benefits": ["Reduces swelling", "Boosts immunity", "Detoxifies body"],
        "distance": 4.1,
        "availability": "Limited slots",
        "isFavorite": false,
      },
    ],
    "similar_users": [
      {
        "id": 6,
        "title": "Anti-Aging LED Therapy",
        "price": 175.0,
        "image": "https://picsum.photos/300/200?random=6&keyword=led",
        "spa": "Advanced Skin Solutions",
        "rating": 4.5,
        "reviews": 145,
        "category": "facial",
        "duration": "40 min",
        "reasonType": "similar_users",
        "reason": "Popular with users similar to you",
        "matchPercentage": 87,
        "benefits": ["Reduces fine lines", "Stimulates collagen", "Non-invasive"],
        "distance": 1.9,
        "availability": "Available today",
        "isFavorite": true,
      },
      {
        "id": 7,
        "title": "Prenatal Massage",
        "price": 165.0,
        "image": "https://picsum.photos/300/200?random=7&keyword=prenatal",
        "spa": "Motherhood Wellness Spa",
        "rating": 4.8,
        "reviews": 189,
        "category": "massage",
        "duration": "60 min",
        "reasonType": "similar_users",
        "reason": "Highly rated by users in your area",
        "matchPercentage": 85,
        "benefits": ["Safe for pregnancy", "Reduces back pain", "Improves sleep"],
        "distance": 2.3,
        "availability": "Book ahead",
        "isFavorite": false,
      },
    ],
    "near_you": [
      {
        "id": 8,
        "title": "Classic European Facial",
        "price": 125.0,
        "image": "https://picsum.photos/300/200?random=8&keyword=european",
        "spa": "Neighborhood Beauty Spa",
        "rating": 4.4,
        "reviews": 112,
        "category": "facial",
        "duration": "60 min",
        "reasonType": "location",
        "reason": "Only 0.8 km from your location",
        "matchPercentage": 78,
        "benefits": ["Deep cleansing", "Relaxing", "Affordable"],
        "distance": 0.8,
        "availability": "Walk-ins welcome",
        "isFavorite": false,
      },
      {
        "id": 9,
        "title": "Swedish Relaxation Massage",
        "price": 140.0,
        "image": "https://picsum.photos/300/200?random=9&keyword=swedish",
        "spa": "Local Wellness Center",
        "rating": 4.3,
        "reviews": 89,
        "category": "massage",
        "duration": "60 min",
        "reasonType": "location",
        "reason": "Close to your home and highly convenient",
        "matchPercentage": 82,
        "benefits": ["Gentle techniques", "Full body relaxation", "Great value"],
        "distance": 1.2,
        "availability": "Same day booking",
        "isFavorite": false,
      },
    ],
  };

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "For You", "value": "for_you", "icon": Icons.person},
    {"label": "Trending", "value": "trending", "icon": Icons.trending_up},
    {"label": "Similar Users", "value": "similar_users", "icon": Icons.group},
    {"label": "Near You", "value": "near_you", "icon": Icons.location_on},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendations"),
        actions: [
          QButton(
            icon: showExplanations ? Icons.help : Icons.help_outline,
            size: bs.sm,
            onPressed: () {
              setState(() {
                showExplanations = !showExplanations;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Recommendations Header
          _buildRecommendationsHeader(),

          // Category Tabs
          _buildCategoryTabs(),

          // Recommendations List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: _getCurrentRecommendations().length,
              itemBuilder: (context, index) {
                final recommendation = _getCurrentRecommendations()[index];
                return _buildRecommendationCard(recommendation);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.recommend, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personalized for You",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Discover treatments perfect for your needs",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // AI Recommendation Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: Colors.white.withAlpha(100),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.psychology, color: Colors.white, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "AI-powered recommendations based on your preferences and booking history",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      color: Colors.grey[50],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: spMd),
        child: Row(
          children: categoryOptions.map((category) {
            bool isSelected = selectedCategory == category["value"];
            return GestureDetector(
              onTap: () {
                selectedCategory = category["value"];
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category["icon"] as IconData,
                      color: isSelected ? Colors.white : disabledBoldColor,
                      size: 18,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${category["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(Map<String, dynamic> recommendation) {
    int matchPercentage = recommendation["matchPercentage"] as int;
    bool showMatch = matchPercentage > 0;

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
          // Image and Match Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${recommendation["image"]}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),

              // Match Percentage Badge
              if (showMatch)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.white, size: 12),
                        SizedBox(width: spXs),
                        Text(
                          "$matchPercentage% Match",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Favorite Button
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    _toggleFavorite(recommendation["id"]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      recommendation["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                      color: recommendation["isFavorite"] ? dangerColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Title and Spa
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${recommendation["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${recommendation["spa"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Recommendation Reason
                if (showExplanations)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getReasonTypeColor(recommendation["reasonType"]).withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: _getReasonTypeColor(recommendation["reasonType"]).withAlpha(100),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getReasonTypeIcon(recommendation["reasonType"]),
                          color: _getReasonTypeColor(recommendation["reasonType"]),
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${recommendation["reason"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getReasonTypeColor(recommendation["reasonType"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Price, Rating, and Distance
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${((recommendation["price"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${recommendation["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${recommendation["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " (${recommendation["reviews"]})",
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
                            Icon(Icons.location_on, color: disabledBoldColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${recommendation["distance"]} km",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Benefits
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (recommendation["benefits"] as List<String>).map((benefit) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        benefit,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Availability and Action
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: successColor.withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${recommendation["availability"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Book Now",
                        size: bs.sm,
                        onPressed: () {
                          _bookRecommendation(recommendation);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getCurrentRecommendations() {
    return recommendations[selectedCategory] ?? [];
  }

  Color _getReasonTypeColor(String reasonType) {
    switch (reasonType) {
      case "previous_booking":
        return primaryColor;
      case "profile_preference":
        return secondaryColor;
      case "seasonal":
        return warningColor;
      case "trending":
        return dangerColor;
      case "similar_users":
        return infoColor;
      case "location":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getReasonTypeIcon(String reasonType) {
    switch (reasonType) {
      case "previous_booking":
        return Icons.history;
      case "profile_preference":
        return Icons.person;
      case "seasonal":
        return Icons.schedule;
      case "trending":
        return Icons.trending_up;
      case "similar_users":
        return Icons.group;
      case "location":
        return Icons.location_on;
      default:
        return Icons.recommend;
    }
  }

  void _toggleFavorite(int recommendationId) {
    setState(() {
      for (var categoryRecs in recommendations.values) {
        final index = categoryRecs.indexWhere((r) => r["id"] == recommendationId);
        if (index != -1) {
          categoryRecs[index]["isFavorite"] = !(categoryRecs[index]["isFavorite"] as bool);
          break;
        }
      }
    });

    // Find if favorite was added or removed
    bool isFavorite = false;
    for (var categoryRecs in recommendations.values) {
      final rec = categoryRecs.firstWhere((r) => r["id"] == recommendationId, orElse: () => {});
      if (rec.isNotEmpty) {
        isFavorite = rec["isFavorite"];
        break;
      }
    }

    if (isFavorite) {
      ss("Added to favorites");
    } else {
      si("Removed from favorites");
    }
  }

  void _bookRecommendation(Map<String, dynamic> recommendation) {
    ss("Booking ${recommendation["title"]}...");
    //navigateTo ( SpaBookingView )
  }
}
