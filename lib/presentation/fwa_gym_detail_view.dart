import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaGymDetailView extends StatefulWidget {
  const FwaGymDetailView({super.key});

  @override
  State<FwaGymDetailView> createState() => _FwaGymDetailViewState();
}

class _FwaGymDetailViewState extends State<FwaGymDetailView> {
  Map<String, dynamic> gym = {
    "id": "gym001",
    "name": "PowerFit Fitness Center",
    "rating": 4.7,
    "reviewCount": 328,
    "distance": 1.2,
    "priceRange": "\$\$",
    "address": "123 Fitness Street, Downtown, CA 90210",
    "phone": "+1 (555) 123-4567",
    "website": "www.powerfit.com",
    "openingHours": "Mon-Sun: 5:00 AM - 11:00 PM",
    "images": [
      "https://picsum.photos/800/600?random=1&keyword=gym",
      "https://picsum.photos/800/600?random=2&keyword=fitness",
      "https://picsum.photos/800/600?random=3&keyword=workout",
      "https://picsum.photos/800/600?random=4&keyword=equipment",
      "https://picsum.photos/800/600?random=5&keyword=swimming-pool"
    ],
    "amenities": [
      {"name": "Free Weights", "icon": Icons.fitness_center, "available": true},
      {"name": "Cardio Equipment", "icon": Icons.directions_run, "available": true},
      {"name": "Swimming Pool", "icon": Icons.pool, "available": true},
      {"name": "Group Classes", "icon": Icons.group, "available": true},
      {"name": "Personal Training", "icon": Icons.person, "available": true},
      {"name": "Sauna", "icon": Icons.hot_tub, "available": true},
      {"name": "Parking", "icon": Icons.local_parking, "available": true},
      {"name": "Locker Rooms", "icon": Icons.lock, "available": true},
      {"name": "Towel Service", "icon": Icons.dry_cleaning, "available": false},
      {"name": "Juice Bar", "icon": Icons.local_drink, "available": true}
    ],
    "classes": [
      {"name": "HIIT Training", "time": "6:00 AM", "duration": "45 min", "instructor": "Mike Johnson", "spots": 8},
      {"name": "Yoga Flow", "time": "7:30 AM", "duration": "60 min", "instructor": "Sarah Chen", "spots": 12},
      {"name": "CrossFit", "time": "8:30 AM", "duration": "60 min", "instructor": "David Smith", "spots": 5},
      {"name": "Pilates", "time": "6:00 PM", "duration": "45 min", "instructor": "Emma Wilson", "spots": 15},
      {"name": "Spin Class", "time": "7:00 PM", "duration": "45 min", "instructor": "Tom Rodriguez", "spots": 3}
    ],
    "membershipPlans": [
      {"name": "Basic", "price": 29.99, "duration": "monthly", "features": ["Gym Access", "Locker Room"]},
      {"name": "Premium", "price": 49.99, "duration": "monthly", "features": ["Gym Access", "All Classes", "Pool Access", "Personal Training (2x/month)"]},
      {"name": "VIP", "price": 79.99, "duration": "monthly", "features": ["24/7 Access", "All Premium Features", "Unlimited Personal Training", "Towel Service"]}
    ],
    "description": "PowerFit Fitness Center is a state-of-the-art facility offering everything you need for your fitness journey. With top-quality equipment, expert trainers, and a variety of classes, we help you achieve your fitness goals in a supportive environment."
  };

