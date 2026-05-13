import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaFactCheckView extends StatefulWidget {
  const NmaFactCheckView({super.key});

  @override
  State<NmaFactCheckView> createState() => _NmaFactCheckViewState();
}

class _NmaFactCheckViewState extends State<NmaFactCheckView> {
  String selectedStatus = "All";
  String selectedCategory = "All";
  String searchQuery = "";
  String selectedTimeframe = "All Time";
  
  List<Map<String, dynamic>> factChecks = [
    {
      "id": 1,
      "claim": "COVID-19 vaccines contain microchips for tracking",
      "status": "False",
      "verdict": "Completely False",
      "category": "Health",
      "claimant": "Social Media Post",
      "originalSource": "Facebook viral post",
      "checkedBy": "Dr. Sarah Johnson",
      "checkerTitle": "Medical Fact Checker",
      "checkerImage": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "organization": "Health Facts Institute",
      "publishedAt": "2024-01-16T10:30:00Z",
      "lastUpdated": "2024-01-16T10:30:00Z",
      "evidence": [
        "No scientific evidence supports this claim",
        "Vaccine ingredients are publicly documented",
        "Microchip technology cannot fit through vaccine needles"
      ],
      "sources": [
        "WHO Official Statement",
        "CDC Vaccine Ingredient List",
        "IEEE Technology Analysis"
      ],
      "relatedFacts": 3,
      "shareCount": 2340,
      "helpful": 1890,
      "notHelpful": 156,
      "tags": ["Vaccine", "Microchip", "COVID-19", "Technology"],
      "isBookmarked": false,
      "confidence": 100,
      "difficulty": "Easy",
    },
    {
      "id": 2,
      "claim": "Electric vehicles are worse for environment than gas cars",
      "status": "Misleading",
      "verdict": "Mostly False with Context",
      "category": "Environment",
      "claimant": "News Article",
      "originalSource": "Local newspaper opinion piece",
      "checkedBy": "Prof. Michael Chen",
      "checkerTitle": "Environmental Scientist",
      "checkerImage": "https://picsum.photos/100/100?random=2&keyword=scientist",
      "organization": "Climate Truth Initiative",
      "publishedAt": "2024-01-15T14:20:00Z",
      "lastUpdated": "2024-01-15T16:45:00Z",
      "evidence": [
        "EVs have lower lifetime emissions despite battery production",
        "Manufacturing impact decreases as battery technology improves",
        "Grid electricity mix affects overall environmental impact"
      ],
      "sources": [
        "EPA Lifecycle Analysis",
        "MIT Energy Study",
        "European Environment Agency Report"
      ],
      "relatedFacts": 7,
      "shareCount": 1567,
      "helpful": 1234,
      "notHelpful": 89,
      "tags": ["Electric Vehicles", "Environment", "Climate", "Energy"],
      "isBookmarked": true,
      "confidence": 85,
      "difficulty": "Moderate",
    },
    {
      "id": 3,
      "claim": "Voting machines in recent election were hacked",
      "status": "Unproven",
      "verdict": "No Evidence Found",
      "category": "Politics",
      "claimant": "Political Figure",
      "originalSource": "Campaign rally speech",
      "checkedBy": "Emma Rodriguez",
      "checkerTitle": "Election Security Expert",
      "checkerImage": "https://picsum.photos/100/100?random=3&keyword=security",
      "organization": "Election Integrity Watch",
      "publishedAt": "2024-01-14T09:15:00Z",
      "lastUpdated": "2024-01-15T11:30:00Z",
      "evidence": [
        "No credible evidence of voting machine hacking",
        "Post-election audits found no discrepancies",
        "Cybersecurity agencies reported secure election"
      ],
      "sources": [
        "DHS Election Security Report",
        "State Election Audit Results",
        "Cybersecurity and Infrastructure Security Agency"
      ],
      "relatedFacts": 12,
      "shareCount": 3456,
      "helpful": 2890,
      "notHelpful": 234,
      "tags": ["Election", "Voting", "Security", "Democracy"],
      "isBookmarked": false,
      "confidence": 95,
      "difficulty": "Complex",
    },
    {
      "id": 4,
      "claim": "5G networks cause cancer and other health problems",
      "status": "False",
      "verdict": "No Scientific Evidence",
      "category": "Technology",
      "claimant": "Online Forum",
      "originalSource": "Conspiracy theory website",
      "checkedBy": "Dr. Lisa Kim",
      "checkerTitle": "Radiation Safety Specialist",
      "checkerImage": "https://picsum.photos/100/100?random=4&keyword=radiation",
      "organization": "Telecom Safety Institute",
      "publishedAt": "2024-01-13T16:40:00Z",
      "lastUpdated": "2024-01-13T16:40:00Z",
      "evidence": [
        "5G uses non-ionizing radiation like existing cell towers",
        "Extensive studies show no link to cancer",
        "WHO and FDA classify 5G as safe"
      ],
      "sources": [
        "WHO Electromagnetic Fields Report",
        "FDA Wireless Device Safety",
        "International Commission on Non-Ionizing Radiation"
      ],
      "relatedFacts": 5,
      "shareCount": 987,
      "helpful": 756,
      "notHelpful": 45,
      "tags": ["5G", "Health", "Technology", "Radiation"],
      "isBookmarked": true,
      "confidence": 98,
      "difficulty": "Easy",
    },
    {
      "id": 5,
      "claim": "Renewable energy cannot meet global electricity demand",
      "status": "Outdated",
      "verdict": "Based on Old Data",
      "category": "Energy",
      "claimant": "Industry Report",
      "originalSource": "Energy sector analysis from 2020",
      "checkedBy": "Prof. David Anderson",
      "checkerTitle": "Energy Policy Analyst",
      "checkerImage": "https://picsum.photos/100/100?random=5&keyword=energy",
      "organization": "Renewable Energy Research Center",
      "publishedAt": "2024-01-12T11:25:00Z",
      "lastUpdated": "2024-01-14T09:15:00Z",
      "evidence": [
        "Recent technology advances increase renewable capacity",
        "Multiple countries already achieve 100% renewable electricity",
        "Grid storage solutions address intermittency issues"
      ],
      "sources": [
        "International Renewable Energy Agency",
        "Grid Integration Studies",
        "National Renewable Energy Laboratory"
      ],
      "relatedFacts": 8,
      "shareCount": 1123,
      "helpful": 891,
      "notHelpful": 67,
      "tags": ["Renewable Energy", "Grid", "Technology", "Sustainability"],
      "isBookmarked": false,
      "confidence": 80,
      "difficulty": "Moderate",
    },
  ];

