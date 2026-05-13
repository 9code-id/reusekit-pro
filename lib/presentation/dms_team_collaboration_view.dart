import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsTeamCollaborationView extends StatefulWidget {
  const DmsTeamCollaborationView({super.key});

  @override
  State<DmsTeamCollaborationView> createState() => _DmsTeamCollaborationViewState();
}

class _DmsTeamCollaborationViewState extends State<DmsTeamCollaborationView> {
  String selectedProject = "all";
  String selectedTeam = "all";
  String searchQuery = "";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> teamMembers = [
    {
      "id": 1,
      "name": "Alice Johnson",
      "role": "Project Manager",
      "department": "Management",
      "email": "alice@company.com",
      "phone": "+1 (555) 123-4567",
      "status": "online",
      "projects": 3,
      "tasksCompleted": 45,
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "skills": ["Project Management", "Agile", "Scrum"],
      "lastActive": "2024-06-19 15:30",
    },
    {
      "id": 2,
      "name": "Bob Wilson",
      "role": "Senior Developer",
      "department": "Development",
      "email": "bob@company.com",
      "phone": "+1 (555) 987-6543",
      "status": "busy",
      "projects": 2,
      "tasksCompleted": 67,
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "skills": ["React", "Node.js", "MongoDB"],
      "lastActive": "2024-06-19 14:15",
    },
    {
      "id": 3,
      "name": "Carol Smith",
      "role": "UI/UX Designer",
      "department": "Design",
      "email": "carol@company.com",
      "phone": "+1 (555) 456-7890",
      "status": "away",
      "projects": 4,
      "tasksCompleted": 32,
      "avatar": "https://picsum.photos/100/100?random=3&keyword=designer",
      "skills": ["Figma", "Adobe XD", "Prototyping"],
      "lastActive": "2024-06-19 12:45",
    },
    {
      "id": 4,
      "name": "David Brown",
      "role": "QA Engineer",
      "department": "Quality Assurance",
      "email": "david@company.com",
      "phone": "+1 (555) 234-5678",
      "status": "online",
      "projects": 2,
      "tasksCompleted": 28,
      "avatar": "https://picsum.photos/100/100?random=4&keyword=engineer",
      "skills": ["Testing", "Automation", "Selenium"],
      "lastActive": "2024-06-19 15:00",
    },
  ];

