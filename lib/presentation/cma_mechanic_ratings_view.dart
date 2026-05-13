import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaMechanicRatingsView extends StatefulWidget {
  const CmaMechanicRatingsView({super.key});

  @override
  State<CmaMechanicRatingsView> createState() => _CmaMechanicRatingsViewState();
}

class _CmaMechanicRatingsViewState extends State<CmaMechanicRatingsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  String sortBy = "rating";

  List<Map<String, dynamic>> mechanics = [
    {
      "id": "1",
      "name": "Mike Rodriguez",
      "shopName": "Downtown Auto Repair",
      "shopAddress": "123 Main St, Downtown",
      "profileImage": "https://picsum.photos/200/200?random=1&keyword=mechanic",
      "rating": 4.9,
      "totalReviews": 347,
      "specialties": ["Engine Repair", "Transmission", "Diagnostics"],
      "experience": "15 years",
      "certifications": ["ASE Master", "Toyota Certified", "Honda Certified"],
      "hourlyRate": 85.00,
      "availability": "Available",
      "responseTime": "Within 2 hours",
      "completedJobs": 892,
      "description": "Experienced master mechanic specializing in engine diagnostics and transmission repair. Known for accurate diagnoses and quality workmanship.",
      "languages": ["English", "Spanish"],
      "recentReviews": [
        {
          "customerName": "Sarah Johnson",
          "rating": 5.0,
          "date": "2024-12-10",
          "comment": "Excellent work on my transmission repair. Very professional and explained everything clearly.",
          "serviceType": "Transmission Repair",
        },
        {
          "customerName": "David Chen",
          "rating": 5.0,
          "date": "2024-12-08",
          "comment": "Mike diagnosed my engine problem quickly and fixed it at a fair price. Highly recommended!",
          "serviceType": "Engine Diagnostic",
        },
      ],
    },
    {
      "id": "2",
      "name": "Jennifer Smith",
      "shopName": "North Side Auto Care",
      "shopAddress": "456 North Ave, Northside",
      "profileImage": "https://picsum.photos/200/200?random=2&keyword=mechanic",
      "rating": 4.8,
      "totalReviews": 256,
      "specialties": ["Brake Systems", "Electrical", "A/C Repair"],
      "experience": "12 years",
      "certifications": ["ASE Certified", "BMW Specialist", "Mercedes Certified"],
      "hourlyRate": 92.00,
      "availability": "Busy",
      "responseTime": "Within 4 hours",
      "completedJobs": 634,
      "description": "Specialized in European vehicle electrical systems and brake repair. Certified in BMW and Mercedes diagnostics.",
      "languages": ["English", "German"],
      "recentReviews": [
        {
          "customerName": "Mark Wilson",
          "rating": 5.0,
          "date": "2024-12-12",
          "comment": "Jennifer fixed my BMW's electrical issue that other mechanics couldn't solve. Worth every penny!",
          "serviceType": "Electrical Repair",
        },
        {
          "customerName": "Lisa Brown",
          "rating": 4.0,
          "date": "2024-12-09",
          "comment": "Great brake service, very thorough inspection and professional work.",
          "serviceType": "Brake Service",
        },
      ],
    },
    {
      "id": "3",
      "name": "Robert Thompson",
      "shopName": "South End Garage",
      "shopAddress": "789 South Blvd, Southend",
      "profileImage": "https://picsum.photos/200/200?random=3&keyword=mechanic",
      "rating": 4.7,
      "totalReviews": 189,
      "specialties": ["Body Work", "Paint", "Collision Repair"],
      "experience": "20 years",
      "certifications": ["I-CAR Certified", "PPG Certified", "ASE Body Repair"],
      "hourlyRate": 75.00,
      "availability": "Available",
      "responseTime": "Within 1 hour",
      "completedJobs": 1234,
      "description": "Master body technician with expertise in collision repair, paint matching, and restoration work. Perfectionist attention to detail.",
      "languages": ["English"],
      "recentReviews": [
        {
          "customerName": "Amanda Garcia",
          "rating": 5.0,
          "date": "2024-12-11",
          "comment": "Incredible paint work! You can't even tell my car was in an accident. Robert is an artist!",
          "serviceType": "Collision Repair",
        },
        {
          "customerName": "Tom Miller",
          "rating": 4.0,
          "date": "2024-12-07",
          "comment": "Good work on the dent removal. Professional and fair pricing.",
          "serviceType": "Dent Repair",
        },
      ],
    },
    {
      "id": "4",
      "name": "Carlos Hernandez",
      "shopName": "Express Oil & Lube",
      "shopAddress": "321 Quick St, Midtown",
      "profileImage": "https://picsum.photos/200/200?random=4&keyword=mechanic",
      "rating": 4.5,
      "totalReviews": 423,
      "specialties": ["Oil Changes", "Quick Service", "Tire Service"],
      "experience": "8 years",
      "certifications": ["ASE Service", "Valvoline Certified"],
      "hourlyRate": 45.00,
      "availability": "Available",
      "responseTime": "Within 30 minutes",
      "completedJobs": 2156,
      "description": "Fast and efficient service technician specializing in routine maintenance and quick service. Great for oil changes and basic maintenance.",
      "languages": ["English", "Spanish"],
      "recentReviews": [
        {
          "customerName": "Rachel Adams",
          "rating": 5.0,
          "date": "2024-12-13",
          "comment": "Super fast oil change and very friendly service. Carlos always takes good care of my car.",
          "serviceType": "Oil Change",
        },
        {
          "customerName": "Steve Johnson",
          "rating": 4.0,
          "date": "2024-12-11",
          "comment": "Quick tire rotation and good price. No complaints!",
          "serviceType": "Tire Service",
        },
      ],
    },
    {
      "id": "5",
      "name": "Ashley Williams",
      "shopName": "Precision Auto Works",
      "shopAddress": "555 Tech Drive, Innovation District",
      "profileImage": "https://picsum.photos/200/200?random=5&keyword=mechanic",
      "rating": 4.9,
      "totalReviews": 178,
      "specialties": ["Performance Tuning", "Racing", "Custom Work"],
      "experience": "10 years",
      "certifications": ["ASE Performance", "Dyno Certified", "Turbo Specialist"],
      "hourlyRate": 120.00,
      "availability": "Available",
      "responseTime": "Within 3 hours",
      "completedJobs": 445,
      "description": "Performance specialist focusing on engine tuning, turbo systems, and racing modifications. Expert in custom fabrication and dyno tuning.",
      "languages": ["English"],
      "recentReviews": [
        {
          "customerName": "Kyle Rodriguez",
          "rating": 5.0,
          "date": "2024-12-09",
          "comment": "Ashley turned my car into a beast! Amazing turbo install and tune. Incredible results!",
          "serviceType": "Turbo Install",
        },
        {
          "customerName": "Jessica Lee",
          "rating": 5.0,
          "date": "2024-12-06",
          "comment": "Best dyno tuning in the city. My car has never run better. Worth the premium price!",
          "serviceType": "Dyno Tuning",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Mechanics", "value": "All"},
    {"label": "Available Now", "value": "Available"},
    {"label": "ASE Certified", "value": "ASE"},
    {"label": "European Specialist", "value": "European"},
    {"label": "Performance Tuning", "value": "Performance"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Most Reviews", "value": "reviews"},
    {"label": "Lowest Price", "value": "price"},
    {"label": "Most Experience", "value": "experience"},
    {"label": "Fastest Response", "value": "response"},
  ];

  List<Map<String, dynamic>> get filteredMechanics {
    List<Map<String, dynamic>> filtered = mechanics;
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((mechanic) {
        return (mechanic["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (mechanic["shopName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (mechanic["specialties"] as List).any((specialty) => 
                 (specialty as String).toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Apply status filter
    if (selectedFilter != "All") {
      switch (selectedFilter) {
        case "Available":
          filtered = filtered.where((m) => m["availability"] == "Available").toList();
          break;
        case "ASE":
          filtered = filtered.where((m) => 
            (m["certifications"] as List).any((cert) => 
              (cert as String).contains("ASE"))).toList();
          break;
        case "European":
          filtered = filtered.where((m) => 
            (m["certifications"] as List).any((cert) => 
              (cert as String).contains("BMW") || (cert as String).contains("Mercedes"))).toList();
          break;
        case "Performance":
          filtered = filtered.where((m) => 
            (m["specialties"] as List).any((spec) => 
              (spec as String).contains("Performance") || (spec as String).contains("Racing"))).toList();
          break;
      }
    }
    
    // Apply sorting
    switch (sortBy) {
      case "reviews":
        filtered.sort((a, b) => (b["totalReviews"] as int).compareTo(a["totalReviews"] as int));
        break;
      case "price":
        filtered.sort((a, b) => (a["hourlyRate"] as double).compareTo(b["hourlyRate"] as double));
        break;
      case "experience":
        filtered.sort((a, b) {
          int expA = int.tryParse((a["experience"] as String).split(" ")[0]) ?? 0;
          int expB = int.tryParse((b["experience"] as String).split(" ")[0]) ?? 0;
          return expB.compareTo(expA);
        });
        break;
      case "response":
        filtered.sort((a, b) {
          Map<String, int> responseOrder = {
            "Within 30 minutes": 1,
            "Within 1 hour": 2,
            "Within 2 hours": 3,
            "Within 3 hours": 4,
            "Within 4 hours": 5,
          };
          return (responseOrder[a["responseTime"]] ?? 10).compareTo(responseOrder[b["responseTime"]] ?? 10);
        });
        break;
      default: // rating
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mechanic Reviews",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.search)),
        Tab(text: "Favorites", icon: Icon(Icons.favorite)),
        Tab(text: "My Reviews", icon: Icon(Icons.rate_review)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildFavoritesTab(),
        _buildMyReviewsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildBrowseTab() {
    return Column(
      children: [
        // Search and Filters
        Container(
          padding: EdgeInsets.all(spMd),
          color: Colors.grey.shade50,
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search mechanics...",
                      value: searchQuery,
                      hint: "Name, shop, or specialty",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.search,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter",
                      items: filterOptions,
                      value: selectedFilter,
                      onChanged: (value, label) {
                        selectedFilter = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Sort by",
                      items: sortOptions,
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Results count
        Container(
          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${filteredMechanics.length} mechanics found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ),

        // Mechanics List
        Expanded(
          child: filteredMechanics.isEmpty
              ? Center(
                  child: Column(
                    spacing: spMd,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 80,
                        color: disabledBoldColor,
                      ),
                      Text(
                        "No mechanics found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Try adjusting your search or filters",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(spMd),
                  itemCount: filteredMechanics.length,
                  itemBuilder: (context, index) {
                    final mechanic = filteredMechanics[index];
                    return _buildMechanicCard(mechanic);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildMechanicCard(Map<String, dynamic> mechanic) {
    Color availabilityColor = mechanic["availability"] == "Available" ? successColor : warningColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with profile
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${mechanic["profileImage"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${mechanic["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${mechanic["shopName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${mechanic["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " (${mechanic["totalReviews"]} reviews)",
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
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: availabilityColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${mechanic["availability"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: availabilityColor,
                  ),
                ),
              ),
            ],
          ),

          // Specialties
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (mechanic["specialties"] as List).map((specialty) => Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "$specialty",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
          ),

          // Description
          Text(
            "${mechanic["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // Info Row
          Row(
            children: [
              Icon(Icons.work, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${mechanic["experience"]}",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(width: spSm),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${mechanic["responseTime"]}",
                style: TextStyle(fontSize: 12),
              ),
              Spacer(),
              Text(
                "\$${(mechanic["hourlyRate"] as double).toStringAsFixed(0)}/hr",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),

          // Certifications
          if ((mechanic["certifications"] as List).isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Certifications:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  (mechanic["certifications"] as List).join(", "),
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

          // Recent Review Preview
          if ((mechanic["recentReviews"] as List).isNotEmpty) ...[
            Divider(),
            Text(
              "Recent Review:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${(mechanic["recentReviews"] as List)[0]["customerName"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: List.generate(5, (i) => Icon(
                          Icons.star,
                          size: 12,
                          color: i < ((mechanic["recentReviews"] as List)[0]["rating"] as double).floor() 
                              ? warningColor : disabledColor,
                        )),
                      ),
                    ],
                  ),
                  Text(
                    "${(mechanic["recentReviews"] as List)[0]["comment"]}",
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
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () => _showMechanicProfile(mechanic),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () => _contactMechanic(mechanic),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.favorite_border,
                size: bs.sm,
                onPressed: () => _addToFavorites(mechanic),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.rate_review,
                size: bs.sm,
                onPressed: () => _writeReview(mechanic),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Favorite Mechanics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Center(
            child: Column(
              spacing: spMd,
              children: [
                SizedBox(height: 100),
                Icon(
                  Icons.favorite_border,
                  size: 80,
                  color: disabledBoldColor,
                ),
                Text(
                  "No favorite mechanics yet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Add mechanics to favorites for quick access",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                QButton(
                  label: "Browse Mechanics",
                  size: bs.sm,
                  onPressed: () {
                    currentTab = 0;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyReviewsTab() {
    List<Map<String, dynamic>> myReviews = [
      {
        "mechanicName": "Mike Rodriguez",
        "shopName": "Downtown Auto Repair",
        "serviceType": "Engine Diagnostic",
        "rating": 5.0,
        "date": "2024-12-10",
        "comment": "Excellent service! Mike diagnosed the issue quickly and explained everything clearly. Fair pricing and quality work.",
        "cost": 125.00,
        "wouldRecommend": true,
      },
      {
        "mechanicName": "Jennifer Smith",
        "shopName": "North Side Auto Care",
        "serviceType": "Brake Repair",
        "rating": 4.0,
        "date": "2024-11-15",
        "comment": "Good brake service, professional work. The only issue was it took longer than expected.",
        "cost": 245.00,
        "wouldRecommend": true,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Reviews",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          if (myReviews.isEmpty)
            Center(
              child: Column(
                spacing: spMd,
                children: [
                  SizedBox(height: 100),
                  Icon(
                    Icons.rate_review,
                    size: 80,
                    color: disabledBoldColor,
                  ),
                  Text(
                    "No reviews written yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Share your experience with mechanics",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...myReviews.map((review) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${review["mechanicName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${review["shopName"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: List.generate(5, (i) => Icon(
                          Icons.star,
                          size: 16,
                          color: i < (review["rating"] as double).floor() 
                              ? warningColor : disabledColor,
                        )),
                      ),
                    ],
                  ),
                  
                  Text(
                    "${review["serviceType"]} - \$${(review["cost"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  Text(
                    "${review["comment"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${review["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (review["wouldRecommend"] as bool)
                        Row(
                          children: [
                            Icon(Icons.thumb_up, size: 16, color: successColor),
                            SizedBox(width: spXs),
                            Text(
                              "Recommended",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      QButton(
                        label: "Edit Review",
                        size: bs.sm,
                        onPressed: () => _editReview(review),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Delete",
                        size: bs.sm,
                        onPressed: () => _deleteReview(review),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        ],
      ),
    );
  }

  void _showMechanicProfile(Map<String, dynamic> mechanic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${mechanic["name"]}"),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusMd),
                  child: Image.network(
                    "${mechanic["profileImage"]}",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Text("Shop: ${mechanic["shopName"]}"),
                Text("Experience: ${mechanic["experience"]}"),
                Text("Specialties: ${(mechanic["specialties"] as List).join(", ")}"),
                Text("Certifications: ${(mechanic["certifications"] as List).join(", ")}"),
                Text("Rate: \$${(mechanic["hourlyRate"] as double).toStringAsFixed(0)}/hour"),
                Text("Completed Jobs: ${mechanic["completedJobs"]}"),
                Text("Languages: ${(mechanic["languages"] as List).join(", ")}"),
                SizedBox(height: spSm),
                Text(
                  "Recent Reviews:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...(mechanic["recentReviews"] as List).map((review) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("${review["customerName"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                          Spacer(),
                          Row(
                            children: List.generate(5, (i) => Icon(
                              Icons.star,
                              size: 12,
                              color: i < (review["rating"] as double).floor() ? warningColor : disabledColor,
                            )),
                          ),
                        ],
                      ),
                      Text("${review["comment"]}", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _contactMechanic(Map<String, dynamic> mechanic) {
    si("Contacting ${mechanic["name"]} at ${mechanic["shopName"]}");
  }

  void _addToFavorites(Map<String, dynamic> mechanic) {
    ss("${mechanic["name"]} added to favorites");
  }

  void _writeReview(Map<String, dynamic> mechanic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Write Review for ${mechanic["name"]}"),
        content: Text("Review form would open here"),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Submit",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Review submitted successfully");
            },
          ),
        ],
      ),
    );
  }

  void _editReview(Map<String, dynamic> review) {
    si("Edit review functionality would open here");
  }

  void _deleteReview(Map<String, dynamic> review) async {
    bool isConfirmed = await confirm("Delete this review?");
    if (isConfirmed) {
      se("Review deleted");
    }
  }
}
