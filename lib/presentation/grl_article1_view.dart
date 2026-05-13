import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle1View extends StatefulWidget {
  const GrlArticle1View({super.key});

  @override
  State<GrlArticle1View> createState() => _GrlArticle1ViewState();
}

class _GrlArticle1ViewState extends State<GrlArticle1View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Latest";

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Science", "value": "Science"},
    {"label": "Health", "value": "Health"},
    {"label": "Business", "value": "Business"},
    {"label": "Education", "value": "Education"},
  ];

  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Latest", "value": "Latest"},
    {"label": "Most Popular", "value": "Most Popular"},
    {"label": "Most Discussed", "value": "Most Discussed"},
    {"label": "Trending", "value": "Trending"},
  ];

  final List<Map<String, dynamic>> featuredArticles = [
    {
      "id": 1,
      "title": "Breakthrough in Quantum Computing: IBM's Latest 1000-Qubit Processor",
      "excerpt": "IBM has announced a revolutionary advancement in quantum computing with their new 1000-qubit processor, marking a significant milestone in the race towards quantum supremacy.",
      "content": "The quantum computing landscape has been dramatically transformed with IBM's latest announcement...",
      "author": "Dr. Elena Vasquez",
      "authorImage": "https://picsum.photos/50/50?random=1&keyword=scientist",
      "category": "Technology",
      "publishedAt": "2024-01-22T09:00:00Z",
      "readTime": 12,
      "image": "https://picsum.photos/800/400?random=1&keyword=quantum",
      "views": 89400,
      "likes": 2340,
      "comments": 456,
      "shares": 789,
      "tags": ["Quantum Computing", "IBM", "Technology", "Science"],
      "featured": true,
      "premium": false,
    },
    {
      "id": 2,
      "title": "Gene Therapy Success: First Cure for Inherited Blindness Approved",
      "excerpt": "Groundbreaking gene therapy treatment has been approved by the FDA, offering hope to patients with Leber congenital amaurosis, a rare inherited form of blindness.",
      "content": "Medical science has achieved another remarkable milestone with the approval...",
      "author": "Dr. Michael Chen",
      "authorImage": "https://picsum.photos/50/50?random=2&keyword=doctor",
      "category": "Health",
      "publishedAt": "2024-01-21T14:30:00Z",
      "readTime": 10,
      "image": "https://picsum.photos/800/400?random=2&keyword=medical",
      "views": 67800,
      "likes": 1890,
      "comments": 234,
      "shares": 567,
      "tags": ["Gene Therapy", "Medical", "FDA", "Healthcare"],
      "featured": true,
      "premium": true,
    },
    {
      "id": 3,
      "title": "Climate Change: New Carbon Capture Technology Removes 1 Million Tons CO2",
      "excerpt": "A revolutionary direct air capture facility in Iceland has successfully removed one million tons of CO2 from the atmosphere, setting a new benchmark for climate technology.",
      "content": "In the fight against climate change, a significant victory has been achieved...",
      "author": "Dr. Sarah Johnson",
      "authorImage": "https://picsum.photos/50/50?random=3&keyword=environment",
      "category": "Science",
      "publishedAt": "2024-01-20T11:15:00Z",
      "readTime": 8,
      "image": "https://picsum.photos/800/400?random=3&keyword=climate",
      "views": 124500,
      "likes": 3456,
      "comments": 678,
      "shares": 1234,
      "tags": ["Climate Change", "Carbon Capture", "Environment", "Technology"],
      "featured": true,
      "premium": false,
    },
  ];

  final List<Map<String, dynamic>> articles = [
    {
      "id": 4,
      "title": "SpaceX Starship Successfully Completes First Orbital Refueling Test",
      "excerpt": "SpaceX has achieved a major milestone in space exploration with the successful demonstration of orbital refueling technology.",
      "author": "James Rodriguez",
      "authorImage": "https://picsum.photos/50/50?random=4&keyword=space",
      "category": "Technology",
      "publishedAt": "2024-01-19T16:45:00Z",
      "readTime": 6,
      "image": "https://picsum.photos/600/300?random=4&keyword=spacex",
      "views": 45600,
      "likes": 1234,
      "comments": 189,
      "shares": 345,
      "tags": ["SpaceX", "Space Exploration", "Technology"],
      "featured": false,
      "premium": false,
    },
    {
      "id": 5,
      "title": "Revolutionary Brain-Computer Interface Helps Paralyzed Patients Type",
      "excerpt": "Stanford researchers have developed a brain-computer interface that allows paralyzed patients to type at 90 words per minute using only their thoughts.",
      "author": "Dr. Lisa Park",
      "authorImage": "https://picsum.photos/50/50?random=5&keyword=neuroscience",
      "category": "Health",
      "publishedAt": "2024-01-18T13:20:00Z",
      "readTime": 9,
      "image": "https://picsum.photos/600/300?random=5&keyword=brain",
      "views": 78900,
      "likes": 2100,
      "comments": 345,
      "shares": 567,
      "tags": ["Brain-Computer Interface", "Medical Technology", "Stanford"],
      "featured": false,
      "premium": true,
    },
    {
      "id": 6,
      "title": "Renewable Energy Milestone: Solar Power Reaches Grid Parity Globally",
      "excerpt": "Solar energy has officially reached cost parity with fossil fuels in all major markets worldwide, marking a historic transition point.",
      "author": "Emma Thompson",
      "authorImage": "https://picsum.photos/50/50?random=6&keyword=energy",
      "category": "Science",
      "publishedAt": "2024-01-17T10:30:00Z",
      "readTime": 7,
      "image": "https://picsum.photos/600/300?random=6&keyword=solar",
      "views": 92300,
      "likes": 2890,
      "comments": 456,
      "shares": 789,
      "tags": ["Renewable Energy", "Solar Power", "Environment"],
      "featured": false,
      "premium": false,
    },
  ];

  final List<Map<String, dynamic>> trendingTopics = [
    {"name": "Artificial Intelligence", "articles": 342, "trending": true},
    {"name": "Climate Technology", "articles": 198, "trending": true},
    {"name": "Space Exploration", "articles": 167, "trending": false},
    {"name": "Medical Breakthroughs", "articles": 245, "trending": true},
    {"name": "Quantum Computing", "articles": 89, "trending": false},
  ];

  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> allArticles = [...featuredArticles, ...articles];
    return allArticles.where((article) {
      final matchesSearch = searchQuery.isEmpty ||
          "${article["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${article["excerpt"]}".toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || article["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Articles"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, infoColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Scientific Research Hub",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Latest breakthroughs and discoveries from leading researchers worldwide",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "2,847",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Articles",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "892",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Researchers",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "156K",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Citations",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search articles, authors, topics...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            SizedBox(height: spSm),

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

            SizedBox(height: spMd),

            // Trending Topics
            Text(
              "Trending Research Topics",
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
              children: trendingTopics.map((topic) {
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
                        Icon(Icons.trending_up, size: 12, color: successColor),
                        SizedBox(width: spXs),
                      ],
                      Text(
                        "${topic["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: topic["trending"] == true ? primaryColor : disabledBoldColor,
                          fontWeight: topic["trending"] == true ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "(${topic["articles"]})",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Featured Articles
            Text(
              "Featured Research",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QHorizontalScroll(
              children: featuredArticles.map((article) {
                return Container(
                  width: 350,
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
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                            child: Image.network(
                              "${article["image"]}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, size: 12, color: Colors.white),
                                  SizedBox(width: spXs),
                                  Text(
                                    "FEATURED",
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
                          if (article["premium"] == true)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(Icons.workspace_premium, size: 12, color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${article["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${article["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${article["excerpt"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage("${article["authorImage"]}"),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${article["author"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${article["readTime"]} min",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.visibility, size: 12, color: infoColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${((article["views"] as int) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.favorite, size: 12, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${article["likes"]}",
                                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                                    ),
                                  ],
                                ),
                                Icon(Icons.bookmark_border, size: 16, color: disabledBoldColor),
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

            SizedBox(height: spMd),

            // All Articles
            Text(
              "Latest Articles (${filteredArticles.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: filteredArticles.map((article) {
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
                          "${article["image"]}",
                          height: 180,
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
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${article["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (article["featured"] == true)
                                  Icon(Icons.star, size: 16, color: warningColor),
                                if (article["premium"] == true)
                                  Icon(Icons.workspace_premium, size: 16, color: successColor),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${article["title"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${article["excerpt"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Wrap(
                              spacing: spXs,
                              children: (article["tags"] as List).take(3).map<Widget>((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage("${article["authorImage"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${article["author"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Published ${article["readTime"]} min read",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.visibility, size: 16, color: infoColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${((article["views"] as int) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                    ),
                                    SizedBox(width: spMd),
                                    Icon(Icons.favorite, size: 16, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${article["likes"]}",
                                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                    ),
                                    SizedBox(width: spMd),
                                    Icon(Icons.share, size: 16, color: primaryColor),
                                  ],
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
