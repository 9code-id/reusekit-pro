import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNews2View extends StatefulWidget {
  const GrlNews2View({Key? key}) : super(key: key);

  @override
  State<GrlNews2View> createState() => _GrlNews2ViewState();
}

class _GrlNews2ViewState extends State<GrlNews2View> {
  int selectedTab = 0;
  String selectedCategory = "All";
  String selectedCountry = "All";
  String searchQuery = "";
  bool bookmarked = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Business", "value": "Business"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Health", "value": "Health"},
    {"label": "Science", "value": "Science"},
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "All", "value": "All"},
    {"label": "United States", "value": "US"},
    {"label": "United Kingdom", "value": "UK"},
    {"label": "Germany", "value": "DE"},
    {"label": "France", "value": "FR"},
    {"label": "Japan", "value": "JP"},
    {"label": "Australia", "value": "AU"},
  ];

  List<Map<String, dynamic>> newsData = [
    {
      "id": 1,
      "title": "Revolutionary AI Breakthrough Changes Everything",
      "summary": "Scientists announce major advancement in artificial intelligence that could reshape multiple industries within the next decade.",
      "category": "Technology",
      "country": "US",
      "source": "TechDaily",
      "publishedAt": "2024-01-15T10:30:00Z",
      "imageUrl": "https://picsum.photos/400/200?random=1&keyword=technology",
      "readTime": 5,
      "likes": 2847,
      "comments": 156,
      "shares": 892,
      "isBookmarked": false,
      "isLiked": false,
      "tags": ["AI", "Technology", "Innovation"],
      "author": "Dr. Sarah Chen",
      "trending": true,
    },
    {
      "id": 2,
      "title": "Global Markets React to New Economic Policy",
      "summary": "Stock markets worldwide show mixed reactions following the announcement of new international trade agreements and monetary policies.",
      "category": "Business",
      "country": "UK",
      "source": "Financial Times",
      "publishedAt": "2024-01-15T08:45:00Z",
      "imageUrl": "https://picsum.photos/400/200?random=2&keyword=business",
      "readTime": 7,
      "likes": 1923,
      "comments": 89,
      "shares": 534,
      "isBookmarked": false,
      "isLiked": false,
      "tags": ["Finance", "Markets", "Economy"],
      "author": "Michael Thompson",
      "trending": false,
    },
    {
      "id": 3,
      "title": "Championship Finals Break Viewership Records",
      "summary": "Historic sports event draws largest television audience in over a decade, with streaming numbers exceeding all expectations.",
      "category": "Sports",
      "country": "AU",
      "source": "Sports Network",
      "publishedAt": "2024-01-15T06:20:00Z",
      "imageUrl": "https://picsum.photos/400/200?random=3&keyword=sports",
      "readTime": 4,
      "likes": 5672,
      "comments": 423,
      "shares": 1234,
      "isBookmarked": false,
      "isLiked": false,
      "tags": ["Sports", "Championship", "Records"],
      "author": "Emma Rodriguez",
      "trending": true,
    },
    {
      "id": 4,
      "title": "New Health Study Reveals Surprising Benefits",
      "summary": "Long-term research study uncovers unexpected health benefits of common daily activities, challenging conventional wisdom.",
      "category": "Health",
      "country": "DE",
      "source": "Medical Journal",
      "publishedAt": "2024-01-15T05:15:00Z",
      "imageUrl": "https://picsum.photos/400/200?random=4&keyword=health",
      "readTime": 6,
      "likes": 3245,
      "comments": 267,
      "shares": 678,
      "isBookmarked": false,
      "isLiked": false,
      "tags": ["Health", "Research", "Wellness"],
      "author": "Prof. Hans Mueller",
      "trending": false,
    },
    {
      "id": 5,
      "title": "Climate Change Summit Reaches Historic Agreement",
      "summary": "World leaders unite in unprecedented climate action plan, setting ambitious targets for carbon reduction and renewable energy.",
      "category": "Science",
      "country": "FR",
      "source": "Environmental News",
      "publishedAt": "2024-01-15T04:00:00Z",
      "imageUrl": "https://picsum.photos/400/200?random=5&keyword=environment",
      "readTime": 8,
      "likes": 4356,
      "comments": 512,
      "shares": 1876,
      "isBookmarked": false,
      "isLiked": false,
      "tags": ["Climate", "Environment", "Policy"],
      "author": "Marie Dubois",
      "trending": true,
    },
    {
      "id": 6,
      "title": "Entertainment Industry Embraces New Technology",
      "summary": "Major studios announce adoption of cutting-edge production techniques, promising enhanced viewing experiences for audiences.",
      "category": "Entertainment",
      "country": "US",
      "source": "Hollywood Reporter",
      "publishedAt": "2024-01-15T02:30:00Z",
      "imageUrl": "https://picsum.photos/400/200?random=6&keyword=entertainment",
      "readTime": 5,
      "likes": 2134,
      "comments": 178,
      "shares": 445,
      "isBookmarked": false,
      "isLiked": false,
      "tags": ["Entertainment", "Technology", "Movies"],
      "author": "Jessica Park",
      "trending": false,
    },
  ];

  List<Map<String, dynamic>> get filteredNews {
    return newsData.where((article) {
      bool categoryMatch = selectedCategory == "All" || article["category"] == selectedCategory;
      bool countryMatch = selectedCountry == "All" || article["country"] == selectedCountry;
      bool searchMatch = searchQuery.isEmpty || 
        article["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        article["summary"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return categoryMatch && countryMatch && searchMatch;
    }).toList();
  }

  void _toggleBookmark(int articleId) {
    setState(() {
      int index = newsData.indexWhere((article) => article["id"] == articleId);
      if (index != -1) {
        newsData[index]["isBookmarked"] = !newsData[index]["isBookmarked"];
      }
    });
  }

  void _toggleLike(int articleId) {
    setState(() {
      int index = newsData.indexWhere((article) => article["id"] == articleId);
      if (index != -1) {
        newsData[index]["isLiked"] = !newsData[index]["isLiked"];
        if (newsData[index]["isLiked"]) {
          newsData[index]["likes"] = (newsData[index]["likes"] as int) + 1;
        } else {
          newsData[index]["likes"] = (newsData[index]["likes"] as int) - 1;
        }
      }
    });
  }

  Widget _buildNewsCard(Map<String, dynamic> article) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            child: Stack(
              children: [
                Image.network(
                  "${article["imageUrl"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: GestureDetector(
                    onTap: () => _toggleBookmark(article["id"]),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(128),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        article["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                if (article["trending"])
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "TRENDING",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
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
                // Category and Read Time
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${article["category"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${article["readTime"]} min read",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Title
                Text(
                  "${article["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                // Summary
                Text(
                  "${article["summary"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                // Author and Source
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: primaryColor.withAlpha(25),
                      child: Text(
                        "${article["author"]}".substring(0, 1),
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
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
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${article["source"]} • ${DateTime.parse(article["publishedAt"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Engagement Stats
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleLike(article["id"]),
                      child: Row(
                        children: [
                          Icon(
                            article["isLiked"] ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: article["isLiked"] ? dangerColor : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${article["likes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(width: spMd),
                    
                    Row(
                      children: [
                        Icon(Icons.comment_outlined, size: 18, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${article["comments"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(width: spMd),
                    
                    Row(
                      children: [
                        Icon(Icons.share_outlined, size: 18, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${article["shares"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Spacer(),
                    
                    QButton(
                      label: "Read More",
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

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filters & Search",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Search Bar
          QTextField(
            label: "Search news...",
            value: searchQuery,
            hint: "Enter keywords, topics, or author names",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Category and Country Filters
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
              
              SizedBox(width: spMd),
              
              Expanded(
                child: QDropdownField(
                  label: "Country",
                  items: countries,
                  value: selectedCountry,
                  onChanged: (value, label) {
                    selectedCountry = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Quick Filters
          Text(
            "Quick Filters",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          
          SizedBox(height: spSm),
          
          QHorizontalScroll(
            children: [
              _buildQuickFilter("All", selectedCategory == "All"),
              _buildQuickFilter("Trending", false),
              _buildQuickFilter("Technology", selectedCategory == "Technology"),
              _buildQuickFilter("Business", selectedCategory == "Business"),
              _buildQuickFilter("Sports", selectedCategory == "Sports"),
              _buildQuickFilter("Health", selectedCategory == "Health"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (label == "Trending") {
          // Filter trending articles
        } else {
          selectedCategory = label;
          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        margin: EdgeInsets.only(right: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "${filteredNews.length}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Articles",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          
          Expanded(
            child: Column(
              children: [
                Text(
                  "${newsData.where((a) => a["trending"]).length}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Trending",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          
          Expanded(
            child: Column(
              children: [
                Text(
                  "${newsData.where((a) => a["isBookmarked"]).length}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Bookmarked",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Hub"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Header
            _buildStatsHeader(),
            
            // Filters Section
            _buildFiltersSection(),
            
            // Results Header
            Row(
              children: [
                Text(
                  "Latest News",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredNews.length} articles found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // News List
            if (filteredNews.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No articles found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or search terms",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ...filteredNews.map((article) => _buildNewsCard(article)).toList(),
          ],
        ),
      ),
    );
  }
}
