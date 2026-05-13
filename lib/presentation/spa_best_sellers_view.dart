import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaBestSellersView extends StatefulWidget {
  const SpaBestSellersView({Key? key}) : super(key: key);

  @override
  State<SpaBestSellersView> createState() => _SpaBestSellersViewState();
}

class _SpaBestSellersViewState extends State<SpaBestSellersView> {
  String selectedPeriod = "this_month";
  String selectedCategory = "all";
  String sortBy = "sales";

  List<Map<String, dynamic>> bestSellers = [
    {
      "id": 1,
      "rank": 1,
      "title": "Hydrating Oxygen Facial",
      "price": 185.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=oxygen",
      "spa": "Rejuvenation Spa Center",
      "category": "facial",
      "rating": 4.9,
      "reviews": 456,
      "salesCount": 1250,
      "revenueGenerated": 231250.0,
      "duration": "60 min",
      "description": "Revolutionary oxygen facial treatment for instant skin hydration",
      "reasons": ["Immediate results", "Suitable for all skin types", "No downtime"],
      "distance": 2.1,
      "availability": "Available today",
      "isRising": true,
      "isFavorite": false,
      "growthPercentage": 25,
    },
    {
      "id": 2,
      "rank": 2,
      "title": "Deep Tissue Therapeutic Massage",
      "price": 165.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=massage",
      "spa": "Muscle Relief Studio",
      "category": "massage",
      "rating": 4.8,
      "reviews": 623,
      "salesCount": 1180,
      "revenueGenerated": 194700.0,
      "duration": "75 min",
      "description": "Professional deep tissue massage for muscle tension relief",
      "reasons": ["Expert therapists", "Pain relief", "Stress reduction"],
      "distance": 1.8,
      "availability": "Book ahead",
      "isRising": false,
      "isFavorite": true,
      "growthPercentage": 15,
    },
    {
      "id": 3,
      "rank": 3,
      "title": "Anti-Aging Collagen Treatment",
      "price": 295.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=collagen",
      "spa": "Youth Renewal Clinic",
      "category": "facial",
      "rating": 4.9,
      "reviews": 389,
      "salesCount": 890,
      "revenueGenerated": 262550.0,
      "duration": "90 min",
      "description": "Advanced anti-aging treatment with pure collagen infusion",
      "reasons": ["Visible results", "Professional grade", "Long-lasting"],
      "distance": 3.2,
      "availability": "Limited slots",
      "isRising": true,
      "isFavorite": false,
      "growthPercentage": 35,
    },
    {
      "id": 4,
      "rank": 4,
      "title": "Couples Romantic Spa Package",
      "price": 450.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=couples",
      "spa": "Love & Luxury Spa",
      "category": "package",
      "rating": 4.7,
      "reviews": 234,
      "salesCount": 520,
      "revenueGenerated": 234000.0,
      "duration": "2.5 hours",
      "description": "Complete couples spa experience with champagne and roses",
      "reasons": ["Private suite", "Romantic atmosphere", "Premium service"],
      "distance": 4.1,
      "availability": "Weekend available",
      "isRising": false,
      "isFavorite": false,
      "growthPercentage": 8,
    },
    {
      "id": 5,
      "rank": 5,
      "title": "Hot Stone Healing Therapy",
      "price": 195.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=hotstone",
      "spa": "Stone Harmony Spa",
      "category": "massage",
      "rating": 4.6,
      "reviews": 567,
      "salesCount": 780,
      "revenueGenerated": 152100.0,
      "duration": "80 min",
      "description": "Therapeutic hot stone massage for deep relaxation",
      "reasons": ["Ancient technique", "Deep healing", "Stress relief"],
      "distance": 2.9,
      "availability": "Available today",
      "isRising": true,
      "isFavorite": true,
      "growthPercentage": 20,
    },
    {
      "id": 6,
      "rank": 6,
      "title": "Luxury Manicure & Pedicure",
      "price": 125.0,
      "image": "https://picsum.photos/300/200?random=6&keyword=nails",
      "spa": "Nail Artistry Studio",
      "category": "nails",
      "rating": 4.5,
      "reviews": 789,
      "salesCount": 950,
      "revenueGenerated": 118750.0,
      "duration": "90 min",
      "description": "Complete nail care with premium products and nail art",
      "reasons": ["Gel polish", "Nail art", "Hand massage"],
      "distance": 2.3,
      "availability": "Walk-ins welcome",
      "isRising": false,
      "isFavorite": false,
      "growthPercentage": 5,
    },
    {
      "id": 7,
      "rank": 7,
      "title": "Body Detox Wrap Treatment",
      "price": 175.0,
      "image": "https://picsum.photos/300/200?random=7&keyword=detox",
      "spa": "Pure Wellness Studio",
      "category": "body",
      "rating": 4.4,
      "reviews": 345,
      "salesCount": 640,
      "revenueGenerated": 112000.0,
      "duration": "75 min",
      "description": "Complete body detox with marine minerals and seaweed",
      "reasons": ["Detoxifying", "Skin tightening", "Slimming effect"],
      "distance": 3.7,
      "availability": "Book ahead",
      "isRising": true,
      "isFavorite": false,
      "growthPercentage": 18,
    },
    {
      "id": 8,
      "rank": 8,
      "title": "Prenatal Wellness Massage",
      "price": 155.0,
      "image": "https://picsum.photos/300/200?random=8&keyword=prenatal",
      "spa": "Motherhood Spa",
      "category": "massage",
      "rating": 4.8,
      "reviews": 289,
      "salesCount": 420,
      "revenueGenerated": 65100.0,
      "duration": "60 min",
      "description": "Safe and relaxing massage for expecting mothers",
      "reasons": ["Safe for pregnancy", "Expert care", "Comfort focused"],
      "distance": 2.6,
      "availability": "Available today",
      "isRising": false,
      "isFavorite": false,
      "growthPercentage": 12,
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last 3 Months", "value": "three_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Facial Treatments", "value": "facial"},
    {"label": "Massage Therapy", "value": "massage"},
    {"label": "Body Treatments", "value": "body"},
    {"label": "Nail Services", "value": "nails"},
    {"label": "Spa Packages", "value": "package"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Sales Count", "value": "sales"},
    {"label": "Revenue Generated", "value": "revenue"},
    {"label": "Growth Rate", "value": "growth"},
    {"label": "Customer Rating", "value": "rating"},
    {"label": "Reviews Count", "value": "reviews"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Best Sellers"),
        actions: [
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {
              _showAnalytics();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Best Sellers Header
          _buildBestSellersHeader(),

          // Filter Controls
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Time Period",
                        items: periodOptions,
                        value: selectedPeriod,
                        onChanged: (value, label) {
                          selectedPeriod = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Sort by",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Best Sellers List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: _getFilteredBestSellers().length,
              itemBuilder: (context, index) {
                final item = _getFilteredBestSellers()[index];
                return _buildBestSellerCard(item, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellersHeader() {
    int totalSales = bestSellers.fold(0, (sum, item) => sum + (item["salesCount"] as int));
    double totalRevenue = bestSellers.fold(0.0, (sum, item) => sum + (item["revenueGenerated"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Best Selling Treatments",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Most popular spa treatments based on sales",
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
          
          // Statistics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHeaderStat("Total Sales", "${(totalSales / 1000).toStringAsFixed(1)}K"),
              _buildHeaderStat("Revenue", "\$${(totalRevenue / 1000).toStringAsFixed(0)}K"),
              _buildHeaderStat("Top Items", "${bestSellers.length}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(230),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellerCard(Map<String, dynamic> item, int index) {
    bool isRising = item["isRising"] as bool;
    int growthPercentage = item["growthPercentage"] as int;

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
          // Image and Rank Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${item["image"]}",
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),

              // Rank Badge
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getRankColor(item["rank"] as int),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      "#${item["rank"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Growth Badge
              if (isRising)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.trending_up, color: Colors.white, size: 12),
                        SizedBox(width: spXs),
                        Text(
                          "+$growthPercentage%",
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
                bottom: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    _toggleFavorite(item["id"]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                      color: item["isFavorite"] ? dangerColor : disabledBoldColor,
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
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["spa"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Sales Stats
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSalesStat("Sales", "${item["salesCount"]}"),
                      _buildSalesStat("Revenue", "\$${((item["revenueGenerated"] as double) / 1000).toStringAsFixed(0)}K"),
                      _buildSalesStat("Growth", isRising ? "+$growthPercentage%" : "$growthPercentage%"),
                    ],
                  ),
                ),

                // Price, Rating, and Duration
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${((item["price"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${item["duration"]}",
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
                              "${item["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " (${item["reviews"]})",
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
                              "${item["distance"]} km",
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

                // Description
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),

                // Reasons for Success
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (item["reasons"] as List<String>).map((reason) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: successColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        reason,
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Availability and Action
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: primaryColor.withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${item["availability"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Book Now",
                        size: bs.sm,
                        onPressed: () {
                          _bookBestSeller(item);
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

  Widget _buildSalesStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredBestSellers() {
    List<Map<String, dynamic>> filtered = List.from(bestSellers);

    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }

    // Sort
    switch (sortBy) {
      case "revenue":
        filtered.sort((a, b) => (b["revenueGenerated"] as double).compareTo(a["revenueGenerated"] as double));
        break;
      case "growth":
        filtered.sort((a, b) => (b["growthPercentage"] as int).compareTo(a["growthPercentage"] as int));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "reviews":
        filtered.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
        break;
      default: // sales
        filtered.sort((a, b) => (b["salesCount"] as int).compareTo(a["salesCount"] as int));
    }

    return filtered;
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return warningColor; // Gold
      case 2:
        return Colors.grey[600]!; // Silver
      case 3:
        return Colors.brown[400]!; // Bronze
      default:
        return primaryColor;
    }
  }

  void _showAnalytics() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sales Analytics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              
              // Analytics placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.analytics, size: 48, color: disabledBoldColor),
                      SizedBox(height: spSm),
                      Text(
                        "Detailed analytics coming soon",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Close",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleFavorite(int itemId) {
    setState(() {
      final index = bestSellers.indexWhere((item) => item["id"] == itemId);
      if (index != -1) {
        bestSellers[index]["isFavorite"] = !(bestSellers[index]["isFavorite"] as bool);
      }
    });

    bool isFavorite = bestSellers.firstWhere((item) => item["id"] == itemId)["isFavorite"];
    if (isFavorite) {
      ss("Added to favorites");
    } else {
      si("Removed from favorites");
    }
  }

  void _bookBestSeller(Map<String, dynamic> item) {
    ss("Booking ${item["title"]}...");
    //navigateTo ( SpaBookingView )
  }
}
