import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaNetworkingView extends StatefulWidget {
  const EmaNetworkingView({super.key});

  @override
  State<EmaNetworkingView> createState() => _EmaNetworkingViewState();
}

class _EmaNetworkingViewState extends State<EmaNetworkingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedIndustry = "";
  String selectedExperience = "";
  bool showOnlineOnly = false;
  bool showNearbyOnly = false;

  List<Map<String, dynamic>> networkingTabs = [
    {"label": "Discover", "icon": Icons.explore},
    {"label": "Messages", "icon": Icons.message},
    {"label": "Connections", "icon": Icons.people},
    {"label": "Requests", "icon": Icons.person_add}
  ];

  List<Map<String, dynamic>> industryFilters = [
    {"label": "All Industries", "value": ""},
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Consulting", "value": "consulting"}
  ];

  List<Map<String, dynamic>> experienceFilters = [
    {"label": "All Experience", "value": ""},
    {"label": "Entry Level", "value": "entry"},
    {"label": "Mid Level", "value": "mid"},
    {"label": "Senior Level", "value": "senior"},
    {"label": "Executive", "value": "executive"}
  ];

  List<Map<String, dynamic>> discoverPeople = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "title": "Product Manager",
      "company": "TechCorp Inc.",
      "industry": "Technology",
      "experience": "Senior Level",
      "location": "San Francisco, CA",
      "avatar": "https://picsum.photos/120/120?random=101",
      "isOnline": true,
      "distance": "0.5 miles",
      "mutualConnections": 12,
      "commonInterests": ["Product Strategy", "UX Design", "Data Analytics"],
      "about": "Passionate product manager with 8+ years of experience building user-centric solutions."
    },
    {
      "id": 2,
      "name": "Michael Chen",
      "title": "Senior Developer",
      "company": "Innovation Labs",
      "industry": "Technology",
      "experience": "Senior Level",
      "location": "Seattle, WA",
      "avatar": "https://picsum.photos/120/120?random=102",
      "isOnline": false,
      "distance": "2.1 miles",
      "mutualConnections": 8,
      "commonInterests": ["React", "Node.js", "Machine Learning"],
      "about": "Full-stack developer specializing in scalable web applications and AI integration."
    },
    {
      "id": 3,
      "name": "Emily Rodriguez",
      "title": "Marketing Director",
      "company": "BrandForward",
      "industry": "Marketing",
      "experience": "Senior Level",
      "location": "Austin, TX",
      "avatar": "https://picsum.photos/120/120?random=103",
      "isOnline": true,
      "distance": "1.3 miles",
      "mutualConnections": 15,
      "commonInterests": ["Digital Marketing", "Brand Strategy", "Content Creation"],
      "about": "Creative marketing leader with expertise in digital campaigns and brand development."
    },
    {
      "id": 4,
      "name": "David Park",
      "title": "Healthcare Consultant",
      "company": "MedConsult Pro",
      "industry": "Healthcare",
      "experience": "Mid Level",
      "location": "Boston, MA",
      "avatar": "https://picsum.photos/120/120?random=104",
      "isOnline": false,
      "distance": "3.7 miles",
      "mutualConnections": 6,
      "commonInterests": ["Healthcare Tech", "Patient Care", "Process Improvement"],
      "about": "Healthcare consultant focused on improving patient outcomes through technology."
    }
  ];

  List<Map<String, dynamic>> connections = [
    {
      "id": 1,
      "name": "Alex Thompson",
      "title": "UX Designer",
      "company": "DesignStudio",
      "avatar": "https://picsum.photos/100/100?random=201",
      "lastMessage": "Thanks for the design feedback!",
      "lastMessageTime": "2h ago",
      "isOnline": true,
      "connectionDate": "2024-01-15"
    },
    {
      "id": 2,
      "name": "Lisa Wang",
      "title": "Data Scientist",
      "company": "Analytics Co.",
      "avatar": "https://picsum.photos/100/100?random=202",
      "lastMessage": "Would love to collaborate on that project",
      "lastMessageTime": "1d ago",
      "isOnline": false,
      "connectionDate": "2024-01-10"
    },
    {
      "id": 3,
      "name": "Robert Martinez",
      "title": "Business Analyst",
      "company": "ConsultPro",
      "avatar": "https://picsum.photos/100/100?random=203",
      "lastMessage": "Great meeting you at the conference!",
      "lastMessageTime": "3d ago",
      "isOnline": true,
      "connectionDate": "2024-01-08"
    }
  ];

  List<Map<String, dynamic>> connectionRequests = [
    {
      "id": 1,
      "name": "Jennifer Kim",
      "title": "Software Engineer",
      "company": "CodeWorks",
      "avatar": "https://picsum.photos/100/100?random=301",
      "mutualConnections": 5,
      "message": "Hi! I saw your presentation on AI and would love to connect.",
      "requestDate": "2024-01-20"
    },
    {
      "id": 2,
      "name": "Carlos Rodriguez",
      "title": "Project Manager",
      "company": "BuildTech",
      "avatar": "https://picsum.photos/100/100?random=302",
      "mutualConnections": 3,
      "message": "Interested in discussing project management best practices.",
      "requestDate": "2024-01-19"
    }
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=401",
      "lastMessage": "Looking forward to our coffee meeting tomorrow!",
      "lastMessageTime": "10m ago",
      "unreadCount": 2,
      "isOnline": true
    },
    {
      "id": 2,
      "name": "Michael Chen",
      "avatar": "https://picsum.photos/100/100?random=402",
      "lastMessage": "The code review looks good, thanks!",
      "lastMessageTime": "1h ago",
      "unreadCount": 0,
      "isOnline": false
    },
    {
      "id": 3,
      "name": "Emily Rodriguez",
      "avatar": "https://picsum.photos/100/100?random=403",
      "lastMessage": "Can you share the marketing deck?",
      "lastMessageTime": "3h ago",
      "unreadCount": 1,
      "isOnline": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Networking"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Navigate to QR scanner
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: List.generate(networkingTabs.length, (index) {
                final tab = networkingTabs[index];
                final isSelected = currentTab == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentTab = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            tab["icon"],
                            color: isSelected ? primaryColor : disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${tab["label"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildDiscoverTab();
      case 1:
        return _buildMessagesTab();
      case 2:
        return _buildConnectionsTab();
      case 3:
        return _buildRequestsTab();
      default:
        return Container();
    }
  }

  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search professionals...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.tune,
                size: bs.sm,
                onPressed: _showFilterDialog,
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Filter chips
          if (selectedIndustry.isNotEmpty || selectedExperience.isNotEmpty || showOnlineOnly || showNearbyOnly)
            Container(
              height: 40,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (selectedIndustry.isNotEmpty)
                      _buildFilterChip(
                        industryFilters.firstWhere((e) => e["value"] == selectedIndustry)["label"],
                        () {
                          selectedIndustry = "";
                          setState(() {});
                        },
                      ),
                    if (selectedExperience.isNotEmpty)
                      _buildFilterChip(
                        experienceFilters.firstWhere((e) => e["value"] == selectedExperience)["label"],
                        () {
                          selectedExperience = "";
                          setState(() {});
                        },
                      ),
                    if (showOnlineOnly)
                      _buildFilterChip(
                        "Online Only",
                        () {
                          showOnlineOnly = false;
                          setState(() {});
                        },
                      ),
                    if (showNearbyOnly)
                      _buildFilterChip(
                        "Nearby",
                        () {
                          showNearbyOnly = false;
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),
            ),

          if (selectedIndustry.isNotEmpty || selectedExperience.isNotEmpty || showOnlineOnly || showNearbyOnly)
            SizedBox(height: spMd),

          // People List
          ...discoverPeople.map((person) => _buildPersonCard(person)).toList(),
        ],
      ),
    );
  }

  Widget _buildMessagesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Search Bar
          QTextField(
            label: "Search messages...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          SizedBox(height: spMd),

          // Messages List
          ...messages.map((message) => _buildMessageCard(message)).toList(),
        ],
      ),
    );
  }

  Widget _buildConnectionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Connections",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${connections.length} connections",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Search Bar
          QTextField(
            label: "Search connections...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          SizedBox(height: spMd),

          // Connections List
          ...connections.map((connection) => _buildConnectionCard(connection)).toList(),
        ],
      ),
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Connection Requests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (connectionRequests.isNotEmpty)
                Text(
                  "${connectionRequests.length} pending",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),

          SizedBox(height: spMd),

          // Connection Requests
          if (connectionRequests.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No pending requests",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "When someone sends you a connection request, it will appear here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          else
            ...connectionRequests.map((request) => _buildRequestCard(request)).toList(),
        ],
      ),
    );
  }

  Widget _buildPersonCard(Map<String, dynamic> person) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
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
              Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${person["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (person["isOnline"] as bool)
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${person["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${person["title"]} at ${person["company"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${person["distance"]} • ${person["mutualConnections"]} mutual",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: () {
                  _sendConnectionRequest(person);
                },
              ),
            ],
          ),

          SizedBox(height: spMd),

          Text(
            "${person["about"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          SizedBox(height: spMd),

          // Common interests
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (person["commonInterests"] as List).map((interest) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$interest",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageCard(Map<String, dynamic> message) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${message["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (message["isOnline"] as bool)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: successColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${message["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${message["lastMessageTime"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${message["lastMessage"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if ((message["unreadCount"] as int) > 0)
            Container(
              margin: EdgeInsets.only(left: spSm),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                "${message["unreadCount"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildConnectionCard(Map<String, dynamic> connection) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${connection["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (connection["isOnline"] as bool)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: successColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${connection["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${connection["title"]} at ${connection["company"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.message,
            size: bs.sm,
            onPressed: () {
              // Navigate to chat
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${request["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${request["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${request["title"]} at ${request["company"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${request["mutualConnections"]} mutual connections",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (request["message"] != null && (request["message"] as String).isNotEmpty)
            Column(
              children: [
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${request["message"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),

          SizedBox(height: spMd),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Accept",
                  size: bs.sm,
                  onPressed: () {
                    _acceptConnectionRequest(request);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  height: 36,
                  child: OutlinedButton(
                    onPressed: () {
                      _declineConnectionRequest(request);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: disabledBoldColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                    child: Text(
                      "Decline",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 14,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Filter Options"),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Industry Filter
                Text(
                  "Industry",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Select Industry",
                  items: industryFilters,
                  value: selectedIndustry,
                  onChanged: (value, label) {
                    selectedIndustry = value;
                    setDialogState(() {});
                  },
                ),

                SizedBox(height: spMd),

                // Experience Filter
                Text(
                  "Experience Level",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Select Experience",
                  items: experienceFilters,
                  value: selectedExperience,
                  onChanged: (value, label) {
                    selectedExperience = value;
                    setDialogState(() {});
                  },
                ),

                SizedBox(height: spMd),

                // Other Filters
                Text(
                  "Other Filters",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spSm),
                
                CheckboxListTile(
                  title: Text("Show online users only"),
                  value: showOnlineOnly,
                  onChanged: (value) {
                    showOnlineOnly = value ?? false;
                    setDialogState(() {});
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                
                CheckboxListTile(
                  title: Text("Show nearby users only"),
                  value: showNearbyOnly,
                  onChanged: (value) {
                    showNearbyOnly = value ?? false;
                    setDialogState(() {});
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedIndustry = "";
                selectedExperience = "";
                showOnlineOnly = false;
                showNearbyOnly = false;
                setDialogState(() {});
              },
              child: Text("Clear All"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Apply"),
            ),
          ],
        ),
      ),
    );
  }

  void _sendConnectionRequest(Map<String, dynamic> person) {
    ss("Connection request sent to ${person["name"]}");
  }

  void _acceptConnectionRequest(Map<String, dynamic> request) {
    connectionRequests.removeWhere((r) => r["id"] == request["id"]);
    connections.add({
      "id": request["id"],
      "name": request["name"],
      "title": request["title"],
      "company": request["company"],
      "avatar": request["avatar"],
      "lastMessage": "Connected!",
      "lastMessageTime": "now",
      "isOnline": false,
      "connectionDate": DateTime.now().toString().substring(0, 10)
    });
    setState(() {});
    ss("Connection request accepted");
  }

  void _declineConnectionRequest(Map<String, dynamic> request) {
    connectionRequests.removeWhere((r) => r["id"] == request["id"]);
    setState(() {});
    si("Connection request declined");
  }
}
