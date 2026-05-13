import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsKeywordDifficultyView extends StatefulWidget {
  const DmsKeywordDifficultyView({super.key});

  @override
  State<DmsKeywordDifficultyView> createState() => _DmsKeywordDifficultyViewState();
}

class _DmsKeywordDifficultyViewState extends State<DmsKeywordDifficultyView> {
  String selectedDifficulty = "all";
  String selectedCompetition = "all";
  String keywordInput = "";
  int selectedDifficultyRange = 0;

  List<Map<String, dynamic>> difficultyOptions = [
    {"label": "All Difficulties", "value": "all"},
    {"label": "Easy (0-30)", "value": "easy"},
    {"label": "Medium (31-60)", "value": "medium"},
    {"label": "Hard (61-80)", "value": "hard"},
    {"label": "Very Hard (81-100)", "value": "very_hard"},
  ];

  List<Map<String, dynamic>> competitionOptions = [
    {"label": "All Competition", "value": "all"},
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
  ];

  List<Map<String, dynamic>> difficultyData = [
    {
      "keyword": "digital marketing tips",
      "difficulty_score": 25,
      "competition": "low",
      "monthly_volume": 18000,
      "cpc": 2.45,
      "serp_features": ["featured_snippet", "people_also_ask"],
      "top_domains": ["hubspot.com", "neilpatel.com", "contentmarketinginstitute.com"],
      "backlinks_needed": 15,
      "domain_authority_needed": 35,
      "content_length_avg": 2500,
      "ranking_factors": {
        "content_quality": 8,
        "domain_authority": 6,
        "backlinks": 5,
        "user_experience": 7,
        "technical_seo": 6,
      },
      "opportunity_rating": "high",
    },
    {
      "keyword": "seo optimization",
      "difficulty_score": 78,
      "competition": "high",
      "monthly_volume": 145000,
      "cpc": 15.80,
      "serp_features": ["featured_snippet", "people_also_ask", "videos", "images"],
      "top_domains": ["moz.com", "searchengineland.com", "ahrefs.com"],
      "backlinks_needed": 250,
      "domain_authority_needed": 75,
      "content_length_avg": 4500,
      "ranking_factors": {
        "content_quality": 9,
        "domain_authority": 9,
        "backlinks": 9,
        "user_experience": 8,
        "technical_seo": 8,
      },
      "opportunity_rating": "low",
    },
    {
      "keyword": "content marketing strategy",
      "difficulty_score": 55,
      "competition": "medium",
      "monthly_volume": 74000,
      "cpc": 8.90,
      "serp_features": ["people_also_ask", "videos"],
      "top_domains": ["hubspot.com", "semrush.com", "contentmarketinginstitute.com"],
      "backlinks_needed": 85,
      "domain_authority_needed": 55,
      "content_length_avg": 3200,
      "ranking_factors": {
        "content_quality": 8,
        "domain_authority": 7,
        "backlinks": 7,
        "user_experience": 7,
        "technical_seo": 6,
      },
      "opportunity_rating": "medium",
    },
    {
      "keyword": "email marketing automation",
      "difficulty_score": 42,
      "competition": "medium",
      "monthly_volume": 32000,
      "cpc": 12.30,
      "serp_features": ["people_also_ask", "videos", "featured_snippet"],
      "top_domains": ["mailchimp.com", "hubspot.com", "activecampaign.com"],
      "backlinks_needed": 45,
      "domain_authority_needed": 45,
      "content_length_avg": 2800,
      "ranking_factors": {
        "content_quality": 7,
        "domain_authority": 6,
        "backlinks": 6,
        "user_experience": 8,
        "technical_seo": 6,
      },
      "opportunity_rating": "medium",
    },
    {
      "keyword": "ppc campaign management",
      "difficulty_score": 68,
      "competition": "high",
      "monthly_volume": 28000,
      "cpc": 18.75,
      "serp_features": ["people_also_ask", "videos"],
      "top_domains": ["wordstream.com", "google.com", "optmyzr.com"],
      "backlinks_needed": 120,
      "domain_authority_needed": 65,
      "content_length_avg": 3800,
      "ranking_factors": {
        "content_quality": 8,
        "domain_authority": 8,
        "backlinks": 8,
        "user_experience": 7,
        "technical_seo": 7,
      },
      "opportunity_rating": "low",
    },
    {
      "keyword": "social media trends 2024",
      "difficulty_score": 35,
      "competition": "low",
      "monthly_volume": 45000,
      "cpc": 3.20,
      "serp_features": ["featured_snippet", "people_also_ask", "news"],
      "top_domains": ["socialmediaexaminer.com", "sproutsocial.com", "hootsuite.com"],
      "backlinks_needed": 25,
      "domain_authority_needed": 40,
      "content_length_avg": 2200,
      "ranking_factors": {
        "content_quality": 7,
        "domain_authority": 5,
        "backlinks": 5,
        "user_experience": 7,
        "technical_seo": 5,
      },
      "opportunity_rating": "high",
    },
  ];

