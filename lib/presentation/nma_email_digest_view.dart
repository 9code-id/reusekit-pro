import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaEmailDigestView extends StatefulWidget {
  const NmaEmailDigestView({Key? key}) : super(key: key);

  @override
  State<NmaEmailDigestView> createState() => _NmaEmailDigestViewState();
}

class _NmaEmailDigestViewState extends State<NmaEmailDigestView> {
  bool digestEnabled = true;
  String frequency = "daily";
  String deliveryTime = "08:00";
  int maxArticles = 5;
  List<String> selectedCategories = ["technology", "science", "business"];
  String contentType = "mixed";
  bool includeWeekendDigest = true;
  
  List<Map<String, dynamic>> digestHistory = [
    {
      "id": 1,
      "subject": "Your Daily Digest - June 11, 2024",
      "date": "2024-06-11",
      "time": "08:00 AM",
      "articleCount": 5,
      "opened": true,
      "topics": ["AI Breakthrough", "Climate Summit", "Market Update"],
      "readTime": "12 min",
      "engagement": 4.2,
    },
    {
      "id": 2,
      "subject": "Your Daily Digest - June 10, 2024",
      "date": "2024-06-10",
      "time": "08:00 AM",
      "articleCount": 6,
      "opened": true,
      "topics": ["Tech Merger", "Space Exploration", "Economic News"],
      "readTime": "15 min",
      "engagement": 3.8,
    },
    {
      "id": 3,
      "subject": "Your Daily Digest - June 9, 2024",
      "date": "2024-06-09",
      "time": "08:00 AM",
      "articleCount": 4,
      "opened": false,
      "topics": ["Health Research", "Renewable Energy"],
      "readTime": "8 min",
      "engagement": 0.0,
    },
    {
      "id": 4,
      "subject": "Weekend Roundup - June 8, 2024",
      "date": "2024-06-08",
      "time": "09:00 AM",
      "articleCount": 8,
      "opened": true,
      "topics": ["Weekly Highlights", "Tech Trends", "Global News"],
      "readTime": "20 min",
      "engagement": 4.5,
    },
  ];

