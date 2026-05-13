import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShare4View extends StatefulWidget {
  @override
  State<GrlShare4View> createState() => _GrlShare4ViewState();
}

class _GrlShare4ViewState extends State<GrlShare4View> {
  String linkUrl = "";
  String linkTitle = "";
  String linkDescription = "";
  String linkImage = "";
  String selectedCategory = "article";
  bool isBookmark = false;
  bool isPublic = true;
  List<String> tags = [];
  String currentTag = "";
  String selectedFolder = "";
  
  final List<Map<String, dynamic>> categories = [
    {"label": "Article", "value": "article", "icon": Icons.article},
    {"label": "Video", "value": "video", "icon": Icons.play_circle},
    {"label": "Website", "value": "website", "icon": Icons.web},
    {"label": "Tool", "value": "tool", "icon": Icons.build},
    {"label": "Tutorial", "value": "tutorial", "icon": Icons.school},
    {"label": "News", "value": "news", "icon": Icons.newspaper},
  ];

  final List<Map<String, dynamic>> folders = [
    {"label": "General", "value": "general"},
    {"label": "Work", "value": "work"},
    {"label": "Personal", "value": "personal"},
    {"label": "Learning", "value": "learning"},
    {"label": "Resources", "value": "resources"},
  ];

  final List<Map<String, dynamic>> recentLinks = [
    {
      "title": "10 Flutter Tips for Better Performance",
      "url": "https://flutter.dev/tips",
      "description": "Learn how to optimize your Flutter apps",
      "category": "tutorial",
      "date": "2024-01-15",
      "clicks": 24,
      "likes": 8,
      "tags": ["flutter", "performance", "mobile"],
      "image": "https://picsum.photos/200/150?random=1&keyword=flutter"
    },
    {
      "title": "Design System Best Practices",
      "url": "https://design.example.com",
      "description": "How to build scalable design systems",
      "category": "article",
      "date": "2024-01-14",
      "clicks": 18,
      "likes": 12,
      "tags": ["design", "ui", "ux"],
      "image": "https://picsum.photos/200/150?random=2&keyword=design"
    },
    {
      "title": "AI Tools for Developers",
      "url": "https://ai-tools.dev",
      "description": "Collection of useful AI development tools",
      "category": "tool",
      "date": "2024-01-13",
      "clicks": 35,
      "likes": 15,
      "tags": ["ai", "tools", "development"],
      "image": "https://picsum.photos/200/150?random=3&keyword=ai"
    },
  ];

