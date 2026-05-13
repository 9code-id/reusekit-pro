import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNews1View extends StatefulWidget {
  @override
  State<GrlNews1View> createState() => _GrlNews1ViewState();
}

class _GrlNews1ViewState extends State<GrlNews1View> {
  List<Map<String, dynamic>> newsArticles = [
    {
      "id": 1,
      "title": "Breakthrough in Quantum Computing: New Processor Achieves 1000-Qubit Milestone",
      "subtitle": "Revolutionary advancement promises to accelerate machine learning and cryptography",
      "content": "Scientists at TechLab have successfully developed a quantum processor capable of handling 1000 qubits, marking a significant leap forward in quantum computing technology. This achievement could revolutionize fields from drug discovery to financial modeling.",
      "author": "Dr. Sarah Chen",
      "authorAvatar": "https://picsum.photos/40/40?random=1&keyword=author",
      "category": "Technology",
      "source": "TechNews Daily",
      "publishedAt": "2024-12-15T08:30:00Z",
      "readTime": 5,
      "views": 45200,
      "likes": 892,
      "comments": 156,
      "shares": 234,
      "image": "https://picsum.photos/400/250?random=1&keyword=quantum",
      "tags": ["Quantum Computing", "Technology", "Innovation", "Science"],
      "isBreaking": true,
      "isPremium": false,
      "isBookmarked": false,
      "relatedArticles": [2, 3],
      "trending": true
    },
    {
      "id": 2,
      "title": "Global Climate Summit Reaches Historic Agreement on Carbon Neutrality",
      "subtitle": "195 countries commit to achieving net-zero emissions by 2050",
      "content": "World leaders have signed a landmark agreement at the Global Climate Summit, establishing binding commitments for carbon neutrality. The agreement includes specific targets for renewable energy adoption and funding for developing nations.",
      "author": "Michael Roberts",
      "authorAvatar": "https://picsum.photos/40/40?random=2&keyword=reporter",
      "category": "Environment",
      "source": "Global News Network",
      "publishedAt": "2024-12-15T06:15:00Z",
      "readTime": 8,
      "views": 78500,
      "likes": 1245,
      "comments": 389,
      "shares": 567,
      "image": "https://picsum.photos/400/250?random=2&keyword=climate",
      "tags": ["Climate Change", "Environment", "Politics", "Global"],
      "isBreaking": false,
      "isPremium": false,
      "isBookmarked": true,
      "relatedArticles": [4, 5],
      "trending": true
    },
    {
      "id": 3,
      "title": "Stock Market Soars to Record High as Tech Giants Report Strong Earnings",
      "subtitle": "Major technology companies exceed Q4 expectations driving market optimism",
      "content": "The stock market reached unprecedented levels today as major technology companies reported exceptional quarterly earnings. Analysts attribute the surge to strong performance in AI and cloud computing sectors.",
      "author": "Jennifer Walsh",
      "authorAvatar": "https://picsum.photos/40/40?random=3&keyword=finance",
      "category": "Business",
      "source": "Financial Times",
      "publishedAt": "2024-12-15T04:45:00Z",
      "readTime": 6,
      "views": 62300,
      "likes": 734,
      "comments": 278,
      "shares": 445,
      "image": "https://picsum.photos/400/250?random=3&keyword=stocks",
      "tags": ["Stock Market", "Business", "Technology", "Finance"],
      "isBreaking": false,
      "isPremium": true,
      "isBookmarked": false,
      "relatedArticles": [1, 6],
      "trending": false
    },
    {
      "id": 4,
      "title": "Revolutionary Cancer Treatment Shows 95% Success Rate in Clinical Trials",
      "subtitle": "New immunotherapy approach offers hope for previously untreatable cases",
      "content": "A groundbreaking cancer treatment using engineered immune cells has demonstrated remarkable success in clinical trials. The therapy shows particular promise for patients with advanced stages of the disease.",
      "author": "Dr. Emily Carter",
      "authorAvatar": "https://picsum.photos/40/40?random=4&keyword=doctor",
      "category": "Health",
      "source": "Medical Journal",
      "publishedAt": "2024-12-14T22:30:00Z",
      "readTime": 7,
      "views": 89200,
      "likes": 1876,
      "comments": 445,
      "shares": 892,
      "image": "https://picsum.photos/400/250?random=4&keyword=medical",
      "tags": ["Health", "Medicine", "Cancer", "Research"],
      "isBreaking": true,
      "isPremium": false,
      "isBookmarked": true,
      "relatedArticles": [7, 8],
      "trending": true
    },
    {
      "id": 5,
      "title": "Space Mission Successfully Lands on Mars, Begins Search for Extraterrestrial Life",
      "subtitle": "Rover deployment marks beginning of most ambitious exploration yet",
      "content": "The latest Mars mission has successfully deployed its advanced rover system, equipped with state-of-the-art instruments designed to detect signs of past or present microbial life on the Red Planet.",
      "author": "Dr. James Rodriguez",
      "authorAvatar": "https://picsum.photos/40/40?random=5&keyword=astronaut",
      "category": "Science",
      "source": "Space Agency News",
      "publishedAt": "2024-12-14T18:20:00Z",
      "readTime": 9,
      "views": 124000,
      "likes": 2156,
      "comments": 678,
      "shares": 1234,
      "image": "https://picsum.photos/400/250?random=5&keyword=mars",
      "tags": ["Space", "Mars", "Science", "Exploration"],
      "isBreaking": false,
      "isPremium": false,
      "isBookmarked": false,
      "relatedArticles": [9, 10],
      "trending": true
    }
  ];

