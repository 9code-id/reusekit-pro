import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaAnalysisView extends StatefulWidget {
  const NmaAnalysisView({super.key});

  @override
  State<NmaAnalysisView> createState() => _NmaAnalysisViewState();
}

class _NmaAnalysisViewState extends State<NmaAnalysisView> {
  String selectedType = "All";
  String selectedComplexity = "All";
  String selectedDomain = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> analyses = [
    {
      "id": 1,
      "title": "Economic Impact Analysis: Remote Work Revolution",
      "subtitle": "Comprehensive study of post-pandemic labor market transformation",
      "type": "Economic",
      "complexity": "Advanced",
      "domain": "Labor Economics",
      "analyst": "Dr. Michael Patterson",
      "analystImage": "https://picsum.photos/100/100?random=1&keyword=economist",
      "institution": "Economic Research Institute",
      "publishedAt": "2024-01-16T09:30:00Z",
      "readTime": 25,
      "methodology": "Quantitative Analysis",
      "dataPoints": 50000,
      "confidence": 94,
      "excerpt": "This comprehensive analysis examines the long-term economic implications of the remote work shift, including productivity metrics, real estate impacts, and regional economic redistribution patterns.",
      "image": "https://picsum.photos/500/300?random=1&keyword=economic",
      "keyFindings": [
        "15% increase in overall productivity",
        "23% reduction in commercial real estate demand",
        "Regional economic redistribution to smaller cities"
      ],
      "tags": ["Economics", "Remote Work", "Productivity", "Real Estate"],
      "downloadCount": 2340,
      "citations": 156,
      "likes": 892,
      "isBookmarked": false,
      "isVerified": true,
      "charts": 12,
      "tables": 8,
      "references": 145,
    },
    {
      "id": 2,
      "title": "Climate Policy Effectiveness Assessment",
      "subtitle": "Multi-nation comparative analysis of carbon reduction strategies",
      "type": "Environmental",
      "complexity": "Expert",
      "domain": "Environmental Policy",
      "analyst": "Dr. Sarah Chen",
      "analystImage": "https://picsum.photos/100/100?random=2&keyword=scientist",
      "institution": "Global Climate Research Center",
      "publishedAt": "2024-01-15T14:20:00Z",
      "readTime": 35,
      "methodology": "Comparative Case Study",
      "dataPoints": 75000,
      "confidence": 91,
      "excerpt": "Evaluating the real-world effectiveness of various carbon reduction policies across 15 developed nations, with focus on implementation challenges and measurable outcomes.",
      "image": "https://picsum.photos/500/300?random=2&keyword=climate",
      "keyFindings": [
        "Carbon tax most effective in Nordic countries",
        "Cap-and-trade shows mixed results",
        "Renewable subsidies drive fastest adoption"
      ],
      "tags": ["Climate", "Policy", "Carbon", "International"],
      "downloadCount": 3456,
      "citations": 289,
      "likes": 1234,
      "isBookmarked": true,
      "isVerified": true,
      "charts": 18,
      "tables": 15,
      "references": 298,
    },
    {
      "id": 3,
      "title": "Social Media Influence on Political Discourse",
      "subtitle": "Behavioral analysis of information consumption patterns",
      "type": "Social",
      "complexity": "Intermediate",
      "domain": "Political Science",
      "analyst": "Prof. David Rodriguez",
      "analystImage": "https://picsum.photos/100/100?random=3&keyword=professor",
      "institution": "Digital Democracy Lab",
      "publishedAt": "2024-01-14T11:45:00Z",
      "readTime": 18,
      "methodology": "Behavioral Analysis",
      "dataPoints": 25000,
      "confidence": 87,
      "excerpt": "Investigating how social media algorithms affect political opinion formation, echo chambers, and civic engagement among different demographic groups.",
      "image": "https://picsum.photos/500/300?random=3&keyword=social",
      "keyFindings": [
        "Echo chambers stronger in partisan content",
        "Young adults most susceptible to influence",
        "Fact-checking reduces misinformation spread"
      ],
      "tags": ["Social Media", "Politics", "Behavior", "Democracy"],
      "downloadCount": 1890,
      "citations": 98,
      "likes": 567,
      "isBookmarked": false,
      "isVerified": true,
      "charts": 8,
      "tables": 5,
      "references": 87,
    },
    {
      "id": 4,
      "title": "Healthcare System Efficiency Metrics",
      "subtitle": "Comparative analysis of service delivery models",
      "type": "Healthcare",
      "complexity": "Advanced",
      "domain": "Health Policy",
      "analyst": "Dr. Lisa Kim",
      "analystImage": "https://picsum.photos/100/100?random=4&keyword=doctor",
      "institution": "Health Systems Research",
      "publishedAt": "2024-01-13T16:30:00Z",
      "readTime": 22,
      "methodology": "Statistical Modeling",
      "dataPoints": 40000,
      "confidence": 92,
      "excerpt": "Comprehensive evaluation of healthcare delivery efficiency across public and private systems, focusing on cost-effectiveness and patient outcomes.",
      "image": "https://picsum.photos/500/300?random=4&keyword=healthcare",
      "keyFindings": [
        "Integrated care models show 30% better outcomes",
        "Digital health records improve efficiency by 18%",
        "Preventive care reduces long-term costs"
      ],
      "tags": ["Healthcare", "Efficiency", "Policy", "Outcomes"],
      "downloadCount": 2156,
      "citations": 187,
      "likes": 743,
      "isBookmarked": true,
      "isVerified": true,
      "charts": 14,
      "tables": 11,
      "references": 203,
    },
    {
      "id": 5,
      "title": "Technology Adoption in Education",
      "subtitle": "Learning outcome analysis across digital platforms",
      "type": "Educational",
      "complexity": "Intermediate",
      "domain": "Educational Technology",
      "analyst": "Prof. Emma Anderson",
      "analystImage": "https://picsum.photos/100/100?random=5&keyword=teacher",
      "institution": "EdTech Research Institute",
      "publishedAt": "2024-01-12T10:15:00Z",
      "readTime": 16,
      "methodology": "Longitudinal Study",
      "dataPoints": 18000,
      "confidence": 89,
      "excerpt": "Examining the impact of various educational technologies on student performance, engagement, and learning retention across different age groups and subjects.",
      "image": "https://picsum.photos/500/300?random=5&keyword=education",
      "keyFindings": [
        "Interactive content improves retention by 25%",
        "Personalized learning paths increase engagement",
        "Digital tools most effective in STEM subjects"
      ],
      "tags": ["Education", "Technology", "Learning", "Students"],
      "downloadCount": 1456,
      "citations": 76,
      "likes": 432,
      "isBookmarked": false,
      "isVerified": true,
      "charts": 10,
      "tables": 6,
      "references": 98,
    },
  ];

