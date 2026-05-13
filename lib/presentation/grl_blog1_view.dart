import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog1View extends StatefulWidget {
  @override
  State<GrlBlog1View> createState() => _GrlBlog1ViewState();
}

class _GrlBlog1ViewState extends State<GrlBlog1View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Latest";
  bool showFeaturedOnly = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Lifestyle", "value": "Lifestyle"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Food", "value": "Food"},
    {"label": "Health", "value": "Health"},
    {"label": "Business", "value": "Business"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Latest", "value": "Latest"},
    {"label": "Most Popular", "value": "Popular"},
    {"label": "Most Commented", "value": "Commented"},
    {"label": "Trending", "value": "Trending"},
  ];

  Map<String, dynamic> featuredPost = {
    "id": 1,
    "title": "The Future of Remote Work: Transforming Digital Nomad Culture",
    "excerpt": "Exploring how remote work is reshaping traditional employment models and creating new opportunities for digital nomads worldwide",
    "content": "The landscape of work has fundamentally changed in recent years, with remote work becoming not just a temporary solution but a permanent fixture in many industries. This transformation has given rise to a new generation of digital nomads who leverage technology to work from anywhere in the world.",
    "image": "https://picsum.photos/600/350?random=1&keyword=workspace",
    "author": "Sarah Mitchell",
    "authorAvatar": "https://picsum.photos/60/60?random=1&keyword=woman",
    "authorBio": "Tech journalist and remote work advocate",
    "publishedAt": "2024-01-15T10:00:00Z",
    "readTime": 8,
    "category": "Technology",
    "tags": ["Remote Work", "Digital Nomads", "Technology", "Future of Work"],
    "likes": 2340,
    "comments": 156,
    "shares": 89,
    "views": 12500,
    "isFeatured": true,
    "isLiked": false,
    "isBookmarked": false,
  };

  List<Map<String, dynamic>> blogPosts = [
    {
      "id": 2,
      "title": "Mindful Living: Simple Practices for a Balanced Life",
      "excerpt": "Discover easy mindfulness techniques that can transform your daily routine and improve overall well-being",
      "image": "https://picsum.photos/300/200?random=2&keyword=meditation",
      "author": "Dr. Emma Chen",
      "authorAvatar": "https://picsum.photos/40/40?random=2&keyword=woman",
      "publishedAt": "2024-01-14T15:30:00Z",
      "readTime": 6,
      "category": "Lifestyle",
      "tags": ["Mindfulness", "Wellness", "Mental Health"],
      "likes": 1890,
      "comments": 92,
      "views": 8900,
      "isFeatured": false,
      "isLiked": true,
      "isBookmarked": false,
    },
    {
      "id": 3,
      "title": "Hidden Gems: Underrated Travel Destinations in Southeast Asia",
      "excerpt": "Explore breathtaking locations that offer authentic experiences away from crowded tourist spots",
      "image": "https://picsum.photos/300/200?random=3&keyword=temple",
      "author": "Marco Rodriguez",
      "authorAvatar": "https://picsum.photos/40/40?random=3&keyword=man",
      "publishedAt": "2024-01-14T12:00:00Z",
      "readTime": 10,
      "category": "Travel",
      "tags": ["Travel", "Southeast Asia", "Adventure", "Culture"],
      "likes": 3200,
      "comments": 234,
      "views": 15600,
      "isFeatured": true,
      "isLiked": false,
      "isBookmarked": true,
    },
    {
      "id": 4,
      "title": "Farm-to-Table Revolution: Supporting Local Food Systems",
      "excerpt": "How choosing locally sourced ingredients can benefit your health, community, and environment",
      "image": "https://picsum.photos/300/200?random=4&keyword=vegetables",
      "author": "Chef Julia Martinez",
      "authorAvatar": "https://picsum.photos/40/40?random=4&keyword=chef",
      "publishedAt": "2024-01-13T18:45:00Z",
      "readTime": 7,
      "category": "Food",
      "tags": ["Farm-to-Table", "Sustainability", "Local Food", "Health"],
      "likes": 1560,
      "comments": 78,
      "views": 6800,
      "isFeatured": false,
      "isLiked": false,
      "isBookmarked": false,
    },
    {
      "id": 5,
      "title": "Startup Success Stories: Lessons from Young Entrepreneurs",
      "excerpt": "Inspiring stories and practical advice from successful startup founders under 30",
      "image": "https://picsum.photos/300/200?random=5&keyword=startup",
      "author": "Michael Kim",
      "authorAvatar": "https://picsum.photos/40/40?random=5&keyword=businessman",
      "publishedAt": "2024-01-13T14:20:00Z",
      "readTime": 12,
      "category": "Business",
      "tags": ["Startup", "Entrepreneurship", "Success Stories", "Business"],
      "likes": 2780,
      "comments": 189,
      "views": 11200,
      "isFeatured": false,
      "isLiked": true,
      "isBookmarked": true,
    },
    {
      "id": 6,
      "title": "The Science of Sleep: Optimizing Your Rest for Better Health",
      "excerpt": "Evidence-based strategies to improve sleep quality and boost your overall health",
      "image": "https://picsum.photos/300/200?random=6&keyword=sleep",
      "author": "Dr. Robert Thompson",
      "authorAvatar": "https://picsum.photos/40/40?random=6&keyword=doctor",
      "publishedAt": "2024-01-12T20:30:00Z",
      "readTime": 9,
      "category": "Health",
      "tags": ["Sleep", "Health", "Science", "Wellness"],
      "likes": 2100,
      "comments": 134,
      "views": 9400,
      "isFeatured": true,
      "isLiked": false,
      "isBookmarked": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search blog posts...",
                    value: searchQuery,
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

            // Category and Sort Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
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

            // Featured Only Toggle
            QSwitch(
              items: [
                {
                  "label": "Show Featured Posts Only",
                  "value": true,
                  "checked": showFeaturedOnly,
                }
              ],
              value: [
                if (showFeaturedOnly)
                  {
                    "label": "Show Featured Posts Only",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showFeaturedOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Featured Post
            if (!showFeaturedOnly || featuredPost["isFeatured"] == true) ...[
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Featured Post",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
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
                            "${featuredPost["image"]}",
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "FEATURED",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  featuredPost["isLiked"] = !(featuredPost["isLiked"] as bool);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(128),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    featuredPost["isLiked"] == true ? Icons.favorite : Icons.favorite_border,
                                    color: featuredPost["isLiked"] == true ? dangerColor : Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              GestureDetector(
                                onTap: () {
                                  featuredPost["isBookmarked"] = !(featuredPost["isBookmarked"] as bool);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(128),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    featuredPost["isBookmarked"] == true ? Icons.bookmark : Icons.bookmark_border,
                                    color: featuredPost["isBookmarked"] == true ? warningColor : Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${featuredPost["category"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "${featuredPost["title"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              height: 1.3,
                            ),
                          ),
                          Text(
                            "${featuredPost["excerpt"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            "${featuredPost["content"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                              height: 1.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (featuredPost["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    color: warningColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage("${featuredPost["authorAvatar"]}"),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${featuredPost["author"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${featuredPost["authorBio"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${featuredPost["readTime"]} min read",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 16,
                                    color: dangerColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${featuredPost["likes"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: spSm),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.comment,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${featuredPost["comments"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: spSm),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${((featuredPost["views"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                DateTime.parse("${featuredPost["publishedAt"]}").dMMMy,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
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
            ],

            // Recent Posts Section
            Row(
              children: [
                Icon(
                  Icons.article,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Recent Posts",
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
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // Blog Posts Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: blogPosts.where((post) => !showFeaturedOnly || post["isFeatured"] == true).map((post) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
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
                              "${post["image"]}",
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (post["isFeatured"] == true)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "FEATURED",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    post["isLiked"] = !(post["isLiked"] as bool);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(128),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      post["isLiked"] == true ? Icons.favorite : Icons.favorite_border,
                                      color: post["isLiked"] == true ? dangerColor : Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                GestureDetector(
                                  onTap: () {
                                    post["isBookmarked"] = !(post["isBookmarked"] as bool);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(128),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      post["isBookmarked"] == true ? Icons.bookmark : Icons.bookmark_border,
                                      color: post["isBookmarked"] == true ? warningColor : Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${post["category"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "${post["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${post["excerpt"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage("${post["authorAvatar"]}"),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${post["author"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${post["readTime"]} min",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 12,
                                      color: dangerColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${post["likes"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${post["comments"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  DateTime.parse("${post["publishedAt"]}").dMMMy,
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