  String selectedCategory = "All";
  String sortBy = "latest";
  bool showOnlyBookmarked = false;
  bool showOnlyTrending = false;

  List<String> categories = ["All", "Technology", "Environment", "Business", "Health", "Science"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest News"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Breaking News Banner
            if (_hasBreakingNews()) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [dangerColor, dangerColor.withAlpha(200)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flash_on, color: Colors.white),
                        SizedBox(width: spSm),
                        Text(
                          "BREAKING NEWS",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.live_tv, color: Colors.white, size: 16),
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
                    SizedBox(height: spSm),
                    Text(
                      _getLatestBreakingNews()["title"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: spSm),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Read more →",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
            ],

            // Filter Controls
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
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
                        child: QDropdownField(
                          label: "Sort By",
                          items: [
                            {"label": "Latest", "value": "latest"},
                            {"label": "Most Popular", "value": "popular"},
                            {"label": "Most Liked", "value": "likes"},
                            {"label": "Most Shared", "value": "shares"},
                          ],
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Bookmarked only",
                              "value": true,
                              "checked": showOnlyBookmarked,
                            }
                          ],
                          value: showOnlyBookmarked ? [{"label": "Bookmarked only", "value": true, "checked": true}] : [],
                          onChanged: (values, ids) {
                            showOnlyBookmarked = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Trending only",
                              "value": true,
                              "checked": showOnlyTrending,
                            }
                          ],
                          value: showOnlyTrending ? [{"label": "Trending only", "value": true, "checked": true}] : [],
                          onChanged: (values, ids) {
                            showOnlyTrending = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Category Highlights
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
                    children: [
                      Icon(Icons.trending_up, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Trending Topics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildTrendingTopics(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // News Articles
            ...newsArticles.map((article) => _buildNewsCard(article)),

            SizedBox(height: spMd),

            // Load More Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More Articles",
                size: bs.md,
                onPressed: () {
                  ss("Loading more articles...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> article) {
    bool isBookmarked = article["isBookmarked"] as bool;
    bool isBreaking = article["isBreaking"] as bool;
    bool isPremium = article["isPremium"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: isBreaking 
            ? Border.all(color: dangerColor, width: 2)
            : null,
      ),
      child: Column(
        children: [
          // Article Image
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
              
              // Article Badges
              Positioned(
                top: spMd,
                left: spMd,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(article["category"] as String),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${article["category"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isBreaking) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "BREAKING",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              if (isPremium)
                Positioned(
                  top: spMd,
                  right: spMd,
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
                        Icon(Icons.star, color: Colors.white, size: 12),
                        SizedBox(width: spXs),
                        Text(
                          "PREMIUM",
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

              // Read Time Indicator
              Positioned(
                bottom: spMd,
                left: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.schedule, color: Colors.white, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${article["readTime"]} min read",
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
            ],
          ),

          // Article Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Subtitle
                Text(
                  "${article["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${article["subtitle"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spMd),

                // Author and Time
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${article["authorAvatar"]}",
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${article["author"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${article["source"]} • ${_formatTime(article["publishedAt"] as String)}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        article["isBookmarked"] = !isBookmarked;
                        setState(() {});
                      },
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (article["tags"] as List).take(3).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
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
                SizedBox(height: spMd),

                // Engagement Stats
                Row(
                  children: [
                    _buildEngagementStat(Icons.visibility, "${_formatNumber(article["views"] as int)}", "views"),
                    SizedBox(width: spMd),
                    _buildEngagementStat(Icons.thumb_up, "${_formatNumber(article["likes"] as int)}", "likes"),
                    SizedBox(width: spMd),
                    _buildEngagementStat(Icons.comment, "${article["comments"]}", "comments"),
                    SizedBox(width: spMd),
                    _buildEngagementStat(Icons.share, "${article["shares"]}", "shares"),
                    Spacer(),
                    if (article["trending"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.trending_up, color: successColor, size: 12),
                            SizedBox(width: spXs),
                            Text(
                              "Trending",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spMd),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Read Article",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendingTopics() {
    Map<String, int> topicCounts = {};
    for (Map<String, dynamic> article in newsArticles) {
      for (String tag in article["tags"] as List) {
        topicCounts[tag] = (topicCounts[tag] ?? 0) + 1;
      }
    }
    
    List<String> trendingTopics = topicCounts.keys.take(6).toList();
    
    return Wrap(
      spacing: spSm,
      runSpacing: spSm,
      children: trendingTopics.map((topic) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: spMd,
            vertical: spSm,
          ),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: primaryColor.withAlpha(60)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.trending_up, color: primaryColor, size: 16),
              SizedBox(width: spSm),
              Text(
                topic,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${topicCounts[topic]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Technology":
        return primaryColor;
      case "Environment":
        return successColor;
      case "Business":
        return warningColor;
      case "Health":
        return dangerColor;
      case "Science":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  bool _hasBreakingNews() {
    return newsArticles.any((article) => article["isBreaking"] as bool);
  }

  Map<String, dynamic> _getLatestBreakingNews() {
    return newsArticles.firstWhere((article) => article["isBreaking"] as bool);
  }

  String _formatTime(String timestamp) {
    DateTime publishedAt = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(publishedAt);
    
    if (difference.inHours < 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return "${(number / 1000000).toStringAsFixed(1)}M";
    } else if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}K";
    } else {
      return number.toString();
    }
  }
}
