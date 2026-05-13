import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaTrainerProfileView extends StatefulWidget {
  const FwaTrainerProfileView({super.key});

  @override
  State<FwaTrainerProfileView> createState() => _FwaTrainerProfileViewState();
}

class _FwaTrainerProfileViewState extends State<FwaTrainerProfileView> {
  Map<String, dynamic> trainer = {
    "id": "trainer_1",
    "name": "Sarah Johnson",
    "title": "Certified Personal Trainer",
    "specialties": ["Weight Loss", "Strength Training", "Nutrition"],
    "experience": 8,
    "rating": 4.9,
    "reviewCount": 156,
    "price": 85,
    "location": "Downtown Gym",
    "avatar": "https://picsum.photos/200/200?random=60&keyword=trainer",
    "coverPhoto": "https://picsum.photos/400/200?random=70&keyword=gym",
    "isOnline": true,
    "responseTime": "Usually responds within 1 hour",
    "bio": "Passionate fitness coach with 8+ years experience helping clients achieve their goals through personalized training and nutrition guidance. I specialize in creating sustainable lifestyle changes that lead to long-term success.",
    "certifications": ["NASM-CPT", "Nutrition Specialist", "Corrective Exercise"],
    "languages": ["English", "Spanish"],
    "successStories": [
      {
        "clientName": "John D.",
        "achievement": "Lost 25kg in 6 months",
        "story": "Sarah helped me transform my life completely. Her personalized approach and constant motivation made all the difference.",
        "beforePhoto": "https://picsum.photos/150/150?random=71&keyword=fitness",
        "afterPhoto": "https://picsum.photos/150/150?random=72&keyword=fitness",
      },
      {
        "clientName": "Maria S.",
        "achievement": "Built muscle, improved confidence",
        "story": "Working with Sarah gave me the strength and confidence I never knew I had. Amazing results!",
        "beforePhoto": "https://picsum.photos/150/150?random=73&keyword=fitness",
        "afterPhoto": "https://picsum.photos/150/150?random=74&keyword=fitness",
      },
    ],
    "availability": {
      "monday": ["06:00", "08:00", "18:00", "20:00"],
      "tuesday": ["06:00", "08:00", "18:00", "20:00"],
      "wednesday": ["06:00", "08:00", "18:00", "20:00"],
      "thursday": ["06:00", "08:00", "18:00", "20:00"],
      "friday": ["06:00", "08:00", "18:00", "20:00"],
      "saturday": ["08:00", "10:00", "14:00", "16:00"],
      "sunday": ["08:00", "10:00"],
    },
    "packages": [
      {
        "name": "Single Session",
        "price": 85,
        "sessions": 1,
        "description": "Perfect for trying out my training style",
        "features": ["60-minute session", "Workout plan", "Exercise form guidance"],
      },
      {
        "name": "Weekly Package",
        "price": 300,
        "sessions": 4,
        "description": "Most popular choice for consistent progress",
        "features": ["4 sessions per week", "Custom meal plan", "Progress tracking", "24/7 text support"],
        "savings": 40,
      },
      {
        "name": "Monthly Transformation",
        "price": 1000,
        "sessions": 16,
        "description": "Complete lifestyle transformation program",
        "features": ["16 sessions per month", "Nutrition coaching", "Body composition analysis", "Weekly check-ins", "Supplement guidance"],
        "savings": 360,
      },
    ],
  };

  List<Map<String, dynamic>> reviews = [
    {
      "clientName": "Jennifer K.",
      "rating": 5.0,
      "date": "2024-03-10",
      "review": "Sarah is absolutely amazing! She pushed me beyond my limits while keeping me motivated. Lost 15kg in 4 months and feel stronger than ever.",
      "avatar": "https://picsum.photos/100/100?random=75&keyword=person",
    },
    {
      "clientName": "Robert M.",
      "rating": 5.0,
      "date": "2024-03-08",
      "review": "Best trainer I've ever worked with. Her knowledge of nutrition and exercise science is impressive. Highly recommend!",
      "avatar": "https://picsum.photos/100/100?random=76&keyword=person",
    },
    {
      "clientName": "Lisa P.",
      "rating": 4.8,
      "date": "2024-03-05",
      "review": "Sarah helped me build confidence in the gym. Her approach is professional yet friendly. Great results in just 2 months!",
      "avatar": "https://picsum.photos/100/100?random=77&keyword=person",
    },
  ];

