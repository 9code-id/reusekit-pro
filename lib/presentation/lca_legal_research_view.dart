import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaLegalResearchView extends StatefulWidget {
  const LcaLegalResearchView({super.key});

  @override
  State<LcaLegalResearchView> createState() => _LcaLegalResearchViewState();
}

class _LcaLegalResearchViewState extends State<LcaLegalResearchView> {
  String searchQuery = "";
  String selectedJurisdiction = "All";
  String selectedDateRange = "All Time";
  String selectedDocumentType = "All";
  String selectedSortBy = "Relevance";
  bool advancedSearch = false;
  
  List<Map<String, dynamic>> jurisdictions = [
    {"label": "All Jurisdictions", "value": "All"},
    {"label": "Federal", "value": "federal"},
    {"label": "California", "value": "ca"},
    {"label": "New York", "value": "ny"},
    {"label": "Texas", "value": "tx"},
    {"label": "Florida", "value": "fl"},
  ];

  List<Map<String, dynamic>> dateRanges = [
    {"label": "All Time", "value": "All Time"},
    {"label": "Last Year", "value": "1y"},
    {"label": "Last 5 Years", "value": "5y"},
    {"label": "Last 10 Years", "value": "10y"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> documentTypes = [
    {"label": "All Documents", "value": "All"},
    {"label": "Case Law", "value": "cases"},
    {"label": "Statutes", "value": "statutes"},
    {"label": "Regulations", "value": "regulations"},
    {"label": "Legal Articles", "value": "articles"},
    {"label": "Court Rules", "value": "rules"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Relevance", "value": "Relevance"},
    {"label": "Date (Newest)", "value": "date_desc"},
    {"label": "Date (Oldest)", "value": "date_asc"},
    {"label": "Citation Count", "value": "citations"},
    {"label": "Jurisdiction", "value": "jurisdiction"},
  ];

  List<Map<String, dynamic>> searchResults = [
    {
      "id": "1",
      "title": "Smith v. Johnson Manufacturing Corp.",
      "type": "Case Law",
      "jurisdiction": "California Supreme Court",
      "date": "2024-03-15",
      "citation": "123 Cal.4th 456 (2024)",
      "summary": "Landmark decision on product liability standards for manufacturing defects in consumer electronics...",
      "relevanceScore": 95,
      "citationCount": 47,
      "keyWords": ["product liability", "manufacturing defect", "consumer protection"],
      "fullText": true,
      "bookmarked": false
    },
    {
      "id": "2",
      "title": "Consumer Protection Act Section 1798.150",
      "type": "Statute",
      "jurisdiction": "California",
      "date": "2023-01-01",
      "citation": "Cal. Civ. Code § 1798.150",
      "summary": "Statutory provisions regarding private right of action for data breaches affecting personal information...",
      "relevanceScore": 89,
      "citationCount": 156,
      "keyWords": ["data breach", "privacy rights", "consumer protection"],
      "fullText": true,
      "bookmarked": true
    },
    {
      "id": "3",
      "title": "Federal Trade Commission v. Meta Platforms Inc.",
      "type": "Case Law",
      "jurisdiction": "Federal District Court",
      "date": "2024-01-20",
      "citation": "2024 U.S. Dist. LEXIS 8945",
      "summary": "Recent federal court decision on antitrust violations in social media platform operations...",
      "relevanceScore": 84,
      "citationCount": 23,
      "keyWords": ["antitrust", "social media", "competition law"],
      "fullText": true,
      "bookmarked": false
    },
    {
      "id": "4",
      "title": "Contract Law in the Digital Age",
      "type": "Legal Article",
      "jurisdiction": "Harvard Law Review",
      "date": "2024-02-10",
      "citation": "137 Harv. L. Rev. 892 (2024)",
      "summary": "Comprehensive analysis of how traditional contract principles apply to digital agreements and smart contracts...",
      "relevanceScore": 78,
      "citationCount": 12,
      "keyWords": ["contract law", "digital agreements", "smart contracts"],
      "fullText": false,
      "bookmarked": true
    },
    {
      "id": "5",
      "title": "New York Employment Discrimination Regulations",
      "type": "Regulation",
      "jurisdiction": "New York State",
      "date": "2023-07-01",
      "citation": "12 NYCRR 466.13",
      "summary": "Updated regulations on workplace discrimination prevention and reporting requirements...",
      "relevanceScore": 72,
      "citationCount": 34,
      "keyWords": ["employment law", "discrimination", "workplace rights"],
      "fullText": true,
      "bookmarked": false
    },
  ];

  List<Map<String, dynamic>> recentResearches = [
    {
      "query": "intellectual property licensing",
      "results": 156,
      "date": "2025-06-19",
      "duration": "45 min"
    },
    {
      "query": "corporate governance compliance",
      "results": 89,
      "date": "2025-06-18",
      "duration": "32 min"
    },
    {
      "query": "employment contract disputes",
      "results": 234,
      "date": "2025-06-17",
      "duration": "67 min"
    },
  ];

  Color _getTypeColor(String type) {
    switch (type) {
      case "Case Law":
        return primaryColor;
      case "Statute":
        return successColor;
      case "Regulation":
        return warningColor;
      case "Legal Article":
        return infoColor;
      case "Court Rules":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _toggleBookmark(String resultId) {
    setState(() {
      final index = searchResults.indexWhere((result) => result["id"] == resultId);
      if (index != -1) {
        searchResults[index]["bookmarked"] = !searchResults[index]["bookmarked"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Legal Research"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // View bookmarked results
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Research history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Interface
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Legal Research Query",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          advancedSearch = !advancedSearch;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: advancedSearch ? primaryColor : primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Advanced",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: advancedSearch ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search legal documents...",
                          value: searchQuery,
                          hint: "Enter keywords, case names, or legal concepts",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Search",
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {
                          // Perform search
                        },
                      ),
                    ],
                  ),
                  
                  if (advancedSearch) ...[
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Jurisdiction",
                            items: jurisdictions,
                            value: selectedJurisdiction,
                            onChanged: (value, label) {
                              selectedJurisdiction = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Document Type",
                            items: documentTypes,
                            value: selectedDocumentType,
                            onChanged: (value, label) {
                              selectedDocumentType = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Date Range",
                            items: dateRanges,
                            value: selectedDateRange,
                            onChanged: (value, label) {
                              selectedDateRange = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Sort By",
                            items: sortOptions,
                            value: selectedSortBy,
                            onChanged: (value, label) {
                              selectedSortBy = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Search Results Header
            if (searchQuery.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Search Results for \"$searchQuery\"",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${searchResults.length} documents found • Sorted by $selectedSortBy",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.tune,
                      size: bs.sm,
                      onPressed: () {
                        // Filter options
                      },
                    ),
                  ],
                ),
              ),

              // Search Results
              ...searchResults.map((result) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getTypeColor("${result["type"]}"),
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${result["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${result["relevanceScore"]}% match",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              GestureDetector(
                                onTap: () => _toggleBookmark("${result["id"]}"),
                                child: Icon(
                                  result["bookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                  color: result["bookmarked"] ? warningColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getTypeColor("${result["type"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${result["type"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getTypeColor("${result["type"]}"),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${result["jurisdiction"]} • ${DateTime.parse(result["date"] as String).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${result["citation"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${result["summary"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      QHorizontalScroll(
                        children: (result["keyWords"] as List).map((keyword) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: secondaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: secondaryColor.withAlpha(50)),
                            ),
                            child: Text(
                              "$keyword",
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.format_quote,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${result["citationCount"]} citations",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spMd),
                          if (result["fullText"])
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Full Text Available",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                ),
                              ),
                            ),
                          Spacer(),
                          Row(
                            children: [
                              QButton(
                                label: "View",
                                size: bs.sm,
                                onPressed: () {
                                  // View document
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {
                                  // Share document
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],

            // Recent Research Activity
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Research Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // View all research history
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...recentResearches.map((research) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: secondaryColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${research["query"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${research["results"]} results • ${research["duration"]} • ${DateTime.parse(research["date"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            icon: Icons.replay,
                            size: bs.sm,
                            onPressed: () {
                              // Repeat search
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              child: Column(
                spacing: spSm,
                children: [
                  QButton(
                    label: "Saved Searches",
                    icon: Icons.saved_search,
                    size: bs.md,
                    onPressed: () {
                      // View saved searches
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Research Tips",
                          icon: Icons.lightbulb,
                          size: bs.sm,
                          onPressed: () {
                            // Research guidance
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export Results",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            // Export search results
                          },
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
}
