import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog5View extends StatefulWidget {
  const GrlBlog5View({super.key});

  @override
  State<GrlBlog5View> createState() => _GrlBlog5ViewState();
}

class _GrlBlog5ViewState extends State<GrlBlog5View> {
  String selectedTag = "All";
  String sortBy = "Latest";
  
  final List<Map<String, dynamic>> tags = [
    {"label": "All", "value": "All"},
    {"label": "Tech", "value": "Tech"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Startups", "value": "Startups"},
    {"label": "AI", "value": "AI"},
  ];

  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Latest", "value": "Latest"},
    {"label": "Popular", "value": "Popular"},
    {"label": "Most Viewed", "value": "Most Viewed"},
    {"label": "Most Liked", "value": "Most Liked"},
  ];

  final List<Map<String, dynamic>> trendingTopics = [
    {"name": "Artificial Intelligence", "posts": 156, "growth": 23.5},
    {"name": "Blockchain Technology", "posts": 89, "growth": 18.2},
    {"name": "Remote Work Culture", "posts": 134, "growth": 15.8},
    {"name": "Sustainable Business", "posts": 76, "growth": 12.4},
    {"name": "Digital Marketing", "posts": 203, "growth": 9.6},
  ];

  final List<Map<String, dynamic>> blogPosts = [
    {
      "id": 1,
      "title": "10 Essential AI Tools Every Developer Should Know",
      "excerpt": "Discover the most powerful AI development tools that are transforming how we build software.",
      "author": "Alex Rodriguez",
      "authorImage": "https://picsum.photos/40/40?random=1&keyword=person",
      "category": "Technology",
      "tags": ["AI", "Development", "Tools"],
      "readTime": 7,
      "publishedDate": "2024-01-20",
      "image": "https://picsum.photos/400/200?random=1&keyword=ai",
      "views": 25400,
      "likes": 892,
      "comments": 156,
      "shares": 234,
      "rating": 4.8,
      "featured": true,
    },
    {
      "id": 2,
      "title": "Building a Successful SaaS Startup in 2024",
      "excerpt": "Complete guide to launching and scaling your software-as-a-service business from idea to IPO.",
      "author": "Sarah Kim",
      "authorImage": "https://picsum.photos/40/40?random=2&keyword=woman",
      "category": "Business",
      "tags": ["Startups", "SaaS", "Business"],
      "readTime": 12,
      "publishedDate": "2024-01-18",
      "image": "https://picsum.photos/400/200?random=2&keyword=startup",
      "views": 18900,
      "likes": 567,
      "comments": 89,
      "shares": 178,
      "rating": 4.6,
      "featured": false,
    },
    {
      "id": 3,
      "title": "The Future of Decentralized Finance (DeFi)",
      "excerpt": "Exploring how blockchain technology is revolutionizing traditional financial systems.",
      "author": "Michael Chen",
      "authorImage": "https://picsum.photos/40/40?random=3&keyword=man",
      "category": "Finance",
      "tags": ["Blockchain", "Finance", "DeFi"],
      "readTime": 9,
      "publishedDate": "2024-01-16",
      "image": "https://picsum.photos/400/200?random=3&keyword=blockchain",
      "views": 14200,
      "likes": 423,
      "comments": 67,
      "shares": 145,
      "rating": 4.5,
      "featured": true,
    },
    {
      "id": 4,
      "title": "Growth Hacking Strategies That Actually Work",
      "excerpt": "Data-driven marketing techniques that helped 100+ startups achieve explosive growth.",
      "author": "Emma Thompson",
      "authorImage": "https://picsum.photos/40/40?random=4&keyword=woman",
      "category": "Marketing",
      "tags": ["Marketing", "Growth", "Startups"],
      "readTime": 8,
      "publishedDate": "2024-01-14",
      "image": "https://picsum.photos/400/200?random=4&keyword=marketing",
      "views": 22100,
      "likes": 745,
      "comments": 134,
      "shares": 289,
      "rating": 4.7,
      "featured": false,
    },
    {
      "id": 5,
      "title": "Machine Learning in Healthcare: Real-World Applications",
      "excerpt": "How AI is transforming patient care, drug discovery, and medical diagnostics.",
      "author": "Dr. James Wilson",
      "authorImage": "https://picsum.photos/40/40?random=5&keyword=doctor",
      "category": "Healthcare",
      "tags": ["AI", "Healthcare", "ML"],
      "readTime": 11,
      "publishedDate": "2024-01-12",
      "image": "https://picsum.photos/400/200?random=5&keyword=medical",
      "views": 16800,
      "likes": 512,
      "comments": 78,
      "shares": 167,
      "rating": 4.9,
      "featured": true,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    return blogPosts.where((post) {
      final tags = post["tags"] as List;
      return selectedTag == "All" || tags.contains(selectedTag);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tech Blog"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
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
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tech Insights Hub",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Stay ahead with the latest technology trends and insights",
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
                              "1,240",
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
                              "52.8K",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Readers",
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
                              "98.5%",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Satisfaction",
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
            
            // Trending Topics
            Text(
              "Trending Topics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: trendingTopics.map((topic) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(color: primaryColor.withAlpha(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.trending_up, color: successColor, size: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "+${(topic["growth"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${topic["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${topic["posts"]} articles",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Tag",
                    items: tags,
                    value: selectedTag,
                    onChanged: (value, label) {
                      selectedTag = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
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
            
            // Featured Posts
            Text(
              "Featured Articles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: blogPosts.where((post) => post["featured"] == true).map((post) {
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
                              "${post["image"]}",
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
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, size: 12, color: warningColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(post["rating"] as num).toStringAsFixed(1)}",
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
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: (post["tags"] as List).map<Widget>((tag) {
                                return Container(
                                  margin: EdgeInsets.only(right: spXs),
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
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
                            SizedBox(height: spSm),
                            Text(
                              "${post["title"]}",
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
                              "${post["excerpt"]}",
                              style: TextStyle(
                                fontSize: 14,
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
                                  backgroundImage: NetworkImage("${post["authorImage"]}"),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${post["author"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${post["readTime"]} min read",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.visibility, size: 12, color: infoColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${((post["views"] as int) / 1000).toStringAsFixed(1)}K",
                                          style: TextStyle(fontSize: 10, color: disabledBoldColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Icon(Icons.favorite, size: 12, color: dangerColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${post["likes"]}",
                                          style: TextStyle(fontSize: 10, color: disabledBoldColor),
                                        ),
                                      ],
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
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // All Posts
            Text(
              "Latest Articles (${filteredPosts.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: filteredPosts.map((post) {
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
                          "${post["image"]}",
                          height: 200,
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
                              children: (post["tags"] as List).map<Widget>((tag) {
                                return Container(
                                  margin: EdgeInsets.only(right: spXs),
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${post["title"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${post["excerpt"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage("${post["authorImage"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${post["author"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${post["category"]} • ${post["readTime"]} min read",
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
                                      "${((post["views"] as int) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.favorite, size: 16, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${post["likes"]}",
                                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                    ),
                                    SizedBox(width: spSm),
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
