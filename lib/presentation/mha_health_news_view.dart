import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHealthNewsView extends StatefulWidget {
  const MhaHealthNewsView({super.key});

  @override
  State<MhaHealthNewsView> createState() => _MhaHealthNewsViewState();
}

class _MhaHealthNewsViewState extends State<MhaHealthNewsView> {
  List<Map<String, dynamic>> newsArticles = [
    {
      "id": 1,
      "title": "New Study Reveals Benefits of Mediterranean Diet for Heart Health",
      "category": "Nutrition",
      "summary": "A comprehensive 10-year study involving 25,000 participants shows that following a Mediterranean diet can reduce heart disease risk by up to 30%.",
      "content": "Researchers from Harvard Medical School have published groundbreaking findings about the Mediterranean diet's impact on cardiovascular health. The study, which followed participants for over a decade, demonstrates that those who adhered to a Mediterranean eating pattern experienced significantly lower rates of heart attacks, strokes, and other cardiovascular events. The diet emphasizes olive oil, fish, nuts, fruits, and vegetables while limiting red meat and processed foods.",
      "image": "https://picsum.photos/300/200?random=1&keyword=mediterranean",
      "publishedDate": "2024-12-15",
      "readTime": "5 min read",
      "source": "Harvard Medical Journal",
      "author": "Dr. Sarah Martinez",
      "isBreaking": true,
      "views": 12500,
      "shares": 340,
      "isBookmarked": false,
      "tags": ["nutrition", "heart health", "research", "diet"],
    },
    {
      "id": 2,
      "title": "Mental Health Apps Show Promise in Reducing Anxiety",
      "category": "Mental Health",
      "summary": "Clinical trials demonstrate that smartphone-based mental health interventions can be as effective as traditional therapy for mild to moderate anxiety.",
      "content": "A meta-analysis of 40 clinical trials involving over 8,000 participants has shown that digital mental health interventions can significantly reduce anxiety symptoms. The study found that apps incorporating cognitive behavioral therapy techniques, mindfulness exercises, and mood tracking were particularly effective. Researchers noted that while these tools don't replace professional therapy for severe cases, they provide accessible support for many individuals.",
      "image": "https://picsum.photos/300/200?random=2&keyword=mental",
      "publishedDate": "2024-12-14",
      "readTime": "4 min read",
      "source": "Journal of Digital Medicine",
      "author": "Dr. Michael Chen",
      "isBreaking": false,
      "views": 8900,
      "shares": 256,
      "isBookmarked": true,
      "tags": ["mental health", "technology", "anxiety", "therapy"],
    },
    {
      "id": 3,
      "title": "Exercise Guidelines Updated: Quality Over Quantity",
      "category": "Fitness",
      "summary": "World Health Organization releases new exercise recommendations emphasizing the importance of high-intensity interval training over long-duration workouts.",
      "content": "The WHO's latest physical activity guidelines suggest that short bursts of high-intensity exercise can be more beneficial than longer, moderate-intensity sessions. The research indicates that as little as 75 minutes of vigorous activity per week can provide the same health benefits as 150 minutes of moderate exercise. This finding is particularly relevant for busy individuals who struggle to find time for extended workout sessions.",
      "image": "https://picsum.photos/300/200?random=3&keyword=exercise",
      "publishedDate": "2024-12-13",
      "readTime": "3 min read",
      "source": "World Health Organization",
      "author": "WHO Research Team",
      "isBreaking": false,
      "views": 15600,
      "shares": 445,
      "isBookmarked": false,
      "tags": ["fitness", "WHO", "exercise", "guidelines"],
    },
    {
      "id": 4,
      "title": "Sleep Tracking Devices May Disrupt Sleep Quality",
      "category": "Sleep",
      "summary": "Paradoxically, wearable sleep trackers might be causing anxiety about sleep performance, leading to worse sleep quality in some users.",
      "content": "Sleep specialists are reporting a new phenomenon called 'orthosomnia' - an obsession with achieving perfect sleep metrics that actually worsens sleep quality. Users of sleep tracking devices are becoming anxious about their sleep scores, leading to increased stress at bedtime. Experts recommend using these devices as general guides rather than precise measurements and suggest taking regular breaks from tracking.",
      "image": "https://picsum.photos/300/200?random=4&keyword=sleep",
      "publishedDate": "2024-12-12",
      "readTime": "4 min read",
      "source": "Sleep Medicine Review",
      "author": "Dr. Emily Rodriguez",
      "isBreaking": false,
      "views": 7800,
      "shares": 189,
      "isBookmarked": true,
      "tags": ["sleep", "technology", "tracking", "anxiety"],
    },
    {
      "id": 5,
      "title": "Breakthrough in Early Cancer Detection Using AI",
      "category": "Medical Research",
      "summary": "Artificial intelligence system shows 95% accuracy in detecting early-stage cancers from routine blood tests, potentially revolutionizing screening.",
      "content": "Scientists at Stanford University have developed an AI system that can detect 12 different types of cancer from a simple blood sample with 95% accuracy. The technology analyzes patterns in cell-free DNA to identify cancerous changes before symptoms appear. Clinical trials are now underway to test the system's effectiveness in real-world screening programs. If successful, this could dramatically improve cancer survival rates through earlier detection.",
      "image": "https://picsum.photos/300/200?random=5&keyword=medical",
      "publishedDate": "2024-12-11",
      "readTime": "6 min read",
      "source": "Stanford Medical Research",
      "author": "Dr. Lisa Wang",
      "isBreaking": true,
      "views": 22400,
      "shares": 680,
      "isBookmarked": false,
      "tags": ["AI", "cancer", "detection", "research"],
    },
    {
      "id": 6,
      "title": "Vitamin D Deficiency Linked to Increased COVID-19 Severity",
      "category": "Public Health",
      "summary": "Large-scale study confirms that adequate vitamin D levels may reduce the risk of severe COVID-19 outcomes by up to 40%.",
      "content": "A comprehensive analysis of 195,000 COVID-19 patients across 20 countries has confirmed a strong correlation between vitamin D deficiency and severe disease outcomes. Patients with adequate vitamin D levels (above 30 ng/mL) were 40% less likely to require hospitalization and 50% less likely to need intensive care. Health officials now recommend vitamin D supplementation, especially during winter months and for high-risk populations.",
      "image": "https://picsum.photos/300/200?random=6&keyword=vitamin",
      "publishedDate": "2024-12-10",
      "readTime": "5 min read",
      "source": "Global Health Research",
      "author": "Dr. James Park",
      "isBreaking": false,
      "views": 18900,
      "shares": 523,
      "isBookmarked": true,
      "tags": ["vitamin D", "COVID-19", "immunity", "public health"],
    },
  ];

