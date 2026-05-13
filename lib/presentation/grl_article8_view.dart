import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle8View extends StatefulWidget {
  @override
  State<GrlArticle8View> createState() => _GrlArticle8ViewState();
}

class _GrlArticle8ViewState extends State<GrlArticle8View> {
  String title = "";
  String content = "";
  String category = "Technology";
  List<String> tags = [];
  String tagInput = "";
  String coverImage = "";
  bool isPublished = false;
  bool enableComments = true;
  bool featuredArticle = false;
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Technology", "value": "Technology"},
    {"label": "Business", "value": "Business"},
    {"label": "Health", "value": "Health"},
    {"label": "Science", "value": "Science"},
    {"label": "Environment", "value": "Environment"},
    {"label": "Education", "value": "Education"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Travel", "value": "Travel"},
  ];

  List<String> suggestedTags = [
    "AI", "Machine Learning", "Technology", "Innovation", "Healthcare", 
    "Climate Change", "Sustainability", "Business", "Finance", "Education",
    "Research", "Development", "Future", "Digital", "Analytics"
  ];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write Article"),
        actions: [
          GestureDetector(
            onTap: () => _saveAsDraft(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(40),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Text(
                "Save Draft",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.edit, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Article Editor",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${_getCompletionPercentage()}% Complete",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: _getCompletionPercentage() / 100,
                      backgroundColor: primaryColor.withAlpha(40),
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Article Title
              QTextField(
                label: "Article Title",
                hint: "Enter a compelling title for your article",
                value: title,
                validator: Validator.required,
                onChanged: (value) {
                  title = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spMd),

              // Cover Image
              QImagePicker(
                label: "Cover Image",
                hint: "Upload a cover image for your article",
                value: coverImage,
                onChanged: (value) {
                  coverImage = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spMd),

              // Category Selection
              QDropdownField(
                label: "Category",
                items: categoryOptions,
                value: category,
                onChanged: (value, label) {
                  category = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spMd),

              // Content Editor
              Text(
                "Article Content",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    // Editor Toolbar
                    Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                      ),
                      child: Row(
                        children: [
                          _buildToolbarButton(Icons.format_bold, "Bold"),
                          _buildToolbarButton(Icons.format_italic, "Italic"),
                          _buildToolbarButton(Icons.format_underlined, "Underline"),
                          SizedBox(width: spSm),
                          _buildToolbarButton(Icons.format_list_bulleted, "List"),
                          _buildToolbarButton(Icons.format_list_numbered, "Numbers"),
                          SizedBox(width: spSm),
                          _buildToolbarButton(Icons.link, "Link"),
                          _buildToolbarButton(Icons.image, "Image"),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    TextField(
                      maxLines: 15,
                      decoration: InputDecoration(
                        hintText: "Write your article content here...\n\nTip: Use markdown formatting for better structure:\n# Heading 1\n## Heading 2\n**Bold text**\n*Italic text*\n- Bullet points",
                        hintStyle: TextStyle(color: disabledColor),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                      ),
                      onChanged: (value) {
                        content = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Tags Section
              Text(
                "Tags",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              // Current Tags
              if (tags.isNotEmpty) ...[
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {
                              tags.remove(tag);
                              setState(() {});
                            },
                            child: Icon(Icons.close, color: Colors.white, size: 16),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
              ],

              // Add Tag Input
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Add Tags",
                      hint: "Enter tag and press Add",
                      value: tagInput,
                      onChanged: (value) {
                        tagInput = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Add",
                    size: bs.sm,
                    onPressed: tagInput.isNotEmpty ? () {
                      if (!tags.contains(tagInput) && tagInput.isNotEmpty) {
                        tags.add(tagInput);
                        tagInput = "";
                        setState(() {});
                      }
                    } : null,
                  ),
                ],
              ),

              SizedBox(height: spSm),

              // Suggested Tags
              Text(
                "Suggested Tags:",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spXs),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: suggestedTags.where((tag) => !tags.contains(tag)).take(8).map((tag) {
                  return GestureDetector(
                    onTap: () {
                      if (tags.length < 5) {
                        tags.add(tag);
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(60)),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: spLg),

              // Article Settings
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Publishing Settings",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Publish Status
                    QSwitch(
                      label: "Publish Article",
                      items: [
                        {
                          "label": "Published",
                          "value": true,
                          "checked": isPublished,
                        }
                      ],
                      value: [if (isPublished) {"label": "Published", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isPublished = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Enable Comments
                    QSwitch(
                      label: "Allow Comments",
                      items: [
                        {
                          "label": "Enable comments on this article",
                          "value": true,
                          "checked": enableComments,
                        }
                      ],
                      value: [if (enableComments) {"label": "Enable comments on this article", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        enableComments = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Featured Article
                    QSwitch(
                      label: "Featured Article",
                      items: [
                        {
                          "label": "Feature this article on homepage",
                          "value": true,
                          "checked": featuredArticle,
                        }
                      ],
                      value: [if (featuredArticle) {"label": "Feature this article on homepage", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        featuredArticle = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Preview Section
              if (title.isNotEmpty) ...[
                Text(
                  "Preview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (coverImage.isNotEmpty) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            color: primaryColor.withAlpha(40),
                            child: Center(
                              child: Icon(Icons.image, color: primaryColor, size: 48),
                            ),
                          ),
                        ),
                        SizedBox(height: spMd),
                      ],
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (content.isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Text(
                          content.length > 100 ? "${content.substring(0, 100)}..." : content,
                          style: TextStyle(
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                      if (tags.isNotEmpty) ...[
                        SizedBox(height: spMd),
                        Wrap(
                          spacing: spXs,
                          children: tags.map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: spLg),
              ],

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Preview Article",
                      size: bs.md,
                      onPressed: _canPreview() ? () {
                        _previewArticle();
                      } : null,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: isPublished ? "Publish Article" : "Save as Draft",
                      size: bs.md,
                      onPressed: _canSave() ? () {
                        if (formKey.currentState!.validate()) {
                          _publishArticle();
                        }
                      } : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbarButton(IconData icon, String tooltip) {
    return GestureDetector(
      onTap: () {
        // Handle toolbar action
        ss("$tooltip formatting applied");
      },
      child: Container(
        margin: EdgeInsets.only(right: spXs),
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Icon(icon, color: disabledBoldColor, size: 18),
      ),
    );
  }

  int _getCompletionPercentage() {
    int completed = 0;
    int total = 5;
    
    if (title.isNotEmpty) completed++;
    if (content.isNotEmpty) completed++;
    if (coverImage.isNotEmpty) completed++;
    if (tags.isNotEmpty) completed++;
    if (category.isNotEmpty) completed++;
    
    return ((completed / total) * 100).round();
  }

  bool _canPreview() {
    return title.isNotEmpty && content.isNotEmpty;
  }

  bool _canSave() {
    return title.isNotEmpty;
  }

  void _saveAsDraft() {
    ss("Article saved as draft");
  }

  void _previewArticle() {
    si("Opening article preview");
  }

  void _publishArticle() {
    if (isPublished) {
      ss("Article published successfully!");
    } else {
      ss("Article saved as draft");
    }
  }
}
