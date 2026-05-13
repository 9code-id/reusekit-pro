import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaEditorialsView extends StatefulWidget {
  const NmaEditorialsView({super.key});

  @override
  State<NmaEditorialsView> createState() => _NmaEditorialsViewState();
}

class _NmaEditorialsViewState extends State<NmaEditorialsView> {
  String selectedTopic = "All";
  String selectedPriority = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> editorials = [
    {
      "id": 1,
      "title": "The Need for Digital Privacy Reform",
      "subtitle": "Protecting citizens in the age of data exploitation",
      "topic": "Technology",
      "priority": "High",
      "publishedAt": "2024-01-16T09:00:00Z",
      "readTime": 15,
      "excerpt": "As technology companies amass unprecedented amounts of personal data, governments must act swiftly to implement comprehensive privacy legislation that protects individual rights while fostering innovation.",
      "image": "https://picsum.photos/400/250?random=1&keyword=privacy",
      "editorName": "Editorial Board",
      "position": "Pro-regulation",
      "impact": "National",
      "urgency": "Immediate",
      "likes": 2340,
      "comments": 456,
      "shares": 789,
      "isBookmarked": false,
      "tags": ["Privacy", "Technology", "Regulation", "Data"],
      "stance": "Progressive",
      "featured": true,
    },
    {
      "id": 2,
      "title": "Climate Action Cannot Wait",
      "subtitle": "The economic imperative of environmental leadership",
      "topic": "Environment",
      "priority": "Critical",
      "publishedAt": "2024-01-16T07:30:00Z",
      "readTime": 12,
      "excerpt": "The window for meaningful climate action continues to narrow. Bold policy decisions and substantial investments in renewable energy infrastructure are not just environmental necessities—they are economic imperatives.",
      "image": "https://picsum.photos/400/250?random=2&keyword=climate",
      "editorName": "Environmental Desk",
      "position": "Pro-action",
      "impact": "Global",
      "urgency": "Critical",
      "likes": 3456,
      "comments": 892,
      "shares": 1234,
      "isBookmarked": true,
      "tags": ["Climate", "Environment", "Policy", "Economy"],
      "stance": "Progressive",
      "featured": true,
    },
    {
      "id": 3,
      "title": "Healthcare Accessibility Crisis",
      "subtitle": "Addressing systemic barriers to medical care",
      "topic": "Healthcare",
      "priority": "High",
      "publishedAt": "2024-01-15T14:20:00Z",
      "readTime": 10,
      "excerpt": "Rising healthcare costs and insurance complexities are creating a two-tiered system that undermines the fundamental principle of equal access to medical care for all citizens.",
      "image": "https://picsum.photos/400/250?random=3&keyword=healthcare",
      "editorName": "Health Policy Team",
      "position": "Reform-oriented",
      "impact": "National",
      "urgency": "High",
      "likes": 1890,
      "comments": 234,
      "shares": 445,
      "isBookmarked": false,
      "tags": ["Healthcare", "Policy", "Access", "Reform"],
      "stance": "Centrist",
      "featured": false,
    },
    {
      "id": 4,
      "title": "Education Funding Inequalities",
      "subtitle": "Bridging the gap between districts",
      "topic": "Education",
      "priority": "Medium",
      "publishedAt": "2024-01-15T11:45:00Z",
      "readTime": 8,
      "excerpt": "Disparities in school funding continue to perpetuate educational inequalities. A comprehensive approach to resource allocation could help ensure every student receives quality education regardless of their zip code.",
      "image": "https://picsum.photos/400/250?random=4&keyword=education",
      "editorName": "Education Editorial",
      "position": "Reform-supportive",
      "impact": "Regional",
      "urgency": "Medium",
      "likes": 1245,
      "comments": 123,
      "shares": 267,
      "isBookmarked": true,
      "tags": ["Education", "Funding", "Equality", "Policy"],
      "stance": "Progressive",
      "featured": false,
    },
    {
      "id": 5,
      "title": "Infrastructure Investment Imperative",
      "subtitle": "Building for economic competitiveness",
      "topic": "Economy",
      "priority": "High",
      "publishedAt": "2024-01-14T16:10:00Z",
      "readTime": 11,
      "excerpt": "Aging infrastructure threatens economic growth and public safety. Strategic investments in roads, bridges, broadband, and utilities are essential for maintaining competitive advantage in the global economy.",
      "image": "https://picsum.photos/400/250?random=5&keyword=infrastructure",
      "editorName": "Economic Policy Board",
      "position": "Investment-focused",
      "impact": "National",
      "urgency": "High",
      "likes": 2156,
      "comments": 345,
      "shares": 678,
      "isBookmarked": false,
      "tags": ["Infrastructure", "Economy", "Investment", "Growth"],
      "stance": "Centrist",
      "featured": false,
    },
  ];

