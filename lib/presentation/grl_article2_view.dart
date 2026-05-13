import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle2View extends StatefulWidget {
  const GrlArticle2View({super.key});

  @override
  State<GrlArticle2View> createState() => _GrlArticle2ViewState();
}

class _GrlArticle2ViewState extends State<GrlArticle2View> {
  int currentTab = 0;
  String selectedJournal = "All Journals";
  bool showBookmarked = false;

  final List<Map<String, dynamic>> journalOptions = [
    {"label": "All Journals", "value": "All Journals"},
    {"label": "Nature", "value": "Nature"},
    {"label": "Science", "value": "Science"},
    {"label": "Cell", "value": "Cell"},
    {"label": "The Lancet", "value": "The Lancet"},
    {"label": "NEJM", "value": "NEJM"},
  ];

  final List<Map<String, dynamic>> researchFields = [
    {
      "name": "Artificial Intelligence",
      "articles": 1247,
      "citations": 45600,
      "hIndex": 89,
      "color": primaryColor,
      "icon": Icons.psychology,
      "trending": true,
    },
    {
      "name": "Biotechnology",
      "articles": 892,
      "citations": 67800,
      "hIndex": 76,
      "color": successColor,
      "icon": Icons.biotech,
      "trending": true,
    },
    {
      "name": "Climate Science",
      "articles": 567,
      "citations": 34500,
      "hIndex": 65,
      "color": infoColor,
      "icon": Icons.public,
      "trending": false,
    },
    {
      "name": "Quantum Physics",
      "articles": 423,
      "citations": 28900,
      "hIndex": 72,
      "color": warningColor,
      "icon": Icons.scatter_plot,
      "trending": true,
    },
  ];

  final List<Map<String, dynamic>> recentPublications = [
    {
      "id": 1,
      "title": "Machine Learning Approaches for Drug Discovery: A Comprehensive Review",
      "authors": ["Dr. Elena Rodriguez", "Prof. James Chen", "Dr. Maria Santos"],
      "journal": "Nature Machine Intelligence",
      "publishedDate": "2024-01-22",
      "doi": "10.1038/s42256-024-00789-1",
      "citations": 23,
      "downloads": 4560,
      "abstract": "This comprehensive review examines the current state and future prospects of machine learning applications in pharmaceutical drug discovery...",
      "keywords": ["Machine Learning", "Drug Discovery", "AI", "Pharmaceuticals"],
      "category": "Biotechnology",
      "openAccess": true,
      "peerReviewed": true,
      "impact": 9.2,
    },
    {
      "id": 2,
      "title": "Quantum Error Correction in Topological Quantum Computing Systems",
      "authors": ["Prof. Sarah Kim", "Dr. Michael Brown", "Dr. Lisa Wang"],
      "journal": "Physical Review Letters",
      "publishedDate": "2024-01-20",
      "doi": "10.1103/PhysRevLett.132.040301",
      "citations": 18,
      "downloads": 2890,
      "abstract": "We present a novel approach to quantum error correction using topological quantum computing principles...",
      "keywords": ["Quantum Computing", "Error Correction", "Topology", "Physics"],
      "category": "Quantum Physics",
      "openAccess": false,
      "peerReviewed": true,
      "impact": 8.6,
    },
    {
      "id": 3,
      "title": "Global Climate Model Predictions: Enhanced Accuracy Through AI Integration",
      "authors": ["Dr. Robert Johnson", "Prof. Amy Lee", "Dr. David Miller"],
      "journal": "Science",
      "publishedDate": "2024-01-18",
      "doi": "10.1126/science.adg5432",
      "citations": 45,
      "downloads": 7890,
      "abstract": "Integration of artificial intelligence algorithms significantly improves the accuracy of global climate predictions...",
      "keywords": ["Climate Science", "AI", "Weather Prediction", "Modeling"],
      "category": "Climate Science",
      "openAccess": true,
      "peerReviewed": true,
      "impact": 9.8,
    },
  ];

  final List<Map<String, dynamic>> savedArticles = [
    {
      "title": "CRISPR-Cas9 Gene Editing: Latest Advances",
      "journal": "Cell",
      "authors": ["Dr. Jennifer Doudna", "Prof. Feng Zhang"],
      "savedDate": "2024-01-15",
      "tags": ["CRISPR", "Gene Editing", "Biotechnology"],
    },
    {
      "title": "Neural Network Architecture for Medical Imaging",
      "journal": "Nature Biomedical Engineering",
      "authors": ["Dr. Geoffrey Hinton", "Prof. Yann LeCun"],
      "savedDate": "2024-01-12",
      "tags": ["AI", "Medical Imaging", "Deep Learning"],
    },
  ];

