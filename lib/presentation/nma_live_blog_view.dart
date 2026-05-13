import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaLiveBlogView extends StatefulWidget {
  const NmaLiveBlogView({super.key});

  @override
  State<NmaLiveBlogView> createState() => _NmaLiveBlogViewState();
}

class _NmaLiveBlogViewState extends State<NmaLiveBlogView> {
  String selectedEvent = "Climate Summit 2024";
  bool autoRefresh = true;
  
  List<Map<String, dynamic>> blogPosts = [
    {
      "id": 1,
      "timestamp": "2024-01-16T15:45:00Z",
      "title": "Final Agreement Reached on Carbon Targets",
      "content": "After 6 hours of intense negotiations, world leaders have reached a consensus on ambitious carbon reduction targets. The agreement includes a commitment to reduce global emissions by 50% by 2030.",
      "author": "Sarah Johnson",
      "authorImage": "https://picsum.photos/100/100?random=1&keyword=reporter",
      "type": "Major Update",
      "priority": "High",
      "tags": ["Agreement", "Carbon", "Targets"],
      "location": "Conference Hall A",
      "source": "Live from venue",
      "image": "https://picsum.photos/400/200?random=1&keyword=agreement",
      "likes": 892,
      "comments": 67,
      "shares": 145,
      "isBookmarked": false,
      "hasVideo": false,
      "hasAudio": true,
      "relatedPosts": 3,
    },
    {
      "id": 2,
      "timestamp": "2024-01-16T15:30:00Z",
      "title": "Breakthrough in Renewable Energy Funding",
      "content": "Major development as 20 countries pledge \$500 billion for renewable energy infrastructure. This historic commitment will accelerate the transition to clean energy globally.",
      "author": "Michael Chen",
      "authorImage": "https://picsum.photos/100/100?random=2&keyword=journalist",
      "type": "Breaking News",
      "priority": "Critical",
      "tags": ["Funding", "Renewable", "Infrastructure"],
      "location": "Press Room",
      "source": "Official announcement",
      "image": "https://picsum.photos/400/200?random=2&keyword=renewable",
      "likes": 1456,
      "comments": 234,
      "shares": 567,
      "isBookmarked": true,
      "hasVideo": true,
      "hasAudio": false,
      "relatedPosts": 5,
    },
    {
      "id": 3,
      "timestamp": "2024-01-16T15:15:00Z",
      "title": "Youth Climate Activists Address Summit",
      "content": "Powerful speeches from young climate activists demanding immediate action. Their message resonates with delegates as they call for intergenerational justice and swift implementation of climate policies.",
      "author": "Emma Rodriguez",
      "authorImage": "https://picsum.photos/100/100?random=3&keyword=activist",
      "type": "Speech Coverage",
      "priority": "Medium",
      "tags": ["Youth", "Activists", "Speech"],
      "location": "Main Auditorium",
      "source": "Live coverage",
      "image": "https://picsum.photos/400/200?random=3&keyword=activists",
      "likes": 743,
      "comments": 156,
      "shares": 289,
      "isBookmarked": false,
      "hasVideo": true,
      "hasAudio": true,
      "relatedPosts": 2,
    },
    {
      "id": 4,
      "timestamp": "2024-01-16T14:45:00Z",
      "title": "Technology Solutions Showcase",
      "content": "Innovative climate technologies displayed in exhibition hall. Featured solutions include carbon capture systems, advanced solar panels, and smart grid technologies that could revolutionize energy distribution.",
      "author": "Dr. Lisa Kim",
      "authorImage": "https://picsum.photos/100/100?random=4&keyword=scientist",
      "type": "Feature Report",
      "priority": "Medium",
      "tags": ["Technology", "Innovation", "Solutions"],
      "location": "Exhibition Hall",
      "source": "Tech showcase",
      "image": "https://picsum.photos/400/200?random=4&keyword=technology",
      "likes": 567,
      "comments": 89,
      "shares": 123,
      "isBookmarked": true,
      "hasVideo": false,
      "hasAudio": false,
      "relatedPosts": 4,
    },
    {
      "id": 5,
      "timestamp": "2024-01-16T14:20:00Z",
      "title": "Economic Impact Analysis Released",
      "content": "New report reveals the economic benefits of climate action. Analysis shows that investing in clean energy could create 15 million jobs globally and boost GDP by 2.5% over the next decade.",
      "author": "Prof. David Anderson",
      "authorImage": "https://picsum.photos/100/100?random=5&keyword=economist",
      "type": "Analysis",
      "priority": "Low",
      "tags": ["Economics", "Jobs", "Analysis"],
      "location": "Research Center",
      "source": "Economic report",
      "image": "https://picsum.photos/400/200?random=5&keyword=economics",
      "likes": 432,
      "comments": 45,
      "shares": 78,
      "isBookmarked": false,
      "hasVideo": false,
      "hasAudio": false,
      "relatedPosts": 1,
    },
  ];

