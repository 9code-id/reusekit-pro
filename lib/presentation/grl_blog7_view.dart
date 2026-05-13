import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog7View extends StatefulWidget {
  const GrlBlog7View({super.key});

  @override
  State<GrlBlog7View> createState() => _GrlBlog7ViewState();
}

class _GrlBlog7ViewState extends State<GrlBlog7View> {
  bool showWriteDialog = false;
  String newPostTitle = "";
  String newPostContent = "";
  String selectedCategory = "Technology";

  final List<Map<String, dynamic>> categories = [
    {"label": "Technology", "value": "Technology"},
    {"label": "Business", "value": "Business"},
    {"label": "Design", "value": "Design"},
    {"label": "Science", "value": "Science"},
    {"label": "Health", "value": "Health"},
    {"label": "Lifestyle", "value": "Lifestyle"},
  ];

  final List<Map<String, dynamic>> myPosts = [
    {
      "id": 1,
      "title": "Understanding Modern JavaScript Frameworks",
      "excerpt": "A comprehensive comparison of React, Vue, and Angular for modern web development.",
      "category": "Technology",
      "status": "Published",
      "publishedAt": "2024-01-20T10:30:00Z",
      "image": "https://picsum.photos/400/200?random=1&keyword=javascript",
      "views": 5420,
      "likes": 234,
      "comments": 45,
      "readTime": 8,
      "tags": ["JavaScript", "React", "Vue", "Angular"],
    },
    {
      "id": 2,
      "title": "The Future of Remote Work Culture",
      "excerpt": "How distributed teams are reshaping workplace dynamics and company culture.",
      "category": "Business",
      "status": "Draft",
      "publishedAt": null,
      "image": "https://picsum.photos/400/200?random=2&keyword=remote",
      "views": 0,
      "likes": 0,
      "comments": 0,
      "readTime": 6,
      "tags": ["Remote Work", "Culture", "Business"],
    },
    {
      "id": 3,
      "title": "Design Systems That Scale",
      "excerpt": "Building consistent and maintainable design systems for growing product teams.",
      "category": "Design",
      "status": "Published",
      "publishedAt": "2024-01-15T14:20:00Z",
      "image": "https://picsum.photos/400/200?random=3&keyword=design",
      "views": 3280,
      "likes": 189,
      "comments": 67,
      "readTime": 12,
      "tags": ["Design Systems", "UI/UX", "Product"],
    },
  ];

  final List<Map<String, dynamic>> analytics = [
    {
      "title": "Total Views",
      "value": 45600,
      "change": 12.5,
      "icon": Icons.visibility,
      "color": infoColor,
    },
    {
      "title": "Total Likes",
      "value": 2890,
      "change": 8.3,
      "icon": Icons.favorite,
      "color": dangerColor,
    },
    {
      "title": "Total Comments",
      "value": 456,
      "change": 15.7,
      "icon": Icons.comment,
      "color": successColor,
    },
    {
      "title": "Followers",
      "value": 1240,
      "change": 5.2,
      "icon": Icons.people,
      "color": warningColor,
    },
  ];

  final List<Map<String, dynamic>> topicSuggestions = [
    {"text": "AI and Machine Learning", "trending": true},
    {"text": "Sustainable Technology", "trending": false},
    {"text": "Web3 and Blockchain", "trending": true},
    {"text": "Mobile App Development", "trending": false},
    {"text": "Data Science Trends", "trending": true},
    {"text": "Cloud Computing", "trending": false},
    {"text": "Cybersecurity Basics", "trending": true},
    {"text": "IoT Applications", "trending": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Blog"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.analytics),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back, Writer!",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Ready to share your thoughts with the world?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Write Article",
                    size: bs.sm,
                    onPressed: () {
                      showWriteDialog = true;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Analytics Overview
            Text(
              "Performance Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: analytics.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            stat["icon"] as IconData,
                            color: stat["color"] as Color,
                            size: 24,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "+${(stat["change"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${((stat["value"] as int) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Topic Suggestions
            Text(
              "Trending Topics to Write About",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: topicSuggestions.map((topic) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: topic["trending"] == true ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: topic["trending"] == true ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (topic["trending"] == true) ...[
                        Icon(
                          Icons.whatshot,
                          size: 12,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                      ],
                      Text(
                        "${topic["text"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: topic["trending"] == true ? primaryColor : disabledBoldColor,
                          fontWeight: topic["trending"] == true ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // My Posts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Articles",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${myPosts.length} articles",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            Column(
              children: myPosts.map((post) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Image.network(
                          "${post["image"]}",
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: post["status"] == "Published" 
                                        ? successColor.withAlpha(20) 
                                        : warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${post["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: post["status"] == "Published" ? successColor : warningColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Icon(Icons.more_vert, color: disabledBoldColor),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${post["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${post["excerpt"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Wrap(
                              spacing: spXs,
                              children: (post["tags"] as List).take(3).map<Widget>((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spSm),
                            if (post["status"] == "Published") ...[
                              Row(
                                children: [
                                  Icon(Icons.visibility, size: 14, color: infoColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["views"]}",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(Icons.favorite, size: 14, color: dangerColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["likes"]}",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(Icons.comment, size: 14, color: successColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["comments"]}",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${post["readTime"]} min read",
                                    style: TextStyle(fontSize: 11, color: disabledBoldColor),
                                  ),
                                ],
                              ),
                            ] else ...[
                              Row(
                                children: [
                                  Text(
                                    "Draft • ${post["readTime"]} min read",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                  Spacer(),
                                  QButton(
                                    label: "Continue Writing",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Write New Post Dialog
            if (showWriteDialog) ...[
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Write New Article",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showWriteDialog = false;
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    QTextField(
                      label: "Article Title",
                      value: newPostTitle,
                      onChanged: (value) {
                        newPostTitle = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Category",
                      items: categories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "Content",
                      value: newPostContent,
                      onChanged: (value) {
                        newPostContent = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Save as Draft",
                            size: bs.sm,
                            onPressed: () {
                              // Save draft logic
                              showWriteDialog = false;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Publish",
                            size: bs.sm,
                            onPressed: () {
                              // Publish logic
                              showWriteDialog = false;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