  List<String> types = ["All", "Economic", "Environmental", "Social", "Healthcare", "Educational", "Political"];
  List<String> complexities = ["All", "Beginner", "Intermediate", "Advanced", "Expert"];
  List<String> domains = ["All", "Labor Economics", "Environmental Policy", "Political Science", "Health Policy", "Educational Technology"];

  List<Map<String, dynamic>> get filteredAnalyses {
    return analyses.where((analysis) {
      bool matchesSearch = "${analysis["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${analysis["excerpt"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedType == "All" || "${analysis["type"]}" == selectedType;
      bool matchesComplexity = selectedComplexity == "All" || "${analysis["complexity"]}" == selectedComplexity;
      bool matchesDomain = selectedDomain == "All" || "${analysis["domain"]}" == selectedDomain;
      
      return matchesSearch && matchesType && matchesComplexity && matchesDomain;
    }).toList();
  }

  Color _getComplexityColor(String complexity) {
    switch (complexity) {
      case "Beginner": return successColor;
      case "Intermediate": return infoColor;
      case "Advanced": return warningColor;
      case "Expert": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("In-Depth Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search analyses",
                    value: searchQuery,
                    hint: "Search by title, author, or content",
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
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Row 1
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: types.map((type) => {"label": type, "value": type}).toList(),
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Complexity",
                    items: complexities.map((complexity) => {"label": complexity, "value": complexity}).toList(),
                    value: selectedComplexity,
                    onChanged: (value, label) {
                      selectedComplexity = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Domain Filter
            QDropdownField(
              label: "Research Domain",
              items: domains.map((domain) => {"label": domain, "value": domain}).toList(),
              value: selectedDomain,
              onChanged: (value, label) {
                selectedDomain = value;
                setState(() {});
              },
            ),

            // Analytics Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Research Analytics Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${filteredAnalyses.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Analyses",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(filteredAnalyses.fold(0, (sum, analysis) => sum + (analysis["dataPoints"] as int)) / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Data Points",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(filteredAnalyses.fold(0, (sum, analysis) => sum + (analysis["confidence"] as int)) / filteredAnalyses.length).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Avg Confidence",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
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

            // Analysis Cards
            ...filteredAnalyses.map((analysis) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getComplexityColor(analysis["complexity"] as String),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Header Image
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${analysis["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Complexity Badge
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getComplexityColor(analysis["complexity"] as String),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${analysis["complexity"]}".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Verified Badge
                          if (analysis["isVerified"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "VERIFIED",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Analysis Content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        // Type and Domain
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${analysis["type"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${analysis["domain"]}",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${analysis["readTime"]} min read",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Title and Subtitle
                        Text(
                          "${analysis["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            height: 1.3,
                          ),
                        ),
                        Text(
                          "${analysis["subtitle"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: secondaryColor,
                            height: 1.3,
                          ),
                        ),

                        // Excerpt
                        Text(
                          "${analysis["excerpt"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),

                        // Research Metrics
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${((analysis["dataPoints"] as int) / 1000).toStringAsFixed(0)}K",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: infoColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Data Points",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 30,
                                color: disabledOutlineBorderColor,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${analysis["confidence"]}%",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Confidence",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 30,
                                color: disabledOutlineBorderColor,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${analysis["methodology"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Method",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Key Findings
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Key Findings:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            ...(analysis["keyFindings"] as List).map((finding) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "$finding",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),

                        // Tags
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (analysis["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  color: infoColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        // Analyst Info
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                image: DecorationImage(
                                  image: NetworkImage("${analysis["analystImage"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${analysis["analyst"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "${analysis["institution"]} • ${DateTime.parse(analysis["publishedAt"] as String).dMMMy}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                analysis["isBookmarked"] = !(analysis["isBookmarked"] as bool);
                                setState(() {});
                              },
                              child: Icon(
                                (analysis["isBookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),

                        // Stats and Actions
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.download,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${analysis["downloadCount"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: spMd),
                            Row(
                              children: [
                                Icon(
                                  Icons.format_quote,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${analysis["citations"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            QButton(
                              label: "Read Analysis",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredAnalyses.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.analytics,
                      size: 60,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No analyses found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search criteria or filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
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
}
