import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsLongTailKeywordsView extends StatefulWidget {
  const DmsLongTailKeywordsView({super.key});

  @override
  State<DmsLongTailKeywordsView> createState() => _DmsLongTailKeywordsViewState();
}

class _DmsLongTailKeywordsViewState extends State<DmsLongTailKeywordsView> {
  String seedKeyword = "";
  String selectedWordCount = "all";
  String selectedIntent = "all";
  int selectedLongTailFilter = 0;

  List<Map<String, dynamic>> wordCountOptions = [
    {"label": "All Lengths", "value": "all"},
    {"label": "3-4 Words", "value": "short_tail"},
    {"label": "5-6 Words", "value": "medium_tail"},
    {"label": "7+ Words", "value": "long_tail"},
  ];

  List<Map<String, dynamic>> intentOptions = [
    {"label": "All Intent", "value": "all"},
    {"label": "Informational", "value": "informational"},
    {"label": "Commercial", "value": "commercial"},
    {"label": "Transactional", "value": "transactional"},
    {"label": "Navigational", "value": "navigational"},
  ];

  List<Map<String, dynamic>> longTailData = [
    {
      "keyword": "how to create a digital marketing strategy for small business",
      "word_count": 10,
      "monthly_volume": 1200,
      "difficulty": 15,
      "cpc": 2.80,
      "intent": "informational",
      "parent_keyword": "digital marketing strategy",
      "competition": "low",
      "search_trend": "growing",
      "conversion_potential": "medium",
      "questions": ["what is", "how to", "why should"],
      "modifiers": ["for small business", "beginners guide", "step by step"],
      "related_topics": ["content marketing", "social media", "email campaigns"],
      "opportunity_score": 85,
    },
    {
      "keyword": "best email marketing software for e-commerce stores 2024",
      "word_count": 8,
      "monthly_volume": 890,
      "difficulty": 25,
      "cpc": 8.50,
      "intent": "commercial",
      "parent_keyword": "email marketing software",
      "competition": "low",
      "search_trend": "stable",
      "conversion_potential": "high",
      "questions": ["what is the best", "which is better", "how to choose"],
      "modifiers": ["for e-commerce", "2024", "comparison"],
      "related_topics": ["automation", "segmentation", "analytics"],
      "opportunity_score": 78,
    },
    {
      "keyword": "social media marketing course online with certificate",
      "word_count": 8,
      "monthly_volume": 2400,
      "difficulty": 32,
      "cpc": 12.40,
      "intent": "transactional",
      "parent_keyword": "social media marketing course",
      "competition": "medium",
      "search_trend": "growing",
      "conversion_potential": "high",
      "questions": ["where to find", "how much does it cost", "is it worth"],
      "modifiers": ["online", "with certificate", "free vs paid"],
      "related_topics": ["certification", "training", "skills"],
      "opportunity_score": 72,
    },
    {
      "keyword": "why content marketing is important for B2B companies",
      "word_count": 8,
      "monthly_volume": 650,
      "difficulty": 18,
      "cpc": 4.20,
      "intent": "informational",
      "parent_keyword": "content marketing",
      "competition": "low",
      "search_trend": "stable",
      "conversion_potential": "medium",
      "questions": ["why is", "what are the benefits", "how does it help"],
      "modifiers": ["for B2B", "importance", "benefits"],
      "related_topics": ["lead generation", "brand awareness", "thought leadership"],
      "opportunity_score": 80,
    },
    {
      "keyword": "affordable seo services for local restaurants near me",
      "word_count": 8,
      "monthly_volume": 1800,
      "difficulty": 28,
      "cpc": 15.30,
      "intent": "transactional",
      "parent_keyword": "seo services",
      "competition": "medium",
      "search_trend": "growing",
      "conversion_potential": "high",
      "questions": ["how much does it cost", "where to find", "which company"],
      "modifiers": ["affordable", "for restaurants", "near me", "local"],
      "related_topics": ["local seo", "google my business", "restaurant marketing"],
      "opportunity_score": 75,
    },
    {
      "keyword": "google ads campaign management tools comparison guide",
      "word_count": 7,
      "monthly_volume": 950,
      "difficulty": 35,
      "cpc": 18.90,
      "intent": "commercial",
      "parent_keyword": "google ads management",
      "competition": "medium",
      "search_trend": "stable",
      "conversion_potential": "high",
      "questions": ["which is the best", "how to compare", "what features"],
      "modifiers": ["comparison", "guide", "tools", "management"],
      "related_topics": ["automation", "bidding", "optimization"],
      "opportunity_score": 68,
    },
  ];

