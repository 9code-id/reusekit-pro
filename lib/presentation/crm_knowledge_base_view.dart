import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmKnowledgeBaseView extends StatefulWidget {
  const CrmKnowledgeBaseView({super.key});

  @override
  State<CrmKnowledgeBaseView> createState() => _CrmKnowledgeBaseViewState();
}

class _CrmKnowledgeBaseViewState extends State<CrmKnowledgeBaseView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "all";
  bool showAddArticleForm = false;
  
  String articleTitle = "";
  String articleContent = "";
  String articleCategory = "";
  String articleTags = "";
  bool articlePublished = true;

  List<Map<String, dynamic>> articles = [
    {
      "id": 1,
      "title": "How to Reset Your Password",
      "content": "Step-by-step guide to reset your account password safely and securely...",
      "category": "Account Management",
      "author": "Sarah Wilson",
      "createdAt": "2024-12-15 10:30:00",
      "updatedAt": "2024-12-18 14:20:00",
      "views": 1245,
      "likes": 89,
      "helpful": 76,
      "tags": ["password", "account", "security"],
      "published": true,
      "featured": true,
    },
    {
      "id": 2,
      "title": "Payment Methods Guide",
      "content": "Complete guide to accepted payment methods and how to update payment information...",
      "category": "Billing",
      "author": "Mike Johnson",
      "createdAt": "2024-12-14 09:15:00",
      "updatedAt": "2024-12-19 11:45:00",
      "views": 892,
      "likes": 67,
      "helpful": 58,
      "tags": ["payment", "billing", "credit card"],
      "published": true,
      "featured": false,
    },
    {
      "id": 3,
      "title": "API Integration Tutorial",
      "content": "Learn how to integrate our API into your application with code examples...",
      "category": "Developer",
      "author": "Emily Davis",
      "createdAt": "2024-12-13 16:00:00",
      "updatedAt": "2024-12-19 09:30:00",
      "views": 567,
      "likes": 45,
      "helpful": 42,
      "tags": ["api", "integration", "developer"],
      "published": true,
      "featured": true,
    },
    {
      "id": 4,
      "title": "Mobile App Features",
      "content": "Explore all the features available in our mobile application...",
      "category": "Mobile App",
      "author": "Alex Chen",
      "createdAt": "2024-12-12 13:20:00",
      "updatedAt": "2024-12-17 15:10:00",
      "views": 734,
      "likes": 56,
      "helpful": 49,
      "tags": ["mobile", "features", "app"],
      "published": false,
      "featured": false,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {
      "name": "Account Management",
      "count": 15,
      "icon": Icons.account_circle,
      "color": "#3B82F6",
    },
    {
      "name": "Billing",
      "count": 8,
      "icon": Icons.payment,
      "color": "#10B981",
    },
    {
      "name": "Developer",
      "count": 12,
      "icon": Icons.code,
      "color": "#8B5CF6",
    },
    {
      "name": "Mobile App",
      "count": 6,
      "icon": Icons.smartphone,
      "color": "#F59E0B",
    },
    {
      "name": "Troubleshooting",
      "count": 20,
      "icon": Icons.build,
      "color": "#EF4444",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Knowledge Base",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Articles", icon: Icon(Icons.article)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        showAddArticleForm ? _buildAddArticleForm() : _buildArticlesTab(),
        _buildCategoriesTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildArticlesTab() {
    final filteredArticles = articles.where((article) {
      final matchesSearch = (article["title"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          (article["content"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "all" ||
          article["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildArticleHeader(),
          _buildArticleFilters(),
          _buildFeaturedArticles(),
          _buildArticlesList(filteredArticles),
        ],
      ),
    );
  }

  Widget _buildArticleHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Knowledge Base",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Find answers and resources to help you succeed",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              showAddArticleForm = true;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArticleFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search articles",
          value: searchQuery,
          hint: "Search by title, content, or tags",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        QDropdownField(
          label: "Category",
          items: [
            {"label": "All Categories", "value": "all"},
            ...categories.map((cat) => {
                  "label": cat["name"],
                  "value": cat["name"],
                }),
          ],
          value: selectedCategory,
          onChanged: (value, label) {
            selectedCategory = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildFeaturedArticles() {
    final featuredArticles = articles.where((article) => article["featured"] == true).toList();
    
    if (featuredArticles.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          children: featuredArticles.map((article) {
            return Container(
              width: 280,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "FEATURED",
                          style: TextStyle(
                            fontSize: 10,
                            color: warningColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${article["views"]} views",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${article["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${article["content"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.thumb_up, size: 16, color: successColor),
                      SizedBox(width: spXs),
                      Text(
                        "${article["likes"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.help, size: 16, color: infoColor),
                      SizedBox(width: spXs),
                      Text(
                        "${article["helpful"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildArticlesList(List<Map<String, dynamic>> filteredArticles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Articles",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          spacing: spSm,
          children: filteredArticles.map((article) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
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
                                if (article["featured"] == true) ...[
                                  Icon(Icons.star, size: 16, color: warningColor),
                                  SizedBox(width: spXs),
                                ],
                                Text(
                                  "${article["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${article["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: article["published"] == true
                              ? successColor.withAlpha(20)
                              : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          article["published"] == true ? "Published" : "Draft",
                          style: TextStyle(
                            fontSize: 12,
                            color: article["published"] == true
                                ? successColor
                                : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${article["content"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${article["author"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${article["views"]} views",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.thumb_up, size: 16, color: successColor),
                              SizedBox(width: spXs),
                              Text(
                                "${article["likes"]} likes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.help, size: 16, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "${article["helpful"]} helpful",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: (article["tags"] as List).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
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
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Article",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to article details
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {
                          _editArticle(article);
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.delete,
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm(
                              "Are you sure you want to delete this article?");
                          if (isConfirmed) {
                            _deleteArticle(article["id"] as int);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAddArticleForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  showAddArticleForm = false;
                  _resetArticleForm();
                  setState(() {});
                },
              ),
              Text(
                "Add New Article",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Column(
            spacing: spMd,
            children: [
              QTextField(
                label: "Article Title",
                value: articleTitle,
                hint: "Enter article title",
                onChanged: (value) {
                  articleTitle = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Category",
                items: categories.map((cat) => {
                      "label": cat["name"],
                      "value": cat["name"],
                    }).toList(),
                value: articleCategory,
                onChanged: (value, label) {
                  articleCategory = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Article Content",
                value: articleContent,
                hint: "Write your article content here...",
                onChanged: (value) {
                  articleContent = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Tags",
                value: articleTags,
                hint: "Enter tags separated by commas",
                onChanged: (value) {
                  articleTags = value;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Publish Article",
                    "value": true,
                    "checked": articlePublished,
                  }
                ],
                value: [
                  if (articlePublished)
                    {
                      "label": "Publish Article",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  articlePublished = values.isNotEmpty;
                  setState(() {});
                },
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Article",
                  size: bs.md,
                  onPressed: () {
                    _saveArticle();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCategoriesOverview(),
          _buildCategoriesList(),
        ],
      ),
    );
  }

  Widget _buildCategoriesOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Categories Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Categories",
                  "${categories.length}",
                  Icons.category,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Total Articles",
                  "${categories.fold(0, (sum, cat) => sum + (cat["count"] as int))}",
                  Icons.article,
                  successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    return Column(
      spacing: spSm,
      children: categories.map((category) {
        Color categoryColor = Color(int.parse(
            "${category["color"]}".replaceAll("#", "0xFF")));

        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: categoryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  category["icon"],
                  color: categoryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${category["count"]} articles",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.arrow_forward,
                size: bs.sm,
                onPressed: () {
                  selectedCategory = category["name"];
                  currentTab = 0;
                  setState(() {});
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildTopPerformingArticles(),
          _buildReaderEngagement(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Knowledge Base Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Views",
                  "${articles.fold(0, (sum, a) => sum + (a["views"] as int))}",
                  Icons.visibility,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Total Likes",
                  "${articles.fold(0, (sum, a) => sum + (a["likes"] as int))}",
                  Icons.thumb_up,
                  successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Helpful Votes",
                  "${articles.fold(0, (sum, a) => sum + (a["helpful"] as int))}",
                  Icons.help,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Avg Rating",
                  "4.2/5",
                  Icons.star,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformingArticles() {
    final topArticles = List.from(articles)
      ..sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Top Performing Articles",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topArticles.take(3).map((article) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${article["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${article["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${article["views"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "views",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReaderEngagement() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Reader Engagement",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildEngagementMetric("Average Reading Time", "3.5 minutes", successColor),
          _buildEngagementMetric("Bounce Rate", "23%", warningColor),
          _buildEngagementMetric("Return Visitors", "67%", infoColor),
          _buildEngagementMetric("Search Success Rate", "84%", primaryColor),
        ],
      ),
    );
  }

  Widget _buildEngagementMetric(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _saveArticle() {
    if (articleTitle.isNotEmpty && articleContent.isNotEmpty && articleCategory.isNotEmpty) {
      articles.add({
        "id": articles.length + 1,
        "title": articleTitle,
        "content": articleContent,
        "category": articleCategory,
        "author": "Current User",
        "createdAt": DateTime.now().toString(),
        "updatedAt": DateTime.now().toString(),
        "views": 0,
        "likes": 0,
        "helpful": 0,
        "tags": articleTags.split(',').map((tag) => tag.trim()).toList(),
        "published": articlePublished,
        "featured": false,
      });
      
      ss("Article saved successfully");
      showAddArticleForm = false;
      _resetArticleForm();
      setState(() {});
    } else {
      se("Please fill in all required fields");
    }
  }

  void _editArticle(Map<String, dynamic> article) {
    articleTitle = article["title"];
    articleContent = article["content"];
    articleCategory = article["category"];
    articleTags = (article["tags"] as List).join(', ');
    articlePublished = article["published"];
    showAddArticleForm = true;
    setState(() {});
  }

  void _deleteArticle(int id) {
    articles.removeWhere((article) => article["id"] == id);
    ss("Article deleted successfully");
    setState(() {});
  }

  void _resetArticleForm() {
    articleTitle = "";
    articleContent = "";
    articleCategory = "";
    articleTags = "";
    articlePublished = true;
  }
}
