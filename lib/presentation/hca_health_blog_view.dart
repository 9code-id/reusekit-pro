import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaHealthBlogView extends StatefulWidget {
  const HcaHealthBlogView({super.key});

  @override
  State<HcaHealthBlogView> createState() => _HcaHealthBlogViewState();
}

class _HcaHealthBlogViewState extends State<HcaHealthBlogView> {
  String selectedCategory = "All";
  String searchQuery = "";
  String sortBy = "latest";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Medical News", "value": "medical_news"},
    {"label": "Wellness Tips", "value": "wellness"},
    {"label": "Research Updates", "value": "research"},
    {"label": "Lifestyle", "value": "lifestyle"},
    {"label": "Mental Health", "value": "mental_health"},
    {"label": "Nutrition", "value": "nutrition"},
    {"label": "Technology", "value": "technology"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Latest", "value": "latest"},
    {"label": "Most Popular", "value": "popular"},
    {"label": "Most Commented", "value": "comments"},
    {"label": "Oldest", "value": "oldest"},
  ];

  List<Map<String, dynamic>> blogPosts = [
    {
      "id": 1,
      "title": "Revolutionary Gene Therapy Shows Promise for Treating Inherited Blindness",
      "excerpt": "Recent clinical trials demonstrate significant vision improvement in patients with Leber congenital amaurosis through innovative gene therapy approaches.",
      "content": "A groundbreaking study published in Nature Medicine reveals unprecedented success rates in treating inherited blindness using CRISPR-based gene therapy...",
      "category": "medical_news",
      "author": "Dr. Rebecca Chen",
      "authorTitle": "Ophthalmologist & Research Director",
      "authorImage": "https://picsum.photos/50/50?random=1",
      "publishDate": "2024-01-15T10:00:00Z",
      "readTime": "8 min read",
      "featuredImage": "https://picsum.photos/400/250?random=1&keyword=medical",
      "views": 2847,
      "likes": 234,
      "comments": 67,
      "shares": 89,
      "isBookmarked": true,
      "isLiked": false,
      "tags": ["gene therapy", "blindness", "clinical trial", "breakthrough"],
      "relatedTopics": ["Genetic Medicine", "Eye Health", "Clinical Research"],
      "estimatedReadingLevel": "Advanced",
      "sources": [
        "Nature Medicine Journal",
        "National Eye Institute",
        "FDA Clinical Trials Database"
      ]
    },
    {
      "id": 2,
      "title": "10 Simple Daily Habits That Can Add Years to Your Life",
      "excerpt": "Evidence-based lifestyle changes that research shows can significantly impact longevity and quality of life, backed by decades of health studies.",
      "content": "Longevity research from the Blue Zones reveals simple but powerful daily practices that centenarians around the world share in common...",
      "category": "wellness",
      "author": "Sarah Martinez, RD",
      "authorTitle": "Registered Dietitian & Wellness Coach",
      "authorImage": "https://picsum.photos/50/50?random=2",
      "publishDate": "2024-01-14T14:30:00Z",
      "readTime": "6 min read",
      "featuredImage": "https://picsum.photos/400/250?random=2&keyword=wellness",
      "views": 5621,
      "likes": 892,
      "comments": 156,
      "shares": 234,
      "isBookmarked": false,
      "isLiked": true,
      "tags": ["longevity", "wellness", "lifestyle", "healthy habits"],
      "relatedTopics": ["Healthy Aging", "Preventive Medicine", "Lifestyle Medicine"],
      "estimatedReadingLevel": "Beginner",
      "sources": [
        "Blue Zones Research",
        "Harvard Health Studies",
        "Journal of Longevity Research"
      ]
    },
    {
      "id": 3,
      "title": "AI-Powered Diagnostic Tools: The Future of Early Disease Detection",
      "excerpt": "Artificial intelligence is revolutionizing medical diagnosis, enabling earlier detection of diseases like cancer, heart disease, and neurological conditions.",
      "content": "Machine learning algorithms trained on millions of medical images are now outperforming human radiologists in detecting early-stage cancers...",
      "category": "technology",
      "author": "Dr. Michael Rodriguez",
      "authorTitle": "Chief Technology Officer, MedTech Innovations",
      "authorImage": "https://picsum.photos/50/50?random=3",
      "publishDate": "2024-01-13T09:15:00Z",
      "readTime": "12 min read",
      "featuredImage": "https://picsum.photos/400/250?random=3&keyword=technology",
      "views": 3942,
      "likes": 456,
      "comments": 98,
      "shares": 167,
      "isBookmarked": true,
      "isLiked": true,
      "tags": ["AI", "diagnosis", "technology", "medical imaging"],
      "relatedTopics": ["Medical Technology", "Digital Health", "Precision Medicine"],
      "estimatedReadingLevel": "Intermediate",
      "sources": [
        "Nature Digital Medicine",
        "FDA Medical Device Reports",
        "Healthcare AI Research Consortium"
      ]
    },
    {
      "id": 4,
      "title": "Understanding Anxiety in the Digital Age: Causes and Coping Strategies",
      "excerpt": "How social media, constant connectivity, and digital overwhelm contribute to modern anxiety, plus practical strategies for managing digital stress.",
      "content": "The rise of social media and constant digital connectivity has created new forms of anxiety and stress that previous generations never experienced...",
      "category": "mental_health",
      "author": "Dr. Lisa Thompson, PhD",
      "authorTitle": "Clinical Psychologist & Digital Wellness Expert",
      "authorImage": "https://picsum.photos/50/50?random=4",
      "publishDate": "2024-01-12T16:45:00Z",
      "readTime": "7 min read",
      "featuredImage": "https://picsum.photos/400/250?random=4&keyword=mental",
      "views": 4156,
      "likes": 678,
      "comments": 203,
      "shares": 145,
      "isBookmarked": false,
      "isLiked": false,
      "tags": ["anxiety", "mental health", "digital wellness", "social media"],
      "relatedTopics": ["Digital Detox", "Stress Management", "Mental Wellness"],
      "estimatedReadingLevel": "Beginner",
      "sources": [
        "Journal of Digital Psychology",
        "American Psychological Association",
        "Digital Wellness Institute"
      ]
    },
    {
      "id": 5,
      "title": "Plant-Based Nutrition: Separating Science from Marketing Hype",
      "excerpt": "An evidence-based look at plant-based diets, their health benefits, potential risks, and how to make informed nutritional choices.",
      "content": "With the growing popularity of plant-based diets, it's important to examine the scientific evidence behind the health claims and marketing messages...",
      "category": "nutrition",
      "author": "Dr. Jennifer Park, MD",
      "authorTitle": "Internal Medicine & Nutrition Specialist",
      "authorImage": "https://picsum.photos/50/50?random=5",
      "publishDate": "2024-01-11T11:20:00Z",
      "readTime": "10 min read",
      "featuredImage": "https://picsum.photos/400/250?random=5&keyword=nutrition",
      "views": 3287,
      "likes": 521,
      "comments": 134,
      "shares": 98,
      "isBookmarked": true,
      "isLiked": false,
      "tags": ["plant-based", "nutrition", "diet", "evidence-based"],
      "relatedTopics": ["Nutritional Science", "Dietary Guidelines", "Preventive Nutrition"],
      "estimatedReadingLevel": "Intermediate",
      "sources": [
        "Journal of Nutrition",
        "Academy of Nutrition and Dietetics",
        "Harvard Nutrition Studies"
      ]
    },
    {
      "id": 6,
      "title": "Sleep and Immune Function: Why Quality Rest is Your Best Medicine",
      "excerpt": "New research reveals the critical connection between sleep quality and immune system strength, with practical tips for better sleep hygiene.",
      "content": "Recent studies from sleep medicine centers around the world confirm what many have suspected: sleep is not just rest, it's active immune maintenance...",
      "category": "research",
      "author": "Dr. Amanda Foster, MD",
      "authorTitle": "Sleep Medicine Specialist",
      "authorImage": "https://picsum.photos/50/50?random=6",
      "publishDate": "2024-01-10T13:30:00Z",
      "readTime": "9 min read",
      "featuredImage": "https://picsum.photos/400/250?random=6&keyword=sleep",
      "views": 2956,
      "likes": 387,
      "comments": 78,
      "shares": 156,
      "isBookmarked": false,
      "isLiked": true,
      "tags": ["sleep", "immune system", "research", "health"],
      "relatedTopics": ["Sleep Medicine", "Immune Health", "Wellness Research"],
      "estimatedReadingLevel": "Intermediate",
      "sources": [
        "Sleep Medicine Journal",
        "National Sleep Foundation",
        "Immune System Research Institute"
      ]
    },
    {
      "id": 7,
      "title": "Exercise as Medicine: Prescribing Physical Activity for Chronic Conditions",
      "excerpt": "How healthcare providers are increasingly prescribing specific exercise regimens as treatment for diabetes, heart disease, and mental health conditions.",
      "content": "The concept of 'exercise as medicine' is gaining traction in healthcare systems worldwide as research continues to demonstrate the therapeutic benefits...",
      "category": "lifestyle",
      "author": "Dr. Robert Kim, MD",
      "authorTitle": "Sports Medicine & Rehabilitation Specialist",
      "authorImage": "https://picsum.photos/50/50?random=7",
      "publishDate": "2024-01-09T15:45:00Z",
      "readTime": "11 min read",
      "featuredImage": "https://picsum.photos/400/250?random=7&keyword=exercise",
      "views": 2134,
      "likes": 289,
      "comments": 45,
      "shares": 67,
      "isBookmarked": false,
      "isLiked": false,
      "tags": ["exercise", "chronic disease", "medicine", "treatment"],
      "relatedTopics": ["Sports Medicine", "Chronic Disease Management", "Physical Therapy"],
      "estimatedReadingLevel": "Advanced",
      "sources": [
        "Sports Medicine Journal",
        "Exercise is Medicine Initiative",
        "American College of Sports Medicine"
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredPosts {
    var posts = blogPosts;
    
    if (selectedCategory != "All") {
      posts = posts.where((post) => post["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      posts = posts.where((post) => 
        "${post["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${post["excerpt"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${post["author"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }
    
    // Sort posts
    switch (sortBy) {
      case "popular":
        posts.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case "comments":
        posts.sort((a, b) => (b["comments"] as int).compareTo(a["comments"] as int));
        break;
      case "oldest":
        posts.sort((a, b) => a["publishDate"].compareTo(b["publishDate"]));
        break;
      default: // latest
        posts.sort((a, b) => b["publishDate"].compareTo(a["publishDate"]));
    }
    
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Blog"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Show bookmarked articles
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Show blog notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Article Header
            if (filteredPosts.isNotEmpty)
              Container(
                margin: EdgeInsets.only(bottom: spLg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Stack(
                    children: [
                      Image.network(
                        "${filteredPosts[0]["featuredImage"]}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(180),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: spMd,
                        left: spMd,
                        right: spMd,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Featured Article",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${filteredPosts[0]["title"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${filteredPosts[0]["author"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(230),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " • ${filteredPosts[0]["readTime"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 13,
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
              ),
            
            // Search and Filter Section
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
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
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
            
            SizedBox(height: spLg),
            
            // Articles Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredPosts.length} Articles",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (selectedCategory != "All" || searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      selectedCategory = "All";
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Text(
                      "Clear Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Blog Articles List
            ...List.generate(filteredPosts.length, (index) {
              final post = filteredPosts[index];
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${post["featuredImage"]}",
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(post["category"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                _getCategoryLabel(post["category"]),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${post["readTime"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Article Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Article Title
                          Text(
                            "${post["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              height: 1.3,
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Article Excerpt
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
                          
                          SizedBox(height: spMd),
                          
                          // Author Info
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
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${post["authorTitle"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                _formatPublishDate(post["publishDate"]),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Article Stats
                          Row(
                            children: [
                              _buildStatItem(Icons.visibility, "${post["views"]}", "views"),
                              SizedBox(width: spMd),
                              _buildStatItem(Icons.chat_bubble_outline, "${post["comments"]}", "comments"),
                              SizedBox(width: spMd),
                              _buildStatItem(Icons.favorite_border, "${post["likes"]}", "likes"),
                              
                              Spacer(),
                              
                              // Reading Level Badge
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getReadingLevelColor(post["estimatedReadingLevel"]).withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${post["estimatedReadingLevel"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _getReadingLevelColor(post["estimatedReadingLevel"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Tags
                          Wrap(
                            spacing: spXs,
                            children: ((post["tags"] as List).take(4)).map<Widget>((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "#$tag",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
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
                                    _readArticle(post);
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  post["isLiked"] = !(post["isLiked"] as bool);
                                  if (post["isLiked"]) {
                                    post["likes"] = (post["likes"] as int) + 1;
                                  } else {
                                    post["likes"] = (post["likes"] as int) - 1;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: post["isLiked"] ? dangerColor.withAlpha(25) : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    post["isLiked"] ? Icons.favorite : Icons.favorite_border,
                                    size: 20,
                                    color: post["isLiked"] ? dangerColor : disabledBoldColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  post["isBookmarked"] = !(post["isBookmarked"] as bool);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: post["isBookmarked"] ? primaryColor.withAlpha(25) : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    post["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                    size: 20,
                                    color: post["isBookmarked"] ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  _shareArticle(post);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.share,
                                    size: 20,
                                    color: disabledBoldColor,
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
              );
            }),
            
            if (filteredPosts.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Articles Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or category filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "medical_news":
        return dangerColor;
      case "wellness":
        return successColor;
      case "research":
        return primaryColor;
      case "lifestyle":
        return warningColor;
      case "mental_health":
        return infoColor;
      case "nutrition":
        return successColor;
      case "technology":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case "medical_news":
        return "Medical News";
      case "wellness":
        return "Wellness";
      case "research":
        return "Research";
      case "lifestyle":
        return "Lifestyle";
      case "mental_health":
        return "Mental Health";
      case "nutrition":
        return "Nutrition";
      case "technology":
        return "Technology";
      default:
        return "Health";
    }
  }

  Color _getReadingLevelColor(String level) {
    switch (level) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatPublishDate(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  void _readArticle(Map<String, dynamic> post) {
    post["views"] = (post["views"] as int) + 1;
    setState(() {});
    // Navigate to full article view
  }

  void _shareArticle(Map<String, dynamic> post) {
    post["shares"] = (post["shares"] as int) + 1;
    setState(() {});
    ss("Article shared successfully!");
  }
}