  List<String> topics = ["All", "Technology", "Environment", "Healthcare", "Education", "Economy", "Politics"];
  List<String> priorities = ["All", "Critical", "High", "Medium", "Low"];
  List<String> stances = ["All", "Progressive", "Conservative", "Centrist"];
  
  String selectedStance = "All";

  List<Map<String, dynamic>> get filteredEditorials {
    return editorials.where((editorial) {
      bool matchesSearch = "${editorial["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${editorial["excerpt"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesTopic = selectedTopic == "All" || "${editorial["topic"]}" == selectedTopic;
      bool matchesPriority = selectedPriority == "All" || "${editorial["priority"]}" == selectedPriority;
      bool matchesStance = selectedStance == "All" || "${editorial["stance"]}" == selectedStance;
      
      return matchesSearch && matchesTopic && matchesPriority && matchesStance;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical": return dangerColor;
      case "High": return warningColor;
      case "Medium": return infoColor;
      case "Low": return successColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editorial Board"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
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
                    label: "Search editorials",
                    value: searchQuery,
                    hint: "Search by title or content",
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

            // Filters Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Topic",
                    items: topics.map((topic) => {"label": topic, "value": topic}).toList(),
                    value: selectedTopic,
                    onChanged: (value, label) {
                      selectedTopic = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorities.map((priority) => {"label": priority, "value": priority}).toList(),
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Stance Filter
            QCategoryPicker(
              items: stances.map((stance) => {
                "label": stance,
                "value": stance,
              }).toList(),
              value: selectedStance,
              onChanged: (index, label, value, item) {
                selectedStance = value;
                setState(() {});
              },
            ),

            // Editorial Board Stats
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
                    "Editorial Board Insights",
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
                              "${filteredEditorials.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Editorials",
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
                              "${filteredEditorials.where((ed) => ed["priority"] == "Critical" || ed["priority"] == "High").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "High Priority",
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
                              "${filteredEditorials.where((ed) => ed["featured"] as bool).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Featured",
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

            // Featured Editorials Section
            if (filteredEditorials.any((ed) => ed["featured"] as bool))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Featured Editorials",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...filteredEditorials.where((ed) => ed["featured"] as bool).map((editorial) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowMd],
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: _getPriorityColor(editorial["priority"] as String),
                          ),
                        ),
                      ),
                      child: Column(
                        spacing: spMd,
                        children: [
                          // Header Image
                          Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${editorial["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                // Featured Badge
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "FEATURED",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // Priority Badge
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(editorial["priority"] as String),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${editorial["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Content
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              // Topic and Stance
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
                                      "${editorial["topic"]}",
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
                                      "${editorial["stance"]}",
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${editorial["readTime"]} min read",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              // Title and Subtitle
                              Text(
                                "${editorial["title"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  height: 1.3,
                                ),
                              ),
                              Text(
                                "${editorial["subtitle"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.w600,
                                  color: secondaryColor,
                                  height: 1.3,
                                ),
                              ),

                              // Excerpt
                              Text(
                                "${editorial["excerpt"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),

                              // Tags
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (editorial["tags"] as List).map((tag) {
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

                              // Editorial Info
                              Row(
                                children: [
                                  Icon(
                                    Icons.edit_note,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${editorial["editorName"]} • ${DateTime.parse(editorial["publishedAt"] as String).dMMMy}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      editorial["isBookmarked"] = !(editorial["isBookmarked"] as bool);
                                      setState(() {});
                                    },
                                    child: Icon(
                                      (editorial["isBookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),

                              // Engagement and Actions
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.thumb_up_outlined,
                                        color: disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${editorial["likes"]}",
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
                                        Icons.comment_outlined,
                                        color: disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${editorial["comments"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  QButton(
                                    label: "Read Editorial",
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
                ],
              ),

            // Regular Editorials Section
            if (filteredEditorials.any((ed) => !(ed["featured"] as bool)))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "All Editorials",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...filteredEditorials.where((ed) => !(ed["featured"] as bool)).map((editorial) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: _getPriorityColor(editorial["priority"] as String),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${editorial["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
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
                                        "${editorial["topic"]}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(editorial["priority"] as String).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${editorial["priority"]}",
                                        style: TextStyle(
                                          color: _getPriorityColor(editorial["priority"] as String),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${editorial["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${editorial["editorName"]} • ${DateTime.parse(editorial["publishedAt"] as String).dMMMy}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: disabledBoldColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${editorial["readTime"]} min",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        editorial["isBookmarked"] = !(editorial["isBookmarked"] as bool);
                                        setState(() {});
                                      },
                                      child: Icon(
                                        (editorial["isBookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                        color: primaryColor,
                                        size: 16,
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
                ],
              ),

            if (filteredEditorials.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.edit_note,
                      size: 60,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No editorials found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
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
