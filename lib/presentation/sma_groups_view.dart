import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaGroupsView extends StatefulWidget {
  const SmaGroupsView({super.key});

  @override
  State<SmaGroupsView> createState() => _SmaGroupsViewState();
}

class _SmaGroupsViewState extends State<SmaGroupsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Music", "value": "Music"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Food", "value": "Food"},
    {"label": "Business", "value": "Business"},
    {"label": "Education", "value": "Education"},
  ];

  final List<Map<String, dynamic>> myGroups = [
    {
      "id": 1,
      "name": "Flutter Developers",
      "description": "A community for Flutter developers to share knowledge and tips",
      "members": 12540,
      "image": "https://picsum.photos/80/80?random=1&keyword=tech",
      "category": "Technology",
      "isAdmin": true,
      "lastActivity": "2 hours ago",
      "unreadCount": 5,
    },
    {
      "id": 2,
      "name": "Photography Enthusiasts",
      "description": "Share your best shots and photography techniques",
      "members": 8934,
      "image": "https://picsum.photos/80/80?random=2&keyword=camera",
      "category": "Arts",
      "isAdmin": false,
      "lastActivity": "1 day ago",
      "unreadCount": 0,
    },
    {
      "id": 3,
      "name": "Fitness Motivation",
      "description": "Stay motivated and track your fitness journey together",
      "members": 15670,
      "image": "https://picsum.photos/80/80?random=3&keyword=fitness",
      "category": "Sports",
      "isAdmin": false,
      "lastActivity": "5 hours ago",
      "unreadCount": 12,
    },
  ];

  final List<Map<String, dynamic>> suggestedGroups = [
    {
      "id": 4,
      "name": "Startup Founders",
      "description": "Connect with fellow entrepreneurs and startup founders",
      "members": 6743,
      "image": "https://picsum.photos/80/80?random=4&keyword=business",
      "category": "Business",
      "isPrivate": false,
    },
    {
      "id": 5,
      "name": "Digital Nomads",
      "description": "Remote workers sharing travel and work experiences",
      "members": 9821,
      "image": "https://picsum.photos/80/80?random=5&keyword=travel",
      "category": "Travel",
      "isPrivate": false,
    },
    {
      "id": 6,
      "name": "Cooking Masters",
      "description": "Share recipes and cooking techniques with food lovers",
      "members": 4567,
      "image": "https://picsum.photos/80/80?random=6&keyword=food",
      "category": "Food",
      "isPrivate": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Groups",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "My Groups", icon: Icon(Icons.group)),
        Tab(text: "Discover", icon: Icon(Icons.explore)),
        Tab(text: "Create", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildMyGroupsTab(),
        _buildDiscoverTab(),
        _buildCreateGroupTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildMyGroupsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search Bar
          QTextField(
            label: "Search my groups",
            value: searchQuery,
            hint: "Search groups...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Groups List
          Column(
            spacing: spSm,
            children: myGroups.map((group) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    // Group Image
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${group["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),

                    // Group Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${group["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              if ((group["isAdmin"] as bool))
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Admin",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${group["description"]}",
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
                              Icon(
                                Icons.people,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${((group["members"] as int) / 1000).toStringAsFixed(1)}K members",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${group["lastActivity"]}",
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

                    // Unread Badge & Action
                    Column(
                      children: [
                        if ((group["unreadCount"] as int) > 0)
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "${group["unreadCount"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        SizedBox(height: spSm),
                        QButton(
                          icon: Icons.arrow_forward,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to group detail
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search Bar
          QTextField(
            label: "Search groups",
            value: searchQuery,
            hint: "Find groups to join...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Category Filter
          QCategoryPicker(
            label: "Category",
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),

          // Suggested Groups Header
          Text(
            "Suggested for You",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Suggested Groups
          Column(
            spacing: spSm,
            children: suggestedGroups.map((group) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    // Group Image
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Stack(
                          children: [
                            Image.network(
                              "${group["image"]}",
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                            if (group["isPrivate"] as bool)
                              Positioned(
                                top: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),

                    // Group Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${group["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${group["description"]}",
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
                              Icon(
                                Icons.people,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${((group["members"] as int) / 1000).toStringAsFixed(1)}K members",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${group["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Join Button
                    Column(
                      children: [
                        QButton(
                          label: group["isPrivate"] as bool ? "Request" : "Join",
                          size: bs.sm,
                          onPressed: () {
                            _joinGroup(group);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateGroupTab() {
    String groupName = "";
    String groupDescription = "";
    String groupCategory = "Technology";
    bool isPrivate = false;
    String groupImage = "";

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header
          Text(
            "Create New Group",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Group Image
          QImagePicker(
            label: "Group Image",
            value: groupImage,
            hint: "Select group cover image",
            onChanged: (value) {
              groupImage = value;
              setState(() {});
            },
          ),

          // Group Name
          QTextField(
            label: "Group Name",
            value: groupName,
            hint: "Enter group name",
            onChanged: (value) {
              groupName = value;
              setState(() {});
            },
          ),

          // Group Description
          QMemoField(
            label: "Description",
            value: groupDescription,
            hint: "Describe what your group is about...",
            maxLines: 4,
            onChanged: (value) {
              groupDescription = value;
              setState(() {});
            },
          ),

          // Category
          QDropdownField(
            label: "Category",
            items: categories.where((cat) => cat["value"] != "All").toList(),
            value: groupCategory,
            onChanged: (value, label) {
              groupCategory = value;
              setState(() {});
            },
          ),

          // Privacy Setting
          QSwitch(
            label: "Group Privacy",
            items: [
              {
                "label": "Private Group (Requires approval to join)",
                "value": true,
                "checked": isPrivate,
              }
            ],
            value: [
              if (isPrivate)
                {
                  "label": "Private Group (Requires approval to join)",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isPrivate = values.isNotEmpty;
              setState(() {});
            },
          ),

          // Group Rules Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: infoColor.withAlpha(100),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Group Guidelines",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Be respectful to all members\n• Stay on topic related to the group's purpose\n• No spam or promotional content\n• Follow community guidelines",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),

          // Create Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Group",
              size: bs.md,
              onPressed: () {
                _createGroup();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _joinGroup(Map<String, dynamic> group) {
    bool isPrivate = group["isPrivate"] as bool;
    if (isPrivate) {
      ss("Join request sent for ${group["name"]}");
    } else {
      ss("Successfully joined ${group["name"]}!");
    }
  }

  void _createGroup() {
    ss("Group created successfully!");
    selectedTab = 0;
    setState(() {});
  }
}