  List<Map<String, dynamic>> upcomingDigests = [
    {
      "date": "2024-06-12",
      "time": "08:00 AM",
      "estimatedArticles": 5,
      "topTopics": ["Artificial Intelligence", "Climate Policy", "Market Analysis"],
    },
    {
      "date": "2024-06-13",
      "time": "08:00 AM",
      "estimatedArticles": 4,
      "topTopics": ["Technology Innovation", "Health Sciences", "Business News"],
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "Technology", "value": "technology", "selected": true, "color": Colors.blue},
    {"label": "Science", "value": "science", "selected": true, "color": Colors.green},
    {"label": "Business", "value": "business", "selected": true, "color": Colors.orange},
    {"label": "Health", "value": "health", "selected": false, "color": Colors.red},
    {"label": "Sports", "value": "sports", "selected": false, "color": Colors.purple},
    {"label": "Environment", "value": "environment", "selected": false, "color": Colors.teal},
    {"label": "Politics", "value": "politics", "selected": false, "color": Colors.indigo},
    {"label": "Entertainment", "value": "entertainment", "selected": false, "color": Colors.pink},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Digest"),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _sendTestDigest(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Digest status
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: digestEnabled ? primaryColor.withAlpha(10) : disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: digestEnabled ? primaryColor : disabledBoldColor,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: digestEnabled ? primaryColor : disabledBoldColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Digest",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          digestEnabled 
                              ? "Next digest: Tomorrow at ${deliveryTime}"
                              : "Digest is currently paused",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: digestEnabled,
                    onChanged: (value) {
                      digestEnabled = value;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),

            if (digestEnabled) ...[
              // Digest configuration
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Digest Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Frequency",
                      items: [
                        {"label": "Daily", "value": "daily"},
                        {"label": "Weekly", "value": "weekly"},
                        {"label": "Bi-weekly", "value": "biweekly"},
                        {"label": "Monthly", "value": "monthly"},
                      ],
                      value: frequency,
                      onChanged: (value, label) {
                        frequency = value;
                        setState(() {});
                      },
                    ),
                    QTimePicker(
                      label: "Delivery Time",
                      value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $deliveryTime:00")),
                      onChanged: (value) {
                        if (value != null) {
                          deliveryTime = "${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}";
                          setState(() {});
                        }
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          "Maximum Articles: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: maxArticles.toDouble(),
                            min: 3,
                            max: 10,
                            divisions: 7,
                            label: maxArticles.toString(),
                            onChanged: (value) {
                              maxArticles = value.round();
                              setState(() {});
                            },
                          ),
                        ),
                        Text(
                          "$maxArticles",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Content Type",
                      items: [
                        {"label": "Mixed Content", "value": "mixed"},
                        {"label": "Articles Only", "value": "articles"},
                        {"label": "News Only", "value": "news"},
                        {"label": "Analysis Only", "value": "analysis"},
                      ],
                      value: contentType,
                      onChanged: (value, label) {
                        contentType = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Icon(Icons.weekend, color: disabledBoldColor, size: 16),
                        SizedBox(width: spSm),
                        Text(
                          "Include weekend digest",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Switch(
                          value: includeWeekendDigest,
                          onChanged: (value) {
                            includeWeekendDigest = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Category preferences
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
                      "Content Categories",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Select categories to include in your digest",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      spacing: spXs,
                      children: categories.map((category) {
                        bool isSelected = category["selected"];
                        return GestureDetector(
                          onTap: () {
                            category["selected"] = !isSelected;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? (category["color"] as Color).withAlpha(10) : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? category["color"] : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: isSelected ? category["color"] : Colors.transparent,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(
                                      color: category["color"],
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12,
                                        )
                                      : null,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${category["label"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? category["color"] : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            // Upcoming digests
            if (digestEnabled) ...[
              Text(
                "Upcoming Digests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: upcomingDigests.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> digest = entry.value;
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: index < upcomingDigests.length - 1
                            ? Border(bottom: BorderSide(color: disabledOutlineBorderColor))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.schedule,
                              color: primaryColor,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${digest["date"]} at ${digest["time"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "~${digest["estimatedArticles"]} articles",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Wrap(
                                  spacing: 4,
                                  children: (digest["topTopics"] as List).take(2).map((topic) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        topic,
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            // Digest history
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: primaryColor,
                  size: 18,
                ),
                SizedBox(width: spXs),
                Text(
                  "Recent Digests",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: digestHistory.map((digest) => _buildDigestHistoryCard(digest)).toList(),
              ),
            ),

            // Digest analytics
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
                    "Digest Analytics",
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
                        child: _buildAnalyticsCard("Open Rate", "85%", Icons.mail, successColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildAnalyticsCard("Avg Engagement", "4.1", Icons.favorite, dangerColor),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnalyticsCard("Total Sent", "127", Icons.send, primaryColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildAnalyticsCard("Time Saved", "45h", Icons.schedule, infoColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action buttons
            if (digestEnabled) ...[
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Send Test Digest",
                      size: bs.md,
                      icon: Icons.send,
                      onPressed: () => _sendTestDigest(),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Preview Format",
                      size: bs.md,
                      icon: Icons.preview,
                      onPressed: () => _previewDigest(),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDigestHistoryCard(Map<String, dynamic> digest) {
    bool wasOpened = digest["opened"];
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: wasOpened ? successColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${digest["subject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: wasOpened ? Colors.black : disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${digest["date"]} • ${digest["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${digest["articleCount"]} articles • ${digest["readTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if (wasOpened) ...[
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.star, size: 12, color: Colors.amber),
                      SizedBox(width: 2),
                      Text(
                        "${(digest["engagement"] as double).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: spXs),
                Wrap(
                  spacing: 4,
                  children: (digest["topics"] as List).take(3).map((topic) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        topic,
                        style: TextStyle(
                          fontSize: 8,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => _viewDigest(digest),
                child: Icon(
                  Icons.visibility,
                  size: 16,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              GestureDetector(
                onTap: () => _shareDigest(digest),
                child: Icon(
                  Icons.share,
                  size: 16,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(20)),
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
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _sendTestDigest() {
    ss("Test digest sent to your email");
  }

  void _previewDigest() {
    ss("Opening digest preview");
    //navigateTo('DigestPreviewView');
  }

  void _viewDigest(Map<String, dynamic> digest) {
    ss("Opening digest: ${digest["subject"]}");
  }

  void _shareDigest(Map<String, dynamic> digest) {
    ss("Digest link copied to clipboard");
  }
}
