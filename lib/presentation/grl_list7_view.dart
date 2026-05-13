import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlList7View extends StatefulWidget {
  @override
  State<GrlList7View> createState() => _GrlList7ViewState();
}

class _GrlList7ViewState extends State<GrlList7View> {
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Health", "value": "Health"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Education", "value": "Education"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Technology", "value": "Technology"},
  ];

  List<Map<String, dynamic>> articles = [
    {
      "id": "ART-001",
      "title": "10 Healthy Habits That Will Change Your Life",
      "category": "Health",
      "author": "Dr. Sarah Johnson",
      "publishDate": "2024-12-15",
      "readTime": 8,
      "views": 2450,
      "likes": 189,
      "featured": true,
      "image": "https://picsum.photos/400/250?random=61&keyword=health",
      "excerpt": "Discover simple yet powerful habits that can transform your physical and mental well-being in just 30 days.",
      "tags": ["Wellness", "Lifestyle", "Health Tips"],
      "isBookmarked": false,
      "isLiked": false,
    },
    {
      "id": "ART-002",
      "title": "Smart Investment Strategies for Beginners",
      "category": "Finance",
      "author": "Michael Chen",
      "publishDate": "2024-12-14",
      "readTime": 12,
      "views": 3120,
      "likes": 267,
      "featured": false,
      "image": "https://picsum.photos/400/250?random=62&keyword=finance",
      "excerpt": "Learn the fundamentals of investing and build a solid portfolio that grows with your financial goals.",
      "tags": ["Investment", "Money", "Portfolio"],
      "isBookmarked": true,
      "isLiked": true,
    },
    {
      "id": "ART-003",
      "title": "The Future of Remote Learning",
      "category": "Education",
      "author": "Emma Rodriguez",
      "publishDate": "2024-12-13",
      "readTime": 6,
      "views": 1890,
      "likes": 142,
      "featured": true,
      "image": "https://picsum.photos/400/250?random=63&keyword=education",
      "excerpt": "Exploring how technology is reshaping education and creating new opportunities for learners worldwide.",
      "tags": ["EdTech", "Learning", "Innovation"],
      "isBookmarked": false,
      "isLiked": false,
    },
    {
      "id": "ART-004",
      "title": "Hidden Gems: 7 Underrated Travel Destinations",
      "category": "Travel",
      "author": "David Kim",
      "publishDate": "2024-12-12",
      "readTime": 10,
      "views": 4560,
      "likes": 398,
      "featured": false,
      "image": "https://picsum.photos/400/250?random=64&keyword=travel",
      "excerpt": "Uncover breathtaking destinations that offer unique experiences without the crowds of popular tourist spots.",
      "tags": ["Adventure", "Destinations", "Travel Tips"],
      "isBookmarked": true,
      "isLiked": false,
    },
    {
      "id": "ART-005",
      "title": "AI Revolution: How Machine Learning is Changing Business",
      "category": "Technology",
      "author": "Lisa Wang",
      "publishDate": "2024-12-11",
      "readTime": 15,
      "views": 5230,
      "likes": 456,
      "featured": true,
      "image": "https://picsum.photos/400/250?random=65&keyword=technology",
      "excerpt": "An in-depth look at how artificial intelligence is transforming industries and creating new business opportunities.",
      "tags": ["AI", "Machine Learning", "Business"],
      "isBookmarked": false,
      "isLiked": true,
    },
  ];

  List<Map<String, dynamic>> get filteredArticles {
    return articles.where((article) {
      bool matchesSearch = "${article["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${article["author"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || article["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "Health":
        return successColor;
      case "Finance":
        return warningColor;
      case "Education":
        return infoColor;
      case "Travel":
        return primaryColor;
      case "Technology":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Articles"),
        actions: [
          Icon(Icons.bookmark_border),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.article,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Discover Amazing Content",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${articles.length} articles • ${articles.where((a) => a["featured"] == true).length} featured",
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

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search articles",
                    value: searchQuery,
                    hint: "Search by title or author...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Articles (${filteredArticles.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    QButton(
                      icon: Icons.grid_view,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    QButton(
                      icon: Icons.list,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                final article = filteredArticles[index];
                final categoryColor = getCategoryColor("${article["category"]}");
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                    border: (article["featured"] as bool)
                        ? Border.all(color: warningColor.withAlpha(100), width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            child: Image.network(
                              "${article["image"]}",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (article["featured"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  spacing: spXs,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    Text(
                                      "Featured",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: categoryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${article["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${article["title"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                                QButton(
                                  icon: (article["isBookmarked"] as bool)
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  size: bs.sm,
                                  onPressed: () {
                                    article["isBookmarked"] = !(article["isBookmarked"] as bool);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: primaryColor,
                                  child: Text(
                                    "${article["author"]}".substring(0, 1),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 2,
                                    children: [
                                      Text(
                                        "${article["author"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${article["publishDate"]} • ${article["readTime"]} min read",
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

                            Text(
                              "${article["excerpt"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.5,
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Tags:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (article["tags"] as List).map((tag) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: categoryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$tag",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: categoryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: spMd,
                                  children: [
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        Icon(
                                          Icons.visibility,
                                          color: disabledBoldColor,
                                          size: 16,
                                        ),
                                        Text(
                                          "${article["views"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            article["isLiked"] = !(article["isLiked"] as bool);
                                            if (article["isLiked"] as bool) {
                                              article["likes"] = (article["likes"] as int) + 1;
                                            } else {
                                              article["likes"] = (article["likes"] as int) - 1;
                                            }
                                            setState(() {});
                                          },
                                          child: Icon(
                                            (article["isLiked"] as bool)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: (article["isLiked"] as bool)
                                                ? dangerColor
                                                : disabledBoldColor,
                                            size: 16,
                                          ),
                                        ),
                                        Text(
                                          "${article["likes"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: spSm,
                                  children: [
                                    QButton(
                                      label: "Read More",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                    QButton(
                                      icon: Icons.share,
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
