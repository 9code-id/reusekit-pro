import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaFarmerNetworkView extends StatefulWidget {
  const AmaFarmerNetworkView({super.key});

  @override
  State<AmaFarmerNetworkView> createState() => _AmaFarmerNetworkViewState();
}

class _AmaFarmerNetworkViewState extends State<AmaFarmerNetworkView> {
  String searchQuery = "";
  int selectedFilter = 0;
  
  List<Map<String, dynamic>> farmers = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "farm": "Green Valley Farm",
      "location": "California, USA",
      "specialty": "Organic Vegetables",
      "experience": 15,
      "followers": 2847,
      "posts": 156,
      "image": "https://picsum.photos/120/120?random=1&keyword=farmer",
      "isOnline": true,
      "rating": 4.8,
      "verified": true,
    },
    {
      "id": "2", 
      "name": "Miguel Rodriguez",
      "farm": "Sunset Orchards",
      "location": "Mexico",
      "specialty": "Citrus Fruits",
      "experience": 22,
      "followers": 3456,
      "posts": 234,
      "image": "https://picsum.photos/120/120?random=2&keyword=farmer",
      "isOnline": false,
      "rating": 4.9,
      "verified": true,
    },
    {
      "id": "3",
      "name": "Priya Sharma", 
      "farm": "Golden Fields",
      "location": "Punjab, India",
      "specialty": "Rice & Wheat",
      "experience": 18,
      "followers": 1923,
      "posts": 89,
      "image": "https://picsum.photos/120/120?random=3&keyword=farmer",
      "isOnline": true,
      "rating": 4.7,
      "verified": false,
    },
    {
      "id": "4",
      "name": "John Thompson",
      "farm": "Prairie Winds Farm",
      "location": "Kansas, USA", 
      "specialty": "Corn & Soybeans",
      "experience": 25,
      "followers": 4521,
      "posts": 312,
      "image": "https://picsum.photos/120/120?random=4&keyword=farmer",
      "isOnline": false,
      "rating": 4.6,
      "verified": true,
    },
    {
      "id": "5",
      "name": "Anna Kowalski",
      "farm": "Alpine Meadows",
      "location": "Poland",
      "specialty": "Dairy & Livestock",
      "experience": 12,
      "followers": 1654,
      "posts": 78,
      "image": "https://picsum.photos/120/120?random=5&keyword=farmer",
      "isOnline": true,
      "rating": 4.5,
      "verified": false,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Farmers", "value": 0},
    {"label": "Online Now", "value": 1},
    {"label": "Verified", "value": 2},
    {"label": "Top Rated", "value": 3},
    {"label": "Most Followers", "value": 4},
  ];

  List<Map<String, dynamic>> get filteredFarmers {
    List<Map<String, dynamic>> filtered = List.from(farmers);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((farmer) =>
        (farmer["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (farmer["farm"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (farmer["specialty"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Apply category filter
    switch (selectedFilter) {
      case 1: // Online Now
        filtered = filtered.where((farmer) => farmer["isOnline"] as bool).toList();
        break;
      case 2: // Verified
        filtered = filtered.where((farmer) => farmer["verified"] as bool).toList();
        break;
      case 3: // Top Rated
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case 4: // Most Followers
        filtered.sort((a, b) => (b["followers"] as int).compareTo(a["followers"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farmer Network"),
        actions: [
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search farmers, farms, or specialties...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            // Filter Categories
            QCategoryPicker(
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value as int;
                setState(() {});
              },
            ),
            
            // Network Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "2,847",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Active Farmers",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                          "156",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Online Now",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                          "89",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Countries",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Farmers List
            ...List.generate(filteredFarmers.length, (index) {
              final farmer = filteredFarmers[index];
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${farmer["image"]}",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (farmer["isOnline"] as bool)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${farmer["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (farmer["verified"] as bool) ...[
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.verified,
                                      size: 16,
                                      color: successColor,
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${farmer["farm"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: secondaryColor,
                                ),
                              ),
                              Text(
                                "${farmer["location"]} • ${farmer["experience"]} years exp",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(farmer["rating"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            QButton(
                              icon: Icons.message,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.agriculture,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${farmer["specialty"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${(farmer["followers"] as int).toString()} followers",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(" • "),
                        Text(
                          "${farmer["posts"]} posts",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Profile",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            height: 36,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.person_add,
                                size: 16,
                                color: primaryColor,
                              ),
                              label: Text(
                                "Follow",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            
            if (filteredFarmers.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No farmers found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
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
