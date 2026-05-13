import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaBoostPostView extends StatefulWidget {
  const SmaBoostPostView({super.key});

  @override
  State<SmaBoostPostView> createState() => _SmaBoostPostViewState();
}

class _SmaBoostPostViewState extends State<SmaBoostPostView> {
  String selectedPost = "";
  String selectedAudience = "All Users";
  String selectedBudget = "10";
  String selectedDuration = "7";
  List<String> selectedObjectives = [];

  List<Map<String, dynamic>> recentPosts = [
    {
      "id": 1,
      "content": "Just launched our new product line! Check it out 🚀",
      "type": "Text",
      "likes": 245,
      "comments": 18,
      "shares": 32,
      "reach": 1250,
      "image": "https://picsum.photos/300/200?random=1&keyword=product",
      "timestamp": "2 hours ago",
    },
    {
      "id": 2,
      "content": "Behind the scenes of our latest photoshoot",
      "type": "Photo",
      "likes": 189,
      "comments": 24,
      "shares": 15,
      "reach": 890,
      "image": "https://picsum.photos/300/200?random=2&keyword=photoshoot",
      "timestamp": "1 day ago",
    },
    {
      "id": 3,
      "content": "Live streaming tonight at 8 PM! Don't miss it",
      "type": "Video",
      "likes": 356,
      "comments": 42,
      "shares": 67,
      "reach": 2100,
      "image": "https://picsum.photos/300/200?random=3&keyword=streaming",
      "timestamp": "3 days ago",
    },
  ];

  List<Map<String, dynamic>> objectives = [
    {"label": "Increase Reach", "value": "reach", "checked": false},
    {"label": "Drive Engagement", "value": "engagement", "checked": false},
    {"label": "Generate Leads", "value": "leads", "checked": false},
    {"label": "Boost Website Visits", "value": "website", "checked": false},
    {"label": "Promote Brand Awareness", "value": "awareness", "checked": false},
  ];

  List<Map<String, dynamic>> audienceOptions = [
    {"label": "All Users", "value": "All Users"},
    {"label": "Followers Only", "value": "Followers Only"},
    {"label": "Similar to Followers", "value": "Similar to Followers"},
    {"label": "Custom Audience", "value": "Custom Audience"},
  ];

  List<Map<String, dynamic>> budgetOptions = [
    {"label": "\$5/day", "value": "5"},
    {"label": "\$10/day", "value": "10"},
    {"label": "\$25/day", "value": "25"},
    {"label": "\$50/day", "value": "50"},
    {"label": "\$100/day", "value": "100"},
  ];

  List<Map<String, dynamic>> durationOptions = [
    {"label": "3 days", "value": "3"},
    {"label": "7 days", "value": "7"},
    {"label": "14 days", "value": "14"},
    {"label": "30 days", "value": "30"},
  ];

  double get estimatedReach {
    final budget = double.tryParse(selectedBudget) ?? 10;
    final duration = int.tryParse(selectedDuration) ?? 7;
    return budget * duration * 50; // Simplified calculation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boost Post"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Post Section
            Text(
              "Select Post to Boost",
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
                children: recentPosts.map((post) {
                  final isSelected = selectedPost == "${post["id"]}";
                  return GestureDetector(
                    onTap: () {
                      selectedPost = "${post["id"]}";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${post["image"]}",
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
                                Text(
                                  "${post["content"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${post["likes"]} likes • ${post["comments"]} comments",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${post["timestamp"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: primaryColor,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Campaign Objectives
            Text(
              "Campaign Objectives",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QSwitch(
              items: objectives,
              value: objectives.where((obj) => obj["checked"] == true).toList(),
              onChanged: (values, ids) {
                for (var obj in objectives) {
                  obj["checked"] = values.any((v) => v["value"] == obj["value"]);
                }
                setState(() {});
              },
            ),

            // Target Audience
            Text(
              "Target Audience",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Audience",
              items: audienceOptions,
              value: selectedAudience,
              onChanged: (value, label) {
                selectedAudience = value;
                setState(() {});
              },
            ),

            // Budget & Duration
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daily Budget",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Budget",
                        items: budgetOptions,
                        value: selectedBudget,
                        onChanged: (value, label) {
                          selectedBudget = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Duration",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Duration",
                        items: durationOptions,
                        value: selectedDuration,
                        onChanged: (value, label) {
                          selectedDuration = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Estimated Results
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Estimated Results",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Estimated Reach",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(estimatedReach / 1000).toStringAsFixed(1)}K people",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Budget",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((double.tryParse(selectedBudget) ?? 10) * (int.tryParse(selectedDuration) ?? 7)).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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

            // Payment Method
            Text(
              "Payment Method",
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
              child: Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "•••• •••• •••• 1234",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Visa ending in 1234",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //navigateTo('PaymentMethodView')
                    },
                    child: Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Terms and Conditions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "By boosting this post, you agree to our advertising terms and conditions. Your post will be reviewed before going live.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Preview Campaign",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('CampaignPreviewView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Boost Post - \$${((double.tryParse(selectedBudget) ?? 10) * (int.tryParse(selectedDuration) ?? 7)).toStringAsFixed(0)}",
                    size: bs.md,
                    onPressed: selectedPost.isNotEmpty ? () {
                      //submitBoostRequest()
                    } : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
