import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobBoardsView extends StatefulWidget {
  const RhaJobBoardsView({super.key});

  @override
  State<RhaJobBoardsView> createState() => _RhaJobBoardsViewState();
}

class _RhaJobBoardsViewState extends State<RhaJobBoardsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Professional", "value": "Professional"},
    {"label": "General", "value": "General"},
    {"label": "Tech-focused", "value": "Tech-focused"},
    {"label": "Industry-specific", "value": "Industry-specific"},
    {"label": "Freelance", "value": "Freelance"},
  ];
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Trial", "value": "Trial"},
    {"label": "Suspended", "value": "Suspended"},
  ];

  List<Map<String, dynamic>> jobBoards = [
    {
      "id": "1",
      "name": "LinkedIn Jobs",
      "category": "Professional",
      "status": "Active",
      "description": "Professional networking platform with targeted job posting capabilities",
      "audience": "Professionals and executives",
      "monthlyReach": 150000,
      "avgApplications": 45,
      "costPerPost": 299,
      "features": ["Professional targeting", "Company page integration", "InMail credits"],
      "integrationStatus": "Connected",
      "apiKey": "lnk_live_xxxx",
      "lastSync": "2024-06-18 10:30",
      "activeJobs": 8,
      "totalApplications": 234,
      "logo": "https://picsum.photos/50/50?random=1&keyword=linkedin",
      "rating": 4.8,
      "setupDifficulty": "Easy",
    },
    {
      "id": "2",
      "name": "Indeed",
      "category": "General",
      "status": "Active",
      "description": "World's largest job site with massive reach across all industries",
      "audience": "General job seekers",
      "monthlyReach": 300000,
      "avgApplications": 78,
      "costPerPost": 150,
      "features": ["Wide reach", "Easy application", "Resume database access"],
      "integrationStatus": "Connected",
      "apiKey": "ind_live_xxxx",
      "lastSync": "2024-06-18 09:15",
      "activeJobs": 12,
      "totalApplications": 456,
      "logo": "https://picsum.photos/50/50?random=2&keyword=indeed",
      "rating": 4.6,
      "setupDifficulty": "Easy",
    },
    {
      "id": "3",
      "name": "Stack Overflow Jobs",
      "category": "Tech-focused",
      "status": "Active",
      "description": "Premier destination for developer and tech talent recruitment",
      "audience": "Developers and tech professionals",
      "monthlyReach": 85000,
      "avgApplications": 32,
      "costPerPost": 350,
      "features": ["Developer community", "Tech stack filtering", "Remote job focus"],
      "integrationStatus": "Connected",
      "apiKey": "so_live_xxxx",
      "lastSync": "2024-06-18 08:45",
      "activeJobs": 5,
      "totalApplications": 89,
      "logo": "https://picsum.photos/50/50?random=3&keyword=stackoverflow",
      "rating": 4.9,
      "setupDifficulty": "Medium",
    },
    {
      "id": "4",
      "name": "Glassdoor",
      "category": "Professional",
      "status": "Inactive",
      "description": "Company review and salary transparency platform for job postings",
      "audience": "Company-conscious job seekers",
      "monthlyReach": 120000,
      "avgApplications": 38,
      "costPerPost": 200,
      "features": ["Company reviews", "Salary insights", "Interview insights"],
      "integrationStatus": "Not Connected",
      "apiKey": "",
      "lastSync": "Never",
      "activeJobs": 0,
      "totalApplications": 0,
      "logo": "https://picsum.photos/50/50?random=4&keyword=glassdoor",
      "rating": 4.3,
      "setupDifficulty": "Hard",
    },
    {
      "id": "5",
      "name": "AngelList",
      "category": "Tech-focused",
      "status": "Trial",
      "description": "Startup-focused platform connecting talent with growing companies",
      "audience": "Startup enthusiasts and tech talent",
      "monthlyReach": 45000,
      "avgApplications": 28,
      "costPerPost": 250,
      "features": ["Startup focus", "Equity compensation", "Remote-first"],
      "integrationStatus": "Trial",
      "apiKey": "al_trial_xxxx",
      "lastSync": "2024-06-17 16:20",
      "activeJobs": 3,
      "totalApplications": 67,
      "logo": "https://picsum.photos/50/50?random=5&keyword=angellist",
      "rating": 4.5,
      "setupDifficulty": "Medium",
    },
    {
      "id": "6",
      "name": "ZipRecruiter",
      "category": "General",
      "status": "Suspended",
      "description": "AI-powered job matching platform with smart distribution",
      "audience": "General workforce",
      "monthlyReach": 180000,
      "avgApplications": 52,
      "costPerPost": 180,
      "features": ["AI matching", "One-click apply", "Mobile-first"],
      "integrationStatus": "Suspended",
      "apiKey": "",
      "lastSync": "2024-06-10 14:30",
      "activeJobs": 0,
      "totalApplications": 156,
      "logo": "https://picsum.photos/50/50?random=6&keyword=ziprecruiter",
      "rating": 4.2,
      "setupDifficulty": "Easy",
    },
  ];

  List<Map<String, dynamic>> get filteredJobBoards {
    return jobBoards.where((board) {
      bool matchesSearch = searchQuery.isEmpty ||
          (board["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (board["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" ||
          board["category"] == selectedCategory;
      
      bool matchesStatus = selectedStatus == "All" ||
          board["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return disabledBoldColor;
      case "Trial":
        return warningColor;
      case "Suspended":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getIntegrationColor(String integration) {
    switch (integration) {
      case "Connected":
        return successColor;
      case "Not Connected":
        return dangerColor;
      case "Trial":
        return warningColor;
      case "Suspended":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Boards Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              _showAddJobBoardDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              _syncAllJobBoards();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search job boards...",
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
                      onPressed: () {
                        // Perform search
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryItems,
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
                        label: "Status",
                        items: statusItems,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Summary Section
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${jobBoards.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Boards",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${jobBoards.where((b) => b["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${jobBoards.fold(0, (sum, b) => sum + (b["activeJobs"] as int))}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Active Jobs",
                          style: TextStyle(
                            color: warningColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Job Boards List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredJobBoards.length,
              itemBuilder: (context, index) {
                final board = filteredJobBoards[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: board["status"] == "Active"
                        ? Border.all(color: successColor.withAlpha(50))
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${board["logo"]}"),
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
                                    Expanded(
                                      child: Text(
                                        "${board["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor("${board["status"]}")
                                            .withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${board["status"]}",
                                        style: TextStyle(
                                          color: _getStatusColor("${board["status"]}"),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${board["category"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${board["rating"]}",
                                      style: TextStyle(
                                        color: warningColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Description
                      Text(
                        "${board["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),

                      // Statistics Row
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${((board["monthlyReach"] as int) / 1000).toInt()}K",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "Monthly Reach",
                                    style: TextStyle(
                                      color: infoColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${board["avgApplications"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Avg Applications",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${board["costPerPost"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  Text(
                                    "Cost per Post",
                                    style: TextStyle(
                                      color: warningColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Integration Status
                      Row(
                        children: [
                          Icon(
                            board["integrationStatus"] == "Connected"
                                ? Icons.check_circle
                                : board["integrationStatus"] == "Trial"
                                    ? Icons.access_time
                                    : Icons.error,
                            size: 16,
                            color: _getIntegrationColor("${board["integrationStatus"]}"),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${board["integrationStatus"]}",
                            style: TextStyle(
                              color: _getIntegrationColor("${board["integrationStatus"]}"),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (board["lastSync"] != "Never") ...[
                            SizedBox(width: spSm),
                            Text(
                              "Last sync: ${board["lastSync"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),

                      // Features
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (board["features"] as List).map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "${board["activeJobs"]} active jobs",
                                  style: TextStyle(
                                    color: board["activeJobs"] > 0
                                        ? successColor
                                        : disabledBoldColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${board["totalApplications"]} total applications",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            spacing: spXs,
                            children: [
                              if (board["status"] == "Inactive" ||
                                  board["integrationStatus"] == "Not Connected")
                                QButton(
                                  label: "Connect",
                                  size: bs.sm,
                                  onPressed: () {
                                    _connectJobBoard(board);
                                  },
                                ),
                              if (board["status"] == "Active")
                                QButton(
                                  label: "View Jobs",
                                  size: bs.sm,
                                  onPressed: () {
                                    // View jobs on this board
                                  },
                                ),
                              QButton(
                                icon: Icons.settings,
                                size: bs.sm,
                                onPressed: () {
                                  _showJobBoardSettings(board);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddJobBoardDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _connectJobBoard(Map<String, dynamic> board) {
    String apiKey = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Connect ${board["name"]}"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text("Enter your API credentials to connect to ${board["name"]}"),
              QTextField(
                label: "API Key",
                value: apiKey,
                onChanged: (value) => apiKey = value,
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "You can find your API key in your ${board["name"]} account settings.",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                  ),
                ),
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
              if (apiKey.isNotEmpty) {
                Navigator.pop(context);
                ss("${board["name"]} connected successfully");
              }
            },
            child: Text("Connect"),
          ),
        ],
      ),
    );
  }

  void _showJobBoardSettings(Map<String, dynamic> board) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "${board["name"]} Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Configuration"),
              onTap: () {
                Navigator.pop(context);
                _editJobBoardConfig(board);
              },
            ),
            ListTile(
              leading: Icon(Icons.sync),
              title: Text("Sync Now"),
              onTap: () {
                Navigator.pop(context);
                ss("Syncing ${board["name"]}...");
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("View Analytics"),
              onTap: () {
                Navigator.pop(context);
                // View board analytics
              },
            ),
            if (board["status"] == "Active")
              ListTile(
                leading: Icon(Icons.pause, color: warningColor),
                title: Text("Pause Integration", style: TextStyle(color: warningColor)),
                onTap: () {
                  Navigator.pop(context);
                  ss("${board["name"]} integration paused");
                },
              ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Remove Integration", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Remove ${board["name"]} integration?");
                if (isConfirmed) {
                  ss("${board["name"]} integration removed");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editJobBoardConfig(Map<String, dynamic> board) {
    String apiKey = board["apiKey"];
    bool autoSync = true;
    bool featuredJobs = false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit ${board["name"]} Configuration"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "API Key",
                value: apiKey,
                onChanged: (value) => apiKey = value,
              ),
              QSwitch(
                items: [
                  {
                    "label": "Auto-sync jobs",
                    "value": true,
                    "checked": autoSync,
                  }
                ],
                value: [
                  if (autoSync)
                    {
                      "label": "Auto-sync jobs",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) => autoSync = values.isNotEmpty,
              ),
              QSwitch(
                items: [
                  {
                    "label": "Enable featured job postings",
                    "value": true,
                    "checked": featuredJobs,
                  }
                ],
                value: [
                  if (featuredJobs)
                    {
                      "label": "Enable featured job postings",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) => featuredJobs = values.isNotEmpty,
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
              Navigator.pop(context);
              ss("${board["name"]} configuration updated");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showAddJobBoardDialog() {
    String boardName = "";
    String category = "General";
    String apiEndpoint = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Custom Job Board"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Job Board Name",
                value: boardName,
                onChanged: (value) => boardName = value,
              ),
              QDropdownField(
                label: "Category",
                items: categoryItems.where((item) => item["value"] != "All").toList(),
                value: category,
                onChanged: (value, label) => category = value,
              ),
              QTextField(
                label: "API Endpoint URL",
                value: apiEndpoint,
                onChanged: (value) => apiEndpoint = value,
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
              if (boardName.isNotEmpty && apiEndpoint.isNotEmpty) {
                Navigator.pop(context);
                ss("Custom job board added successfully");
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void _syncAllJobBoards() async {
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    ss("All job boards synced successfully");
  }
}