  List<Map<String, dynamic>> get filteredDifficultyData {
    List<Map<String, dynamic>> filtered = difficultyData;

    if (keywordInput.isNotEmpty) {
      filtered = filtered.where((item) =>
          (item["keyword"] as String)
              .toLowerCase()
              .contains(keywordInput.toLowerCase())).toList();
    }

    if (selectedDifficulty != "all") {
      switch (selectedDifficulty) {
        case "easy":
          filtered = filtered.where((item) => (item["difficulty_score"] as int) <= 30).toList();
          break;
        case "medium":
          filtered = filtered.where((item) => (item["difficulty_score"] as int) > 30 && (item["difficulty_score"] as int) <= 60).toList();
          break;
        case "hard":
          filtered = filtered.where((item) => (item["difficulty_score"] as int) > 60 && (item["difficulty_score"] as int) <= 80).toList();
          break;
        case "very_hard":
          filtered = filtered.where((item) => (item["difficulty_score"] as int) > 80).toList();
          break;
      }
    }

    if (selectedCompetition != "all") {
      filtered = filtered.where((item) => item["competition"] == selectedCompetition).toList();
    }

    switch (selectedDifficultyRange) {
      case 1: // Easy wins
        filtered = filtered.where((item) => (item["difficulty_score"] as int) <= 40).toList();
        break;
      case 2: // High opportunity
        filtered = filtered.where((item) => item["opportunity_rating"] == "high").toList();
        break;
      case 3: // High volume
        filtered = filtered.where((item) => (item["monthly_volume"] as int) > 50000).toList();
        break;
    }

    filtered.sort((a, b) => (a["difficulty_score"] as int).compareTo(b["difficulty_score"] as int));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keyword Difficulty"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              _showDifficultyCalculator();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export difficulty analysis
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Keyword Input
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Analyze Keywords",
                    value: keywordInput,
                    hint: "Enter keywords to analyze difficulty...",
                    onChanged: (value) {
                      keywordInput = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.analytics,
                  size: bs.sm,
                  onPressed: () {
                    // Analyze keywords
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
                    label: "Difficulty Level",
                    items: difficultyOptions,
                    value: selectedDifficulty,
                    onChanged: (value, label) {
                      selectedDifficulty = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Competition",
                    items: competitionOptions,
                    value: selectedCompetition,
                    onChanged: (value, label) {
                      selectedCompetition = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Difficulty Range Tabs
            QCategoryPicker(
              items: [
                {"label": "All Keywords", "value": 0},
                {"label": "Easy Wins", "value": 1},
                {"label": "High Opportunity", "value": 2},
                {"label": "High Volume", "value": 3},
              ],
              value: selectedDifficultyRange,
              onChanged: (index, label, value, item) {
                selectedDifficultyRange = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Difficulty Overview
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
                    "Difficulty Distribution",
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
                              "Easy (0-30)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${difficultyData.where((d) => (d["difficulty_score"] as int) <= 30).length}",
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
                              "Medium (31-60)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${difficultyData.where((d) => (d["difficulty_score"] as int) > 30 && (d["difficulty_score"] as int) <= 60).length}",
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
                              "Hard (61+)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${difficultyData.where((d) => (d["difficulty_score"] as int) > 60).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
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

            // Difficulty Analysis List
            Text(
              "Keyword Difficulty Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredDifficultyData.map((difficulty) {
              Color difficultyColor = (difficulty["difficulty_score"] as int) <= 30 
                  ? successColor 
                  : (difficulty["difficulty_score"] as int) <= 60 
                      ? warningColor 
                      : dangerColor;

              Color opportunityColor = difficulty["opportunity_rating"] == "high" 
                  ? successColor 
                  : difficulty["opportunity_rating"] == "medium" 
                      ? warningColor 
                      : dangerColor;

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
                      color: difficultyColor,
                    ),
                  ),
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
                                "${difficulty["keyword"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: difficultyColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${difficulty["difficulty_score"]}/100",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: difficultyColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: opportunityColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${difficulty["opportunity_rating"]} opportunity",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: opportunityColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: difficultyColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${difficulty["difficulty_score"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: difficultyColor,
                                  ),
                                ),
                                Text(
                                  "Difficulty",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: difficultyColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
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
                                "${((difficulty["monthly_volume"] as int) / 1000).toStringAsFixed(1)}K",
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
                                "CPC",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${(difficulty["cpc"] as double).toStringAsFixed(2)}",
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
                                "Backlinks",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${difficulty["backlinks_needed"]}",
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
                                "DA Needed",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${difficulty["domain_authority_needed"]}",
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

                    // Ranking Factors
                    Text(
                      "Ranking Factors:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(difficulty["ranking_factors"] as Map<String, dynamic>).entries.map((factor) {
                      double value = (factor.value as int).toDouble();
                      double percentage = value / 10;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${factor.key.replaceAll('_', ' ')}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: percentage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${factor.value}/10",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spSm),

                    // SERP Features
                    Text(
                      "SERP Features:",
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
                      children: (difficulty["serp_features"] as List).map((feature) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$feature".replaceAll('_', ' '),
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

                    // Top Competitors
                    Text(
                      "Top Ranking Domains:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(difficulty["top_domains"] as List).take(3).map((domain) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "$domain",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showDifficultyCalculator() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Difficulty Calculator"),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Enter keywords to calculate their difficulty scores based on current SERP competition.",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Keywords (comma separated)",
                  value: "",
                  hint: "keyword1, keyword2, keyword3",
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Calculate",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
