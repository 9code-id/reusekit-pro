import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNews6View extends StatefulWidget {
  @override
  State<GrlNews6View> createState() => _GrlNews6ViewState();
}

class _GrlNews6ViewState extends State<GrlNews6View> {
  String searchQuery = "";
  String selectedSource = "All Sources";
  String sortBy = "Latest";
  bool showSavedOnly = false;
  int selectedTab = 0;

  List<Map<String, dynamic>> sources = [
    {"label": "All Sources", "value": "All Sources"},
    {"label": "BBC News", "value": "BBC"},
    {"label": "CNN", "value": "CNN"},
    {"label": "Reuters", "value": "Reuters"},
    {"label": "Associated Press", "value": "AP"},
    {"label": "The Guardian", "value": "Guardian"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Latest", "value": "Latest"},
    {"label": "Most Popular", "value": "Popular"},
    {"label": "Most Relevant", "value": "Relevant"},
    {"label": "Oldest First", "value": "Oldest"},
  ];

  List<Map<String, dynamic>> featuredArticles = [
    {
      "id": 1,
      "title": "Climate Change Summit Reaches Historic Agreement on Carbon Emissions",
      "subtitle": "Nations commit to 50% reduction by 2030",
      "content": "World leaders from over 190 countries have reached a groundbreaking agreement at the Global Climate Summit, committing to reduce carbon emissions by 50% within the next decade. The comprehensive plan includes massive investments in renewable energy infrastructure and strict regulations on industrial emissions.",
      "author": "Dr. Sarah Mitchell",
      "authorAvatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "source": "Environmental Times",
      "publishedAt": "2024-01-15T12:00:00Z",
      "readTime": 12,
      "category": "Environment",
      "image": "https://picsum.photos/600/300?random=1&keyword=climate",
      "views": 256000,
      "shares": 18500,
      "comments": 892,
      "isSaved": false,
      "isVerified": true,
      "tags": ["Climate Change", "Environment", "Policy", "Global"],
    },
    {
      "id": 2,
      "title": "Revolutionary Medical Breakthrough: AI Successfully Detects Cancer in Early Stages",
      "subtitle": "New technology shows 99.2% accuracy rate",
      "content": "Researchers at Johns Hopkins University have developed an artificial intelligence system that can detect various types of cancer in their earliest stages with unprecedented accuracy. The AI analyzes medical imaging data and can identify abnormalities that human doctors might miss.",
      "author": "Dr. Michael Chen",
      "authorAvatar": "https://picsum.photos/50/50?random=2&keyword=doctor",
      "source": "Medical Journal Today",
      "publishedAt": "2024-01-15T10:30:00Z",
      "readTime": 8,
      "category": "Health",
      "image": "https://picsum.photos/600/300?random=2&keyword=medical",
      "views": 189000,
      "shares": 12300,
      "comments": 654,
      "isSaved": true,
      "isVerified": true,
      "tags": ["AI", "Healthcare", "Cancer", "Technology"],
    },
  ];

  List<Map<String, dynamic>> regularNews = [
    {
      "id": 3,
      "title": "Global Stock Markets Rally Following Economic Data Release",
      "excerpt": "Major indices surge as inflation data shows positive trends",
      "author": "Jennifer Rodriguez",
      "source": "Financial Daily",
      "publishedAt": "2024-01-15T09:15:00Z",
      "readTime": 5,
      "category": "Finance",
      "image": "https://picsum.photos/150/100?random=3&keyword=finance",
      "isSaved": false,
      "isVerified": true,
    },
    {
      "id": 4,
      "title": "Space Mission Successfully Lands on Mars, Begins Scientific Research",
      "excerpt": "Historic achievement opens new chapter in space exploration",
      "author": "Dr. Robert Kim",
      "source": "Space Explorer",
      "publishedAt": "2024-01-15T08:45:00Z",
      "readTime": 7,
      "category": "Science",
      "image": "https://picsum.photos/150/100?random=4&keyword=mars",
      "isSaved": true,
      "isVerified": true,
    },
    {
      "id": 5,
      "title": "International Trade Agreement Boosts Economic Cooperation",
      "excerpt": "New partnership expected to create millions of jobs worldwide",
      "author": "Maria Santos",
      "source": "Global Economics",
      "publishedAt": "2024-01-15T07:20:00Z",
      "readTime": 6,
      "category": "Economics",
      "image": "https://picsum.photos/150/100?random=5&keyword=trade",
      "isSaved": false,
      "isVerified": false,
    },
    {
      "id": 6,
      "title": "Olympic Games Preparation Shows Remarkable Progress",
      "excerpt": "Infrastructure development ahead of schedule, officials report",
      "author": "David Park",
      "source": "Sports Weekly",
      "publishedAt": "2024-01-15T06:00:00Z",
      "readTime": 4,
      "category": "Sports",
      "image": "https://picsum.photos/150/100?random=6&keyword=olympics",
      "isSaved": false,
      "isVerified": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Feed"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
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
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: QTextField(
                    label: "Search news articles...",
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

            // Advanced Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Source",
                    items: sources,
                    value: selectedSource,
                    onChanged: (value, label) {
                      selectedSource = value;
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

            // Show Saved Only Toggle
            QSwitch(
              items: [
                {
                  "label": "Show Saved Articles Only",
                  "value": true,
                  "checked": showSavedOnly,
                }
              ],
              value: [
                if (showSavedOnly)
                  {
                    "label": "Show Saved Articles Only",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showSavedOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Featured Articles Header
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Featured Articles",
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
                    color: warningColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Editor's Choice",
                    style: TextStyle(
                      color: warningColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // Featured Articles
            ...featuredArticles.map((article) {
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
                            "${article["image"]}",
                            height: 220,
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
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${article["category"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (article["isVerified"] == true) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: GestureDetector(
                            onTap: () {
                              article["isSaved"] = !(article["isSaved"] as bool);
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(128),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                article["isSaved"] == true ? Icons.bookmark : Icons.bookmark_border,
                                color: Colors.white,
                                size: 18,
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
                          Text(
                            "${article["title"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              height: 1.3,
                            ),
                          ),
                          Text(
                            "${article["subtitle"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor,
                            ),
                          ),
                          Text(
                            "${article["content"]}",
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
                            children: (article["tags"] as List).map((tag) {
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
                                  "$tag",
                                  style: TextStyle(
                                    color: primaryColor,
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
                                radius: 16,
                                backgroundImage: NetworkImage("${article["authorAvatar"]}"),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${article["author"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${article["source"]} • ${DateTime.parse("${article["publishedAt"]}").dMMMy}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${article["readTime"]} min read",
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
                                    Icons.visibility,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${((article["views"] as int) / 1000).toStringAsFixed(0)}K",
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
                                    Icons.share,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${((article["shares"] as int) / 1000).toStringAsFixed(1)}K",
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
                                    "${article["comments"]}",
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
                                  Icons.more_horiz,
                                  color: disabledBoldColor,
                                  size: 20,
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

            // Regular News Section
            Row(
              children: [
                Icon(
                  Icons.article,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Latest News",
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

            // Regular News List
            ...regularNews.map((news) {
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
                        width: 100,
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
                                  color: infoColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${news["category"]}",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (news["isVerified"] == true) ...[
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.verified,
                                  color: successColor,
                                  size: 12,
                                ),
                              ],
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  news["isSaved"] = !(news["isSaved"] as bool);
                                  setState(() {});
                                },
                                child: Icon(
                                  news["isSaved"] == true ? Icons.bookmark : Icons.bookmark_border,
                                  size: 18,
                                  color: news["isSaved"] == true ? primaryColor : disabledBoldColor,
                                ),
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                "${news["author"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " • ",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                "${news["source"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                " • ",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                "${news["readTime"]} min",
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
          ],
        ),
      ),
    );
  }
}
