import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaNewsletterView extends StatefulWidget {
  const NmaNewsletterView({Key? key}) : super(key: key);

  @override
  State<NmaNewsletterView> createState() => _NmaNewsletterViewState();
}

class _NmaNewsletterViewState extends State<NmaNewsletterView> {
  bool isSubscribed = true;
  String email = "john.doe@example.com";
  String frequency = "weekly";
  List<String> selectedTopics = ["technology", "science", "business"];
  String preferredTime = "morning";
  
  List<Map<String, dynamic>> newsletters = [
    {
      "id": 1,
      "title": "Tech Weekly",
      "description": "Latest technology news, trends, and innovations delivered weekly",
      "frequency": "Weekly",
      "subscribers": 45200,
      "rating": 4.8,
      "imageUrl": "https://picsum.photos/80/80?random=1",
      "subscribed": true,
      "categories": ["Technology", "Innovation"],
      "lastIssue": "2024-06-10"
    },
    {
      "id": 2,
      "title": "Science Today",
      "description": "Breakthrough discoveries and research findings from the world of science",
      "frequency": "Bi-weekly",
      "subscribers": 32100,
      "rating": 4.7,
      "imageUrl": "https://picsum.photos/80/80?random=2",
      "subscribed": true,
      "categories": ["Science", "Research"],
      "lastIssue": "2024-06-08"
    },
    {
      "id": 3,
      "title": "Business Insider",
      "description": "Market analysis, business trends, and economic insights for professionals",
      "frequency": "Daily",
      "subscribers": 28900,
      "rating": 4.6,
      "imageUrl": "https://picsum.photos/80/80?random=3",
      "subscribed": false,
      "categories": ["Business", "Finance"],
      "lastIssue": "2024-06-11"
    },
    {
      "id": 4,
      "title": "Health & Wellness",
      "description": "Tips for healthy living, medical breakthroughs, and wellness advice",
      "frequency": "Weekly",
      "subscribers": 22500,
      "rating": 4.5,
      "imageUrl": "https://picsum.photos/80/80?random=4",
      "subscribed": false,
      "categories": ["Health", "Wellness"],
      "lastIssue": "2024-06-09"
    },
    {
      "id": 5,
      "title": "Environment Watch",
      "description": "Climate change updates, environmental news, and sustainability tips",
      "frequency": "Monthly",
      "subscribers": 18700,
      "rating": 4.4,
      "imageUrl": "https://picsum.photos/80/80?random=5",
      "subscribed": true,
      "categories": ["Environment", "Climate"],
      "lastIssue": "2024-06-01"
    },
  ];

  List<Map<String, dynamic>> recentIssues = [
    {
      "title": "Tech Weekly #245: AI Revolution Continues",
      "date": "June 10, 2024",
      "summary": "This week: OpenAI's latest updates, quantum computing breakthroughs, and the future of autonomous vehicles",
      "readTime": "8 min",
      "opened": true,
    },
    {
      "title": "Science Today: Gene Therapy Breakthrough",
      "date": "June 8, 2024",
      "summary": "Revolutionary gene therapy shows promise for treating rare diseases, plus updates on Mars mission progress",
      "readTime": "12 min",
      "opened": false,
    },
    {
      "title": "Environment Watch: Climate Action Update",
      "date": "June 1, 2024",
      "summary": "Global climate commitments, renewable energy milestones, and practical sustainability tips for individuals",
      "readTime": "10 min",
      "opened": true,
    },
  ];

