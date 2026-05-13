import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaCreatePostView extends StatefulWidget {
  const SmaCreatePostView({super.key});

  @override
  State<SmaCreatePostView> createState() => _SmaCreatePostViewState();
}

class _SmaCreatePostViewState extends State<SmaCreatePostView> {
  String postContent = "";
  String selectedPrivacy = "public";
  String selectedTag = "";
  String location = "";
  List<String> postImages = [];
  List<String> postVideos = [];
  List<String> attachments = [];
  bool allowComments = true;
  bool enableNotifications = true;
  bool schedulePost = false;
  DateTime scheduledDate = DateTime.now();
  String scheduledTime = "${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}";

  List<Map<String, dynamic>> privacyItems = [
    {
      "label": "Public - Anyone can see",
      "value": "public",
    },
    {
      "label": "Friends Only",
      "value": "friends",
    },
    {
      "label": "Private - Only me",
      "value": "private",
    },
    {
      "label": "Custom",
      "value": "custom",
    },
  ];

  List<Map<String, dynamic>> tagItems = [
    {
      "label": "No Tag",
      "value": "",
    },
    {
      "label": "Personal",
      "value": "personal",
    },
    {
      "label": "Work",
      "value": "work",
    },
    {
      "label": "Travel",
      "value": "travel",
    },
    {
      "label": "Food",
      "value": "food",
    },
    {
      "label": "Sports",
      "value": "sports",
    },
    {
      "label": "Entertainment",
      "value": "entertainment",
    },
    {
      "label": "News",
      "value": "news",
    },
  ];

  IconData getPrivacyIcon(String privacy) {
    switch (privacy) {
      case "public":
        return Icons.public;
      case "friends":
        return Icons.group;
      case "private":
        return Icons.lock;
      case "custom":
        return Icons.settings;
      default:
        return Icons.public;
    }
  }

  void _publishPost() async {
    if (postContent.isEmpty && postImages.isEmpty && postVideos.isEmpty) {
      se("Please add some content to your post");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    if (schedulePost) {
      ss("Post scheduled successfully");
    } else {
      ss("Post published successfully");
    }
    back();
  }

  void _saveDraft() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    ss("Post saved as draft");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveDraft,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Post Content
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          "https://picsum.photos/40/40?random=1&keyword=profile",
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "John Doe",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  getPrivacyIcon(selectedPrivacy),
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  selectedPrivacy == "public" ? "Public" :
                                  selectedPrivacy == "friends" ? "Friends" :
                                  selectedPrivacy == "private" ? "Private" : "Custom",
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
                    ],
                  ),
                  QMemoField(
                    label: "What's on your mind?",
                    value: postContent,
                    hint: "Share your thoughts, ideas, or updates...",
                    onChanged: (value) {
                      postContent = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Media Attachments
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.attachment,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Media & Attachments",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QMultiImagePicker(
                    label: "Add Photos",
                    value: postImages,
                    maxImages: 10,
                    hint: "Share photos with your post",
                    onChanged: (value) {
                      postImages = value;
                      setState(() {});
                    },
                  ),
                  QAttachmentPicker(
                    label: "Add Files",
                    value: attachments,
                    hint: "Attach documents, videos, or other files",
                    maxAttachments: 5,
                    allowedTypes: ['document', 'video', 'audio'],
                    onChanged: (value) {
                      attachments = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Post Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Post Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Privacy",
                          items: privacyItems,
                          value: selectedPrivacy,
                          onChanged: (value, label) {
                            selectedPrivacy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Tag",
                          items: tagItems,
                          value: selectedTag,
                          onChanged: (value, label) {
                            selectedTag = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Location (Optional)",
                    value: location,
                    hint: "Add location to your post",
                    onChanged: (value) {
                      location = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Post Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tune,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Post Options",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Allow comments on this post",
                        "value": "comments",
                        "checked": allowComments,
                      }
                    ],
                    value: [if (allowComments) {"label": "Allow comments on this post", "value": "comments", "checked": true}],
                    onChanged: (values, ids) {
                      allowComments = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable notifications for interactions",
                        "value": "notifications",
                        "checked": enableNotifications,
                      }
                    ],
                    value: [if (enableNotifications) {"label": "Enable notifications for interactions", "value": "notifications", "checked": true}],
                    onChanged: (values, ids) {
                      enableNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Schedule this post for later",
                        "value": "schedule",
                        "checked": schedulePost,
                      }
                    ],
                    value: [if (schedulePost) {"label": "Schedule this post for later", "value": "schedule", "checked": true}],
                    onChanged: (values, ids) {
                      schedulePost = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Schedule Settings
            if (schedulePost)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Schedule Settings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: 'Publish Date',
                            value: scheduledDate,
                            onChanged: (value) {
                              scheduledDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: 'Publish Time',
                            value: TimeOfDay.fromDateTime(scheduledDate),
                            onChanged: (value) {
                              if (value != null) {
                                scheduledTime = value.kkmm;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Your post will be published on ${scheduledDate.dMMMy} at $scheduledTime",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Post Preview
            if (postContent.isNotEmpty || postImages.isNotEmpty || attachments.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.preview,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Post Preview",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(20),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                  "https://picsum.photos/32/32?random=1&keyword=profile",
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "John Doe",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Icon(
                                getPrivacyIcon(selectedPrivacy),
                                size: 12,
                                color: disabledBoldColor,
                              ),
                            ],
                          ),
                          if (postContent.isNotEmpty)
                            Text(
                              postContent,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          if (location.isNotEmpty)
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  location,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          if (postImages.isNotEmpty)
                            Text(
                              "${postImages.length} image(s) attached",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          if (attachments.isNotEmpty)
                            Text(
                              "${attachments.length} file(s) attached",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Draft",
                    size: bs.md,
                    onPressed: _saveDraft,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: schedulePost ? "Schedule Post" : "Publish Now",
                    size: bs.md,
                    onPressed: _publishPost,
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
