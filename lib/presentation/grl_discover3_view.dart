import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover3View extends StatefulWidget {
  @override
  State<GrlDiscover3View> createState() => _GrlDiscover3ViewState();
}

class _GrlDiscover3ViewState extends State<GrlDiscover3View> {
  String searchQuery = "";
  String selectedFilter = "Newest";
  List<String> filterOptions = ["Newest", "Popular", "Trending", "Bookmarked"];
  
  List<Map<String, dynamic>> exploreCategories = [
    {
      "name": "Technology",
      "icon": Icons.computer,
      "color": primaryColor,
      "articleCount": 1250,
      "description": "Latest tech trends and innovations"
    },
    {
      "name": "Science",
      "icon": Icons.science,
      "color": infoColor,
      "articleCount": 890,
      "description": "Scientific discoveries and research"
    },
    {
      "name": "Health",
      "icon": Icons.health_and_safety,
      "color": successColor,
      "articleCount": 765,
      "description": "Health tips and medical insights"
    },
    {
      "name": "Business",
      "icon": Icons.business,
      "color": warningColor,
      "articleCount": 654,
      "description": "Business news and strategies"
    },
    {
      "name": "Travel",
      "icon": Icons.flight,
      "color": secondaryColor,
      "articleCount": 543,
      "description": "Travel guides and experiences"
    },
    {
      "name": "Food",
      "icon": Icons.restaurant,
      "color": dangerColor,
      "articleCount": 432,
      "description": "Recipes and culinary adventures"
    }
  ];

  List<Map<String, dynamic>> quickReads = [
    {
      "title": "5 Minute Morning Routine",
      "author": "Lisa Park",
      "readTime": "3 min",
      "category": "Lifestyle",
      "image": "https://picsum.photos/80/80?random=10&keyword=morning",
      "likes": 89
    },
    {
      "title": "Quick Photo Tips",
      "author": "Mike Chen",
      "readTime": "4 min",
      "category": "Photography",
      "image": "https://picsum.photos/80/80?random=11&keyword=photography",
      "likes": 156
    },
    {
      "title": "Coding Shortcuts",
      "author": "Alex Johnson",
      "readTime": "5 min",
      "category": "Programming",
      "image": "https://picsum.photos/80/80?random=12&keyword=coding",
      "likes": 234
    }
  ];

  List<Map<String, dynamic>> popularAuthors = [
    {
      "name": "Dr. Sarah Wilson",
      "avatar": "https://picsum.photos/60/60?random=20&keyword=person",
      "specialty": "Technology Researcher",
      "followers": 12450,
      "articles": 89,
      "isFollowing": false
    },
    {
      "name": "Mark Rodriguez",
      "avatar": "https://picsum.photos/60/60?random=21&keyword=person",
      "specialty": "Travel Blogger",
      "followers": 8930,
      "articles": 156,
      "isFollowing": true
    },
    {
      "name": "Emma Thompson",
      "avatar": "https://picsum.photos/60/60?random=22&keyword=person",
      "specialty": "Food Critic",
      "followers": 7650,
      "articles": 203,
      "isFollowing": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Search and Filter
            Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "What are you interested in?",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Sort by",
                  items: filterOptions.map((option) => {
                    "label": option,
                    "value": option,
                  }).toList(),
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Explore Categories
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Explore Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: exploreCategories.map((category) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: (category["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  category["icon"] as IconData,
                                  color: category["color"] as Color,
                                  size: 24,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${(category["articleCount"] as int)} articles",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),

                          Text(
                            "${category["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Explore",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Quick Reads
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.flash_on,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Quick Reads",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: List.generate(quickReads.length, (index) {
                    final article = quickReads[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${article["image"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${article["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${article["author"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "•",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${article["readTime"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: secondaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${article["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: secondaryColor,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.favorite_border,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${(article["likes"] as int)}",
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
                    );
                  }),
                ),
              ],
            ),

            // Popular Authors
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_search,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Popular Authors",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: List.generate(popularAuthors.length, (index) {
                    final author = popularAuthors[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${author["avatar"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${author["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${author["specialty"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${(author["followers"] as int).toString()} followers",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${(author["articles"] as int)} articles",
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
                          SizedBox(width: spSm),
                          QButton(
                            label: (author["isFollowing"] as bool) ? "Following" : "Follow",
                            size: bs.sm,
                            onPressed: () {
                              author["isFollowing"] = !(author["isFollowing"] as bool);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