  final List<Map<String, dynamic>> topCitedPapers = [
    {
      "title": "Attention Is All You Need",
      "authors": ["A. Vaswani", "N. Shazeer", "N. Parmar"],
      "journal": "NIPS",
      "year": "2017",
      "citations": 67890,
      "field": "Artificial Intelligence",
    },
    {
      "title": "The Hallmarks of Cancer",
      "authors": ["D. Hanahan", "R. A. Weinberg"],
      "journal": "Cell",
      "year": "2000",
      "citations": 45600,
      "field": "Biotechnology",
    },
    {
      "title": "Climate Change 2023: The Physical Science Basis",
      "authors": ["IPCC Working Group I"],
      "journal": "IPCC",
      "year": "2023",
      "citations": 23400,
      "field": "Climate Science",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Research Articles",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.explore)),
        Tab(text: "Recent", icon: Icon(Icons.schedule)),
        Tab(text: "Saved", icon: Icon(Icons.bookmark)),
        Tab(text: "Top Cited", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildRecentTab(),
        _buildSavedTab(),
        _buildTopCitedTab(),
      ],
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Research Statistics
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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "2.8M+",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Publications",
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
                        "45K+",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Journals",
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
                        "156M+",
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
          ),

          SizedBox(height: spMd),

          // Research Fields
          Text(
            "Research Fields",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: researchFields.map((field) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(color: (field["color"] as Color).withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          field["icon"] as IconData,
                          color: field["color"] as Color,
                          size: 24,
                        ),
                        if (field["trending"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.trending_up, size: 10, color: dangerColor),
                                SizedBox(width: spXs),
                                Text(
                                  "HOT",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: dangerColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${field["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${field["articles"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: field["color"] as Color,
                                ),
                              ),
                              Text(
                                "Articles",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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
                                "${((field["citations"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: field["color"] as Color,
                                ),
                              ),
                              Text(
                                "Citations",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "h-index: ${field["hIndex"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter
          QDropdownField(
            label: "Filter by Journal",
            items: journalOptions,
            value: selectedJournal,
            onChanged: (value, label) {
              selectedJournal = value;
              setState(() {});
            },
          ),

          SizedBox(height: spMd),

          Text(
            "Recent Publications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          Column(
            children: recentPublications.map((paper) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
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
                            "${paper["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            if (paper["openAccess"] == true) ...[
                              Icon(Icons.lock_open, size: 14, color: successColor),
                              SizedBox(width: spXs),
                            ],
                            if (paper["peerReviewed"] == true) ...[
                              Icon(Icons.verified, size: 14, color: infoColor),
                            ],
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${paper["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Authors: ${(paper["authors"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${paper["journal"]} • ${paper["publishedDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${paper["abstract"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      children: (paper["keywords"] as List).map<Widget>((keyword) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$keyword",
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
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.format_quote, size: 14, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "${paper["citations"]} citations",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.download, size: 14, color: successColor),
                              SizedBox(width: spXs),
                              Text(
                                "${paper["downloads"]} downloads",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Impact: ${(paper["impact"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "DOI: ${paper["doi"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.bookmark_border, size: 16, color: disabledBoldColor),
                        SizedBox(width: spSm),
                        Icon(Icons.share, size: 16, color: disabledBoldColor),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Saved Articles",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${savedArticles.length} saved",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          Column(
            children: savedArticles.map((article) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${article["journal"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.bookmark, size: 16, color: warningColor),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${article["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Authors: ${(article["authors"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      children: (article["tags"] as List).map<Widget>((tag) {
                        return Container(
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
                      "Saved on ${article["savedDate"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCitedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Most Cited Papers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          Column(
            children: topCitedPapers.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> paper = entry.value;
              
              Color rankColor = primaryColor;
              if (index == 0) rankColor = warningColor;
              if (index == 1) rankColor = disabledBoldColor;
              if (index == 2) rankColor = successColor;

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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: rankColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "#${index + 1}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: rankColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${paper["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Authors: ${(paper["authors"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${paper["journal"]} • ${paper["year"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${paper["field"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(Icons.format_quote, size: 16, color: rankColor),
                              SizedBox(width: spXs),
                              Text(
                                "${((paper["citations"] as int) / 1000).toStringAsFixed(1)}K citations",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: rankColor,
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
        ],
      ),
    );
  }
}
