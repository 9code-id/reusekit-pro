import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsContentCreationView extends StatefulWidget {
  const DmsContentCreationView({super.key});

  @override
  State<DmsContentCreationView> createState() => _DmsContentCreationViewState();
}

class _DmsContentCreationViewState extends State<DmsContentCreationView> {
  int currentTab = 0;
  String contentTitle = "";
  String contentType = "blog";
  String category = "marketing";
  String content = "";
  String metaDescription = "";
  String tags = "";
  String featuredImage = "";
  List<String> contentImages = [];
  bool publishNow = true;
  String scheduledDate = DateTime.now().toString();
  String scheduledTime = "09:00";
  bool enableComments = true;
  bool featured = false;
  String status = "draft";

  List<Map<String, dynamic>> contentTypeOptions = [
    {"label": "Blog Post", "value": "blog"},
    {"label": "Article", "value": "article"},
    {"label": "Case Study", "value": "case_study"},
    {"label": "White Paper", "value": "whitepaper"},
    {"label": "News", "value": "news"},
    {"label": "Tutorial", "value": "tutorial"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Marketing", "value": "marketing"},
    {"label": "Technology", "value": "technology"},
    {"label": "Business", "value": "business"},
    {"label": "Finance", "value": "finance"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Education", "value": "education"},
  ];

  List<Map<String, dynamic>> recentContent = [
    {
      "id": 1,
      "title": "10 Digital Marketing Trends for 2024",
      "type": "Blog Post",
      "status": "Published",
      "date": "2024-01-15",
      "views": 2847,
      "likes": 156,
      "author": "Sarah Johnson",
      "category": "Marketing",
      "featured": true,
    },
    {
      "id": 2,
      "title": "Complete Guide to Social Media Analytics",
      "type": "Article",
      "status": "Draft",
      "date": "2024-01-14",
      "views": 0,
      "likes": 0,
      "author": "Mike Chen",
      "category": "Technology",
      "featured": false,
    },
    {
      "id": 3,
      "title": "Customer Success Case Study - TechCorp",
      "type": "Case Study",
      "status": "Published",
      "date": "2024-01-13",
      "views": 1205,
      "likes": 89,
      "author": "Emma Davis",
      "category": "Business",
      "featured": false,
    },
  ];

  List<Map<String, dynamic>> contentTemplates = [
    {
      "id": 1,
      "name": "Blog Post Template",
      "description": "Standard blog post with introduction, body, and conclusion",
      "type": "Blog",
      "usage": 45,
    },
    {
      "id": 2,
      "name": "Product Review Template",
      "description": "Structured template for product reviews and comparisons",
      "type": "Review",
      "usage": 32,
    },
    {
      "id": 3,
      "name": "How-to Guide Template",
      "description": "Step-by-step tutorial template with numbered sections",
      "type": "Tutorial",
      "usage": 28,
    },
  ];

  void _saveAsDraft() {
    status = "draft";
    ss("Content saved as draft");
  }

  void _publishContent() {
    status = "published";
    ss("Content published successfully");
  }

  void _scheduleContent() {
    status = "scheduled";
    ss("Content scheduled for publication");
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Content Creation",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Create", icon: Icon(Icons.edit)),
        Tab(text: "Recent", icon: Icon(Icons.history)),
        Tab(text: "Templates", icon: Icon(Icons.copy)),
      ],
      tabChildren: [
        _buildCreateTab(),
        _buildRecentTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Content Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.create, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create New Content",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Build engaging content for your audience",
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
          ),

          // Basic Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Basic Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QTextField(
                  label: "Content Title",
                  value: contentTitle,
                  hint: "Enter a compelling title for your content",
                  validator: Validator.required,
                  onChanged: (value) {
                    contentTitle = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Content Type",
                        items: contentTypeOptions,
                        value: contentType,
                        onChanged: (value, label) {
                          contentType = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: category,
                        onChanged: (value, label) {
                          category = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content Editor
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Content Editor",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QMemoField(
                  label: "Content Body",
                  value: content,
                  hint: "Write your content here...",
                  validator: Validator.required,
                  onChanged: (value) {
                    content = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Meta Description",
                  value: metaDescription,
                  hint: "Brief description for SEO (150-160 characters)",
                  onChanged: (value) {
                    metaDescription = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Tags",
                  value: tags,
                  hint: "Enter tags separated by commas",
                  onChanged: (value) {
                    tags = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Media & Images
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Media & Images",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QImagePicker(
                  label: "Featured Image",
                  value: featuredImage,
                  hint: "Select the main image for your content",
                  onChanged: (value) {
                    featuredImage = value;
                    setState(() {});
                  },
                ),
                QMultiImagePicker(
                  label: "Content Images",
                  value: contentImages,
                  maxImages: 10,
                  hint: "Add images to use within your content",
                  onChanged: (value) {
                    contentImages = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Publishing Options
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Publishing Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Publish Immediately",
                      "value": true,
                      "checked": publishNow,
                    }
                  ],
                  value: [
                    if (publishNow)
                      {
                        "label": "Publish Immediately",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    publishNow = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                if (!publishNow) ...[
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Scheduled Date",
                          value: DateTime.parse(scheduledDate),
                          onChanged: (value) {
                            scheduledDate = value.toString();
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTimePicker(
                          label: "Scheduled Time",
                          value: TimeOfDay.fromDateTime(
                              DateTime.parse("2024-01-01 $scheduledTime:00")),
                          onChanged: (value) {
                            scheduledTime = value!.kkmm;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Enable Comments",
                            "value": true,
                            "checked": enableComments,
                          }
                        ],
                        value: [
                          if (enableComments)
                            {
                              "label": "Enable Comments",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          enableComments = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Featured Content",
                            "value": true,
                            "checked": featured,
                          }
                        ],
                        value: [
                          if (featured)
                            {
                              "label": "Featured Content",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          featured = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
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
                    Expanded(
                      child: QButton(
                        label: "Save as Draft",
                        icon: Icons.save,
                        size: bs.md,
                        onPressed: _saveAsDraft,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: publishNow ? "Publish Now" : "Schedule",
                        icon: publishNow ? Icons.publish : Icons.schedule,
                        size: bs.md,
                        onPressed: publishNow ? _publishContent : _scheduleContent,
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

  Widget _buildRecentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Stats Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Content", "1,247", Icons.article, primaryColor),
              _buildStatCard("Published", "896", Icons.publish, successColor),
              _buildStatCard("Drafts", "203", Icons.edit, warningColor),
              _buildStatCard("Scheduled", "148", Icons.schedule, infoColor),
            ],
          ),

          // Recent Content List
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.history, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Recent Content",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                ...recentContent.map((content) => _buildContentItem(content)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Templates Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.copy, color: successColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Content Templates",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Pre-built templates to speed up content creation",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Create Template",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Templates List
          ...contentTemplates.map((template) => _buildTemplateItem(template)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentItem(Map<String, dynamic> content) {
    Color statusColor = content["status"] == "Published" 
        ? successColor 
        : content["status"] == "Draft" 
            ? warningColor 
            : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${content["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${content["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "${content["type"]} • ${content["category"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (content["featured"] == true) ...[
                Icon(Icons.star, color: warningColor, size: 12),
                SizedBox(width: spXs),
              ],
              Text(
                "${content["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (content["status"] == "Published") ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.visibility, size: 12, color: disabledBoldColor),
                SizedBox(width: 2),
                Text(
                  "${(content["views"] as int).toString()}",
                  style: TextStyle(fontSize: 11, color: disabledBoldColor),
                ),
                SizedBox(width: spXs),
                Icon(Icons.favorite, size: 12, color: disabledBoldColor),
                SizedBox(width: 2),
                Text(
                  "${(content["likes"] as int).toString()}",
                  style: TextStyle(fontSize: 11, color: disabledBoldColor),
                ),
                Spacer(),
                QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTemplateItem(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(Icons.copy, color: primaryColor),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "${template["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${template["type"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Used ${template["usage"]} times",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            label: "Use Template",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
