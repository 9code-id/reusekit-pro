import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog4View extends StatefulWidget {
  const GrlBlog4View({super.key});

  @override
  State<GrlBlog4View> createState() => _GrlBlog4ViewState();
}

class _GrlBlog4ViewState extends State<GrlBlog4View> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool isGridView = false;

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Design", "value": "Design"},
    {"label": "Business", "value": "Business"},
    {"label": "Lifestyle", "value": "Lifestyle"},
    {"label": "Health", "value": "Health"},
  ];

  final List<Map<String, dynamic>> blogPosts = [
    {
      "id": 1,
      "title": "The Future of Artificial Intelligence in Healthcare",
      "excerpt": "Exploring how AI is revolutionizing medical diagnosis and patient care across the globe.",
      "author": "Dr. Sarah Chen",
      "category": "Technology",
      "readTime": 8,
      "publishedDate": "2024-01-15",
      "image": "https://picsum.photos/400/250?random=1&keyword=medical",
      "tags": ["AI", "Healthcare", "Technology"],
      "views": 12500,
      "likes": 342,
      "comments": 28,
      "featured": true,
    },
    {
      "id": 2,
      "title": "Sustainable Design Principles for Modern Architecture",
      "excerpt": "How green building practices are shaping the future of urban development and environmental consciousness.",
      "author": "Michael Rodriguez",
      "category": "Design",
      "readTime": 6,
      "publishedDate": "2024-01-12",
      "image": "https://picsum.photos/400/250?random=2&keyword=architecture",
      "tags": ["Sustainability", "Architecture", "Green Building"],
      "views": 8900,
      "likes": 245,
      "comments": 19,
      "featured": false,
    },
    {
      "id": 3,
      "title": "Building Resilient Teams in Remote Work Environment",
      "excerpt": "Strategies for maintaining productivity and team cohesion in distributed work settings.",
      "author": "Jennifer Park",
      "category": "Business",
      "readTime": 5,
      "publishedDate": "2024-01-10",
      "image": "https://picsum.photos/400/250?random=3&keyword=teamwork",
      "tags": ["Remote Work", "Team Management", "Productivity"],
      "views": 15600,
      "likes": 467,
      "comments": 52,
      "featured": true,
    },
    {
      "id": 4,
      "title": "Mindful Living: Finding Balance in Digital Age",
      "excerpt": "Practical approaches to maintaining mental wellness while navigating our connected world.",
      "author": "Emma Thompson",
      "category": "Lifestyle",
      "readTime": 7,
      "publishedDate": "2024-01-08",
      "image": "https://picsum.photos/400/250?random=4&keyword=meditation",
      "tags": ["Mindfulness", "Digital Wellness", "Mental Health"],
      "views": 9800,
      "likes": 298,
      "comments": 31,
      "featured": false,
    },
    {
      "id": 5,
      "title": "Nutrition Science: Debunking Common Food Myths",
      "excerpt": "Evidence-based insights into healthy eating and separating fact from fiction in nutrition.",
      "author": "Dr. James Wilson",
      "category": "Health",
      "readTime": 9,
      "publishedDate": "2024-01-05",
      "image": "https://picsum.photos/400/250?random=5&keyword=nutrition",
      "tags": ["Nutrition", "Health", "Science"],
      "views": 11200,
      "likes": 378,
      "comments": 45,
      "featured": true,
    },
    {
      "id": 6,
      "title": "The Evolution of User Experience Design",
      "excerpt": "From basic interfaces to intuitive experiences: tracing the journey of UX design principles.",
      "author": "Alex Kim",
      "category": "Design",
      "readTime": 6,
      "publishedDate": "2024-01-03",
      "image": "https://picsum.photos/400/250?random=6&keyword=ux",
      "tags": ["UX Design", "Interface", "User Research"],
      "views": 7400,
      "likes": 189,
      "comments": 22,
      "featured": false,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    return blogPosts.where((post) {
      final matchesSearch = "${post["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${post["excerpt"]}".toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || post["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<Map<String, dynamic>> get featuredPosts {
    return blogPosts.where((post) => post["featured"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creative Blog"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
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
                    label: "Search articles...",
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
            
            SizedBox(height: spMd),
            
            // Category Filter
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Featured Posts Section
            if (featuredPosts.isNotEmpty) ...[
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
                children: featuredPosts.map((post) {
                  return Container(
                    width: 320,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
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
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "FEATURED",
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
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: secondaryColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${post["category"]}",
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
                                  Icon(Icons.person, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["author"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["readTime"]} min read",
                                    style: TextStyle(
                                      fontSize: 12,
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
              ),
              
              SizedBox(height: spMd),
            ],
            
            // All Posts Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Articles (${filteredPosts.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${isGridView ? 'Grid' : 'List'} View",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            // Posts Grid/List
            if (isGridView) ...[
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredPosts.map((post) {
                  return Container(
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
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(50),
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
                              SizedBox(height: spSm),
                              Text(
                                "${post["title"]}",
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
                                "${post["author"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
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
                                  Text(
                                    "${post["readTime"]} min",
                                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
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
            ] else ...[
              Column(
                children: filteredPosts.map((post) {
                  return Container(
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
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                          child: Image.network(
                            "${post["image"]}",
                            width: 120,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(50),
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
                                SizedBox(height: spXs),
                                Text(
                                  "${post["title"]}",
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
                                  "${post["excerpt"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${post["author"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${post["readTime"]} min",
                                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            children: [
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
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.comment, size: 12, color: infoColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["comments"]}",
                                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
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
          ],
        ),
      ),
    );
  }
}
