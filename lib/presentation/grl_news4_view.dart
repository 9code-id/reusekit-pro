import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNews4View extends StatefulWidget {
  @override
  State<GrlNews4View> createState() => _GrlNews4ViewState();
}

class _GrlNews4ViewState extends State<GrlNews4View> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool isFollowing = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Politics", "value": "Politics"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Health", "value": "Health"},
    {"label": "Entertainment", "value": "Entertainment"},
  ];

  List<Map<String, dynamic>> breakingNews = [
    {
      "id": 1,
      "title": "Global Climate Summit Reaches Historic Agreement",
      "excerpt": "World leaders unite on ambitious climate action plan",
      "image": "https://picsum.photos/300/200?random=1&keyword=climate",
      "category": "Politics",
      "author": "Sarah Johnson",
      "publishedAt": "2024-01-15T10:30:00Z",
      "readTime": 5,
      "isLive": true,
    },
    {
      "id": 2,
      "title": "Revolutionary AI Breakthrough Changes Medical Diagnosis",
      "excerpt": "New technology promises 99% accuracy in early disease detection",
      "image": "https://picsum.photos/300/200?random=2&keyword=medical",
      "category": "Technology",
      "author": "Dr. Michael Chen",
      "publishedAt": "2024-01-15T09:15:00Z",
      "readTime": 7,
      "isLive": false,
    },
  ];

  List<Map<String, dynamic>> trendingNews = [
    {
      "id": 3,
      "title": "Olympic Games Set Record Breaking Attendance",
      "excerpt": "Historic numbers as global audience tunes in",
      "image": "https://picsum.photos/250/150?random=3&keyword=olympics",
      "category": "Sports",
      "author": "Emma Rodriguez",
      "publishedAt": "2024-01-15T08:45:00Z",
      "readTime": 4,
      "views": 125000,
    },
    {
      "id": 4,
      "title": "New Study Reveals Benefits of Mediterranean Diet",
      "excerpt": "Research shows significant health improvements",
      "image": "https://picsum.photos/250/150?random=4&keyword=food",
      "category": "Health",
      "author": "Dr. Lisa Wang",
      "publishedAt": "2024-01-15T07:20:00Z",
      "readTime": 6,
      "views": 89000,
    },
    {
      "id": 5,
      "title": "Hollywood Awards Season Brings Surprises",
      "excerpt": "Unexpected winners shake up entertainment industry",
      "image": "https://picsum.photos/250/150?random=5&keyword=awards",
      "category": "Entertainment",
      "author": "James Mitchell",
      "publishedAt": "2024-01-15T06:00:00Z",
      "readTime": 3,
      "views": 67000,
    },
    {
      "id": 6,
      "title": "Electric Vehicle Sales Surge Globally",
      "excerpt": "Market adoption accelerates beyond expectations",
      "image": "https://picsum.photos/250/150?random=6&keyword=electric",
      "category": "Technology",
      "author": "Robert Kim",
      "publishedAt": "2024-01-14T22:30:00Z",
      "readTime": 5,
      "views": 112000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Hub"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
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
            // Search and Follow Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search news...",
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

            // Categories
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Breaking News Section
            Row(
              children: [
                Icon(
                  Icons.flash_on,
                  color: dangerColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Breaking News",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Follow",
                  icon: isFollowing ? Icons.notifications_active : Icons.notifications_none,
                  size: bs.sm,
                  onPressed: () {
                    isFollowing = !isFollowing;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Breaking News Cards
            QHorizontalScroll(
              children: breakingNews.map((news) {
                return Container(
                  width: 320,
                  margin: EdgeInsets.only(right: spSm),
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
                              "${news["image"]}",
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (news["isLive"] == true)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "LIVE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
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
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(128),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                                size: 16,
                              ),
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
                            Row(
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
                                    "${news["category"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${news["readTime"]} min read",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${news["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${news["excerpt"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: primaryColor.withAlpha(51),
                                  child: Text(
                                    "${news["author"]}".substring(0, 1),
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${news["author"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  DateTime.parse("${news["publishedAt"]}").dMMMy,
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
                );
              }).toList(),
            ),

            // Trending Section
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: successColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Trending Now",
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

            // Trending News List
            ...trendingNews.map((news) {
              return Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${news["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${news["category"]}",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${((news["views"] as int) / 1000).toStringAsFixed(0)}K",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "${news["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${news["excerpt"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                "${news["author"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " • ",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                DateTime.parse("${news["publishedAt"]}").dMMMy,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                " • ",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${news["readTime"]} min",
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
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.bookmark_border,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(height: spSm),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.share,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
