import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle3View extends StatefulWidget {
  @override
  State<GrlArticle3View> createState() => _GrlArticle3ViewState();
}

class _GrlArticle3ViewState extends State<GrlArticle3View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedJournal = "All";
  String sortBy = "newest";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Medicine", "value": "medicine"},
    {"label": "Technology", "value": "technology"},
    {"label": "Biology", "value": "biology"},
    {"label": "Chemistry", "value": "chemistry"},
    {"label": "Physics", "value": "physics"},
    {"label": "Engineering", "value": "engineering"},
  ];

  List<Map<String, dynamic>> journals = [
    {"label": "All Journals", "value": "All"},
    {"label": "Nature", "value": "nature"},
    {"label": "Science", "value": "science"},
    {"label": "Cell", "value": "cell"},
    {"label": "The Lancet", "value": "lancet"},
    {"label": "NEJM", "value": "nejm"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Most Cited", "value": "citations"},
    {"label": "Most Relevant", "value": "relevance"},
    {"label": "Oldest First", "value": "oldest"},
  ];

  List<Map<String, dynamic>> articles = [
    {
      "id": 1,
      "title": "CRISPR-Cas9 Gene Editing: Revolutionary Advances in Precision Medicine",
      "journal": "Nature Biotechnology",
      "authors": ["Dr. Jennifer Doudna", "Dr. Emmanuelle Charpentier", "Dr. Feng Zhang"],
      "publishDate": "2024-01-15",
      "citations": 1247,
      "abstract": "This comprehensive review examines the latest developments in CRISPR-Cas9 technology and its applications in treating genetic disorders, with a focus on clinical trials and therapeutic outcomes.",
      "category": "medicine",
      "readTime": 12,
      "doi": "10.1038/s41587-024-2234-5",
      "pdfUrl": "https://example.com/article1.pdf",
      "isOpenAccess": true,
      "impactFactor": 46.9,
      "keywords": ["CRISPR", "Gene Editing", "Precision Medicine", "Therapeutics"]
    },
    {
      "id": 2,
      "title": "Quantum Computing Algorithms for Drug Discovery and Molecular Simulation",
      "journal": "Science",
      "authors": ["Dr. Peter Shor", "Dr. Alán Aspuru-Guzik", "Dr. Seth Lloyd"],
      "publishDate": "2024-01-10",
      "citations": 892,
      "abstract": "We present novel quantum algorithms that significantly accelerate molecular dynamics simulations, potentially revolutionizing pharmaceutical research and drug development processes.",
      "category": "technology",
      "readTime": 15,
      "doi": "10.1126/science.abcd1234",
      "pdfUrl": "https://example.com/article2.pdf",
      "isOpenAccess": false,
      "impactFactor": 47.7,
      "keywords": ["Quantum Computing", "Drug Discovery", "Molecular Simulation", "Algorithms"]
    },
    {
      "id": 3,
      "title": "Neuroplasticity and Memory Formation: New Insights from Advanced Brain Imaging",
      "journal": "Cell",
      "authors": ["Dr. Eric Kandel", "Dr. Lynn Nadel", "Dr. Karim Nader"],
      "publishDate": "2024-01-08",
      "citations": 756,
      "abstract": "Using cutting-edge neuroimaging techniques, we reveal novel mechanisms of synaptic plasticity and their role in memory consolidation and retrieval processes.",
      "category": "biology",
      "readTime": 18,
      "doi": "10.1016/j.cell.2024.01.008",
      "pdfUrl": "https://example.com/article3.pdf",
      "isOpenAccess": true,
      "impactFactor": 38.6,
      "keywords": ["Neuroplasticity", "Memory", "Brain Imaging", "Synaptic Plasticity"]
    },
    {
      "id": 4,
      "title": "Climate Change Impacts on Arctic Ecosystems: A 20-Year Longitudinal Study",
      "journal": "Nature Climate Change",
      "authors": ["Dr. Susan Solomon", "Dr. Michael Mann", "Dr. Gavin Schmidt"],
      "publishDate": "2024-01-05",
      "citations": 623,
      "abstract": "This longitudinal study documents unprecedented changes in Arctic wildlife populations and ecosystem dynamics over two decades of climate monitoring.",
      "category": "biology",
      "readTime": 14,
      "doi": "10.1038/s41558-024-1945-2",
      "pdfUrl": "https://example.com/article4.pdf",
      "isOpenAccess": true,
      "impactFactor": 20.9,
      "keywords": ["Climate Change", "Arctic", "Ecosystems", "Longitudinal Study"]
    },
    {
      "id": 5,
      "title": "Advanced Materials for Next-Generation Solar Cells: Perovskite Innovations",
      "journal": "Nature Energy",
      "authors": ["Dr. Henry Snaith", "Dr. Sang Il Seok", "Dr. Michael Grätzel"],
      "publishDate": "2024-01-03",
      "citations": 534,
      "abstract": "We report breakthrough efficiency improvements in perovskite solar cells through novel material engineering and manufacturing processes.",
      "category": "engineering",
      "readTime": 16,
      "doi": "10.1038/s41560-024-1456-7",
      "pdfUrl": "https://example.com/article5.pdf",
      "isOpenAccess": false,
      "impactFactor": 56.7,
      "keywords": ["Solar Cells", "Perovskite", "Materials Science", "Renewable Energy"]
    },
  ];

  List<Map<String, dynamic>> get filteredArticles {
    return articles.where((article) {
      bool matchesSearch = searchQuery.isEmpty || 
          article["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          article["abstract"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["keywords"] as List).any((keyword) => 
              keyword.toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory == "All" || 
          article["category"] == selectedCategory;
      
      bool matchesJournal = selectedJournal == "All" || 
          article["journal"].toLowerCase().contains(selectedJournal.toLowerCase());
      
      return matchesSearch && matchesCategory && matchesJournal;
    }).toList()..sort((a, b) {
      switch (sortBy) {
        case "citations":
          return (b["citations"] as int).compareTo(a["citations"] as int);
        case "oldest":
          return DateTime.parse(a["publishDate"]).compareTo(DateTime.parse(b["publishDate"]));
        case "relevance":
          return (b["impactFactor"] as double).compareTo(a["impactFactor"] as double);
        case "newest":
        default:
          return DateTime.parse(b["publishDate"]).compareTo(DateTime.parse(a["publishDate"]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Articles"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Navigate to saved articles
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.search, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Search articles, keywords, authors...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
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
                          label: "Journal",
                          items: journals,
                          value: selectedJournal,
                          onChanged: (value, label) {
                            selectedJournal = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
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
                      SizedBox(width: spSm),
                      QButton(
                        label: "Advanced Search",
                        size: bs.sm,
                        onPressed: () {
                          // Show advanced search dialog
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Results Summary
            Container(
              padding: EdgeInsets.all(spSm),
              child: Row(
                children: [
                  Text(
                    "${filteredArticles.length} articles found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.trending_up, color: successColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Updated daily",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Articles List
            Column(
              children: filteredArticles.map((article) {
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
                      // Article Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${article["journal"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (article["isOpenAccess"])
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.lock_open, color: successColor, size: 12),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Open Access",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Spacer(),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: disabledBoldColor),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.bookmark_border, size: 16),
                                    SizedBox(width: spSm),
                                    Text("Save Article"),
                                  ],
                                ),
                                onTap: () {
                                  // Save article
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.share, size: 16),
                                    SizedBox(width: spSm),
                                    Text("Share"),
                                  ],
                                ),
                                onTap: () {
                                  // Share article
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.download, size: 16),
                                    SizedBox(width: spSm),
                                    Text("Download PDF"),
                                  ],
                                ),
                                onTap: () {
                                  // Download PDF
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Article Title
                      Text(
                        "${article["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Authors
                      Text(
                        "${(article["authors"] as List).join(", ")}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Abstract
                      Text(
                        "${article["abstract"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Keywords
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (article["keywords"] as List).map<Widget>((keyword) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$keyword",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Article Stats
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${DateTime.parse(article["publishDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.format_quote, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${article["citations"]} citations",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${article["readTime"]} min read",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "IF: ${article["impactFactor"]}",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Read Abstract",
                              size: bs.sm,
                              onPressed: () {
                                // Show full abstract
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: article["isOpenAccess"] ? "Read Full Text" : "Access Article",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to full article
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            // Load More Button
            if (filteredArticles.length >= 5)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: spMd),
                child: QButton(
                  label: "Load More Articles",
                  size: bs.md,
                  onPressed: () {
                    // Load more articles
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
