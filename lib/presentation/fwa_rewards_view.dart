import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaRewardsView extends StatefulWidget {
  const FwaRewardsView({super.key});

  @override
  State<FwaRewardsView> createState() => _FwaRewardsViewState();
}

class _FwaRewardsViewState extends State<FwaRewardsView> {
  String selectedTab = "Available";
  int totalPoints = 2450;
  int pointsThisMonth = 680;

  List<Map<String, dynamic>> tabOptions = [
    {"label": "Available", "value": "Available"},
    {"label": "My Rewards", "value": "My Rewards"},
    {"label": "Redeemed", "value": "Redeemed"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> availableRewards = [
    {
      "id": 1,
      "title": "Premium Protein Powder",
      "description": "High-quality whey protein powder to fuel your workouts",
      "image": "https://picsum.photos/200/200?random=1&keyword=protein",
      "category": "Supplements",
      "pointsCost": 500,
      "originalPrice": 59.99,
      "discount": "85% off",
      "brand": "FitNutrition",
      "rating": 4.8,
      "reviews": 234,
      "inStock": true,
      "quantity": 50,
      "expiryDate": "2024-12-31",
      "tags": ["Popular", "Best Value"]
    },
    {
      "id": 2,
      "title": "Wireless Fitness Tracker",
      "description": "Track your steps, heart rate, and sleep patterns",
      "image": "https://picsum.photos/200/200?random=2&keyword=watch",
      "category": "Electronics",
      "pointsCost": 1200,
      "originalPrice": 149.99,
      "discount": "Free",
      "brand": "FitTech",
      "rating": 4.6,
      "reviews": 567,
      "inStock": true,
      "quantity": 25,
      "expiryDate": "2024-12-31",
      "tags": ["Premium", "Latest"]
    },
    {
      "id": 3,
      "title": "Gym Membership - 1 Month",
      "description": "Access to premium gym facilities for one month",
      "image": "https://picsum.photos/200/200?random=3&keyword=gym",
      "category": "Memberships",
      "pointsCost": 800,
      "originalPrice": 89.99,
      "discount": "Free",
      "brand": "FitLife Gym",
      "rating": 4.7,
      "reviews": 189,
      "inStock": true,
      "quantity": 100,
      "expiryDate": "2024-09-30",
      "tags": ["Limited Time"]
    },
    {
      "id": 4,
      "title": "Workout Gear Bundle",
      "description": "Complete set including resistance bands, yoga mat, and towel",
      "image": "https://picsum.photos/200/200?random=4&keyword=equipment",
      "category": "Equipment",
      "pointsCost": 600,
      "originalPrice": 79.99,
      "discount": "75% off",
      "brand": "FitGear",
      "rating": 4.5,
      "reviews": 123,
      "inStock": true,
      "quantity": 75,
      "expiryDate": "2024-12-31",
      "tags": ["Bundle", "Best Seller"]
    },
    {
      "id": 5,
      "title": "Personal Training Session",
      "description": "One-on-one training session with certified trainer",
      "image": "https://picsum.photos/200/200?random=5&keyword=trainer",
      "category": "Services",
      "pointsCost": 400,
      "originalPrice": 99.99,
      "discount": "60% off",
      "brand": "FitCoach Pro",
      "rating": 4.9,
      "reviews": 67,
      "inStock": true,
      "quantity": 30,
      "expiryDate": "2024-08-31",
      "tags": ["Expert", "Popular"]
    },
    {
      "id": 6,
      "title": "Nutrition Consultation",
      "description": "Professional dietary assessment and meal planning",
      "image": "https://picsum.photos/200/200?random=6&keyword=nutrition",
      "category": "Services",
      "pointsCost": 350,
      "originalPrice": 79.99,
      "discount": "56% off",
      "brand": "NutriExpert",
      "rating": 4.8,
      "reviews": 89,
      "inStock": true,
      "quantity": 40,
      "expiryDate": "2024-10-31",
      "tags": ["Professional"]
    },
  ];

  List<Map<String, dynamic>> myRewards = [
    {
      "id": 7,
      "title": "Workout Towel",
      "description": "Premium microfiber workout towel",
      "image": "https://picsum.photos/200/200?random=7&keyword=towel",
      "category": "Equipment",
      "pointsCost": 150,
      "status": "Ready to Use",
      "earnedDate": "2024-06-10",
      "expiryDate": "2024-12-31",
      "code": "FIT2024-TOWEL-001"
    },
    {
      "id": 8,
      "title": "Protein Bar Pack",
      "description": "Pack of 12 high-protein energy bars",
      "image": "https://picsum.photos/200/200?random=8&keyword=protein",
      "category": "Supplements",
      "pointsCost": 200,
      "status": "Delivered",
      "earnedDate": "2024-06-05",
      "deliveredDate": "2024-06-08",
      "code": "FIT2024-BARS-002"
    },
  ];

  List<Map<String, dynamic>> redeemedRewards = [
    {
      "id": 9,
      "title": "Free Smoothie",
      "description": "Fresh protein smoothie from FitCafe",
      "image": "https://picsum.photos/200/200?random=9&keyword=smoothie",
      "category": "Food & Drink",
      "pointsCost": 100,
      "redeemedDate": "2024-05-28",
      "usedDate": "2024-05-29",
      "code": "FIT2024-SMOOTH-003"
    },
    {
      "id": 10,
      "title": "Gym Day Pass",
      "description": "Single day access to premium gym",
      "image": "https://picsum.photos/200/200?random=10&keyword=gym",
      "category": "Memberships",
      "pointsCost": 75,
      "redeemedDate": "2024-05-20",
      "usedDate": "2024-05-22",
      "code": "FIT2024-PASS-004"
    },
  ];

  List<Map<String, dynamic>> pointsHistory = [
    {
      "activity": "Completed Daily Challenge",
      "points": 50,
      "date": "2024-06-14",
      "type": "earned"
    },
    {
      "activity": "7-day workout streak",
      "points": 100,
      "date": "2024-06-13",
      "type": "earned"
    },
    {
      "activity": "Redeemed Protein Bar Pack",
      "points": -200,
      "date": "2024-06-12",
      "type": "spent"
    },
    {
      "activity": "Shared workout progress",
      "points": 25,
      "date": "2024-06-11",
      "type": "earned"
    },
    {
      "activity": "Completed workout session",
      "points": 30,
      "date": "2024-06-10",
      "type": "earned"
    },
  ];

  List<Map<String, dynamic>> get currentRewards {
    switch (selectedTab) {
      case "Available":
        return availableRewards;
      case "My Rewards":
        return myRewards;
      case "Redeemed":
        return redeemedRewards;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rewards"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showPointsHistory();
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showHowItWorks();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Points Summary Card
            Container(
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Points",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${totalPoints.toString()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "This Month",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "+${pointsThisMonth}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Next Reward",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${500 - (totalPoints % 500)} pts",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tab Selector
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: QHorizontalScroll(
                children: tabOptions.map((tab) {
                  bool isSelected = tab["value"] == selectedTab;
                  return GestureDetector(
                    onTap: () {
                      selectedTab = tab["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
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
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Rewards List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedTab == "Available" ? "Available Rewards" : selectedTab,
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  ...currentRewards.map((reward) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          // Reward Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${reward["image"]}",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          // Reward Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${reward["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    if (selectedTab == "Available" && (reward["tags"] as List?)?.isNotEmpty == true)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${(reward["tags"] as List)[0]}",
                                          style: TextStyle(
                                            color: warningColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                
                                SizedBox(height: spXs),
                                
                                Text(
                                  "${reward["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 13,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                
                                SizedBox(height: spSm),
                                
                                if (selectedTab == "Available") ...[
                                  Row(
                                    children: [
                                      // Points Cost
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${reward["pointsCost"]} pts",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      
                                      SizedBox(width: spSm),
                                      
                                      // Original Price
                                      if (reward["originalPrice"] != null)
                                        Text(
                                          "\$${(reward["originalPrice"] as double).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      
                                      SizedBox(width: spSm),
                                      
                                      // Discount
                                      Text(
                                        "${reward["discount"]}",
                                        style: TextStyle(
                                          color: successColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      
                                      Spacer(),
                                      
                                      // Rating
                                      if (reward["rating"] != null) ...[
                                        Icon(
                                          Icons.star,
                                          color: warningColor,
                                          size: 12,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${(reward["rating"] as double).toStringAsFixed(1)}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ] else if (selectedTab == "My Rewards") ...[
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${reward["status"]}",
                                          style: TextStyle(
                                            color: successColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      
                                      Spacer(),
                                      
                                      Text(
                                        "Earned: ${reward["earnedDate"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ] else if (selectedTab == "Redeemed") ...[
                                  Row(
                                    children: [
                                      Text(
                                        "Used: ${reward["usedDate"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      
                                      Spacer(),
                                      
                                      Text(
                                        "${reward["pointsCost"]} pts",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          // Action Button
                          if (selectedTab == "Available")
                            QButton(
                              label: totalPoints >= (reward["pointsCost"] as int) ? "Redeem" : "Need ${(reward["pointsCost"] as int) - totalPoints}",
                              size: bs.sm,
                              onPressed: totalPoints >= (reward["pointsCost"] as int) 
                                  ? () => _redeemReward(reward)
                                  : () => _showEarnPointsTips(),
                            )
                          else if (selectedTab == "My Rewards")
                            QButton(
                              label: "Use Now",
                              size: bs.sm,
                              onPressed: () => _useReward(reward),
                            )
                          else
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 24,
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Ways to Earn Points
            if (selectedTab == "Available")
              Container(
                margin: EdgeInsets.symmetric(horizontal: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ways to Earn Points",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    _buildEarnPointItem("Complete daily workout", "30 pts", Icons.fitness_center),
                    _buildEarnPointItem("7-day workout streak", "100 pts", Icons.local_fire_department),
                    _buildEarnPointItem("Share progress", "25 pts", Icons.share),
                    _buildEarnPointItem("Invite friends", "50 pts", Icons.person_add),
                    _buildEarnPointItem("Complete challenges", "50-200 pts", Icons.emoji_events),
                    _buildEarnPointItem("Write reviews", "15 pts", Icons.star),
                  ],
                ),
              ),

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  Widget _buildEarnPointItem(String activity, String points, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          
          SizedBox(width: spSm),
          
          Expanded(
            child: Text(
              activity,
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
              ),
            ),
          ),
          
          Text(
            points,
            style: TextStyle(
              color: successColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _redeemReward(Map<String, dynamic> reward) {
    if (totalPoints >= (reward["pointsCost"] as int)) {
      setState(() {
        totalPoints -= (reward["pointsCost"] as int);
        myRewards.add({
          ...reward,
          "status": "Ready to Use",
          "earnedDate": DateTime.now().toString().substring(0, 10),
          "code": "FIT2024-${reward["id"]}-${DateTime.now().millisecondsSinceEpoch}"
        });
      });
      ss("Successfully redeemed ${reward["title"]}!");
    } else {
      se("Not enough points to redeem this reward");
    }
  }

  void _useReward(Map<String, dynamic> reward) {
    // Show reward code or usage instructions
    ss("Reward code: ${reward["code"]}");
  }

  void _showPointsHistory() {
    // Show points earning/spending history modal
  }

  void _showHowItWorks() {
    // Show how rewards system works
  }

  void _showEarnPointsTips() {
    // Show tips on earning more points
    si("Complete daily workouts and challenges to earn more points!");
  }
}
