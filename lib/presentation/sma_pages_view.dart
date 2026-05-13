import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPagesView extends StatefulWidget {
  const SmaPagesView({super.key});

  @override
  State<SmaPagesView> createState() => _SmaPagesViewState();
}

class _SmaPagesViewState extends State<SmaPagesView> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool showFollowedOnly = false;

  List<Map<String, dynamic>> pages = [
    {
      "id": 1,
      "name": "TechCorp Solutions",
      "category": "Technology",
      "description": "Leading technology solutions provider for businesses worldwide",
      "coverImage": "https://picsum.photos/400/200?random=1&keyword=technology",
      "profileImage": "https://picsum.photos/100/100?random=11&keyword=tech",
      "followers": 45200,
      "following": false,
      "verified": true,
      "posts": 342,
      "engagement": 8.5,
      "location": "San Francisco, CA",
      "website": "techcorp.com",
      "phone": "+1 555-0123",
      "email": "contact@techcorp.com",
      "founded": "2015",
      "employees": "501-1000"
    },
    {
      "id": 2,
      "name": "Green Earth Initiative",
      "category": "Environmental",
      "description": "Non-profit organization dedicated to environmental conservation and sustainability",
      "coverImage": "https://picsum.photos/400/200?random=2&keyword=nature",
      "profileImage": "https://picsum.photos/100/100?random=12&keyword=green",
      "followers": 23800,
      "following": true,
      "verified": true,
      "posts": 156,
      "engagement": 12.3,
      "location": "Seattle, WA",
      "website": "greenearthinitiative.org",
      "phone": "+1 555-0456",
      "email": "info@greenearthinitiative.org",
      "founded": "2010",
      "employees": "11-50"
    },
    {
      "id": 3,
      "name": "Urban Fitness Studio",
      "category": "Health & Fitness",
      "description": "Premium fitness studio offering personalized training and wellness programs",
      "coverImage": "https://picsum.photos/400/200?random=3&keyword=fitness",
      "profileImage": "https://picsum.photos/100/100?random=13&keyword=gym",
      "followers": 12500,
      "following": false,
      "verified": false,
      "posts": 89,
      "engagement": 15.7,
      "location": "New York, NY",
      "website": "urbanfitnessstudio.com",
      "phone": "+1 555-0789",
      "email": "hello@urbanfitnessstudio.com",
      "founded": "2018",
      "employees": "1-10"
    },
    {
      "id": 4,
      "name": "Artisan Coffee Co.",
      "category": "Food & Beverage",
      "description": "Specialty coffee roasters sourcing beans from sustainable farms worldwide",
      "coverImage": "https://picsum.photos/400/200?random=4&keyword=coffee",
      "profileImage": "https://picsum.photos/100/100?random=14&keyword=coffee",
      "followers": 18700,
      "following": true,
      "verified": false,
      "posts": 234,
      "engagement": 9.8,
      "location": "Portland, OR",
      "website": "artisancoffeeco.com",
      "phone": "+1 555-0321",
      "email": "info@artisancoffeeco.com",
      "founded": "2016",
      "employees": "11-50"
    },
    {
      "id": 5,
      "name": "Digital Marketing Pros",
      "category": "Marketing",
      "description": "Full-service digital marketing agency helping brands grow online presence",
      "coverImage": "https://picsum.photos/400/200?random=5&keyword=marketing",
      "profileImage": "https://picsum.photos/100/100?random=15&keyword=digital",
      "followers": 31400,
      "following": false,
      "verified": true,
      "posts": 412,
      "engagement": 7.2,
      "location": "Austin, TX",
      "website": "digitalmarketingpros.com",
      "phone": "+1 555-0654",
      "email": "contact@digitalmarketingpros.com",
      "founded": "2014",
      "employees": "51-200"
    }
  ];

  List<String> categories = [
    "All",
    "Technology",
    "Environmental",
    "Health & Fitness",
    "Food & Beverage",
    "Marketing",
    "Education",
    "Entertainment",
    "Non-profit"
  ];

  List<Map<String, dynamic>> get filteredPages {
    List<Map<String, dynamic>> filtered = pages;

    if (showFollowedOnly) {
      filtered = filtered.where((page) => page["following"] as bool).toList();
    }

    if (selectedCategory != "All") {
      filtered = filtered.where((page) => page["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((page) => 
        (page["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (page["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pages"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                          "Following",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${pages.where((p) => p["following"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Pages",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${pages.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search pages...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories.map((cat) => {
                            "label": cat,
                            "value": cat,
                          }).toList(),
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Following Only",
                              "value": true,
                              "checked": showFollowedOnly,
                            }
                          ],
                          value: [
                            if (showFollowedOnly)
                              {
                                "label": "Following Only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showFollowedOnly = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Pages List
            ...filteredPages.map((page) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover Image
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                      image: DecorationImage(
                        image: NetworkImage("${page["coverImage"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        // Profile Section
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage("${page["profileImage"]}"),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${page["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      if (page["verified"] as bool)
                                        Icon(
                                          Icons.verified,
                                          size: 20,
                                          color: primaryColor,
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${page["category"]}",
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

                        // Description
                        Text(
                          "${page["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Stats Row
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${((page["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.article,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${page["posts"]} posts",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.trending_up,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${page["engagement"]}% engagement",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: (page["following"] as bool) ? "Following" : "Follow",
                                size: bs.sm,
                                color: (page["following"] as bool) ? disabledBoldColor : primaryColor,
                                onPressed: () {
                                  page["following"] = !(page["following"] as bool);
                                  if (page["following"] as bool) {
                                    page["followers"] = (page["followers"] as int) + 1;
                                  } else {
                                    page["followers"] = (page["followers"] as int) - 1;
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "View Page",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to page detail
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
            )),

            if (filteredPages.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No pages found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
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