  String selectedCategory = "All";
  String searchQuery = "";
  bool showBookmarkedOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health News"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              setState(() {
                showBookmarkedOnly = !showBookmarkedOnly;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilter(),
            _buildBreakingNews(),
            _buildNewsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search health news...",
                value: searchQuery,
                hint: "Type keywords to search",
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
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Category",
                items: [
                  {"label": "All Categories", "value": "All"},
                  {"label": "Nutrition", "value": "Nutrition"},
                  {"label": "Mental Health", "value": "Mental Health"},
                  {"label": "Fitness", "value": "Fitness"},
                  {"label": "Sleep", "value": "Sleep"},
                  {"label": "Medical Research", "value": "Medical Research"},
                  {"label": "Public Health", "value": "Public Health"},
                ],
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Bookmarked Only",
                    "value": true,
                    "checked": showBookmarkedOnly,
                  }
                ],
                value: [if (showBookmarkedOnly) {"label": "Bookmarked Only", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  showBookmarkedOnly = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBreakingNews() {
    var breakingNews = newsArticles.where((article) => article["isBreaking"] == true).toList();
    
    if (breakingNews.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.emergency, color: dangerColor, size: 24),
            SizedBox(width: spSm),
            Text(
              "Breaking Health News",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
          ],
        ),
        QHorizontalScroll(
          children: breakingNews.map((article) => _buildBreakingNewsCard(article)).toList(),
        ),
      ],
    );
  }

  Widget _buildBreakingNewsCard(Map<String, dynamic> article) {
    Color categoryColor = _getCategoryColor(article["category"]);

    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${article["image"]}",
                  height: 150,
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
                    "BREAKING",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    article["isBookmarked"] = !article["isBookmarked"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      article["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.white,
                      size: 18,
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
              spacing: spSm,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: categoryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${article["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: categoryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "${article["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${article["summary"]}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${article["readTime"]}",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _showArticleDetail(article),
                      child: Text(
                        "Read more",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
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
  }

  Widget _buildNewsList() {
    var filteredNews = newsArticles;
    
    if (selectedCategory != "All") {
      filteredNews = newsArticles.where((article) => article["category"] == selectedCategory).toList();
    }
    
    if (showBookmarkedOnly) {
      filteredNews = filteredNews.where((article) => article["isBookmarked"] == true).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filteredNews = filteredNews.where((article) => 
        article["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        article["summary"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        (article["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Latest Health News",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredNews.map((article) => _buildNewsItem(article)).toList(),
      ],
    );
  }

  Widget _buildNewsItem(Map<String, dynamic> article) {
    Color categoryColor = _getCategoryColor(article["category"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${article["image"]}",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${article["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            article["isBookmarked"] = !article["isBookmarked"];
                            setState(() {});
                          },
                          child: Icon(
                            article["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                            color: article["isBookmarked"] ? primaryColor : disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${article["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "${article["summary"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${article["author"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.source, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${article["source"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${article["readTime"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${article["publishedDate"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${(article["views"] as int).currency}",
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.share, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${article["shares"]}",
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Read Article",
                  size: bs.sm,
                  onPressed: () => _showArticleDetail(article),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Share",
                  size: bs.sm,
                  onPressed: () => _shareArticle(article),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Nutrition": return successColor;
      case "Mental Health": return infoColor;
      case "Fitness": return primaryColor;
      case "Sleep": return Color(0xFF9C27B0);
      case "Medical Research": return dangerColor;
      case "Public Health": return warningColor;
      default: return primaryColor;
    }
  }

  void _showArticleDetail(Map<String, dynamic> article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusMd),
              child: Image.network(
                "${article["image"]}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            if (article["isBreaking"] == true)
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "BREAKING NEWS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              "${article["title"]}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Row(
              children: [
                Text(
                  "By ${article["author"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "${article["source"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "${article["summary"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                    Text(
                      "${article["content"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: disabledBoldColor,
                        height: 1.6,
                      ),
                    ),
                    Text(
                      "Tags:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      children: (article["tags"] as List).map((tag) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: article["isBookmarked"] ? "Remove Bookmark" : "Bookmark",
                    size: bs.sm,
                    onPressed: () {
                      article["isBookmarked"] = !article["isBookmarked"];
                      setState(() {});
                      ss(article["isBookmarked"] ? "Article bookmarked!" : "Bookmark removed");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share Article",
                    size: bs.sm,
                    onPressed: () => _shareArticle(article),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _shareArticle(Map<String, dynamic> article) {
    ss("Sharing: ${article["title"]}");
    // Implementation for sharing article
  }
}