  List<String> events = [
    "Climate Summit 2024",
    "Tech Conference Live",
    "Election Coverage",
    "Sports Championship",
    "Economic Forum"
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical": return dangerColor;
      case "High": return warningColor;
      case "Medium": return infoColor;
      case "Low": return successColor;
      default: return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Breaking News": return dangerColor;
      case "Major Update": return warningColor;
      case "Speech Coverage": return infoColor;
      case "Feature Report": return successColor;
      case "Analysis": return secondaryColor;
      default: return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Blog"),
        actions: [
          IconButton(
            icon: Icon(autoRefresh ? Icons.autorenew : Icons.refresh),
            onPressed: () {
              autoRefresh = !autoRefresh;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Event Selector
            QDropdownField(
              label: "Select Live Event",
              items: events.map((event) => {"label": event, "value": event}).toList(),
              value: selectedEvent,
              onChanged: (value, label) {
                selectedEvent = value;
                setState(() {});
              },
            ),

            // Live Blog Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: dangerColor,
                  ),
                ),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
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
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "LIVE BLOG",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      if (autoRefresh)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "AUTO-REFRESH ON",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    selectedEvent,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Follow the latest developments as they unfold. Updates are posted in real-time by our team of reporters on the ground.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${blogPosts.length}",
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
                              "${blogPosts.where((post) => post["priority"] == "Critical" || post["priority"] == "High").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Major News",
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
                              "${blogPosts.where((post) => post["hasVideo"] as bool).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "With Video",
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

            // Auto Refresh Toggle
            QSwitch(
              items: [
                {
                  "label": "Auto-refresh live updates",
                  "value": true,
                  "checked": autoRefresh,
                }
              ],
              value: [if (autoRefresh) {"label": "Auto-refresh live updates", "value": true, "checked": true}],
              onChanged: (values, ids) {
                autoRefresh = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Blog Posts Timeline
            ...blogPosts.map((post) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 3,
                      color: _getPriorityColor(post["priority"] as String),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Post Header
                    Row(
                      children: [
                        Text(
                          "${DateTime.parse(post["timestamp"] as String).hour.toString().padLeft(2, '0')}:${DateTime.parse(post["timestamp"] as String).minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(post["type"] as String),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${post["type"]}".toUpperCase(),
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
                            color: _getPriorityColor(post["priority"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${post["priority"]}",
                            style: TextStyle(
                              color: _getPriorityColor(post["priority"] as String),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        if (post["hasVideo"] as bool)
                          Icon(
                            Icons.videocam,
                            color: dangerColor,
                            size: 16,
                          ),
                        if (post["hasAudio"] as bool)
                          Icon(
                            Icons.mic,
                            color: infoColor,
                            size: 16,
                          ),
                      ],
                    ),

                    // Post Image (if available)
                    if (post["image"] != null)
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${post["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Media indicators
                            if (post["hasVideo"] as bool || post["hasAudio"] as bool)
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (post["hasVideo"] as bool)
                                      Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(150),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    if (post["hasAudio"] as bool)
                                      Container(
                                        margin: EdgeInsets.only(left: spXs),
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(150),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.volume_up,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                    // Post Content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        // Title
                        Text(
                          "${post["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            height: 1.3,
                          ),
                        ),

                        // Content
                        Text(
                          "${post["content"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),

                        // Location and Source
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: infoColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${post["location"]}",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${post["source"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),

                        // Tags
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (post["tags"] as List).map((tag) {
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

                        // Author Info
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                image: DecorationImage(
                                  image: NetworkImage("${post["authorImage"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${post["author"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                post["isBookmarked"] = !(post["isBookmarked"] as bool);
                                setState(() {});
                              },
                              child: Icon(
                                (post["isBookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                color: primaryColor,
                                size: 18,
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
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${post["likes"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
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
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${post["comments"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
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
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${post["shares"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            if (post["relatedPosts"] as int > 0)
                              Text(
                                "${post["relatedPosts"]} related",
                                style: TextStyle(
                                  color: infoColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Load More Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.refresh,
                    color: primaryColor,
                    size: 30,
                  ),
                  Text(
                    "Load Earlier Updates",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "See what happened before the current timeline",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  QButton(
                    label: "Load More",
                    size: bs.sm,
                    onPressed: () {},
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
