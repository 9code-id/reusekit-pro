import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaShareProgressView extends StatefulWidget {
  const FwaShareProgressView({super.key});

  @override
  State<FwaShareProgressView> createState() => _FwaShareProgressViewState();
}

class _FwaShareProgressViewState extends State<FwaShareProgressView> {
  String postText = "";
  String selectedAudience = "Public";
  String selectedCategory = "General";
  List<String> selectedImages = [];
  bool enableComments = true;
  bool enableReactions = true;
  bool addToStory = false;

  List<Map<String, dynamic>> audienceOptions = [
    {"label": "Public", "value": "Public"},
    {"label": "Friends", "value": "Friends"},
    {"label": "Groups Only", "value": "Groups Only"},
    {"label": "Private", "value": "Private"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "General", "value": "General"},
    {"label": "Workout Achievement", "value": "Workout Achievement"},
    {"label": "Weight Loss", "value": "Weight Loss"},
    {"label": "Muscle Gain", "value": "Muscle Gain"},
    {"label": "Before & After", "value": "Before & After"},
    {"label": "Personal Record", "value": "Personal Record"},
    {"label": "Nutrition Success", "value": "Nutrition Success"},
    {"label": "Milestone Reached", "value": "Milestone Reached"},
  ];

  List<Map<String, dynamic>> progressTemplates = [
    {
      "title": "Workout Complete",
      "description": "Just finished an amazing workout! 💪",
      "category": "Workout Achievement",
      "icon": Icons.fitness_center,
      "color": primaryColor,
    },
    {
      "title": "Weight Loss Milestone",
      "description": "Reached another weight loss goal! 🎯",
      "category": "Weight Loss",
      "icon": Icons.trending_down,
      "color": successColor,
    },
    {
      "title": "Personal Record",
      "description": "New personal best achieved! 🏆",
      "category": "Personal Record",
      "icon": Icons.emoji_events,
      "color": warningColor,
    },
    {
      "title": "Nutrition Win",
      "description": "Eating healthy feels amazing! 🥗",
      "category": "Nutrition Success",
      "icon": Icons.restaurant,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> recentWorkouts = [
    {
      "name": "Upper Body Strength",
      "duration": "45 min",
      "calories": 320,
      "exercises": 8,
      "date": "Today",
    },
    {
      "name": "HIIT Cardio",
      "duration": "30 min",
      "calories": 280,
      "exercises": 6,
      "date": "Yesterday",
    },
    {
      "name": "Leg Day",
      "duration": "60 min",
      "calories": 410,
      "exercises": 10,
      "date": "2 days ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Progress"),
        actions: [
          QButton(
            label: "Post",
            size: bs.sm,
            onPressed: () {
              // Share progress post
              _shareProgress();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Templates
            Text(
              "Quick Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: progressTemplates.map((template) {
                return GestureDetector(
                  onTap: () {
                    postText = template["description"];
                    selectedCategory = template["category"];
                    setState(() {});
                  },
                  child: Container(
                    width: 200,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (template["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                template["icon"],
                                color: template["color"],
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${template["title"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Post Content
            Text(
              "What's your progress today?",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Share your achievement, milestone, or motivation...",
              value: postText,
              maxLines: 5,
              onChanged: (value) {
                postText = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Images Section
            Text(
              "Add Photos",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QMultiImagePicker(
              label: "Progress Photos",
              value: selectedImages,
              maxImages: 4,
              onChanged: (value) {
                selectedImages = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Recent Workouts to Share
            Text(
              "Recent Workouts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...recentWorkouts.map((workout) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.fitness_center,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${workout["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${workout["duration"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(" • ", style: TextStyle(color: disabledBoldColor)),
                              Text(
                                "${workout["calories"]} cal",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(" • ", style: TextStyle(color: disabledBoldColor)),
                              Text(
                                "${workout["exercises"]} exercises",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Share",
                      size: bs.sm,
                      onPressed: () {
                        // Share this workout
                        _shareWorkout(workout);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Post Settings
            Text(
              "Post Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Audience Selection
            QDropdownField(
              label: "Who can see this?",
              items: audienceOptions,
              value: selectedAudience,
              onChanged: (value, label) {
                selectedAudience = value;
                setState(() {});
              },
            ),

            SizedBox(height: spSm),

            // Category Selection
            QDropdownField(
              label: "Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spSm),

            // Additional Options
            QSwitch(
              items: [
                {
                  "label": "Enable Comments",
                  "value": "comments",
                  "checked": enableComments,
                }
              ],
              value: enableComments ? [{"label": "Enable Comments", "value": "comments", "checked": true}] : [],
              onChanged: (values, ids) {
                enableComments = values.isNotEmpty;
                setState(() {});
              },
            ),

            SizedBox(height: spSm),

            QSwitch(
              items: [
                {
                  "label": "Enable Reactions",
                  "value": "reactions",
                  "checked": enableReactions,
                }
              ],
              value: enableReactions ? [{"label": "Enable Reactions", "value": "reactions", "checked": true}] : [],
              onChanged: (values, ids) {
                enableReactions = values.isNotEmpty;
                setState(() {});
              },
            ),

            SizedBox(height: spSm),

            QSwitch(
              items: [
                {
                  "label": "Add to Story (24h)",
                  "value": "story",
                  "checked": addToStory,
                }
              ],
              value: addToStory ? [{"label": "Add to Story (24h)", "value": "story", "checked": true}] : [],
              onChanged: (values, ids) {
                addToStory = values.isNotEmpty;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Preview Section
            if (postText.isNotEmpty || selectedImages.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage("https://picsum.photos/40/40?random=1&keyword=person"),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "You",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Just now",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(" • ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                                    Icon(
                                      selectedAudience == "Public" ? Icons.public : 
                                      selectedAudience == "Friends" ? Icons.people : Icons.lock,
                                      color: disabledBoldColor,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        if (postText.isNotEmpty) ...[
                          SizedBox(height: spSm),
                          Text(
                            postText,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                        
                        if (selectedImages.isNotEmpty) ...[
                          SizedBox(height: spSm),
                          Container(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedImages.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: spSm),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      selectedImages[index],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                        
                        SizedBox(height: spSm),
                        
                        // Category Badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            selectedCategory,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            SizedBox(height: spMd),

            // Share Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Share Progress",
                size: bs.md,
                onPressed: () {
                  _shareProgress();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareProgress() {
    if (postText.isEmpty && selectedImages.isEmpty) {
      se("Please add some content to share");
      return;
    }

    // Share progress logic
    ss("Progress shared successfully!");
    back();
  }

  void _shareWorkout(Map<String, dynamic> workout) {
    postText = "Just completed ${workout["name"]}! 💪\n\n"
        "Duration: ${workout["duration"]}\n"
        "Calories burned: ${workout["calories"]}\n"
        "Exercises: ${workout["exercises"]}\n\n"
        "#workout #fitness #progress";
    selectedCategory = "Workout Achievement";
    setState(() {});
  }
}
