import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaArticlesView extends StatefulWidget {
  const MhaArticlesView({super.key});

  @override
  State<MhaArticlesView> createState() => _MhaArticlesViewState();
}

class _MhaArticlesViewState extends State<MhaArticlesView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedFilter = "Latest";
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Cardiology", "value": "Cardiology"},
    {"label": "Diabetes", "value": "Diabetes"},
    {"label": "Mental Health", "value": "Mental Health"},
    {"label": "Nutrition", "value": "Nutrition"},
    {"label": "Pediatrics", "value": "Pediatrics"},
    {"label": "Women's Health", "value": "Women's Health"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "Latest", "value": "Latest"},
    {"label": "Most Popular", "value": "Most Popular"},
    {"label": "Most Read", "value": "Most Read"},
    {"label": "Trending", "value": "Trending"},
  ];

  List<Map<String, dynamic>> articles = [
    {
      "id": "1",
      "title": "Understanding Heart Disease Prevention",
      "subtitle": "A comprehensive guide to maintaining cardiovascular health",
      "content": "Heart disease remains one of the leading causes of death worldwide. However, many cases can be prevented through lifestyle changes and early detection...",
      "category": "Cardiology",
      "author": "Dr. Sarah Johnson",
      "authorTitle": "Cardiologist",
      "authorImage": "https://picsum.photos/100/100?random=101&keyword=doctor",
      "publishedDate": DateTime.now().subtract(Duration(days: 1)),
      "readTime": "8 min read",
      "views": 2450,
      "likes": 189,
      "comments": 23,
      "shares": 45,
      "featured": true,
      "image": "https://picsum.photos/400/250?random=1&keyword=heart",
      "tags": ["prevention", "cardiology", "lifestyle"],
      "isBookmarked": false,
      "difficulty": "Intermediate",
      "rating": 4.8,
    },
    {
      "id": "2",
      "title": "Managing Type 2 Diabetes Effectively",
      "subtitle": "Evidence-based strategies for blood sugar control",
      "content": "Type 2 diabetes affects millions worldwide, but with proper management, patients can live healthy, full lives. This article explores the latest treatment approaches...",
      "category": "Diabetes",
      "author": "Dr. Michael Chen",
      "authorTitle": "Endocrinologist",
      "authorImage": "https://picsum.photos/100/100?random=102&keyword=doctor",
      "publishedDate": DateTime.now().subtract(Duration(days: 3)),
      "readTime": "12 min read",
      "views": 1890,
      "likes": 156,
      "comments": 31,
      "shares": 28,
      "featured": false,
      "image": "https://picsum.photos/400/250?random=2&keyword=diabetes",
      "tags": ["diabetes", "management", "blood sugar"],
      "isBookmarked": true,
      "difficulty": "Advanced",
      "rating": 4.6,
    },
    {
      "id": "3",
      "title": "Mental Health in the Digital Age",
      "subtitle": "Coping with technology's impact on wellbeing",
      "content": "Our relationship with technology profoundly affects our mental health. This article examines the benefits and risks of our digital lifestyle...",
      "category": "Mental Health",
      "author": "Dr. Emily Rodriguez",
      "authorTitle": "Psychiatrist",
      "authorImage": "https://picsum.photos/100/100?random=103&keyword=doctor",
      "publishedDate": DateTime.now().subtract(Duration(days: 2)),
      "readTime": "6 min read",
      "views": 3200,
      "likes": 278,
      "comments": 67,
      "shares": 89,
      "featured": true,
      "image": "https://picsum.photos/400/250?random=3&keyword=mental",
      "tags": ["mental health", "technology", "wellbeing"],
      "isBookmarked": false,
      "difficulty": "Beginner",
      "rating": 4.9,
    },
    {
      "id": "4",
      "title": "Nutrition Myths Debunked",
      "subtitle": "Separating fact from fiction in modern dieting",
      "content": "The world of nutrition is filled with conflicting information. This article examines common myths and provides evidence-based nutritional guidance...",
      "category": "Nutrition",
      "author": "Dr. Lisa Thompson",
      "authorTitle": "Nutritionist",
      "authorImage": "https://picsum.photos/100/100?random=104&keyword=doctor",
      "publishedDate": DateTime.now().subtract(Duration(days: 5)),
      "readTime": "10 min read",
      "views": 1650,
      "likes": 134,
      "comments": 19,
      "shares": 36,
      "featured": false,
      "image": "https://picsum.photos/400/250?random=4&keyword=nutrition",
      "tags": ["nutrition", "myths", "diet"],
      "isBookmarked": false,
      "difficulty": "Intermediate",
      "rating": 4.7,
    },
    {
      "id": "5",
      "title": "Child Development Milestones",
      "subtitle": "What parents should know about healthy growth",
      "content": "Understanding child development milestones helps parents recognize normal growth patterns and identify potential concerns early...",
      "category": "Pediatrics",
      "author": "Dr. James Wilson",
      "authorTitle": "Pediatrician",
      "authorImage": "https://picsum.photos/100/100?random=105&keyword=doctor",
      "publishedDate": DateTime.now().subtract(Duration(days: 4)),
      "readTime": "7 min read",
      "views": 2100,
      "likes": 167,
      "comments": 42,
      "shares": 53,
      "featured": false,
      "image": "https://picsum.photos/400/250?random=5&keyword=children",
      "tags": ["pediatrics", "development", "milestones"],
      "isBookmarked": true,
      "difficulty": "Beginner",
      "rating": 4.5,
    },
  ];

  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> filtered = articles;

    if (selectedCategory != "All") {
      filtered = filtered.where((article) => article["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((article) =>
          (article["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["subtitle"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["category"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["author"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    // Apply sorting based on filter
    switch (selectedFilter) {
      case "Most Popular":
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "Most Read":
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case "Trending":
        filtered.sort((a, b) => (b["shares"] as int).compareTo(a["shares"] as int));
        break;
      default: // Latest
        filtered.sort((a, b) => (b["publishedDate"] as DateTime).compareTo(a["publishedDate"] as DateTime));
    }

    return filtered;
  }

  void _toggleBookmark(String articleId) {
    setState(() {
      for (var article in articles) {
        if (article["id"] == articleId) {
          article["isBookmarked"] = !(article["isBookmarked"] as bool);
          break;
        }
      }
    });

    ss("Article bookmark updated");
  }

  void _shareArticle(Map<String, dynamic> article) {
    ss("Article shared successfully");
  }

  Widget _buildFeaturedArticleCard(Map<String, dynamic> article) {
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
          // Featured Badge and Image
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
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "FEATURED",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () => _toggleBookmark(article["id"]),
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      (article["isBookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and Rating
                Row(
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
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${article["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Title
                Text(
                  "${article["title"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                SizedBox(height: spXs),

                // Subtitle
                Text(
                  "${article["subtitle"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: spMd),

                // Author Info
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
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${article["authorTitle"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${article["readTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                        onPressed: () {
                          // Navigate to article detail
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () => _shareArticle(article),
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.share,
                          color: disabledBoldColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Stats
                Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${article["views"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${article["likes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.comment_outlined,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${article["comments"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(article["publishedDate"] as DateTime).dMMMy}",
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
  }

  Widget _buildRegularArticleCard(Map<String, dynamic> article) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${article["image"]}",
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: spMd),

            // Article Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
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

                  SizedBox(height: spXs),

                  // Title
                  Text(
                    "${article["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: spXs),

                  // Author and Read Time
                  Row(
                    children: [
                      Text(
                        "${article["author"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        " • ",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${article["readTime"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spXs),

                  // Stats and Actions
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${article["likes"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.visibility,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${article["views"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _toggleBookmark(article["id"]),
                        child: Icon(
                          (article["isBookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                          size: 16,
                          color: (article["isBookmarked"] as bool) ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Articles"),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to bookmarked articles
            },
            icon: Icon(Icons.bookmark),
          ),
          IconButton(
            onPressed: () {
              // Navigate to search
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    "Latest Medical Articles",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  SizedBox(height: spXs),

                  Text(
                    "Evidence-based articles from medical professionals",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Search and Filters
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
                        icon: Icons.tune,
                        size: bs.sm,
                        onPressed: () {
                          // Show advanced filters
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Category Filter
                  QCategoryPicker(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spMd),

                  // Sort Filter
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Articles List
                  if (filteredArticles.isEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.article_outlined,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No articles found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your search or filters",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Text(
                          "${filteredArticles.length} articles found",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Sorted by $selectedFilter",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Featured Articles
                    ...filteredArticles
                        .where((article) => article["featured"] == true)
                        .map((article) => _buildFeaturedArticleCard(article))
                        .toList(),

                    // Regular Articles
                    ...filteredArticles
                        .where((article) => article["featured"] == false)
                        .map((article) => _buildRegularArticleCard(article))
                        .toList(),
                  ],
                ],
              ),
            ),
    );
  }
}
