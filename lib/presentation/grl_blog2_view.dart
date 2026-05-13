import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog2View extends StatefulWidget {
  @override
  State<GrlBlog2View> createState() => _GrlBlog2ViewState();
}

class _GrlBlog2ViewState extends State<GrlBlog2View> {
  String searchQuery = "";
  String selectedAuthor = "All Authors";
  String selectedTimeframe = "All Time";
  bool showTrendingOnly = false;
  int currentTab = 0;

  List<Map<String, dynamic>> authors = [
    {"label": "All Authors", "value": "All Authors"},
    {"label": "Sarah Mitchell", "value": "Sarah Mitchell"},
    {"label": "Dr. Emma Chen", "value": "Dr. Emma Chen"},
    {"label": "Marco Rodriguez", "value": "Marco Rodriguez"},
    {"label": "Chef Julia Martinez", "value": "Chef Julia Martinez"},
    {"label": "Michael Kim", "value": "Michael Kim"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "All Time", "value": "All Time"},
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> trendingPosts = [
    {
      "id": 1,
      "title": "The Art of Minimalist Design: Less is Always More",
      "excerpt": "Exploring the principles of minimalist design and how simplicity creates powerful visual impact",
      "image": "https://picsum.photos/400/240?random=1&keyword=minimal",
      "author": "Sarah Mitchell",
      "authorAvatar": "https://picsum.photos/50/50?random=1&keyword=woman",
      "publishedAt": "2024-01-15T09:00:00Z",
      "readTime": 7,
      "category": "Design",
      "trendScore": 98,
      "views": 25600,
      "likes": 3400,
      "comments": 287,
      "isHot": true,
      "tags": ["Design", "Minimalism", "UI/UX", "Trends"],
    },
    {
      "id": 2,
      "title": "Sustainable Fashion: Building a Conscious Wardrobe",
      "excerpt": "How to create a stylish and environmentally responsible approach to fashion choices",
      "image": "https://picsum.photos/400/240?random=2&keyword=fashion",
      "author": "Emma Rodriguez",
      "authorAvatar": "https://picsum.photos/50/50?random=2&keyword=fashion",
      "publishedAt": "2024-01-14T14:30:00Z",
      "readTime": 9,
      "category": "Lifestyle",
      "trendScore": 94,
      "views": 18900,
      "likes": 2890,
      "comments": 156,
      "isHot": true,
      "tags": ["Fashion", "Sustainability", "Lifestyle", "Environment"],
    },
    {
      "id": 3,
      "title": "AI and Creativity: The Future of Human-Machine Collaboration",
      "excerpt": "Examining how artificial intelligence is transforming creative industries and human expression",
      "image": "https://picsum.photos/400/240?random=3&keyword=ai",
      "author": "Dr. Michael Chen",
      "authorAvatar": "https://picsum.photos/50/50?random=3&keyword=scientist",
      "publishedAt": "2024-01-14T11:00:00Z",
      "readTime": 11,
      "category": "Technology",
      "trendScore": 91,
      "views": 22100,
      "likes": 3150,
      "comments": 203,
      "isHot": false,
      "tags": ["AI", "Technology", "Creativity", "Innovation"],
    },
  ];

  List<Map<String, dynamic>> authorSpotlight = [
    {
      "name": "Sarah Mitchell",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "bio": "Design strategist and minimalism advocate",
      "postsCount": 24,
      "followersCount": 12500,
      "expertise": ["Design", "UI/UX", "Minimalism"],
      "isFollowing": false,
      "verifiedAuthor": true,
    },
    {
      "name": "Dr. Emma Chen",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=doctor",
      "bio": "Wellness expert and mindfulness coach",
      "postsCount": 18,
      "followersCount": 8900,
      "expertise": ["Health", "Wellness", "Mindfulness"],
      "isFollowing": true,
      "verifiedAuthor": true,
    },
    {
      "name": "Marco Rodriguez",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=traveler",
      "bio": "Travel photographer and cultural explorer",
      "postsCount": 31,
      "followersCount": 15600,
      "expertise": ["Travel", "Photography", "Culture"],
      "isFollowing": false,
      "verifiedAuthor": false,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {
      "name": "Technology",
      "icon": Icons.computer,
      "color": primaryColor,
      "postCount": 45,
      "latestPost": "2 hours ago",
    },
    {
      "name": "Lifestyle",
      "icon": Icons.self_improvement,
      "color": successColor,
      "postCount": 38,
      "latestPost": "4 hours ago",
    },
    {
      "name": "Travel",
      "icon": Icons.flight,
      "color": infoColor,
      "postCount": 29,
      "latestPost": "1 day ago",
    },
    {
      "name": "Food",
      "icon": Icons.restaurant,
      "color": warningColor,
      "postCount": 33,
      "latestPost": "6 hours ago",
    },
    {
      "name": "Health",
      "icon": Icons.favorite,
      "color": dangerColor,
      "postCount": 27,
      "latestPost": "3 hours ago",
    },
    {
      "name": "Business",
      "icon": Icons.business,
      "color": secondaryColor,
      "postCount": 22,
      "latestPost": "8 hours ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Blog Hub",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
        Tab(text: "Authors", icon: Icon(Icons.person)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
      ],
      tabChildren: [
        // Trending Tab
        SingleChildScrollView(
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
                      label: "Search trending posts...",
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

              // Author and Timeframe Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Author",
                      items: authors,
                      value: selectedAuthor,
                      onChanged: (value, label) {
                        selectedAuthor = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Timeframe",
                      items: timeframes,
                      value: selectedTimeframe,
                      onChanged: (value, label) {
                        selectedTimeframe = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Trending Only Toggle
              QSwitch(
                items: [
                  {
                    "label": "Show Only Hot Trending Posts",
                    "value": true,
                    "checked": showTrendingOnly,
                  }
                ],
                value: [
                  if (showTrendingOnly)
                    {
                      "label": "Show Only Hot Trending Posts",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  showTrendingOnly = values.isNotEmpty;
                  setState(() {});
                },
              ),

              // Trending Header
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: dangerColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Trending Posts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Updated 5min ago",
                      style: TextStyle(
                        color: dangerColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              // Trending Posts
              ...trendingPosts.where((post) => !showTrendingOnly || post["isHot"] == true).map((post) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
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
                              "${post["image"]}",
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (post["isHot"] == true)
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
                                    Icon(
                                      Icons.local_fire_department,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "HOT",
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
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(179),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["trendScore"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                Spacer(),
                                Text(
                                  "${post["readTime"]} min read",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${post["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                height: 1.3,
                              ),
                            ),
                            Text(
                              "${post["excerpt"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (post["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage("${post["authorAvatar"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${post["author"]}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        DateTime.parse("${post["publishedAt"]}").dMMMy,
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
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
                                      Icons.visibility,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${((post["views"] as int) / 1000).toStringAsFixed(1)}K",
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
                                      Icons.favorite,
                                      size: 16,
                                      color: dangerColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${((post["likes"] as int) / 1000).toStringAsFixed(1)}K",
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
                                      "${post["comments"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.share,
                                    size: 20,
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
              }).toList(),
            ],
          ),
        ),

        // Authors Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Featured Authors",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ...authorSpotlight.map((author) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage("${author["avatar"]}"),
                          ),
                          if (author["verifiedAuthor"] == true)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.verified,
                                  color: primaryColor,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${author["bio"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 13,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${author["postsCount"]} posts",
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
                                  "${((author["followersCount"] as int) / 1000).toStringAsFixed(1)}K followers",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: spXs,
                              children: (author["expertise"] as List).map((skill) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$skill",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        child: QButton(
                          label: author["isFollowing"] == true ? "Following" : "Follow",
                          size: bs.sm,
                          onPressed: () {
                            author["isFollowing"] = !(author["isFollowing"] as bool);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Categories Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Browse by Category",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: categories.map((category) {
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
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (category["color"] as Color).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                color: category["color"] as Color,
                                size: 24,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.arrow_forward,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${category["postCount"]} posts",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Latest: ${category["latestPost"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
