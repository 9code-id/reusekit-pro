import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaLiveUpdatesView extends StatefulWidget {
  const NmaLiveUpdatesView({super.key});

  @override
  State<NmaLiveUpdatesView> createState() => _NmaLiveUpdatesViewState();
}

class _NmaLiveUpdatesViewState extends State<NmaLiveUpdatesView> {
  String selectedTopic = "All";
  String selectedPriority = "All";
  bool showOnlyFollowing = false;
  
  List<Map<String, dynamic>> liveUpdates = [
    {
      "id": 1,
      "title": "BREAKING: Major Economic Summit Concludes",
      "content": "World leaders reach consensus on new trade agreements affecting global markets. Key decisions include reduced tariffs and enhanced digital trade protocols.",
      "topic": "Politics",
      "priority": "High",
      "timestamp": "2024-01-16T14:30:00Z",
      "location": "Geneva, Switzerland",
      "reporter": "Sarah Johnson",
      "reporterImage": "https://picsum.photos/100/100?random=1&keyword=reporter",
      "source": "International News Network",
      "isLive": true,
      "isFollowing": true,
      "viewers": 12540,
      "upvotes": 892,
      "comments": 156,
      "shares": 234,
      "tags": ["Summit", "Trade", "Economy", "Politics"],
      "relatedStories": 5,
      "lastUpdate": "2 minutes ago",
      "updateCount": 12,
      "verified": true,
      "image": "https://picsum.photos/400/200?random=1&keyword=summit",
    },
    {
      "id": 2,
      "title": "Climate Conference: New Commitments Announced",
      "content": "15 nations pledge ambitious carbon reduction targets. Renewable energy investments to reach \$2 trillion by 2030. Implementation timeline revealed.",
      "topic": "Environment",
      "priority": "Critical",
      "timestamp": "2024-01-16T13:45:00Z",
      "location": "Copenhagen, Denmark",
      "reporter": "Michael Chen",
      "reporterImage": "https://picsum.photos/100/100?random=2&keyword=journalist",
      "source": "Environmental News Today",
      "isLive": true,
      "isFollowing": false,
      "viewers": 8934,
      "upvotes": 1456,
      "comments": 289,
      "shares": 567,
      "tags": ["Climate", "Environment", "Renewable", "Global"],
      "relatedStories": 8,
      "lastUpdate": "5 minutes ago",
      "updateCount": 18,
      "verified": true,
      "image": "https://picsum.photos/400/200?random=2&keyword=climate",
    },
    {
      "id": 3,
      "title": "Tech Giant Announces Revolutionary AI System",
      "content": "New artificial intelligence breakthrough promises to transform healthcare diagnostics. Clinical trials show 95% accuracy in early disease detection.",
      "topic": "Technology",
      "priority": "Medium",
      "timestamp": "2024-01-16T12:20:00Z",
      "location": "Silicon Valley, USA",
      "reporter": "Emma Rodriguez",
      "reporterImage": "https://picsum.photos/100/100?random=3&keyword=tech",
      "source": "Tech Daily Reporter",
      "isLive": false,
      "isFollowing": true,
      "viewers": 5678,
      "upvotes": 743,
      "comments": 98,
      "shares": 145,
      "tags": ["AI", "Healthcare", "Technology", "Innovation"],
      "relatedStories": 3,
      "lastUpdate": "30 minutes ago",
      "updateCount": 7,
      "verified": true,
      "image": "https://picsum.photos/400/200?random=3&keyword=technology",
    },
    {
      "id": 4,
      "title": "Sports: Championship Finals Underway",
      "content": "Intense match between top teams. Current score: 2-1 with 15 minutes remaining. Record-breaking viewership numbers as fans worldwide tune in.",
      "topic": "Sports",
      "priority": "Medium",
      "timestamp": "2024-01-16T11:30:00Z",
      "location": "London, UK",
      "reporter": "David Kim",
      "reporterImage": "https://picsum.photos/100/100?random=4&keyword=sports",
      "source": "Sports Central Live",
      "isLive": true,
      "isFollowing": false,
      "viewers": 25340,
      "upvotes": 2156,
      "comments": 1234,
      "shares": 890,
      "tags": ["Championship", "Sports", "Live", "Competition"],
      "relatedStories": 12,
      "lastUpdate": "1 minute ago",
      "updateCount": 45,
      "verified": true,
      "image": "https://picsum.photos/400/200?random=4&keyword=sports",
    },
    {
      "id": 5,
      "title": "Market Update: Stocks Surge on Positive News",
      "content": "Major indices climb following quarterly earnings reports. Technology sector leads gains with 4.2% increase. Investor confidence reaches new highs.",
      "topic": "Business",
      "priority": "Low",
      "timestamp": "2024-01-16T10:15:00Z",
      "location": "New York, USA",
      "reporter": "Lisa Anderson",
      "reporterImage": "https://picsum.photos/100/100?random=5&keyword=business",
      "source": "Financial News Wire",
      "isLive": false,
      "isFollowing": true,
      "viewers": 3456,
      "upvotes": 432,
      "comments": 67,
      "shares": 89,
      "tags": ["Stocks", "Markets", "Business", "Finance"],
      "relatedStories": 6,
      "lastUpdate": "1 hour ago",
      "updateCount": 4,
      "verified": true,
      "image": "https://picsum.photos/400/200?random=5&keyword=business",
    },
  ];

