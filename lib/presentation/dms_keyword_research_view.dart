import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsKeywordResearchView extends StatefulWidget {
  const DmsKeywordResearchView({super.key});

  @override
  State<DmsKeywordResearchView> createState() => _DmsKeywordResearchViewState();
}

class _DmsKeywordResearchViewState extends State<DmsKeywordResearchView> {
  String seedKeyword = "";
  String selectedCountry = "US";
  String selectedLanguage = "en";
  int currentTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> countryOptions = [
    {"label": "United States", "value": "US"},
    {"label": "United Kingdom", "value": "UK"},
    {"label": "Canada", "value": "CA"},
    {"label": "Australia", "value": "AU"},
    {"label": "Germany", "value": "DE"},
    {"label": "France", "value": "FR"},
    {"label": "Japan", "value": "JP"},
    {"label": "India", "value": "IN"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Japanese", "value": "ja"},
    {"label": "Chinese", "value": "zh"},
  ];

  List<Map<String, dynamic>> keywordResults = [
    {
      "keyword": "digital marketing",
      "volume": 90500,
      "difficulty": 85,
      "cpc": 3.45,
      "competition": "High",
      "trend": "Stable",
      "opportunities": 7,
      "related": ["online marketing", "internet marketing", "digital advertising"]
    },
    {
      "keyword": "content marketing",
      "volume": 74000,
      "difficulty": 78,
      "cpc": 2.87,
      "competition": "High",
      "trend": "Growing",
      "opportunities": 12,
      "related": ["content strategy", "blog marketing", "content creation"]
    },
    {
      "keyword": "social media marketing",
      "volume": 165000,
      "difficulty": 82,
      "cpc": 4.12,
      "competition": "High",
      "trend": "Stable",
      "opportunities": 8,
      "related": ["social marketing", "social media strategy", "social advertising"]
    },
    {
      "keyword": "email marketing",
      "volume": 49500,
      "difficulty": 71,
      "cpc": 3.98,
      "competition": "Medium",
      "trend": "Growing",
      "opportunities": 15,
      "related": ["email campaigns", "newsletter marketing", "email automation"]
    },
    {
      "keyword": "seo marketing",
      "volume": 27100,
      "difficulty": 76,
      "cpc": 5.23,
      "competition": "High",
      "trend": "Stable",
      "opportunities": 9,
      "related": ["search engine optimization", "seo strategy", "organic search"]
    }
  ];

  List<Map<String, dynamic>> longtailKeywords = [
    {
      "keyword": "best digital marketing tools for small business",
      "volume": 1200,
      "difficulty": 45,
      "cpc": 2.15,
      "intent": "Commercial"
    },
    {
      "keyword": "how to create digital marketing strategy",
      "volume": 890,
      "difficulty": 38,
      "cpc": 1.87,
      "intent": "Informational"
    },
    {
      "keyword": "digital marketing course online free",
      "volume": 2100,
      "difficulty": 52,
      "cpc": 1.23,
      "intent": "Educational"
    },
    {
      "keyword": "digital marketing agency near me",
      "volume": 3400,
      "difficulty": 67,
      "cpc": 8.45,
      "intent": "Local"
    }
  ];

  List<Map<String, dynamic>> competitorKeywords = [
    {
      "keyword": "marketing automation",
      "volume": 33100,
      "difficulty": 79,
      "position": 3,
      "competitor": "HubSpot",
      "gap": "Opportunity"
    },
    {
      "keyword": "lead generation",
      "volume": 40500,
      "difficulty": 74,
      "position": 7,
      "competitor": "Salesforce",
      "gap": "High"
    },
    {
      "keyword": "crm software",
      "volume": 27400,
      "difficulty": 81,
      "position": 12,
      "competitor": "Zoho",
      "gap": "Medium"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Keyword Research",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Research", icon: Icon(Icons.search)),
        Tab(text: "Long-tail", icon: Icon(Icons.list)),
        Tab(text: "Competitors", icon: Icon(Icons.business)),
      ],
      tabChildren: [
        _buildResearchTab(),
        _buildLongtailTab(),
        _buildCompetitorTab(),
      ],
    );
  }

  Widget _buildResearchTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchForm(),
          if (seedKeyword.isNotEmpty) ...[
            _buildKeywordOverview(),
            _buildKeywordResults(),
          ]
        ],
      ),
    );
  }

  Widget _buildSearchForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Keyword Research",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Seed Keyword",
            value: seedKeyword,
            hint: "Enter your main keyword",
            onChanged: (value) {
              seedKeyword = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Country",
                  items: countryOptions,
                  value: selectedCountry,
                  onChanged: (value, label) {
                    selectedCountry = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Language",
                  items: languageOptions,
                  value: selectedLanguage,
                  onChanged: (value, label) {
                    selectedLanguage = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Find Keywords",
              size: bs.md,
              onPressed: () => _searchKeywords(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeywordOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Research Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard("Keywords Found", "247", primaryColor, Icons.search),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Avg. Volume", "45.2K", successColor, Icons.trending_up),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Avg. Difficulty", "73", warningColor, Icons.speed),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Opportunities", "32", infoColor, Icons.lightbulb),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
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
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeywordResults() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Keyword Results",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Export",
                size: bs.sm,
                icon: Icons.download,
                onPressed: () {},
              ),
            ],
          ),
          ...keywordResults.map((keyword) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${keyword["keyword"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor((keyword["difficulty"] as int)).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "KD ${keyword["difficulty"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: _getDifficultyColor((keyword["difficulty"] as int)),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildKeywordMetric("Volume", "${((keyword["volume"] as int) / 1000).toStringAsFixed(1)}K", Icons.search),
                      ),
                      Expanded(
                        child: _buildKeywordMetric("CPC", "\$${(keyword["cpc"] as double).toStringAsFixed(2)}", Icons.monetization_on),
                      ),
                      Expanded(
                        child: _buildKeywordMetric("Competition", "${keyword["competition"]}", Icons.trending_up),
                      ),
                      Expanded(
                        child: _buildKeywordMetric("Opportunities", "${keyword["opportunities"]}", Icons.lightbulb),
                      ),
                    ],
                  ),
                  if ((keyword["related"] as List).isNotEmpty) ...[
                    Text(
                      "Related Keywords:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (keyword["related"] as List).map((related) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$related",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildKeywordMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLongtailTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildLongtailHeader(),
          _buildLongtailList(),
        ],
      ),
    );
  }

  Widget _buildLongtailHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Long-tail Keywords",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Long-tail keywords are longer, more specific keyword phrases that visitors are more likely to use when they're closer to making a purchase.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildLongtailStat("Lower Competition", "35-65", successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildLongtailStat("Higher Intent", "Commercial", warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildLongtailStat("Better ROI", "+40%", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLongtailStat(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLongtailList() {
    return Column(
      spacing: spSm,
      children: longtailKeywords.map((keyword) {
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
                    child: Text(
                      "${keyword["keyword"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getIntentColor("${keyword["intent"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${keyword["intent"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getIntentColor("${keyword["intent"]}"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildLongtailMetric("Volume", "${keyword["volume"]}", Icons.search),
                  ),
                  Expanded(
                    child: _buildLongtailMetric("Difficulty", "${keyword["difficulty"]}", Icons.speed),
                  ),
                  Expanded(
                    child: _buildLongtailMetric("CPC", "\$${(keyword["cpc"] as double).toStringAsFixed(2)}", Icons.monetization_on),
                  ),
                  QButton(
                    label: "Track",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLongtailMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompetitorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCompetitorHeader(),
          _buildCompetitorList(),
        ],
      ),
    );
  }

  Widget _buildCompetitorHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Competitor Keywords",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Discover keywords your competitors are ranking for and identify content gaps in your strategy.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorList() {
    return Column(
      spacing: spSm,
      children: competitorKeywords.map((keyword) {
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
                        Text(
                          "${keyword["keyword"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Ranking #${keyword["position"]} by ${keyword["competitor"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getGapColor("${keyword["gap"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${keyword["gap"]} Gap",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getGapColor("${keyword["gap"]}"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildCompetitorMetric("Volume", "${((keyword["volume"] as int) / 1000).toStringAsFixed(1)}K"),
                  ),
                  Expanded(
                    child: _buildCompetitorMetric("Difficulty", "${keyword["difficulty"]}"),
                  ),
                  Expanded(
                    child: _buildCompetitorMetric("Position", "#${keyword["position"]}"),
                  ),
                  QButton(
                    label: "Analyze",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCompetitorMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getDifficultyColor(int difficulty) {
    if (difficulty >= 80) return dangerColor;
    if (difficulty >= 60) return warningColor;
    if (difficulty >= 40) return infoColor;
    return successColor;
  }

  Color _getIntentColor(String intent) {
    switch (intent) {
      case "Commercial":
        return successColor;
      case "Informational":
        return infoColor;
      case "Educational":
        return warningColor;
      case "Local":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getGapColor(String gap) {
    switch (gap) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Opportunity":
        return successColor;
      default:
        return infoColor;
    }
  }

  void _searchKeywords() {
    if (seedKeyword.isEmpty) {
      se("Please enter a seed keyword");
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate keyword research
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Keyword research completed successfully");
    });
  }
}
