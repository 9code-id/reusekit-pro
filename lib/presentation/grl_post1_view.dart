import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPost1View extends StatefulWidget {
  @override
  State<GrlPost1View> createState() => _GrlPost1ViewState();
}

class _GrlPost1ViewState extends State<GrlPost1View> {
  String postContent = "";
  List<String> selectedImages = [];
  String selectedLocation = "";
  List<String> selectedTags = [];
  String postPrivacy = "Public";
  bool allowComments = true;
  bool allowSharing = true;
  
  List<String> privacyOptions = ["Public", "Friends", "Private"];
  List<String> suggestedTags = ["#lifestyle", "#photography", "#travel", "#food", "#fitness", "#technology", "#art", "#music"];
  
  List<Map<String, dynamic>> mediaTemplates = [
    {
      "type": "story",
      "title": "Story Template",
      "icon": Icons.auto_stories,
      "description": "Share a quick story update"
    },
    {
      "type": "photo",
      "title": "Photo Post",
      "icon": Icons.photo_camera,
      "description": "Share photos with your followers"
    },
    {
      "type": "video",
      "title": "Video Post",
      "icon": Icons.videocam,
      "description": "Upload and share videos"
    },
    {
      "type": "poll",
      "title": "Create Poll",
      "icon": Icons.poll,
      "description": "Ask your audience a question"
    },
    {
      "type": "event",
      "title": "Event",
      "icon": Icons.event,
      "description": "Create or share an event"
    },
    {
      "type": "article",
      "title": "Article",
      "icon": Icons.article,
      "description": "Write a detailed article"
    }
  ];

  void _addTag(String tag) {
    if (!selectedTags.contains(tag)) {
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

  void _publishPost() async {
    if (postContent.trim().isEmpty && selectedImages.isEmpty) {
      se("Please add some content or images to your post");
      return;
    }

    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Post published successfully!");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        actions: [
          QButton(
            label: "Publish",
            size: bs.sm,
            onPressed: _publishPost,
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
            // User Info
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusLg),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/100/100?random=200&keyword=profile"),
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
                        "John Doe",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "",
                              items: privacyOptions.map((privacy) => {
                                "label": privacy,
                                "value": privacy,
                              }).toList(),
                              value: postPrivacy,
                              onChanged: (value, label) {
                                setState(() {
                                  postPrivacy = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Post Content
            QMemoField(
              label: "What's on your mind?",
              value: postContent,
              hint: "Share your thoughts, experiences, or updates...",
              onChanged: (value) {
                setState(() {
                  postContent = value;
                });
              },
            ),
            
            // Media Templates
            Text(
              "Post Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: mediaTemplates.map((template) {
                return GestureDetector(
                  onTap: () {
                    //navigateTo('${template["type"]}PostView')
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            template["icon"] as IconData,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${template["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            // Image Upload
            QMultiImagePicker(
              label: "Add Photos",
              value: selectedImages,
              hint: "Select multiple images for your post",
              maxImages: 10,
              onChanged: (value) {
                setState(() {
                  selectedImages = value;
                });
              },
            ),
            
            // Location
            Row(
              children: [
                Icon(Icons.location_on, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Expanded(
                  child: QTextField(
                    label: "Add Location",
                    value: selectedLocation,
                    hint: "Where are you?",
                    onChanged: (value) {
                      setState(() {
                        selectedLocation = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            
            // Tags Section
            Text(
              "Add Tags",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
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
            
            // Suggested Tags
            Text(
              "Suggested Tags",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: disabledBoldColor,
              ),
            ),
            
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: suggestedTags.where((tag) => !selectedTags.contains(tag)).map((tag) {
                return GestureDetector(
                  onTap: () => _addTag(tag),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            // Post Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Post Settings",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Allow Comments",
                              "value": true,
                              "checked": allowComments,
                            }
                          ],
                          value: allowComments ? [{
                            "label": "Allow Comments",
                            "value": true,
                            "checked": true
                          }] : [],
                          onChanged: (values, ids) {
                            setState(() {
                              allowComments = values.isNotEmpty;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Allow Sharing",
                              "value": true,
                              "checked": allowSharing,
                            }
                          ],
                          value: allowSharing ? [{
                            "label": "Allow Sharing",
                            "value": true,
                            "checked": true
                          }] : [],
                          onChanged: (values, ids) {
                            setState(() {
                              allowSharing = values.isNotEmpty;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Preview Section
            if (postContent.isNotEmpty || selectedImages.isNotEmpty)
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
                    
                    // Post Header
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            image: DecorationImage(
                              image: NetworkImage("https://picsum.photos/100/100?random=200&keyword=profile"),
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
                                "John Doe",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Just now • $postPrivacy",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                      ),
                    ],
                    
                    if (selectedTags.isNotEmpty) ...[
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        children: selectedTags.map((tag) {
                          return Text(
                            tag,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    
                    if (selectedImages.isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Container(
                        height: 150,
                        child: QHorizontalScroll(
                          children: selectedImages.map((image) {
                            return Container(
                              width: 120,
                              margin: EdgeInsets.only(right: spSm),
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
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                    
                    if (selectedLocation.isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            selectedLocation,
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
