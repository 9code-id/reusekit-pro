import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCitationManagementView extends StatefulWidget {
  const LcaCitationManagementView({super.key});

  @override
  State<LcaCitationManagementView> createState() => _LcaCitationManagementViewState();
}

class _LcaCitationManagementViewState extends State<LcaCitationManagementView> {
  String selectedStyle = "Bluebook";
  String selectedCollection = "All";
  String searchQuery = "";
  String selectedType = "All";
  
  List<Map<String, dynamic>> citationStyles = [
    {"label": "Bluebook (20th)", "value": "Bluebook"},
    {"label": "ALWD Guide", "value": "ALWD"},
    {"label": "Chicago Manual", "value": "Chicago"},
    {"label": "MLA Style", "value": "MLA"},
    {"label": "APA Style", "value": "APA"},
    {"label": "Harvard Referencing", "value": "Harvard"},
  ];

  List<Map<String, dynamic>> collections = [
    {"label": "All Citations", "value": "All"},
    {"label": "Research Project A", "value": "project_a"},
    {"label": "Employment Law Brief", "value": "employment"},
    {"label": "Contract Dispute Case", "value": "contract"},
    {"label": "Constitutional Law Paper", "value": "constitutional"},
    {"label": "Saved for Later", "value": "saved"},
  ];

  List<Map<String, dynamic>> citationTypes = [
    {"label": "All Types", "value": "All"},
    {"label": "Case Law", "value": "case"},
    {"label": "Statutes", "value": "statute"},
    {"label": "Law Reviews", "value": "article"},
    {"label": "Books", "value": "book"},
    {"label": "Regulations", "value": "regulation"},
    {"label": "Web Sources", "value": "web"},
  ];

  List<Map<String, dynamic>> citations = [
    {
      "id": "1",
      "title": "Brown v. Board of Education",
      "type": "case",
      "citation": "347 U.S. 483 (1954)",
      "bluebookFormat": "Brown v. Bd. of Educ., 347 U.S. 483 (1954).",
      "alwdFormat": "Brown v. Board of Education, 347 U.S. 483 (1954).",
      "collection": "constitutional",
      "dateAdded": "2025-06-19",
      "notes": "Landmark civil rights case overturning separate but equal doctrine",
      "pinCite": "486-87",
      "tags": ["civil rights", "education", "equal protection"],
      "frequency": 15,
      "lastUsed": "2025-06-18",
      "verified": true,
      "url": "https://supreme.justia.com/cases/federal/us/347/483/"
    },
    {
      "id": "2",
      "title": "Privacy Rights in Digital Age",
      "type": "article",
      "citation": "123 Harv. L. Rev. 456 (2024)",
      "bluebookFormat": "Jane Smith, Privacy Rights in Digital Age, 123 Harv. L. Rev. 456 (2024).",
      "alwdFormat": "Jane Smith, Privacy Rights in Digital Age, 123 Harv. L. Rev. 456 (2024).",
      "collection": "project_a",
      "dateAdded": "2025-06-18",
      "notes": "Comprehensive analysis of privacy law evolution",
      "pinCite": "467-470",
      "tags": ["privacy", "digital rights", "technology law"],
      "frequency": 8,
      "lastUsed": "2025-06-17",
      "verified": true,
      "url": "https://harvardlawreview.org/example"
    },
    {
      "id": "3",
      "title": "Employment Discrimination Statute",
      "type": "statute",
      "citation": "42 U.S.C. § 2000e (2018)",
      "bluebookFormat": "42 U.S.C. § 2000e (2018).",
      "alwdFormat": "42 U.S.C. § 2000e (2018).",
      "collection": "employment",
      "dateAdded": "2025-06-17",
      "notes": "Title VII civil rights act provisions",
      "pinCite": "§ 2000e-2",
      "tags": ["employment", "discrimination", "civil rights"],
      "frequency": 12,
      "lastUsed": "2025-06-19",
      "verified": true,
      "url": "https://www.law.cornell.edu/uscode/text/42/2000e"
    },
    {
      "id": "4",
      "title": "Contract Law: Theory and Practice",
      "type": "book",
      "citation": "John Doe, Contract Law: Theory and Practice (5th ed. 2023)",
      "bluebookFormat": "John Doe, Contract Law: Theory and Practice 234 (5th ed. 2023).",
      "alwdFormat": "John Doe, Contract Law: Theory and Practice 234 (5th ed. 2023).",
      "collection": "contract",
      "dateAdded": "2025-06-16",
      "notes": "Comprehensive contract law treatise",
      "pinCite": "234-236",
      "tags": ["contracts", "theory", "practice"],
      "frequency": 6,
      "lastUsed": "2025-06-15",
      "verified": true,
      "url": ""
    },
    {
      "id": "5",
      "title": "Federal Privacy Regulations",
      "type": "regulation",
      "citation": "16 C.F.R. § 312 (2023)",
      "bluebookFormat": "16 C.F.R. § 312 (2023).",
      "alwdFormat": "16 C.F.R. § 312 (2023).",
      "collection": "project_a",
      "dateAdded": "2025-06-15",
      "notes": "COPPA regulations for children's privacy",
      "pinCite": "§ 312.3",
      "tags": ["privacy", "regulations", "children"],
      "frequency": 4,
      "lastUsed": "2025-06-14",
      "verified": false,
      "url": "https://www.ecfr.gov/current/title-16/chapter-I/subchapter-C/part-312"
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "action": "Added",
      "citation": "Miranda v. Arizona, 384 U.S. 436 (1966)",
      "collection": "constitutional",
      "timestamp": "2025-06-19 14:30"
    },
    {
      "action": "Formatted",
      "citation": "Brown v. Board of Education",
      "style": "Bluebook",
      "timestamp": "2025-06-19 11:15"
    },
    {
      "action": "Exported",
      "citation": "Employment Law Bibliography",
      "format": "Word Document",
      "timestamp": "2025-06-18 16:45"
    },
  ];

