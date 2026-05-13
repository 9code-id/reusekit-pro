import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsComboDealsView extends StatefulWidget {
  const BrsComboDealsView({super.key});

  @override
  State<BrsComboDealsView> createState() => _BrsComboDealsViewState();
}

class _BrsComboDealsViewState extends State<BrsComboDealsView> {
  int selectedTab = 0;

  List<Map<String, dynamic>> comboDeals = [
    {
      "id": 1,
      "title": "Father & Son Combo",
      "subtitle": "Perfect bonding experience",
      "originalPrice": 180000,
      "comboPrice": 120000,
      "savings": 60000,
      "image": "https://picsum.photos/400/250?random=1&keyword=father-son",
      "services": [
        {"name": "Adult Classic Cut", "price": 85000},
        {"name": "Kids Fun Cut", "price": 55000},
        {"name": "Photo Session", "price": 40000}
      ],
      "features": [
        "Same time booking available",
        "Family photo included",
        "Special father-son chairs",
        "Complimentary refreshments"
      ],
      "validUntil": "2024-02-29",
      "minimumBooking": 2,
      "category": "family",
      "rating": 4.8,
      "reviews": 156,
      "isPopular": true,
    },
    {
      "id": 2,
      "title": "Groom's Party Package",
      "subtitle": "Wedding preparation special",
      "originalPrice": 800000,
      "comboPrice": 600000,
      "savings": 200000,
      "image": "https://picsum.photos/400/250?random=2&keyword=wedding-groom",
      "services": [
        {"name": "Groom Premium Cut", "price": 150000},
        {"name": "Best Man Cut (3x)", "price": 255000},
        {"name": "Groomsmen Cut (2x)", "price": 170000},
        {"name": "Group Styling", "price": 225000}
      ],
      "features": [
        "Group booking discount",
        "Pre-wedding consultation",
        "Same-day service",
        "Wedding day touch-up included",
        "Group photos"
      ],
      "validUntil": "2024-12-31",
      "minimumBooking": 6,
      "category": "wedding",
      "rating": 4.9,
      "reviews": 89,
      "isPopular": false,
    },
    {
      "id": 3,
      "title": "Monthly Maintenance",
      "subtitle": "Regular grooming subscription",
      "originalPrice": 340000,
      "comboPrice": 250000,
      "savings": 90000,
      "image": "https://picsum.photos/400/250?random=3&keyword=monthly-haircut",
      "services": [
        {"name": "Monthly Haircut (4x)", "price": 340000},
        {"name": "Beard Trim (2x)", "price": 60000},
        {"name": "Hair Treatment (1x)", "price": 75000}
      ],
      "features": [
        "Priority booking",
        "Flexible scheduling",
        "Free rescheduling",
        "Product discounts",
        "Style consultation included"
      ],
      "validUntil": "2024-03-31",
      "minimumBooking": 1,
      "category": "subscription",
      "rating": 4.7,
      "reviews": 234,
      "isPopular": true,
    },
    {
      "id": 4,
      "title": "Friends Group Deal",
      "subtitle": "Bring your squad",
      "originalPrice": 425000,
      "comboPrice": 320000,
      "savings": 105000,
      "image": "https://picsum.photos/400/250?random=4&keyword=friends-group",
      "services": [
        {"name": "Premium Cut (5x)", "price": 425000},
        {"name": "Group Styling", "price": 100000},
        {"name": "Group Photos", "price": 50000}
      ],
      "features": [
        "Group booking required",
        "Same time slots",
        "Group photo session",
        "Friendship memories",
        "Social media package"
      ],
      "validUntil": "2024-06-30",
      "minimumBooking": 5,
      "category": "group",
      "rating": 4.6,
      "reviews": 127,
      "isPopular": false,
    },
  ];

  List<Map<String, dynamic>> tabs = [
    {"label": "All Deals", "value": "all"},
    {"label": "Family", "value": "family"},
    {"label": "Wedding", "value": "wedding"},
    {"label": "Group", "value": "group"},
    {"label": "Subscription", "value": "subscription"},
  ];

  List<Map<String, dynamic>> get filteredDeals {
    if (selectedTab == 0) return comboDeals;
    String category = tabs[selectedTab]["value"];
    return comboDeals.where((deal) => deal["category"] == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Combo Deals"),
        actions: [
          IconButton(
            icon: Icon(Icons.local_offer),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            height: 50,
            child: QHorizontalScroll(
              children: List.generate(tabs.length, (index) {
                final tab = tabs[index];
                final isSelected = selectedTab == index;
                return GestureDetector(
                  onTap: () {
                    selectedTab = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? spMd : spXs,
                      right: index == tabs.length - 1 ? spMd : spXs,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      "${tab["label"]}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Deals List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredDeals.length,
              itemBuilder: (context, index) {
                final deal = filteredDeals[index];
                return _buildComboCard(deal);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComboCard(Map<String, dynamic> deal) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: (deal["isPopular"] as bool) ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Image with Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: AspectRatio(
                  aspectRatio: 16/10,
                  child: Image.network(
                    "${deal["image"]}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              
              // Popular Badge
              if (deal["isPopular"] as bool)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "POPULAR",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              // Savings Badge
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "SAVE Rp ${(deal["savings"] as int).currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              // Rating
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: warningColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${deal["rating"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "(${deal["reviews"]})",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
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
                // Title & Subtitle
                Text(
                  "${deal["title"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${deal["subtitle"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                // Price Info
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rp ${(deal["originalPrice"] as int).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          "Rp ${(deal["comboPrice"] as int).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Spacer(),
                    
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${((deal["savings"] as int) / (deal["originalPrice"] as int) * 100).round()}% OFF",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Services Included
                Text(
                  "Services Included:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                Column(
                  children: List.generate((deal["services"] as List).length, (index) {
                    final service = (deal["services"] as List)[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, size: 16, color: successColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${service["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "Rp ${(service["price"] as int).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                
                SizedBox(height: spSm),
                
                // Deal Info
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.people, size: 16, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "Min ${deal["minimumBooking"]} people",
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
                              Icon(Icons.schedule, size: 16, color: warningColor),
                              SizedBox(width: spXs),
                              Text(
                                "Valid until ${DateTime.parse(deal["validUntil"]).dMMMy}",
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
                    
                    QButton(
                      label: "Book Deal",
                      size: bs.sm,
                      onPressed: () {
                        ss("Combo deal booking initiated");
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
  }
}
