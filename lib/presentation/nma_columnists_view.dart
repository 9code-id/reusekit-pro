import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaColumnistsView extends StatefulWidget {
  const NmaColumnistsView({super.key});

  @override
  State<NmaColumnistsView> createState() => _NmaColumnistsViewState();
}

class _NmaColumnistsViewState extends State<NmaColumnistsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> columnists = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "category": "Politics",
      "bio": "Senior political correspondent with 15 years of experience covering Washington politics and policy analysis.",
      "image": "https://picsum.photos/150/150?random=1&keyword=woman",
      "articles": 245,
      "followers": 85000,
      "specialties": ["Politics", "Policy", "Elections"],
      "isFollowing": true,
      "rating": 4.8,
      "verified": true,
      "lastArticle": "2024-01-15",
    },
    {
      "id": 2,
      "name": "Michael Chen",
      "category": "Technology",
      "bio": "Technology analyst and startup ecosystem expert. Former Silicon Valley executive turned journalist.",
      "image": "https://picsum.photos/150/150?random=2&keyword=man",
      "articles": 189,
      "followers": 92000,
      "specialties": ["AI", "Startups", "Innovation"],
      "isFollowing": false,
      "rating": 4.9,
      "verified": true,
      "lastArticle": "2024-01-14",
    },
    {
      "id": 3,
      "name": "Emma Rodriguez",
      "category": "Business",
      "bio": "Business journalist specializing in market analysis, corporate strategy, and economic trends.",
      "image": "https://picsum.photos/150/150?random=3&keyword=business",
      "articles": 312,
      "followers": 67000,
      "specialties": ["Markets", "Economy", "Corporate"],
      "isFollowing": true,
      "rating": 4.7,
      "verified": true,
      "lastArticle": "2024-01-13",
    },
    {
      "id": 4,
      "name": "David Thompson",
      "category": "Sports",
      "bio": "Sports columnist covering NFL, NBA, and Olympic sports. Award-winning sports journalism veteran.",
      "image": "https://picsum.photos/150/150?random=4&keyword=sports",
      "articles": 428,
      "followers": 156000,
      "specialties": ["NFL", "NBA", "Olympics"],
      "isFollowing": false,
      "rating": 4.6,
      "verified": true,
      "lastArticle": "2024-01-16",
    },
    {
      "id": 5,
      "name": "Lisa Anderson",
      "category": "Health",
      "bio": "Medical journalist and health policy expert. MD turned writer focusing on public health issues.",
      "image": "https://picsum.photos/150/150?random=5&keyword=doctor",
      "articles": 198,
      "followers": 73000,
      "specialties": ["Public Health", "Medical", "Policy"],
      "isFollowing": true,
      "rating": 4.8,
      "verified": true,
      "lastArticle": "2024-01-12",
    },
    {
      "id": 6,
      "name": "Robert Kim",
      "category": "Entertainment",
      "bio": "Entertainment industry insider covering Hollywood, streaming wars, and celebrity culture.",
      "image": "https://picsum.photos/150/150?random=6&keyword=entertainment",
      "articles": 267,
      "followers": 134000,
      "specialties": ["Hollywood", "Streaming", "Celebrity"],
      "isFollowing": false,
      "rating": 4.5,
      "verified": true,
      "lastArticle": "2024-01-15",
    },
  ];

  List<String> categories = ["All", "Politics", "Technology", "Business", "Sports", "Health", "Entertainment"];

  List<Map<String, dynamic>> get filteredColumnists {
    return columnists.where((columnist) {
      bool matchesSearch = "${columnist["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${columnist["bio"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || "${columnist["category"]}" == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Featured Columnists"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
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
                    label: "Search columnists",
                    value: searchQuery,
                    hint: "Search by name or expertise",
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

            // Category Filter
            QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Stats Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredColumnists.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Columnists",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
                          "${(filteredColumnists.fold(0, (sum, columnist) => sum + (columnist["articles"] as int))).toString()}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Articles",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
                          "${((filteredColumnists.fold(0, (sum, columnist) => sum + (columnist["followers"] as int)) / 1000)).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Followers",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Columnists List
            ...filteredColumnists.map((columnist) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Header with Photo and Basic Info
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            image: DecorationImage(
                              image: NetworkImage("${columnist["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${columnist["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (columnist["verified"] as bool)
                                    Icon(
                                      Icons.verified,
                                      color: successColor,
                                      size: 20,
                                    ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${columnist["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(columnist["rating"] as num).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: (columnist["isFollowing"] as bool) ? "Following" : "Follow",
                          size: bs.sm,
                          color: (columnist["isFollowing"] as bool) ? disabledBoldColor : primaryColor,
                          onPressed: () {
                            columnist["isFollowing"] = !(columnist["isFollowing"] as bool);
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    // Bio
                    Text(
                      "${columnist["bio"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),

                    // Specialties Tags
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (columnist["specialties"] as List).map((specialty) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$specialty",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Stats Row
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.article,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${columnist["articles"]} articles",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${((columnist["followers"] as int) / 1000).toStringAsFixed(0)}K followers",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Last: ${DateTime.parse(columnist["lastArticle"] as String).dMMMy}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Articles",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Send Message",
                            size: bs.sm,
                            color: disabledBoldColor,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredColumnists.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 60,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No columnists found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search criteria or category filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
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
