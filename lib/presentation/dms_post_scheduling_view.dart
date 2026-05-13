import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsPostSchedulingView extends StatefulWidget {
  const DmsPostSchedulingView({super.key});

  @override
  State<DmsPostSchedulingView> createState() => _DmsPostSchedulingViewState();
}

class _DmsPostSchedulingViewState extends State<DmsPostSchedulingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedPlatform = "";
  bool loading = false;

  // Post data
  String postContent = "";
  String postTitle = "";
  List<String> selectedPlatforms = [];
  String scheduledDate = DateTime.now().add(Duration(hours: 1)).toIso8601String();
  String scheduledTime = TimeOfDay.now().kkmm;
  List<String> postImages = [];
  String postType = "text";
  bool immediatePost = false;

  // Filter data
  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": ""},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Published", "value": "published"},
    {"label": "Failed", "value": "failed"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> platformItems = [
    {"label": "All Platforms", "value": ""},
    {"label": "Facebook", "value": "facebook"},
    {"label": "Instagram", "value": "instagram"},
    {"label": "Twitter", "value": "twitter"},
    {"label": "LinkedIn", "value": "linkedin"},
  ];

  List<Map<String, dynamic>> postTypeItems = [
    {"label": "Text Post", "value": "text"},
    {"label": "Image Post", "value": "image"},
    {"label": "Video Post", "value": "video"},
    {"label": "Link Post", "value": "link"},
  ];

  // Sample scheduled posts data
  List<Map<String, dynamic>> scheduledPosts = [
    {
      "id": "1",
      "title": "Morning Motivation Monday",
      "content": "Start your week with positive energy! Remember that every expert was once a beginner. Keep pushing forward! 💪 #MondayMotivation #Success",
      "platforms": ["facebook", "instagram", "twitter"],
      "scheduled_date": "2024-01-22",
      "scheduled_time": "09:00",
      "status": "scheduled",
      "type": "text",
      "engagement_prediction": 8.5,
      "images": ["https://picsum.photos/400/300?random=1"],
    },
    {
      "id": "2",
      "title": "Product Feature Highlight",
      "content": "Discover the new dashboard features that will revolutionize your workflow. Streamline your processes with our latest updates.",
      "platforms": ["linkedin", "facebook"],
      "scheduled_date": "2024-01-22",
      "scheduled_time": "14:30",
      "status": "scheduled",
      "type": "image",
      "engagement_prediction": 6.2,
      "images": ["https://picsum.photos/400/300?random=2", "https://picsum.photos/400/300?random=3"],
    },
    {
      "id": "3",
      "title": "Weekend Tips",
      "content": "5 productivity tips for entrepreneurs working weekends. Make the most of your time while maintaining work-life balance.",
      "platforms": ["twitter", "linkedin"],
      "scheduled_date": "2024-01-21",
      "scheduled_time": "10:15",
      "status": "published",
      "type": "text",
      "engagement_prediction": 7.8,
      "images": [],
    },
    {
      "id": "4",
      "title": "Behind the Scenes",
      "content": "Take a look at our team's creative process. Innovation happens when great minds collaborate! 🎨",
      "platforms": ["instagram"],
      "scheduled_date": "2024-01-23",
      "scheduled_time": "16:00",
      "status": "draft",
      "type": "video",
      "engagement_prediction": 9.1,
      "images": ["https://picsum.photos/400/300?random=4"],
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    return scheduledPosts.where((post) {
      bool matchesSearch = "${post["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${post["content"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus.isEmpty || post["status"] == selectedStatus;
      bool matchesPlatform = selectedPlatform.isEmpty || 
                            (post["platforms"] as List).contains(selectedPlatform);
      return matchesSearch && matchesStatus && matchesPlatform;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Post Scheduling",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Scheduled", icon: Icon(Icons.schedule)),
        Tab(text: "Create Post", icon: Icon(Icons.add)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildScheduledPostsTab(),
        _buildCreatePostTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildScheduledPostsTab() {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          _buildSearchAndFilters(),

          // Scheduling Summary
          _buildSchedulingSummary(),

          // Scheduled Posts List
          _buildScheduledPostsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
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
                child: QTextField(
                  label: "Search posts...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter by Platform",
                  items: platformItems,
                  value: selectedPlatform,
                  onChanged: (value, label) {
                    selectedPlatform = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulingSummary() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Posts",
          "${scheduledPosts.length}",
          Icons.post_add,
          primaryColor,
        ),
        _buildSummaryCard(
          "Scheduled",
          "${scheduledPosts.where((p) => p["status"] == "scheduled").length}",
          Icons.schedule,
          warningColor,
        ),
        _buildSummaryCard(
          "Published",
          "${scheduledPosts.where((p) => p["status"] == "published").length}",
          Icons.check_circle,
          successColor,
        ),
        _buildSummaryCard(
          "Drafts",
          "${scheduledPosts.where((p) => p["status"] == "draft").length}",
          Icons.edit,
          infoColor,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledPostsList() {
    return Container(
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Scheduled Posts (${filteredPosts.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Bulk Actions",
                icon: Icons.checklist,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...filteredPosts.map((post) => _buildPostItem(post)),
        ],
      ),
    );
  }

  Widget _buildPostItem(Map<String, dynamic> post) {
    Color statusColor = _getStatusColor(post["status"]);
    List<String> platforms = (post["platforms"] as List).cast<String>();

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${post["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
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
                  "${post["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${post["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if ((post["images"] as List).isNotEmpty)
            Container(
              height: 60,
              child: QHorizontalScroll(
                children: (post["images"] as List).map((image) => 
                  Container(
                    width: 80,
                    margin: EdgeInsets.only(right: spXs),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusXs),
                      image: DecorationImage(
                        image: NetworkImage("$image"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse(post["scheduled_date"]).dMMMy} at ${post["scheduled_time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              ...platforms.take(3).map((platform) => 
                Padding(
                  padding: EdgeInsets.only(left: spXs),
                  child: Icon(
                    _getPlatformIcon(platform),
                    size: 16,
                    color: _getPlatformColor(platform),
                  ),
                ),
              ),
              if (platforms.length > 3)
                Padding(
                  padding: EdgeInsets.only(left: spXs),
                  child: Text(
                    "+${platforms.length - 3}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.trending_up, size: 16, color: successColor),
              SizedBox(width: spXs),
              Text(
                "Predicted engagement: ${post["engagement_prediction"]}%",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              PopupMenuButton(
                icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 16),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text("Edit"),
                      onTap: () => _editPost(post),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.copy),
                      title: Text("Duplicate"),
                      onTap: () => _duplicatePost(post),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.schedule),
                      title: Text("Reschedule"),
                      onTap: () => _reschedulePost(post),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.delete, color: dangerColor),
                      title: Text("Delete", style: TextStyle(color: dangerColor)),
                      onTap: () => _deletePost(post),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreatePostTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Post Details Form
          _buildPostDetailsForm(),

          // Platform Selection
          _buildPlatformSelection(),

          // Scheduling Options
          _buildSchedulingOptions(),

          // Preview and Actions
          _buildPreviewAndActions(),
        ],
      ),
    );
  }

  Widget _buildPostDetailsForm() {
    return Container(
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
            "Post Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Post Title",
            value: postTitle,
            hint: "Enter a descriptive title for your post",
            onChanged: (value) {
              postTitle = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Post Type",
            items: postTypeItems,
            value: postType,
            onChanged: (value, label) {
              postType = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Post Content",
            value: postContent,
            hint: "Write your post content here...",
            onChanged: (value) {
              postContent = value;
              setState(() {});
            },
          ),
          if (postType == "image" || postType == "video")
            QMultiImagePicker(
              label: "Upload Media",
              value: postImages,
              maxImages: 10,
              hint: "Select images or videos for your post",
              onChanged: (value) {
                postImages = value;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildPlatformSelection() {
    return Container(
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
            "Select Platforms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildPlatformCheckbox("Facebook", "facebook", Icons.facebook, Color(0xFF1877F2)),
              _buildPlatformCheckbox("Instagram", "instagram", Icons.camera_alt, Color(0xFFE4405F)),
              _buildPlatformCheckbox("Twitter", "twitter", Icons.alternate_email, Color(0xFF1DA1F2)),
              _buildPlatformCheckbox("LinkedIn", "linkedin", Icons.business, Color(0xFF0A66C2)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformCheckbox(String name, String value, IconData icon, Color color) {
    bool isSelected = selectedPlatforms.contains(value);
    
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          selectedPlatforms.remove(value);
        } else {
          selectedPlatforms.add(value);
        }
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(20) : Colors.grey.withAlpha(10),
          border: Border.all(
            color: isSelected ? color : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? color : disabledBoldColor,
              size: 20,
            ),
            SizedBox(width: spXs),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? color : disabledBoldColor,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? color : disabledBoldColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchedulingOptions() {
    return Container(
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
            "Scheduling Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Post immediately",
                "value": true,
                "checked": immediatePost,
              }
            ],
            value: immediatePost ? [
              {
                "label": "Post immediately",
                "value": true,
                "checked": true,
              }
            ] : [],
            onChanged: (values, ids) {
              immediatePost = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (!immediatePost) ...[
            Row(
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Scheduled Date",
                    value: DateTime.parse(scheduledDate),
                    onChanged: (value) {
                      scheduledDate = value.toIso8601String();
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTimePicker(
                    label: "Scheduled Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $scheduledTime:00")),
                    onChanged: (value) {
                      scheduledTime = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPreviewAndActions() {
    return Container(
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
            "Preview & Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (postContent.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Post Preview:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    postContent,
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  if (selectedPlatforms.isNotEmpty) ...[
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "Posting to: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        ...selectedPlatforms.map((platform) => 
                          Padding(
                            padding: EdgeInsets.only(right: spXs),
                            child: Icon(
                              _getPlatformIcon(platform),
                              size: 16,
                              color: _getPlatformColor(platform),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  size: bs.md,
                  onPressed: _saveDraft,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: immediatePost ? "Post Now" : "Schedule Post",
                  size: bs.md,
                  onPressed: _schedulePost,
                ),
              ),
            ],
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
          // Template Categories
          _buildTemplateCategories(),

          // Template Gallery
          _buildTemplateGallery(),
        ],
      ),
    );
  }

  Widget _buildTemplateCategories() {
    return Container(
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
            "Post Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: [
              {"label": "All", "value": "all"},
              {"label": "Promotional", "value": "promotional"},
              {"label": "Educational", "value": "educational"},
              {"label": "Motivational", "value": "motivational"},
              {"label": "Behind the Scenes", "value": "behind_scenes"},
              {"label": "User Generated", "value": "user_generated"},
            ],
            value: "all",
            onChanged: (index, label, value, item) {},
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateGallery() {
    List<Map<String, dynamic>> templates = [
      {
        "title": "Monday Motivation",
        "content": "Start your week with positive energy! Remember that every expert was once a beginner. Keep pushing forward! 💪 #MondayMotivation #Success",
        "category": "motivational",
        "engagement": 8.5,
        "uses": 45,
      },
      {
        "title": "Product Launch",
        "content": "🚀 Exciting news! We're thrilled to announce the launch of our latest feature. This game-changing addition will transform how you work. Learn more: [link]",
        "category": "promotional",
        "engagement": 7.2,
        "uses": 23,
      },
      {
        "title": "Tips Tuesday",
        "content": "💡 Tip of the day: [Insert your tip here]. Small changes can lead to big improvements. What's your favorite productivity tip? Share in the comments! #TipsTuesday",
        "category": "educational",
        "engagement": 6.8,
        "uses": 67,
      },
      {
        "title": "Team Spotlight",
        "content": "👏 Meet [Team Member Name], our [Position]. They've been instrumental in [Achievement]. We're proud to have such talented individuals on our team! #TeamSpotlight",
        "category": "behind_scenes",
        "engagement": 9.1,
        "uses": 34,
      },
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: templates.map((template) => _buildTemplateCard(template)).toList(),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "${template["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${template["category"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${template["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(Icons.trending_up, size: 16, color: successColor),
              SizedBox(width: spXs),
              Text(
                "${template["engagement"]}%",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                "Used ${template["uses"]} times",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Use Template",
                  size: bs.sm,
                  onPressed: () => _useTemplate(template),
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editTemplate(template),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'scheduled':
        return warningColor;
      case 'published':
        return successColor;
      case 'failed':
        return dangerColor;
      case 'draft':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt;
      case 'twitter':
        return Icons.alternate_email;
      case 'linkedin':
        return Icons.business;
      default:
        return Icons.public;
    }
  }

  Color _getPlatformColor(String platform) {
    switch (platform) {
      case 'facebook':
        return Color(0xFF1877F2);
      case 'instagram':
        return Color(0xFFE4405F);
      case 'twitter':
        return Color(0xFF1DA1F2);
      case 'linkedin':
        return Color(0xFF0A66C2);
      default:
        return primaryColor;
    }
  }

  void _editPost(Map<String, dynamic> post) {
    // Populate form with post data
    postTitle = post["title"];
    postContent = post["content"];
    selectedPlatforms = (post["platforms"] as List).cast<String>();
    scheduledDate = "${post["scheduled_date"]}T${post["scheduled_time"]}:00";
    
    // Switch to create post tab
    currentTab = 1;
    setState(() {});
  }

  void _duplicatePost(Map<String, dynamic> post) {
    postTitle = "${post["title"]} (Copy)";
    postContent = post["content"];
    selectedPlatforms = (post["platforms"] as List).cast<String>();
    
    currentTab = 1;
    setState(() {});
    
    ss("Post duplicated. You can now edit and schedule it.");
  }

  void _reschedulePost(Map<String, dynamic> post) async {
    // Show reschedule dialog or navigate to edit
    _editPost(post);
    si("Update the schedule and save changes");
  }

  void _deletePost(Map<String, dynamic> post) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this scheduled post?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Post deleted successfully");
    }
  }

  void _saveDraft() async {
    if (postContent.isEmpty) {
      se("Please enter post content");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    // Reset form
    _resetForm();
    
    ss("Post saved as draft");
  }

  void _schedulePost() async {
    if (postContent.isEmpty) {
      se("Please enter post content");
      return;
    }

    if (selectedPlatforms.isEmpty) {
      se("Please select at least one platform");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    // Reset form
    _resetForm();
    
    if (immediatePost) {
      ss("Post published successfully");
    } else {
      ss("Post scheduled successfully");
    }
    
    // Switch to scheduled posts tab
    currentTab = 0;
    setState(() {});
  }

  void _useTemplate(Map<String, dynamic> template) {
    postTitle = template["title"];
    postContent = template["content"];
    
    // Switch to create post tab
    currentTab = 1;
    setState(() {});
    
    ss("Template loaded. Customize and schedule your post.");
  }

  void _editTemplate(Map<String, dynamic> template) {
    // Navigate to template editor
    si("Template editing feature coming soon");
  }

  void _resetForm() {
    postContent = "";
    postTitle = "";
    selectedPlatforms = [];
    scheduledDate = DateTime.now().add(Duration(hours: 1)).toIso8601String();
    scheduledTime = TimeOfDay.now().kkmm;
    postImages = [];
    postType = "text";
    immediatePost = false;
    setState(() {});
  }
}
