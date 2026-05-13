import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPost2View extends StatefulWidget {
  @override
  State<GrlPost2View> createState() => _GrlPost2ViewState();
}

class _GrlPost2ViewState extends State<GrlPost2View> {
  String postTitle = "";
  String postContent = "";
  String selectedCategory = "";
  List<String> selectedTags = [];
  String featuredImage = "";
  bool isScheduled = false;
  DateTime? scheduledDate;
  TimeOfDay? scheduledTime;
  String postStatus = "Draft";
  
  List<String> categories = [
    "Technology",
    "Lifestyle",
    "Business",
    "Health",
    "Travel",
    "Food",
    "Entertainment",
    "Sports",
    "Education",
    "Art & Design"
  ];
  
  List<String> statusOptions = ["Draft", "Published", "Scheduled"];
  
  List<Map<String, dynamic>> postMetrics = [
    {
      "title": "Estimated Reach",
      "value": "5.2K",
      "icon": Icons.visibility,
      "color": infoColor,
    },
    {
      "title": "Engagement Rate",
      "value": "8.5%",
      "icon": Icons.thumb_up,
      "color": successColor,
    },
    {
      "title": "Best Time to Post",
      "value": "2:00 PM",
      "icon": Icons.schedule,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> contentSuggestions = [
    {
      "type": "trending_topic",
      "title": "AI in Healthcare",
      "description": "This topic is trending in Technology category",
      "engagement": "High",
    },
    {
      "type": "seasonal",
      "title": "Winter Wellness Tips",
      "description": "Seasonal content performs well",
      "engagement": "Medium",
    },
    {
      "type": "community",
      "title": "User-Generated Content",
      "description": "Your audience loves interactive posts",
      "engagement": "High",
    },
  ];

  void _addTag(String tag) {
    if (tag.isNotEmpty && !selectedTags.contains(tag)) {
      setState(() {
        selectedTags.add(tag);
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      selectedTags.remove(tag);
    });
  }

  void _savePost() async {
    if (postTitle.trim().isEmpty) {
      se("Please enter a post title");
      return;
    }
    
    if (postContent.trim().isEmpty) {
      se("Please enter post content");
      return;
    }

    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    if (postStatus == "Published") {
      ss("Post published successfully!");
    } else if (postStatus == "Scheduled") {
      ss("Post scheduled successfully!");
    } else {
      ss("Post saved as draft!");
    }
    
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Article"),
        actions: [
          QButton(
            label: postStatus == "Published" ? "Publish" : "Save",
            size: bs.sm,
            onPressed: _savePost,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Post Status & Category
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Post Status",
                    items: statusOptions.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
                    value: postStatus,
                    onChanged: (value, label) {
                      setState(() {
                        postStatus = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            
            // Post Title
            QTextField(
              label: "Post Title",
              value: postTitle,
              hint: "Enter an engaging title for your post",
              validator: Validator.required,
              onChanged: (value) {
                setState(() {
                  postTitle = value;
                });
              },
            ),
            
            // Featured Image
            QImagePicker(
              label: "Featured Image",
              value: featuredImage,
              hint: "Upload a featured image for your post",
              onChanged: (value) {
                setState(() {
                  featuredImage = value;
                });
              },
            ),
            
            // Post Content
            QMemoField(
              label: "Post Content",
              value: postContent,
              hint: "Write your article content here...",
              validator: Validator.required,
              onChanged: (value) {
                setState(() {
                  postContent = value;
                });
              },
            ),
            
            // Tags Input
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Add Tags",
                    value: "",
                    hint: "Type a tag and press enter",
                    onChanged: (value) {
                      if (value.endsWith(' ') && value.trim().isNotEmpty) {
                        _addTag(value.trim());
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    // Add tag functionality
                  },
                ),
              ],
            ),
            
            // Selected Tags
            if (selectedTags.isNotEmpty)
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: selectedTags.map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tag,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () => _removeTag(tag),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            
            // Schedule Post Section
            if (postStatus == "Scheduled")
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Schedule Post",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Date",
                            value: scheduledDate ?? DateTime.now(),
                            onChanged: (value) {
                              setState(() {
                                scheduledDate = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Time",
                            value: scheduledTime ?? TimeOfDay.now(),
                            onChanged: (value) {
                              setState(() {
                                scheduledTime = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
            // Post Metrics
            Text(
              "Post Insights",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: postMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(color: (metric["color"] as Color).withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (metric["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          metric["icon"] as IconData,
                          color: metric["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: metric["color"] as Color,
                        ),
                      ),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            // Content Suggestions
            Text(
              "Content Suggestions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...contentSuggestions.map((suggestion) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _getSuggestionColor(suggestion["type"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        _getSuggestionIcon(suggestion["type"]),
                        color: _getSuggestionColor(suggestion["type"]),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${suggestion["title"]}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${suggestion["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getEngagementColor(suggestion["engagement"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${suggestion["engagement"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getEngagementColor(suggestion["engagement"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            // Preview Section
            if (postTitle.isNotEmpty || postContent.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preview",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    if (featuredImage.isNotEmpty)
                      Container(
                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: disabledBoldColor,
                            size: 40,
                          ),
                        ),
                      ),
                    
                    if (selectedCategory.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          selectedCategory,
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    
                    if (postTitle.isNotEmpty)
                      Text(
                        postTitle,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    
                    if (postContent.isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Text(
                        postContent,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.4,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    
                    if (selectedTags.isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        children: selectedTags.map((tag) {
                          return Text(
                            "#$tag",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "Status: $postStatus",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (postStatus == "Scheduled" && scheduledDate != null) ...[
                          Text(" • ", style: TextStyle(color: disabledBoldColor)),
                          Text(
                            "Scheduled for ${scheduledDate!.day}/${scheduledDate!.month}/${scheduledDate!.year}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
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

  Color _getSuggestionColor(String type) {
    switch (type) {
      case "trending_topic":
        return dangerColor;
      case "seasonal":
        return warningColor;
      case "community":
        return successColor;
      default:
        return primaryColor;
    }
  }

  IconData _getSuggestionIcon(String type) {
    switch (type) {
      case "trending_topic":
        return Icons.trending_up;
      case "seasonal":
        return Icons.calendar_today;
      case "community":
        return Icons.people;
      default:
        return Icons.lightbulb;
    }
  }

  Color _getEngagementColor(String engagement) {
    switch (engagement) {
      case "High":
        return successColor;
      case "Medium":
        return warningColor;
      case "Low":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
