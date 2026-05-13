import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaSupportGroupsView extends StatefulWidget {
  const MhaSupportGroupsView({super.key});

  @override
  State<MhaSupportGroupsView> createState() => _MhaSupportGroupsViewState();
}

class _MhaSupportGroupsViewState extends State<MhaSupportGroupsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLocation = "All";
  bool showMyGroups = false;

  List<Map<String, dynamic>> supportGroups = [
    {
      "id": 1,
      "name": "Diabetes Support Circle",
      "category": "Diabetes",
      "description": "A supportive community for people managing diabetes and their families",
      "memberCount": 342,
      "location": "New York",
      "meetingType": "hybrid",
      "nextMeeting": "2024-01-20T14:00:00Z",
      "isJoined": true,
      "moderator": "Dr. Sarah Johnson",
      "tags": ["Type 2 Diabetes", "Nutrition", "Exercise"],
      "image": "https://picsum.photos/100/100?random=1&keyword=medical",
      "isActive": true,
      "createdDate": "2023-06-15",
      "privacy": "public"
    },
    {
      "id": 2,
      "name": "Heart Health Warriors",
      "category": "Cardiology",
      "description": "Supporting each other through heart conditions and recovery journeys",
      "memberCount": 156,
      "location": "Los Angeles",
      "meetingType": "online",
      "nextMeeting": "2024-01-18T19:00:00Z",
      "isJoined": false,
      "moderator": "Michael Chen",
      "tags": ["Heart Disease", "Recovery", "Lifestyle"],
      "image": "https://picsum.photos/100/100?random=2&keyword=heart",
      "isActive": true,
      "createdDate": "2023-08-22",
      "privacy": "public"
    },
    {
      "id": 3,
      "name": "Cancer Survivors United",
      "category": "Oncology",
      "description": "Empowering cancer survivors and their loved ones with hope and support",
      "memberCount": 289,
      "location": "Chicago",
      "meetingType": "in-person",
      "nextMeeting": "2024-01-25T16:30:00Z",
      "isJoined": true,
      "moderator": "Lisa Rodriguez",
      "tags": ["Cancer", "Survivors", "Family Support"],
      "image": "https://picsum.photos/100/100?random=3&keyword=support",
      "isActive": true,
      "createdDate": "2023-03-10",
      "privacy": "private"
    },
    {
      "id": 4,
      "name": "Mental Wellness Circle",
      "category": "Mental Health",
      "description": "Creating a safe space for mental health discussions and peer support",
      "memberCount": 523,
      "location": "Online",
      "meetingType": "online",
      "nextMeeting": "2024-01-22T20:00:00Z",
      "isJoined": false,
      "moderator": "Dr. Amanda Foster",
      "tags": ["Depression", "Anxiety", "Mindfulness"],
      "image": "https://picsum.photos/100/100?random=4&keyword=mental",
      "isActive": true,
      "createdDate": "2023-01-08",
      "privacy": "public"
    },
    {
      "id": 5,
      "name": "Pregnancy & Parenting Support",
      "category": "Women's Health",
      "description": "Supporting new mothers and parents through pregnancy and early childhood",
      "memberCount": 412,
      "location": "Miami",
      "meetingType": "hybrid",
      "nextMeeting": "2024-01-24T10:00:00Z",
      "isJoined": true,
      "moderator": "Jennifer Wilson",
      "tags": ["Pregnancy", "Parenting", "Newborn Care"],
      "image": "https://picsum.photos/100/100?random=5&keyword=baby",
      "isActive": true,
      "createdDate": "2023-05-12",
      "privacy": "public"
    },
    {
      "id": 6,
      "name": "Weight Loss Journey",
      "category": "Nutrition",
      "description": "Motivating each other towards healthy weight management goals",
      "memberCount": 678,
      "location": "Houston",
      "meetingType": "in-person",
      "nextMeeting": "2024-01-19T18:00:00Z",
      "isJoined": false,
      "moderator": "Carlos Martinez",
      "tags": ["Weight Loss", "Diet", "Exercise"],
      "image": "https://picsum.photos/100/100?random=6&keyword=fitness",
      "isActive": true,
      "createdDate": "2023-04-03",
      "privacy": "public"
    }
  ];

  List<String> categories = [
    "All",
    "Diabetes",
    "Cardiology", 
    "Oncology",
    "Mental Health",
    "Women's Health",
    "Nutrition",
    "Chronic Pain",
    "Autoimmune"
  ];

  List<String> locations = [
    "All",
    "Online",
    "New York",
    "Los Angeles", 
    "Chicago",
    "Miami",
    "Houston",
    "Boston",
    "Seattle"
  ];

  List<Map<String, dynamic>> get filteredGroups {
    List<Map<String, dynamic>> filtered = supportGroups;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((group) {
        return (group["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (group["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (group["category"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedCategory != "All") {
      filtered = filtered.where((group) => group["category"] == selectedCategory).toList();
    }

    if (selectedLocation != "All") {
      filtered = filtered.where((group) => group["location"] == selectedLocation).toList();
    }

    if (showMyGroups) {
      filtered = filtered.where((group) => group["isJoined"] == true).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Groups"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showCreateGroupDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildQuickStats(),
            _buildFeaturedGroups(),
            _buildGroupsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateGroupDialog,
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search support groups...",
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
                label: "Category",
                items: categories.map((cat) => {
                  "label": cat,
                  "value": cat,
                }).toList(),
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Location",
                items: locations.map((loc) => {
                  "label": loc,
                  "value": loc,
                }).toList(),
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        QSwitch(
          items: [
            {
              "label": "Show only my groups",
              "value": true,
              "checked": showMyGroups,
            }
          ],
          value: showMyGroups ? [{"label": "Show only my groups", "value": true, "checked": true}] : [],
          onChanged: (values, ids) {
            showMyGroups = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    int totalGroups = supportGroups.length;
    int joinedGroups = supportGroups.where((g) => g["isJoined"] == true).length;
    int totalMembers = supportGroups.fold(0, (sum, group) => sum + (group["memberCount"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Support Groups Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total Groups", "$totalGroups", Icons.groups, successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("My Groups", "$joinedGroups", Icons.person_add, primaryColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Total Members", "$totalMembers", Icons.people, infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedGroups() {
    List<Map<String, dynamic>> featured = supportGroups.where((g) => g["memberCount"] > 300).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Featured Groups",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: featured.map((group) => _buildFeaturedGroupCard(group)).toList(),
        ),
      ],
    );
  }

  Widget _buildFeaturedGroupCard(Map<String, dynamic> group) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, primaryColor.withAlpha(200)],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${group["image"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${group["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${group["memberCount"]} members",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${group["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: group["isJoined"] ? "View Group" : "Join Group",
              size: bs.sm,
              onPressed: () => _joinGroup(group),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Support Groups",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${filteredGroups.length} groups found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        ...filteredGroups.map((group) => _buildGroupCard(group)).toList(),
      ],
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: group["isJoined"] 
          ? Border.all(color: successColor, width: 2)
          : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${group["image"]}"),
              ),
              SizedBox(width: spSm),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (group["isJoined"])
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Joined",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${group["category"]} • ${group["memberCount"]} members",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${group["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${group["location"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.videocam, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${group["meetingType"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (group["privacy"] == "private")
                Icon(Icons.lock, size: 16, color: warningColor),
            ],
          ),
          if (group["nextMeeting"] != null)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: infoColor),
                  SizedBox(width: spXs),
                  Text(
                    "Next meeting: ${DateTime.parse(group["nextMeeting"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: group["isJoined"] ? "View Details" : "Join Group",
                  size: bs.sm,
                  onPressed: () => _joinGroup(group),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () => _shareGroup(group),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.bookmark_border,
                size: bs.sm,
                onPressed: () => _bookmarkGroup(group),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _joinGroup(Map<String, dynamic> group) {
    if (group["isJoined"]) {
      // Navigate to group details
      ss("Opening group details");
    } else {
      // Join group
      setState(() {
        group["isJoined"] = true;
        group["memberCount"] = (group["memberCount"] as int) + 1;
      });
      ss("Successfully joined ${group["name"]}");
    }
  }

  void _shareGroup(Map<String, dynamic> group) {
    ss("Sharing ${group["name"]}");
  }

  void _bookmarkGroup(Map<String, dynamic> group) {
    ss("Bookmarked ${group["name"]}");
  }

  void _showCreateGroupDialog() {
    String groupName = "";
    String groupDescription = "";
    String selectedGroupCategory = "Mental Health";
    String selectedGroupLocation = "Online";
    String privacy = "public";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Support Group"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Group Name",
                value: groupName,
                onChanged: (value) => groupName = value,
              ),
              QMemoField(
                label: "Description",
                value: groupDescription,
                onChanged: (value) => groupDescription = value,
              ),
              QDropdownField(
                label: "Category",
                items: categories.skip(1).map((cat) => {
                  "label": cat,
                  "value": cat,
                }).toList(),
                value: selectedGroupCategory,
                onChanged: (value, label) => selectedGroupCategory = value,
              ),
              QDropdownField(
                label: "Location",
                items: locations.skip(1).map((loc) => {
                  "label": loc,
                  "value": loc,
                }).toList(),
                value: selectedGroupLocation,
                onChanged: (value, label) => selectedGroupLocation = value,
              ),
              QDropdownField(
                label: "Privacy",
                items: [
                  {"label": "Public", "value": "public"},
                  {"label": "Private", "value": "private"},
                ],
                value: privacy,
                onChanged: (value, label) => privacy = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (groupName.isNotEmpty && groupDescription.isNotEmpty) {
                Navigator.pop(context);
                ss("Support group created successfully!");
              } else {
                se("Please fill all required fields");
              }
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }
}
