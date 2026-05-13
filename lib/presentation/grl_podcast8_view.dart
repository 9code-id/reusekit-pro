import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPodcast8View extends StatefulWidget {
  @override
  State<GrlPodcast8View> createState() => _GrlPodcast8ViewState();
}

class _GrlPodcast8ViewState extends State<GrlPodcast8View> {
  List<Map<String, dynamic>> searchResults = [];
  String searchQuery = "";
  bool isSearching = false;
  String selectedCategory = "All";
  
  List<String> categories = ["All", "Technology", "Business", "Health", "Education", "Entertainment"];
  
  List<Map<String, dynamic>> trendingSearches = [
    {"query": "AI and Machine Learning", "count": 1250},
    {"query": "Digital Marketing", "count": 987},
    {"query": "Mental Health", "count": 756},
    {"query": "Startup Stories", "count": 623},
    {"query": "Cryptocurrency", "count": 584},
  ];

  List<Map<String, dynamic>> recentSearches = [
    {"query": "Tech News", "timestamp": "2 hours ago"},
    {"query": "Fitness Tips", "timestamp": "Yesterday"},
    {"query": "Business Strategy", "timestamp": "3 days ago"},
    {"query": "Creative Writing", "timestamp": "1 week ago"},
  ];

  List<Map<String, dynamic>> allPodcasts = [
    {
      "id": 1,
      "title": "Tech Innovations Weekly",
      "host": "Sarah Johnson",
      "description": "Latest technology trends and innovations",
      "category": "Technology",
      "episodes": 156,
      "rating": 4.8,
      "subscribers": 125000,
      "image": "https://picsum.photos/300/300?random=1&keyword=technology",
      "isSubscribed": false
    },
    {
      "id": 2,
      "title": "Business Mastery Hub",
      "host": "Michael Chen",
      "description": "Business strategies and success stories",
      "category": "Business",
      "episodes": 89,
      "rating": 4.6,
      "subscribers": 98000,
      "image": "https://picsum.photos/300/300?random=2&keyword=business",
      "isSubscribed": true
    },
    {
      "id": 3,
      "title": "Health & Wellness Guide",
      "host": "Dr. Emily Wilson",
      "description": "Tips for healthy living and wellness",
      "category": "Health",
      "episodes": 234,
      "rating": 4.9,
      "subscribers": 87000,
      "image": "https://picsum.photos/300/300?random=3&keyword=health",
      "isSubscribed": false
    },
    {
      "id": 4,
      "title": "Learning Edge",
      "host": "Prof. David Kim",
      "description": "Educational content and learning strategies",
      "category": "Education",
      "episodes": 167,
      "rating": 4.7,
      "subscribers": 76000,
      "image": "https://picsum.photos/300/300?random=4&keyword=education",
      "isSubscribed": true
    },
    {
      "id": 5,
      "title": "Entertainment Tonight",
      "host": "Lisa Anderson",
      "description": "Pop culture and entertainment news",
      "category": "Entertainment",
      "episodes": 312,
      "rating": 4.5,
      "subscribers": 156000,
      "image": "https://picsum.photos/300/300?random=5&keyword=entertainment",
      "isSubscribed": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Podcasts"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search podcasts, episodes, or hosts",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      _performSearch();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    _performSearch();
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Show search results if searching
            if (isSearching && searchQuery.isNotEmpty) ...[
              _buildSearchResults(),
            ] else ...[
              // Trending Searches
              Text(
                "Trending Searches",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: trendingSearches.map((search) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${search["query"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "${search["count"]} searches",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              searchQuery = search["query"];
                              _performSearch();
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: spLg),

              // Recent Searches
              if (recentSearches.isNotEmpty) ...[
                Text(
                  "Recent Searches",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: recentSearches.map((search) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Icon(
                              Icons.history,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${search["query"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${search["timestamp"]}",
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
                                searchQuery = search["query"];
                                _performSearch();
                              },
                              child: Icon(
                                Icons.north_west,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: spLg),
              ],

              // Popular Categories
              Text(
                "Browse by Category",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QCategoryPicker(
                items: categories.map((category) => {
                  "label": category,
                  "value": category,
                }).toList(),
                value: selectedCategory,
                onChanged: (index, label, value, item) {
                  selectedCategory = value;
                  _filterByCategory();
                },
              ),

              SizedBox(height: spLg),

              // Featured Podcasts
              Text(
                "Featured Podcasts",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Column(
                children: allPodcasts.take(3).map((podcast) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            image: DecorationImage(
                              image: NetworkImage("${podcast["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${podcast["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "by ${podcast["host"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${podcast["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${podcast["rating"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${podcast["episodes"]} episodes",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            QButton(
                              icon: podcast["isSubscribed"] == true ? Icons.check : Icons.add,
                              size: bs.sm,
                              onPressed: () {
                                podcast["isSubscribed"] = !podcast["isSubscribed"];
                                setState(() {});
                              },
                            ),
                            SizedBox(height: spXs),
                            QButton(
                              icon: Icons.play_arrow,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Search Results for \"$searchQuery\"",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        if (searchResults.isEmpty) ...[
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "No results found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Try different keywords or browse categories",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ] else ...[
          Column(
            children: searchResults.map((result) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${result["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${result["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${result["host"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.play_arrow,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  void _performSearch() {
    if (searchQuery.isEmpty) {
      isSearching = false;
      searchResults.clear();
      setState(() {});
      return;
    }

    isSearching = true;
    
    // Simulate search
    searchResults = allPodcasts.where((podcast) {
      return podcast["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
             podcast["host"].toLowerCase().contains(searchQuery.toLowerCase()) ||
             podcast["description"].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    
    setState(() {});
  }

  void _filterByCategory() {
    if (selectedCategory == "All") {
      searchResults = allPodcasts;
    } else {
      searchResults = allPodcasts.where((podcast) => 
        podcast["category"] == selectedCategory
      ).toList();
    }
    
    isSearching = true;
    searchQuery = "Category: $selectedCategory";
    setState(() {});
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Filter Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Filter by Category"),
              SizedBox(height: spSm),
              ...categories.map((category) {
                return RadioListTile<String>(
                  title: Text(category),
                  value: category,
                  groupValue: selectedCategory,
                  onChanged: (String? value) {
                    if (value != null) {
                      selectedCategory = value;
                      Navigator.of(context).pop();
                      _filterByCategory();
                    }
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