  String selectedTab = "About";
  List<String> tabOptions = ["About", "Reviews", "Success Stories", "Packages"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildTabNavigation(),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  if (selectedTab == "About") _buildAboutTab(),
                  if (selectedTab == "Reviews") _buildReviewsTab(),
                  if (selectedTab == "Success Stories") _buildSuccessStoriesTab(),
                  if (selectedTab == "Packages") _buildPackagesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      height: 300,
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${trainer["coverPhoto"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(100),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: spMd,
            child: GestureDetector(
              onTap: () => back(),
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(100),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: spMd,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 140,
            left: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [shadowSm],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "${trainer["avatar"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (trainer["isOnline"])
                        Positioned(
                          right: 4,
                          bottom: 4,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: successColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${trainer["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${trainer["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${trainer["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${trainer["reviewCount"]} reviews",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${trainer["experience"]} years",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: tabOptions.map((tab) {
          bool isSelected = selectedTab == tab;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = tab;
                });
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
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : primaryColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoSection(),
        SizedBox(height: spMd),
        _buildSpecialtiesSection(),
        SizedBox(height: spMd),
        _buildCertificationsSection(),
        SizedBox(height: spMd),
        _buildAvailabilitySection(),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Me",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${trainer["bio"]}",
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${trainer["location"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.language, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Languages: ${(trainer["languages"] as List).join(", ")}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${trainer["responseTime"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtiesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Specialties",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: (trainer["specialties"] as List).map((specialty) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$specialty",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Certifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: (trainer["certifications"] as List).map((cert) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: successColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$cert",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
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

  Widget _buildAvailabilitySection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Availability This Week",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  _showFullAvailability();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: (trainer["availability"] as Map<String, dynamic>).entries.take(3).map((entry) {
              String day = entry.key;
              List<String> times = List<String>.from(entry.value);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        day.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: spSm,
                        children: times.map((time) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
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

  Widget _buildReviewsTab() {
    return Column(
      children: reviews.map((review) {
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [shadowSm],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "${review["avatar"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${review["clientName"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (review["rating"] as double).floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: warningColor,
                                  size: 14,
                                );
                              }),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              DateTime.parse("${review["date"]}").dMMMy,
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
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "${review["review"]}",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuccessStoriesTab() {
    return Column(
      children: (trainer["successStories"] as List).map((story) {
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${story["clientName"]} - ${story["achievement"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "BEFORE",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${story["beforePhoto"]}",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "AFTER",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${story["afterPhoto"]}",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "${story["story"]}",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPackagesTab() {
    return Column(
      children: (trainer["packages"] as List).map((package) {
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: package["savings"] != null 
                ? Border.all(color: successColor, width: 2)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${package["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  if (package["savings"] != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "SAVE \$${package["savings"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${package["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              Column(
                children: (package["features"] as List).map((feature) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "$feature",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${package["price"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${package["sessions"]} session${(package["sessions"] as int) > 1 ? "s" : ""}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Select Package",
                    size: bs.sm,
                    onPressed: () {
                      _selectPackage(package);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Message",
              icon: Icons.message,
              size: bs.md,
              onPressed: () {
                _messageTrainer();
              },
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: QButton(
              label: "Book Session",
              size: bs.md,
              onPressed: () {
                _bookSession();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFullAvailability() {
    // Show full availability calendar
  }

  void _selectPackage(Map<String, dynamic> package) {
    // Navigate to package booking
  }

  void _messageTrainer() {
    // Navigate to chat
  }

  void _bookSession() {
    // Navigate to booking
  }
}