  List<String> statuses = ["All", "True", "False", "Misleading", "Unproven", "Outdated"];
  List<String> categories = ["All", "Health", "Environment", "Politics", "Technology", "Energy", "Economy"];
  List<String> timeframes = ["All Time", "Today", "This Week", "This Month"];

  List<Map<String, dynamic>> get filteredFactChecks {
    return factChecks.where((factCheck) {
      bool matchesSearch = "${factCheck["claim"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${factCheck["claimant"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || "${factCheck["status"]}" == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || "${factCheck["category"]}" == selectedCategory;
      
      // Simple timeframe filter
      bool matchesTimeframe = true;
      if (selectedTimeframe != "All Time") {
        DateTime publishedDate = DateTime.parse(factCheck["publishedAt"] as String);
        DateTime now = DateTime.now();
        switch (selectedTimeframe) {
          case "Today":
            matchesTimeframe = publishedDate.day == now.day;
            break;
          case "This Week":
            matchesTimeframe = now.difference(publishedDate).inDays <= 7;
            break;
          case "This Month":
            matchesTimeframe = now.difference(publishedDate).inDays <= 30;
            break;
        }
      }
      
      return matchesSearch && matchesStatus && matchesCategory && matchesTimeframe;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "True": return successColor;
      case "False": return dangerColor;
      case "Misleading": return warningColor;
      case "Unproven": return infoColor;
      case "Outdated": return disabledBoldColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fact Check Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.fact_check),
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
                    label: "Search fact checks",
                    value: searchQuery,
                    hint: "Search claims, claimants, or topics",
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

            // Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statuses.map((status) => {"label": status, "value": status}).toList(),
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {"label": category, "value": category}).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Timeframe Filter
            QCategoryPicker(
              items: timeframes.map((timeframe) => {
                "label": timeframe,
                "value": timeframe,
              }).toList(),
              value: selectedTimeframe,
              onChanged: (index, label, value, item) {
                selectedTimeframe = value;
                setState(() {});
              },
            ),

            // Fact Check Stats
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
                    "Fact Check Statistics",
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
                              "${filteredFactChecks.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Checks",
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
                              "${filteredFactChecks.where((fc) => fc["status"] == "False").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "False Claims",
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
                              "${(filteredFactChecks.fold(0, (sum, fc) => sum + (fc["confidence"] as int)) / filteredFactChecks.length).toStringAsFixed(0)}%",
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

            // Submit Claim Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.add_task,
                    color: infoColor,
                    size: 30,
                  ),
                  Text(
                    "Submit a Claim for Fact-Checking",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "Help us verify information by submitting claims you've encountered",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  QButton(
                    label: "Submit Claim",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Fact Check Cards
            ...filteredFactChecks.map((factCheck) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(factCheck["status"] as String),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Status Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(factCheck["status"] as String),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${factCheck["status"]}".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
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
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${factCheck["category"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${factCheck["confidence"]}% confidence",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // Claim
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "CLAIM:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Text(
                            "${factCheck["claim"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Verdict
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "VERDICT:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getStatusColor(factCheck["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: _getStatusColor(factCheck["status"] as String).withAlpha(40)),
                          ),
                          child: Text(
                            "${factCheck["verdict"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(factCheck["status"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Evidence
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "EVIDENCE:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        ...(factCheck["evidence"] as List).map((evidence) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "$evidence",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),

                    // Sources
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "SOURCES:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (factCheck["sources"] as List).map((source) {
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
                                "$source",
                                style: TextStyle(
                                  color: infoColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    // Tags
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (factCheck["tags"] as List).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "#$tag",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Checker Info
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusMd),
                            image: DecorationImage(
                              image: NetworkImage("${factCheck["checkerImage"]}"),
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
                                "${factCheck["checkedBy"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${factCheck["checkerTitle"]} • ${factCheck["organization"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Published: ${DateTime.parse(factCheck["publishedAt"] as String).dMMMy}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            factCheck["isBookmarked"] = !(factCheck["isBookmarked"] as bool);
                            setState(() {});
                          },
                          child: Icon(
                            (factCheck["isBookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),

                    // Engagement Stats and Actions
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.thumb_up_outlined,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${factCheck["helpful"]}",
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
                              Icons.thumb_down_outlined,
                              color: dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${factCheck["notHelpful"]}",
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
                              Icons.share_outlined,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${factCheck["shareCount"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        QButton(
                          label: "Full Report",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredFactChecks.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.fact_check,
                      size: 60,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No fact checks found",
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