  List<Map<String, dynamic>> get filteredLongTailData {
    List<Map<String, dynamic>> filtered = longTailData;

    if (seedKeyword.isNotEmpty) {
      filtered = filtered.where((item) =>
          (item["keyword"] as String)
              .toLowerCase()
              .contains(seedKeyword.toLowerCase()) ||
          (item["parent_keyword"] as String)
              .toLowerCase()
              .contains(seedKeyword.toLowerCase())).toList();
    }

    if (selectedWordCount != "all") {
      switch (selectedWordCount) {
        case "short_tail":
          filtered = filtered.where((item) => (item["word_count"] as int) >= 3 && (item["word_count"] as int) <= 4).toList();
          break;
        case "medium_tail":
          filtered = filtered.where((item) => (item["word_count"] as int) >= 5 && (item["word_count"] as int) <= 6).toList();
          break;
        case "long_tail":
          filtered = filtered.where((item) => (item["word_count"] as int) >= 7).toList();
          break;
      }
    }

    if (selectedIntent != "all") {
      filtered = filtered.where((item) => item["intent"] == selectedIntent).toList();
    }

    switch (selectedLongTailFilter) {
      case 1: // Low competition
        filtered = filtered.where((item) => (item["difficulty"] as int) <= 30).toList();
        break;
      case 2: // High conversion
        filtered = filtered.where((item) => item["conversion_potential"] == "high").toList();
        break;
      case 3: // High opportunity
        filtered = filtered.where((item) => (item["opportunity_score"] as int) > 75).toList();
        break;
    }

    filtered.sort((a, b) => (b["opportunity_score"] as int).compareTo(a["opportunity_score"] as int));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Long-tail Keywords"),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () {
              _showKeywordIdeas();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export long-tail keywords
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seed Keyword Input
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Seed Keyword",
                    value: seedKeyword,
                    hint: "Enter base keyword to find long-tail variations...",
                    onChanged: (value) {
                      seedKeyword = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    // Generate long-tail keywords
                  },
                ),
              ],
            ),
            SizedBox(height: spSm),

            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Word Count",
                    items: wordCountOptions,
                    value: selectedWordCount,
                    onChanged: (value, label) {
                      selectedWordCount = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Search Intent",
                    items: intentOptions,
                    value: selectedIntent,
                    onChanged: (value, label) {
                      selectedIntent = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Long-tail Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All Keywords", "value": 0},
                {"label": "Low Competition", "value": 1},
                {"label": "High Conversion", "value": 2},
                {"label": "High Opportunity", "value": 3},
              ],
              value: selectedLongTailFilter,
              onChanged: (index, label, value, item) {
                selectedLongTailFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Long-tail Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Long-tail Overview",
                    style: TextStyle(
                      fontSize: fsH6,
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
                              "Total Keywords",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${longTailData.length}",
                              style: TextStyle(
                                fontSize: fsH4,
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
                              "Avg Difficulty",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(longTailData.map((l) => l["difficulty"] as int).reduce((a, b) => a + b) / longTailData.length).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                              "High Opportunity",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${longTailData.where((l) => (l["opportunity_score"] as int) > 75).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
                              "Total Volume",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${((longTailData.map((l) => l["monthly_volume"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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

            // Long-tail Keywords List
            Text(
              "Long-tail Keyword Opportunities",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredLongTailData.map((longTail) {
              Color difficultyColor = (longTail["difficulty"] as int) <= 25 
                  ? successColor 
                  : (longTail["difficulty"] as int) <= 50 
                      ? warningColor 
                      : dangerColor;

              Color intentColor = longTail["intent"] == "transactional" 
                  ? successColor 
                  : longTail["intent"] == "commercial" 
                      ? warningColor 
                      : longTail["intent"] == "informational" 
                          ? infoColor 
                          : disabledBoldColor;

              Color conversionColor = longTail["conversion_potential"] == "high" 
                  ? successColor 
                  : longTail["conversion_potential"] == "medium" 
                      ? warningColor 
                      : dangerColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${longTail["keyword"]}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Parent: ${longTail["parent_keyword"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: intentColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${longTail["intent"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: intentColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: conversionColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${longTail["conversion_potential"]} conversion",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: conversionColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${longTail["opportunity_score"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Score",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Key Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Volume",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((longTail["monthly_volume"] as int) >= 1000) ? "${((longTail["monthly_volume"] as int) / 1000).toStringAsFixed(1)}K" : "${longTail["monthly_volume"]}"}",
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
                                "Difficulty",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${longTail["difficulty"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: difficultyColor,
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
                                "CPC",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${(longTail["cpc"] as double).toStringAsFixed(2)}",
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
                                "Words",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${longTail["word_count"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Questions
                    Text(
                      "Related Questions:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (longTail["questions"] as List).map((question) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$question",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spSm),

                    // Modifiers
                    Text(
                      "Keyword Modifiers:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (longTail["modifiers"] as List).map((modifier) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$modifier",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spSm),

                    // Related Topics
                    Text(
                      "Related Topics:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (longTail["related_topics"] as List).map((topic) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$topic",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showKeywordIdeas() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Long-tail Keyword Ideas"),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tips for finding long-tail keywords:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text("• Use question words: how, what, why, when, where"),
                Text("• Add location modifiers: 'near me', city names"),
                Text("• Include year or time: '2024', 'latest', 'new'"),
                Text("• Add qualifiers: 'best', 'cheap', 'free', 'top'"),
                Text("• Use buyer intent: 'buy', 'price', 'review', 'vs'"),
                Text("• Industry specific: add niche terms"),
                SizedBox(height: spSm),
                Text(
                  "Example patterns:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text("• [how to] + [main keyword] + [modifier]"),
                Text("• [best] + [main keyword] + [for specific use]"),
                Text("• [main keyword] + [vs] + [competitor]"),
                Text("• [main keyword] + [price/cost/review]"),
              ],
            ),
          ),
          actions: [
            QButton(
              label: "Got it",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
