import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaHashtagsView extends StatefulWidget {
  const NmaHashtagsView({super.key});

  @override
  State<NmaHashtagsView> createState() => _NmaHashtagsViewState();
}

class _NmaHashtagsViewState extends State<NmaHashtagsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  List<String> trendingHashtags = [];
  List<String> myHashtags = [];
  bool isLoading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Trending", "value": "Trending"},
    {"label": "My Tags", "value": "My Tags"},
    {"label": "Popular", "value": "Popular"},
    {"label": "Recent", "value": "Recent"},
  ];

  List<Map<String, dynamic>> hashtagsData = [
    {
      "tag": "#SocialMediaMarketing",
      "posts": 125000,
      "engagement": 89.5,
      "category": "Marketing",
      "trending": true,
      "growth": 12.3,
    },
    {
      "tag": "#DigitalMarketing",
      "posts": 98000,
      "engagement": 76.8,
      "category": "Marketing",
      "trending": true,
      "growth": 8.7,
    },
    {
      "tag": "#ContentCreation",
      "posts": 87000,
      "engagement": 92.1,
      "category": "Content",
      "trending": false,
      "growth": 15.2,
    },
    {
      "tag": "#BrandAwareness",
      "posts": 76000,
      "engagement": 68.4,
      "category": "Branding",
      "trending": true,
      "growth": 5.9,
    },
    {
      "tag": "#InfluencerMarketing",
      "posts": 65000,
      "engagement": 84.2,
      "category": "Influencer",
      "trending": false,
      "growth": 22.1,
    },
    {
      "tag": "#VideoMarketing",
      "posts": 54000,
      "engagement": 95.7,
      "category": "Video",
      "trending": true,
      "growth": 18.6,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadHashtags();
  }

  void _loadHashtags() {
    isLoading = true;
    setState(() {});

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      trendingHashtags = hashtagsData
          .where((tag) => tag["trending"] == true)
          .map((tag) => tag["tag"] as String)
          .toList();
      
      myHashtags = hashtagsData
          .take(3)
          .map((tag) => tag["tag"] as String)
          .toList();

      isLoading = false;
      setState(() {});
    });
  }

  List<Map<String, dynamic>> get filteredHashtags {
    var filtered = hashtagsData;
    
    if (selectedCategory != "All") {
      if (selectedCategory == "Trending") {
        filtered = filtered.where((tag) => tag["trending"] == true).toList();
      } else if (selectedCategory == "My Tags") {
        filtered = filtered.take(3).toList();
      }
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((tag) => 
        (tag["tag"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (tag["category"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hashtags Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add hashtag
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search hashtags...",
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
                        onPressed: () {
                          // Perform search
                        },
                      ),
                    ],
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Filter by Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Quick Stats
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Total Tags",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${hashtagsData.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Trending",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${trendingHashtags.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "My Tags",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${myHashtags.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Hashtags List
                  Text(
                    "Hashtags",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredHashtags.length,
                    itemBuilder: (context, index) {
                      final hashtag = filteredHashtags[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${hashtag["tag"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          if (hashtag["trending"] == true)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: successColor.withAlpha(30),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "Trending",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: successColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Category: ${hashtag["category"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Show options
                                  },
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Posts",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${((hashtag["posts"] as int) / 1000).toStringAsFixed(0)}K",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Engagement",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(hashtag["engagement"] as double).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Growth",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "+${(hashtag["growth"] as double).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Use Hashtag",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Use hashtag
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.analytics,
                                  size: bs.sm,
                                  onPressed: () {
                                    // View analytics
                                  },
                                ),
                              ],
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