  Color _getTypeColor(String type) {
    switch (type) {
      case "case":
        return primaryColor;
      case "statute":
        return successColor;
      case "article":
        return infoColor;
      case "book":
        return secondaryColor;
      case "regulation":
        return warningColor;
      case "web":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "case":
        return "Case Law";
      case "statute":
        return "Statute";
      case "article":
        return "Article";
      case "book":
        return "Book";
      case "regulation":
        return "Regulation";
      case "web":
        return "Web Source";
      default:
        return "Unknown";
    }
  }

  List<Map<String, dynamic>> get filteredCitations {
    return citations.where((citation) {
      bool collectionMatch = selectedCollection == "All" || citation["collection"] == selectedCollection;
      bool typeMatch = selectedType == "All" || citation["type"] == selectedType;
      bool searchMatch = searchQuery.isEmpty || 
          citation["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          citation["citation"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return collectionMatch && typeMatch && searchMatch;
    }).toList();
  }

  String _getFormattedCitation(Map<String, dynamic> citation) {
    switch (selectedStyle) {
      case "Bluebook":
        return citation["bluebookFormat"];
      case "ALWD":
        return citation["alwdFormat"];
      default:
        return citation["citation"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Citation Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new citation
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export citations
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
            // Citation Tools Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.format_quote,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Citation Management",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${citations.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Citations",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${collections.length - 1}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Collections",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${citationStyles.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Style Formats",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
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

            // Search and Filters
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
                  Text(
                    "Search & Filter Citations",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search citations...",
                          value: searchQuery,
                          hint: "Enter title, citation, or keywords",
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
                          // Search citations
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Citation Style",
                          items: citationStyles,
                          value: selectedStyle,
                          onChanged: (value, label) {
                            selectedStyle = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Collection",
                          items: collections,
                          value: selectedCollection,
                          onChanged: (value, label) {
                            selectedCollection = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Type",
                    items: citationTypes,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Citation List
            Text(
              "Citations (${filteredCitations.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredCitations.map((citation) {
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
                      color: _getTypeColor("${citation["type"]}"),
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
                            "${citation["title"]}",
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
                                color: _getTypeColor("${citation["type"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getTypeLabel("${citation["type"]}"),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getTypeColor("${citation["type"]}"),
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            if (citation["verified"])
                              Icon(
                                Icons.verified,
                                size: 16,
                                color: successColor,
                              )
                            else
                              Icon(
                                Icons.warning,
                                size: 16,
                                color: warningColor,
                              ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Formatted Citation
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: secondaryColor.withAlpha(30)),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$selectedStyle Format:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // Copy citation
                                },
                                child: Icon(
                                  Icons.copy,
                                  size: 16,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            _getFormattedCitation(citation),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "monospace",
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (citation["notes"] != null && citation["notes"].toString().isNotEmpty)
                      Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notes:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${citation["notes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                    if (citation["pinCite"] != null && citation["pinCite"].toString().isNotEmpty)
                      Row(
                        children: [
                          Text(
                            "Pin Cite: ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${citation["pinCite"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                    // Tags
                    if ((citation["tags"] as List).isNotEmpty)
                      Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tags:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          QHorizontalScroll(
                            children: (citation["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: infoColor.withAlpha(50)),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Used ${citation["frequency"]} times",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "Added ${DateTime.parse(citation["dateAdded"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () {
                                // Edit citation
                              },
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                // More options
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

            // Recent Activity
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
                        "Recent Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // View all activity
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
                  ...recentActivity.map((activity) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: secondaryColor.withAlpha(30)),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${activity["action"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${activity["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${activity["citation"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
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
                    label: "Add New Citation",
                    icon: Icons.add,
                    size: bs.md,
                    onPressed: () {
                      // Add citation form
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Import Bibliography",
                          icon: Icons.upload,
                          size: bs.sm,
                          onPressed: () {
                            // Import from file
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export All",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            // Export all citations
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Style Guide",
                          icon: Icons.help,
                          size: bs.sm,
                          onPressed: () {
                            // Citation style guide
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Verify Citations",
                          icon: Icons.fact_check,
                          size: bs.sm,
                          onPressed: () {
                            // Verify all citations
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