  List<Map<String, dynamic>> collaborationSpaces = [
    {
      "id": 1,
      "name": "E-commerce Platform",
      "type": "project",
      "members": 6,
      "messages": 142,
      "files": 23,
      "lastActivity": "2024-06-19 15:30",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=ecommerce",
    },
    {
      "id": 2,
      "name": "Mobile Banking App",
      "type": "project",
      "members": 8,
      "messages": 98,
      "files": 15,
      "lastActivity": "2024-06-19 14:20",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=banking",
    },
    {
      "id": 3,
      "name": "Design Team",
      "type": "department",
      "members": 4,
      "messages": 67,
      "files": 89,
      "lastActivity": "2024-06-19 13:15",
      "avatar": "https://picsum.photos/100/100?random=7&keyword=design",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "id": 1,
      "user": "Alice Johnson",
      "action": "shared",
      "target": "Project Requirements.pdf",
      "space": "E-commerce Platform",
      "timestamp": "2024-06-19 15:30",
      "type": "file",
    },
    {
      "id": 2,
      "user": "Bob Wilson",
      "action": "commented on",
      "target": "Authentication Module",
      "space": "Mobile Banking App",
      "timestamp": "2024-06-19 14:45",
      "type": "comment",
    },
    {
      "id": 3,
      "user": "Carol Smith",
      "action": "uploaded",
      "target": "UI Mockups v2.fig",
      "space": "Design Team",
      "timestamp": "2024-06-19 13:20",
      "type": "file",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Collaboration"),
        actions: [
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () => _inviteTeamMember(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : QTabBar(
              title: "",
              withoutAppBar: true,
              selectedIndex: currentTab,
              tabs: [
                Tab(text: "Team", icon: Icon(Icons.people)),
                Tab(text: "Spaces", icon: Icon(Icons.workspaces)),
                Tab(text: "Activities", icon: Icon(Icons.timeline)),
              ],
              tabChildren: [
                _buildTeamTab(),
                _buildSpacesTab(),
                _buildActivitiesTab(),
              ],
            ),
    );
  }

  Widget _buildTeamTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTeamStats(),
          SizedBox(height: spLg),
          _buildTeamFilters(),
          SizedBox(height: spLg),
          _buildTeamMembersList(),
        ],
      ),
    );
  }

  Widget _buildSpacesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSpacesOverview(),
          SizedBox(height: spLg),
          _buildCollaborationSpaces(),
        ],
      ),
    );
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActivityFilters(),
          SizedBox(height: spLg),
          _buildActivityFeed(),
        ],
      ),
    );
  }

  Widget _buildTeamStats() {
    final onlineMembers = teamMembers.where((m) => m["status"] == "online").length;
    final totalTasks = teamMembers.fold<num>(0, (sum, member) => sum + (member["tasksCompleted"] as num));
    final activeProjects = teamMembers.fold<num>(0, (sum, member) => sum + (member["projects"] as num));

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
          Text(
            "Team Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildStatCard("Members", "${teamMembers.length}", Icons.people, primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("Online", "$onlineMembers", Icons.circle, successColor),
              SizedBox(width: spSm),
              _buildStatCard("Tasks", "$totalTasks", Icons.check_circle, infoColor),
              SizedBox(width: spSm),
              _buildStatCard("Projects", "$activeProjects", Icons.work, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search team members...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () => _showTeamFilters(),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: [
              {"label": "All", "value": "all"},
              {"label": "Online", "value": "online"},
              {"label": "Busy", "value": "busy"},
              {"label": "Away", "value": "away"},
              {"label": "Offline", "value": "offline"},
            ],
            value: selectedTeam,
            onChanged: (index, label, value, item) {
              selectedTeam = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMembersList() {
    final filteredMembers = _getFilteredTeamMembers();

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
          Text(
            "Team Members (${filteredMembers.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...filteredMembers.map((member) => _buildTeamMemberCard(member)).toList(),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(Map<String, dynamic> member) {
    Color statusColor;
    switch (member["status"]) {
      case "online":
        statusColor = successColor;
        break;
      case "busy":
        statusColor = dangerColor;
        break;
      case "away":
        statusColor = warningColor;
        break;
      default:
        statusColor = disabledBoldColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${member["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${member["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${member["role"]} • ${member["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${member["projects"]} projects",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${member["tasksCompleted"]} tasks",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            children: [
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () => _messageTeamMember(member),
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showMemberOptions(member),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpacesOverview() {
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
          Text(
            "Collaboration Spaces",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildStatCard("Active Spaces", "${collaborationSpaces.length}", Icons.workspaces, primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("Total Messages", "307", Icons.message, infoColor),
              SizedBox(width: spSm),
              _buildStatCard("Shared Files", "127", Icons.folder, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCollaborationSpaces() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Workspaces",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _createWorkspace(),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...collaborationSpaces.map((space) => _buildSpaceCard(space)).toList(),
        ],
      ),
    );
  }

  Widget _buildSpaceCard(Map<String, dynamic> space) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${space["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${space["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: space["type"] == "project" 
                            ? primaryColor.withAlpha(20) 
                            : infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${space["type"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: space["type"] == "project" ? primaryColor : infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.people, size: 12, color: disabledBoldColor),
                    SizedBox(width: 2),
                    Text(
                      "${space["members"]} members",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.message, size: 12, color: disabledBoldColor),
                    SizedBox(width: 2),
                    Text(
                      "${space["messages"]} messages",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.folder, size: 12, color: disabledBoldColor),
                    SizedBox(width: 2),
                    Text(
                      "${space["files"]} files",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Last activity: ${space["lastActivity"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.arrow_forward,
            size: bs.sm,
            onPressed: () => _openWorkspace(space),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: QCategoryPicker(
        items: [
          {"label": "All Activities", "value": "all"},
          {"label": "Files", "value": "file"},
          {"label": "Comments", "value": "comment"},
          {"label": "Tasks", "value": "task"},
          {"label": "Messages", "value": "message"},
        ],
        value: "all",
        onChanged: (index, label, value, item) {
          // Filter activities by type
        },
      ),
    );
  }

  Widget _buildActivityFeed() {
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
          Text(
            "Recent Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...recentActivities.map((activity) => _buildActivityItem(activity)).toList(),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    IconData icon;
    Color iconColor;

    switch (activity["type"]) {
      case "file":
        icon = Icons.folder;
        iconColor = warningColor;
        break;
      case "comment":
        icon = Icons.comment;
        iconColor = infoColor;
        break;
      case "task":
        icon = Icons.task;
        iconColor = primaryColor;
        break;
      default:
        icon = Icons.info;
        iconColor = disabledBoldColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                    children: [
                      TextSpan(
                        text: "${activity["user"]} ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: "${activity["action"]} ",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: "${activity["target"]}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "in ${activity["space"]} • ${activity["timestamp"]}",
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
    );
  }

  List<Map<String, dynamic>> _getFilteredTeamMembers() {
    return teamMembers.where((member) {
      final matchesSearch = searchQuery.isEmpty ||
          member["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          member["role"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          member["department"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      final matchesStatus = selectedTeam == "all" ||
          member["status"] == selectedTeam;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  void _inviteTeamMember() {
    // navigateTo('InviteTeamMemberView')
  }

  void _showTeamFilters() {
    // Show team filters dialog
  }

  void _messageTeamMember(Map<String, dynamic> member) {
    ss("Starting chat with ${member["name"]}...");
  }

  void _showMemberOptions(Map<String, dynamic> member) {
    // navigateTo('TeamMemberDetailsView')
  }

  void _createWorkspace() {
    // navigateTo('CreateWorkspaceView')
  }

  void _openWorkspace(Map<String, dynamic> space) {
    // navigateTo('WorkspaceView')
  }
}