  bool isFavorite = false;
  int currentImageIndex = 0;
  String selectedTab = "Overview";
  List<String> tabs = ["Overview", "Classes", "Membership"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gym Details"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : null,
            ),
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
              if (isFavorite) {
                ss("Added to favorites");
              } else {
                si("Removed from favorites");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Gym details shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gym Images
            Container(
              height: 250,
              child: Stack(
                children: [
                  QHorizontalScroll(
                    children: (gym["images"] as List).asMap().entries.map((entry) {
                      int index = entry.key;
                      String imageUrl = "${entry.value}";
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: spMd,
                    right: spMd,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.photo_library, color: Colors.white, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${(gym["images"] as List).length} Photos",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Status Indicator
                  Positioned(
                    top: spMd,
                    left: spMd,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time, color: Colors.white, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "Open Now",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Gym Basic Info
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${gym["name"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${gym["priceRange"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 18),
                            SizedBox(width: spXs),
                            Text(
                              "${(gym["rating"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "(${gym["reviewCount"]} reviews)",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledColor,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.location_on, color: primaryColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${(gym["distance"] as double).toStringAsFixed(1)} km away",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${gym["address"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.access_time, color: primaryColor, size: 18),
                              SizedBox(width: spXs),
                              Text(
                                "${gym["openingHours"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab Navigation
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        QHorizontalScroll(
                          children: tabs.map((tab) {
                            bool isSelected = selectedTab == tab;
                            return GestureDetector(
                              onTap: () {
                                selectedTab = tab;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                  ),
                                ),
                                child: Text(
                                  tab,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? Colors.white : primaryColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Tab Content
                  if (selectedTab == "Overview") _buildOverviewTab(),
                  if (selectedTab == "Classes") _buildClassesTab(),
                  if (selectedTab == "Membership") _buildMembershipTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowLg],
        ),
        child: Row(
          spacing: spSm,
          children: [
            QButton(
              icon: Icons.phone,
              size: bs.sm,
              onPressed: () {
                si("Calling ${gym["phone"]}");
              },
            ),
            QButton(
              icon: Icons.directions,
              size: bs.sm,
              onPressed: () {
                si("Opening directions to gym");
              },
            ),
            Expanded(
              child: QButton(
                label: "Join Now",
                size: bs.md,
                onPressed: () {
                  //navigateTo(FwaGymMembershipView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Column(
      spacing: spMd,
      children: [
        // Description
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "About This Gym",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${gym["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        // Amenities
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Amenities & Facilities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: (gym["amenities"] as List).map((amenity) {
                  bool isAvailable = amenity["available"] as bool;
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isAvailable 
                          ? successColor.withAlpha(10) 
                          : disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          amenity["icon"] as IconData,
                          color: isAvailable ? successColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${amenity["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: isAvailable ? primaryColor : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (isAvailable)
                          Icon(Icons.check_circle, color: successColor, size: 16)
                        else
                          Icon(Icons.cancel, color: disabledBoldColor, size: 16),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Contact Info
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.phone, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "${gym["phone"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.language, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "${gym["website"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassesTab() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.fitness_center, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Today's Classes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...(gym["classes"] as List).map((classItem) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${classItem["time"]}".split(" ")[0],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${classItem["time"]}".split(" ")[1],
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${classItem["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Instructor: ${classItem["instructor"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${classItem["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.people, color: successColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${classItem["spots"]} spots left",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Book",
                    size: bs.sm,
                    onPressed: () {
                      ss("Class ${classItem["name"]} booked successfully");
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMembershipTab() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.card_membership, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Membership Plans",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: (gym["membershipPlans"] as List).map((plan) {
              Color planColor = _getPlanColor(plan["name"]);
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: planColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: planColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "${plan["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: planColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${(plan["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "/${plan["duration"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: disabledOutlineBorderColor),
                    ...(plan["features"] as List).map((feature) {
                      return Row(
                        children: [
                          Icon(Icons.check_circle, color: planColor, size: 16),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Choose Plan",
                        size: bs.sm,
                        onPressed: () {
                          ss("${plan["name"]} plan selected");
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getPlanColor(String planName) {
    switch (planName.toLowerCase()) {
      case 'basic':
        return infoColor;
      case 'premium':
        return primaryColor;
      case 'vip':
        return warningColor;
      default:
        return primaryColor;
    }
  }
}
