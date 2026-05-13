import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaMedicalNewsView extends StatefulWidget {
  const HcaMedicalNewsView({super.key});

  @override
  State<HcaMedicalNewsView> createState() => _HcaMedicalNewsViewState();
}

class _HcaMedicalNewsViewState extends State<HcaMedicalNewsView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Research", "value": "Research"},
    {"label": "Treatment", "value": "Treatment"},
    {"label": "Prevention", "value": "Prevention"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Public Health", "value": "Public Health"},
  ];

  List<Map<String, dynamic>> latestNews = [
    {
      "id": 1,
      "title": "New Breakthrough in Alzheimer's Treatment Shows Promise",
      "category": "Research",
      "source": "Medical Journal Today",
      "author": "Dr. Sarah Chen",
      "publishDate": "2024-01-15",
      "readTime": "4 min read",
      "image": "https://picsum.photos/400/250?random=1&keyword=medical",
      "summary": "Revolutionary drug trial shows 60% reduction in cognitive decline in early-stage Alzheimer's patients.",
      "views": 24500,
      "likes": 1820,
      "shares": 540,
      "bookmarked": false,
      "trending": true,
      "importance": "High",
      "tags": ["Alzheimer's", "Drug Trial", "Breakthrough"],
    },
    {
      "id": 2,
      "title": "AI-Powered Diagnostic Tool Detects Cancer 5 Years Earlier",
      "category": "Technology",
      "source": "Health Tech News",
      "author": "Jennifer Rodriguez",
      "publishDate": "2024-01-14",
      "readTime": "6 min read",
      "image": "https://picsum.photos/400/250?random=2&keyword=technology",
      "summary": "Machine learning algorithm analyzes blood samples to identify cancer markers years before symptoms appear.",
      "views": 18700,
      "likes": 1250,
      "shares": 380,
      "bookmarked": true,
      "trending": true,
      "importance": "High",
      "tags": ["AI", "Cancer Detection", "Early Diagnosis"],
    },
    {
      "id": 3,
      "title": "Heart Disease Prevention: New Guidelines Released",
      "category": "Prevention",
      "source": "Cardiology Today",
      "author": "Dr. Michael Thompson",
      "publishDate": "2024-01-13",
      "readTime": "5 min read",
      "image": "https://picsum.photos/400/250?random=3&keyword=heart",
      "summary": "Updated recommendations emphasize lifestyle changes and early screening for cardiovascular health.",
      "views": 15300,
      "likes": 920,
      "shares": 275,
      "bookmarked": false,
      "trending": false,
      "importance": "Medium",
      "tags": ["Heart Disease", "Prevention", "Guidelines"],
    },
    {
      "id": 4,
      "title": "Gene Therapy Success in Treating Rare Blood Disorders",
      "category": "Treatment",
      "source": "Nature Medicine",
      "author": "Dr. Lisa Park",
      "publishDate": "2024-01-12",
      "readTime": "7 min read",
      "image": "https://picsum.photos/400/250?random=4&keyword=genes",
      "summary": "Clinical trial shows 90% success rate in treating sickle cell disease using CRISPR gene editing.",
      "views": 12800,
      "likes": 750,
      "shares": 190,
      "bookmarked": false,
      "trending": false,
      "importance": "High",
      "tags": ["Gene Therapy", "CRISPR", "Blood Disorders"],
    },
    {
      "id": 5,
      "title": "Mental Health Apps Show Significant Benefits in New Study",
      "category": "Technology",
      "source": "Digital Health Review",
      "author": "Amanda Wilson",
      "publishDate": "2024-01-11",
      "readTime": "3 min read",
      "image": "https://picsum.photos/400/250?random=5&keyword=mental",
      "summary": "Research finds that meditation and therapy apps reduce anxiety and depression symptoms by 40%.",
      "views": 9650,
      "likes": 580,
      "shares": 145,
      "bookmarked": true,
      "trending": false,
      "importance": "Medium",
      "tags": ["Mental Health", "Apps", "Digital Therapy"],
    },
  ];

  List<Map<String, dynamic>> featuredStories = [
    {
      "id": 1,
      "title": "The Future of Personalized Medicine",
      "category": "Research",
      "author": "Dr. Elena Vasquez",
      "publishDate": "2024-01-10",
      "readTime": "12 min read",
      "image": "https://picsum.photos/600/300?random=6&keyword=medicine",
      "summary": "Exploring how genetic profiling and AI are revolutionizing treatment approaches for individual patients.",
      "featured": true,
      "views": 35600,
      "likes": 2840,
      "bookmarked": false,
    },
    {
      "id": 2,
      "title": "Global Health Initiative Tackles Infectious Diseases",
      "category": "Public Health",
      "author": "Dr. Robert Kim",
      "publishDate": "2024-01-09",
      "readTime": "8 min read",
      "image": "https://picsum.photos/600/300?random=7&keyword=global",
      "summary": "International collaboration aims to prevent the next pandemic through improved surveillance and response systems.",
      "featured": true,
      "views": 28900,
      "likes": 1950,
      "bookmarked": true,
    },
  ];

  List<Map<String, dynamic>> breakingNews = [
    {
      "id": 1,
      "title": "FDA Approves First Treatment for Rare Childhood Disease",
      "timestamp": "2 hours ago",
      "source": "FDA News",
      "urgent": true,
    },
    {
      "id": 2,
      "title": "Major Hospital Chain Adopts New AI Diagnostic System",
      "timestamp": "4 hours ago",
      "source": "Healthcare IT News",
      "urgent": false,
    },
    {
      "id": 3,
      "title": "WHO Issues New Guidelines for Pandemic Preparedness",
      "timestamp": "6 hours ago",
      "source": "World Health Organization",
      "urgent": true,
    },
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {"topic": "Alzheimer's Research", "count": 1520, "growth": "+15%"},
    {"topic": "AI in Healthcare", "count": 1240, "growth": "+28%"},
    {"topic": "Gene Therapy", "count": 980, "growth": "+12%"},
    {"topic": "Mental Health", "count": 750, "growth": "+8%"},
    {"topic": "Cancer Prevention", "count": 640, "growth": "+5%"},
  ];

  List<Map<String, dynamic>> filteredNews = [];

  @override
  void initState() {
    super.initState();
    _filterNews();
  }

  void _filterNews() {
    filteredNews = latestNews.where((news) {
      bool matchesCategory = selectedCategory == "All" || news["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
        news["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        news["summary"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        (news["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Medical News",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Latest", icon: Icon(Icons.fiber_new)),
        Tab(text: "Featured", icon: Icon(Icons.star)),
        Tab(text: "Breaking", icon: Icon(Icons.flash_on)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildLatestTab(),
        _buildFeaturedTab(),
        _buildBreakingTab(),
        _buildTrendingTab(),
      ],
    );
  }

  Widget _buildLatestTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search news...",
                  value: searchQuery,
                  hint: "Search by title, content, or tags",
                  onChanged: (value) {
                    searchQuery = value;
                    _filterNews();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              _filterNews();
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "Articles",
                  "${filteredNews.length}",
                  "Found articles",
                  primaryColor,
                  Icons.article,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "Trending",
                  "${filteredNews.where((n) => n["trending"] as bool).length}",
                  "Hot topics",
                  dangerColor,
                  Icons.trending_up,
                ),
              ),
            ],
          ),
          ...filteredNews.map((news) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  child: Stack(
                    children: [
                      Image.network(
                        "${news["image"]}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      if (news["trending"] as bool) ...[
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.trending_up, color: Colors.white, size: 12),
                                SizedBox(width: 2),
                                Text(
                                  "Trending",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      if (news["importance"] == "High") ...[
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "Important",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${news["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${news["publishDate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${news["title"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "by ${news["author"]} • ${news["source"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${news["summary"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (news["tags"] as List).map((tag) => Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "$tag",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )).toList(),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${news["readTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${(news["views"] as int) ~/ 1000}K",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => _toggleLike(news),
                                child: Row(
                                  children: [
                                    Icon(Icons.thumb_up, size: 16, color: successColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${(news["likes"] as int)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () => _shareNews(news),
                                child: Row(
                                  children: [
                                    Icon(Icons.share, size: 16, color: infoColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${(news["shares"] as int)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () => _toggleBookmark(news),
                                child: Icon(
                                  (news["bookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                  color: (news["bookmarked"] as bool) ? warningColor : disabledBoldColor,
                                  size: 16,
                                ),
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
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildFeaturedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "Featured",
                  "${featuredStories.length}",
                  "Premium stories",
                  primaryColor,
                  Icons.star,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "Views",
                  "${((featuredStories.fold(0, (sum, story) => sum + (story["views"] as int))) / 1000).toInt()}K",
                  "Total views",
                  successColor,
                  Icons.visibility,
                ),
              ),
            ],
          ),
          ...featuredStories.map((story) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  child: Stack(
                    children: [
                      Image.network(
                        "${story["image"]}",
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text(
                                "Featured Story",
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
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${story["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${story["title"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "by ${story["author"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${story["summary"]}",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${story["readTime"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${story["publishDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.visibility, size: 16, color: successColor),
                              SizedBox(width: 4),
                              Text(
                                "${(story["views"] as int) ~/ 1000}K",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Read Full Story",
                              size: bs.md,
                              onPressed: () => _readStory(story),
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () => _toggleBookmark(story),
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (story["bookmarked"] as bool) ? warningColor.withAlpha(20) : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: (story["bookmarked"] as bool) ? warningColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Icon(
                                (story["bookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                color: (story["bookmarked"] as bool) ? warningColor : disabledBoldColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildBreakingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "Breaking",
                  "${breakingNews.length}",
                  "Active alerts",
                  dangerColor,
                  Icons.flash_on,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "Urgent",
                  "${breakingNews.where((n) => n["urgent"] as bool).length}",
                  "High priority",
                  warningColor,
                  Icons.warning,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.flash_on, color: dangerColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Breaking News Updates",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ),
                Text(
                  "Live",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ...breakingNews.map((news) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: (news["urgent"] as bool) ? dangerColor : warningColor,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: (news["urgent"] as bool) ? dangerColor : warningColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        (news["urgent"] as bool) ? "URGENT" : "UPDATE",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${news["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${news["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Source: ${news["source"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          )).toList(),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View All Breaking News",
              size: bs.md,
              onPressed: () => _viewAllBreaking(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildQuickStatCard(
                  "Topics",
                  "${trendingTopics.length}",
                  "Trending now",
                  primaryColor,
                  Icons.trending_up,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard(
                  "Total",
                  "${(trendingTopics.fold(0, (sum, topic) => sum + (topic["count"] as int)) / 1000).toInt()}K",
                  "Total mentions",
                  successColor,
                  Icons.forum,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.trending_up, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Trending Topics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...trendingTopics.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> topic = entry.value;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _getTrendingColor(index),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${topic["topic"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${topic["count"]} mentions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${topic["growth"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          Container(
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
                  "Related Articles",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...latestNews.where((news) => news["trending"] as bool).take(3).map((news) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: dangerColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${news["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.trending_up, color: dangerColor, size: 12),
                                SizedBox(width: 4),
                                Text(
                                  "${(news["views"] as int) ~/ 1000}K views",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTrendingColor(int index) {
    switch (index) {
      case 0:
        return dangerColor;
      case 1:
        return warningColor;
      case 2:
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _toggleLike(Map<String, dynamic> news) {
    news["likes"] = (news["likes"] as int) + 1;
    setState(() {});
  }

  void _shareNews(Map<String, dynamic> news) {
    news["shares"] = (news["shares"] as int) + 1;
    setState(() {});
    si("News shared successfully");
  }

  void _toggleBookmark(Map<String, dynamic> item) {
    item["bookmarked"] = !(item["bookmarked"] as bool);
    setState(() {});
    String message = (item["bookmarked"] as bool) ? "Article bookmarked" : "Bookmark removed";
    si(message);
  }

  void _readStory(Map<String, dynamic> story) {
    // Navigate to full story
  }

  void _viewAllBreaking() {
    // Navigate to breaking news page
  }
}