  List<Map<String, dynamic>> topicCategories = [
    {"label": "Technology", "value": "technology", "selected": true},
    {"label": "Science", "value": "science", "selected": true},
    {"label": "Business", "value": "business", "selected": true},
    {"label": "Health", "value": "health", "selected": false},
    {"label": "Environment", "value": "environment", "selected": false},
    {"label": "Sports", "value": "sports", "selected": false},
    {"label": "Entertainment", "value": "entertainment", "selected": false},
    {"label": "Politics", "value": "politics", "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Newsletter"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showNewsletterSettings(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Subscription status
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSubscribed ? successColor.withAlpha(10) : warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isSubscribed ? successColor : warningColor,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: isSubscribed ? successColor : warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      isSubscribed ? Icons.mail : Icons.mail_outline,
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
                          isSubscribed ? "Newsletter Active" : "Newsletter Paused",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSubscribed ? successColor : warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          isSubscribed 
                              ? "You're subscribed to ${newsletters.where((n) => n["subscribed"]).length} newsletters"
                              : "Subscribe to newsletters to stay updated",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSubscribed ? successColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: isSubscribed ? "Manage" : "Subscribe",
                    size: bs.sm,
                    onPressed: () => _manageSubscription(),
                  ),
                ],
              ),
            ),

            // Recent newsletter issues
            if (isSubscribed) ...[
              Row(
                children: [
                  Icon(
                    Icons.history,
                    color: primaryColor,
                    size: 18,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Recent Issues",
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
                  children: recentIssues.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> issue = entry.value;
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: index < recentIssues.length - 1
                            ? Border(bottom: BorderSide(color: disabledOutlineBorderColor))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: (issue["opened"] as bool) ? disabledColor : primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${issue["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: (issue["opened"] as bool) ? disabledBoldColor : Colors.black,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${issue["summary"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${issue["date"]} • ${issue["readTime"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: disabledBoldColor,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            // Available newsletters
            Text(
              "Available Newsletters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              spacing: spSm,
              children: newsletters.map((newsletter) => _buildNewsletterCard(newsletter)).toList(),
            ),

            // Newsletter preferences
            if (isSubscribed) ...[
              Text(
                "Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
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
                    QTextField(
                      label: "Email Address",
                      value: email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Delivery Frequency",
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
                    QDropdownField(
                      label: "Preferred Delivery Time",
                      items: [
                        {"label": "Morning (8 AM)", "value": "morning"},
                        {"label": "Afternoon (2 PM)", "value": "afternoon"},
                        {"label": "Evening (6 PM)", "value": "evening"},
                      ],
                      value: preferredTime,
                      onChanged: (value, label) {
                        preferredTime = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Topic preferences
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
                      "Topics of Interest",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Select topics you want to receive newsletters about",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: topicCategories.map((topic) {
                        bool isSelected = topic["selected"];
                        return GestureDetector(
                          onTap: () {
                            topic["selected"] = !isSelected;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              "${topic["label"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            // Newsletter statistics
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
                    "Your Newsletter Stats",
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
                        child: _buildStatCard("Newsletters", "3", Icons.mail),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("Issues Read", "47", Icons.visibility),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard("Read Rate", "85%", Icons.analytics),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("Joined", "3 months", Icons.schedule),
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

  Widget _buildNewsletterCard(Map<String, dynamic> newsletter) {
    bool isSubscribed = newsletter["subscribed"];
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isSubscribed ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${newsletter["imageUrl"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${newsletter["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isSubscribed)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "SUBSCRIBED",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${newsletter["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                    SizedBox(width: 2),
                    Text(
                      "${newsletter["frequency"]}",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.people, size: 12, color: disabledBoldColor),
                    SizedBox(width: 2),
                    Text(
                      "${(newsletter["subscribers"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.star, size: 12, color: Colors.amber),
                    SizedBox(width: 2),
                    Text(
                      "${newsletter["rating"]}",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  children: (newsletter["categories"] as List).map((category) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 8,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    QButton(
                      label: isSubscribed ? "Unsubscribe" : "Subscribe",
                      size: bs.sm,
                      onPressed: () => _toggleSubscription(newsletter),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () => _previewNewsletter(newsletter),
                      child: Text(
                        "Preview",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
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
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSubscription(Map<String, dynamic> newsletter) {
    newsletter["subscribed"] = !newsletter["subscribed"];
    setState(() {});
    
    if (newsletter["subscribed"]) {
      ss("Subscribed to ${newsletter["title"]}");
    } else {
      ss("Unsubscribed from ${newsletter["title"]}");
    }
  }

  void _previewNewsletter(Map<String, dynamic> newsletter) {
    ss("Opening newsletter preview");
    //navigateTo('NewsletterPreviewView');
  }

  void _manageSubscription() {
    if (isSubscribed) {
      _showNewsletterSettings();
    } else {
      isSubscribed = true;
      setState(() {});
      ss("Newsletter subscription activated");
    }
  }

  void _showNewsletterSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Newsletter Settings"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDropdownField(
                label: "Email Format",
                items: [
                  {"label": "HTML", "value": "html"},
                  {"label": "Plain Text", "value": "text"},
                ],
                value: "html",
                onChanged: (value, label) {},
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Icon(Icons.pause_circle, color: disabledBoldColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "Pause all newsletters",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Switch(
                    value: !isSubscribed,
                    onChanged: (value) {
                      isSubscribed = !value;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    activeColor: warningColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              ss("Newsletter settings saved");
            },
          ),
        ],
      ),
    );
  }
}