  List<String> topics = ["All", "Politics", "Environment", "Technology", "Sports", "Business", "Health"];
  List<String> priorities = ["All", "Critical", "High", "Medium", "Low"];

  List<Map<String, dynamic>> get filteredUpdates {
    return liveUpdates.where((update) {
      bool matchesTopic = selectedTopic == "All" || "${update["topic"]}" == selectedTopic;
      bool matchesPriority = selectedPriority == "All" || "${update["priority"]}" == selectedPriority;
      bool matchesFollowing = !showOnlyFollowing || (update["isFollowing"] as bool);
      
      return matchesTopic && matchesPriority && matchesFollowing;
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
        title: Text("Live Updates"),
        actions: [
          IconButton(
            icon: Icon(Icons.live_tv),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Live Indicator
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(40)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Live updates are being refreshed automatically",
                      style: TextStyle(
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    "${filteredUpdates.where((update) => update["isLive"] as bool).length} LIVE",
                    style: TextStyle(
                      color: dangerColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Filters
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

            // Following Filter
            QSwitch(
              items: [
                {
                  "label": "Show only followed topics",
                  "value": true,
                  "checked": showOnlyFollowing,
                }
              ],
              value: [if (showOnlyFollowing) {"label": "Show only followed topics", "value": true, "checked": true}],
              onChanged: (values, ids) {
                showOnlyFollowing = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Stats Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredUpdates.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Updates",
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
                          "${filteredUpdates.where((update) => update["isLive"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Live Now",
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
                          "${((filteredUpdates.fold(0, (sum, update) => sum + (update["viewers"] as int)) / 1000)).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Viewers",
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
            ),

            // Live Updates List
            ...filteredUpdates.map((update) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPriorityColor(update["priority"] as String),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Header with Status
                    Row(
                      children: [
                        if (update["isLive"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "LIVE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: disabledBoldColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "ENDED",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
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
                            "${update["topic"]}",
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
                            color: _getPriorityColor(update["priority"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${update["priority"]}",
                            style: TextStyle(
                              color: _getPriorityColor(update["priority"] as String),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        if (update["verified"] as bool)
                          Icon(
                            Icons.verified,
                            color: successColor,
                            size: 16,
                          ),
                      ],
                    ),

                    // Update Image
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${update["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Live Viewer Count
                          if (update["isLive"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${((update["viewers"] as int) / 1000).toStringAsFixed(1)}K",
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

                    // Content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        // Title
                        Text(
                          "${update["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            height: 1.3,
                          ),
                        ),

                        // Content
                        Text(
                          "${update["content"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),

                        // Location and Time
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: infoColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${update["location"]}",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${update["lastUpdate"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Tags
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (update["tags"] as List).map((tag) {
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

                        // Reporter Info
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                image: DecorationImage(
                                  image: NetworkImage("${update["reporterImage"]}"),
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
                                    "${update["reporter"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "${update["source"]} • ${update["updateCount"]} updates",
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
                                update["isFollowing"] = !(update["isFollowing"] as bool);
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: (update["isFollowing"] as bool) ? primaryColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(color: primaryColor),
                                ),
                                child: Text(
                                  (update["isFollowing"] as bool) ? "Following" : "Follow",
                                  style: TextStyle(
                                    color: (update["isFollowing"] as bool) ? Colors.white : primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Engagement Stats
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
                                  "${update["upvotes"]}",
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
                                  "${update["comments"]}",
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
                                  "${update["shares"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            if (update["isLive"] as bool)
                              QButton(
                                label: "Watch Live",
                                size: bs.sm,
                                color: dangerColor,
                                onPressed: () {},
                              )
                            else
                              QButton(
                                label: "View Update",
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

            if (filteredUpdates.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.tv_off,
                      size: 60,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No live updates found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters or check back later",
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