  final List<Map<String, dynamic>> popularTags = [
    {"name": "flutter", "count": 24},
    {"name": "development", "count": 18},
    {"name": "design", "count": 15},
    {"name": "tutorial", "count": 12},
    {"name": "tools", "count": 9},
    {"name": "resources", "count": 7},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Link"),
        actions: [
          QButton(
            icon: Icons.bookmark_border,
            size: bs.sm,
            onPressed: () {
              _showBookmarks();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUrlInput(),
            _buildLinkPreview(),
            _buildLinkDetails(),
            _buildCategoryAndFolder(),
            _buildTags(),
            _buildSettings(),
            _buildPopularTags(),
            _buildRecentLinks(),
            _buildShareButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUrlInput() {
    return Container(
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
            "Enter URL",
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
                child: QTextField(
                  label: "Paste URL here",
                  value: linkUrl,
                  hint: "https://example.com",
                  onChanged: (value) {
                    linkUrl = value;
                    setState(() {});
                    if (value.isNotEmpty && value.startsWith('http')) {
                      _fetchLinkPreview();
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.content_paste,
                size: bs.sm,
                onPressed: () {
                  _pasteFromClipboard();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLinkPreview() {
    if (linkUrl.isEmpty) return Container();

    return Container(
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
            "Link Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (linkImage.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.network(
                        linkImage.isNotEmpty ? linkImage : "https://picsum.photos/400/200?random=1&keyword=website",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: disabledBoldColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        linkTitle.isNotEmpty ? linkTitle : "Sample Website Title",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        linkDescription.isNotEmpty ? linkDescription : "This is a sample description for the shared link. It provides a brief overview of the content.",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        linkUrl,
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkDetails() {
    return Container(
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
            "Link Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Title",
            value: linkTitle,
            hint: "Enter a custom title",
            onChanged: (value) {
              linkTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Description",
            value: linkDescription,
            hint: "Add a description",
            onChanged: (value) {
              linkDescription = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QImagePicker(
            label: "Custom Image (Optional)",
            value: linkImage,
            hint: "Upload a custom preview image",
            onChanged: (value) {
              linkImage = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryAndFolder() {
    return Container(
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
            "Organization",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Category",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: categories.map((category) {
              bool isSelected = selectedCategory == category["value"];
              return GestureDetector(
                onTap: () {
                  selectedCategory = category["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category["icon"],
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${category["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Folder",
            items: folders,
            value: selectedFolder,
            onChanged: (value, label) {
              selectedFolder = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTags() {
    return Container(
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
            "Tags",
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
                child: QTextField(
                  label: "Add Tag",
                  value: currentTag,
                  hint: "Enter tag name",
                  onChanged: (value) {
                    currentTag = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: currentTag.isNotEmpty ? () {
                  if (!tags.contains(currentTag)) {
                    tags.add(currentTag);
                    currentTag = "";
                    setState(() {});
                  }
                } : null,
              ),
            ],
          ),
          if (tags.isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: tags.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXl),
                    border: Border.all(color: primaryColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () {
                          tags.remove(tag);
                          setState(() {});
                        },
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Container(
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
            "Share Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Save as Bookmark",
                "value": "bookmark",
                "checked": isBookmark,
              }
            ],
            value: isBookmark ? [{"label": "Save as Bookmark", "value": "bookmark", "checked": true}] : [],
            onChanged: (values, ids) {
              isBookmark = values.isNotEmpty;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Make Public",
                "value": "public",
                "checked": isPublic,
              }
            ],
            value: isPublic ? [{"label": "Make Public", "value": "public", "checked": true}] : [],
            onChanged: (values, ids) {
              isPublic = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPopularTags() {
    return Container(
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
            "Popular Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: popularTags.map((tag) {
              return GestureDetector(
                onTap: () {
                  if (!tags.contains(tag["name"])) {
                    tags.add(tag["name"]);
                    setState(() {});
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusXl),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "#${tag["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${tag["count"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildRecentLinks() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recent Shares",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
          SizedBox(height: spSm),
          ...recentLinks.map((link) => _buildLinkItem(link)).toList(),
        ],
      ),
    );
  }

  Widget _buildLinkItem(Map<String, dynamic> link) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusXs),
            child: Container(
              width: 60,
              height: 45,
              child: Image.network(
                "${link["image"]}",
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
                  "${link["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${link["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.visibility, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${link["clicks"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.favorite, size: 12, color: Colors.red),
                    SizedBox(width: spXs),
                    Text(
                      "${link["likes"]}",
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
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Share Link",
        size: bs.md,
        onPressed: linkUrl.isNotEmpty ? () {
          _shareLink();
        } : null,
      ),
    );
  }

  void _fetchLinkPreview() {
    // Simulate fetching link preview
    linkTitle = "Sample Website Title";
    linkDescription = "This is a sample description for the shared link.";
    linkImage = "https://picsum.photos/400/200?random=1&keyword=website";
    setState(() {});
  }

  void _pasteFromClipboard() {
    // Simulate pasting from clipboard
    linkUrl = "https://example.com/sample-article";
    _fetchLinkPreview();
  }

  void _shareLink() {
    if (linkUrl.isEmpty) {
      se("Please enter a URL to share");
      return;
    }

    if (linkTitle.isEmpty) {
      se("Please add a title");
      return;
    }

    ss("Link shared successfully!");
  }

  void _showBookmarks() {
    si("Opening bookmarks");
  }
}
