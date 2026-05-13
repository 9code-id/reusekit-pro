import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmThirdPartyAppsView extends StatefulWidget {
  const TpmThirdPartyAppsView({super.key});

  @override
  State<TpmThirdPartyAppsView> createState() => _TpmThirdPartyAppsViewState();
}

class _TpmThirdPartyAppsViewState extends State<TpmThirdPartyAppsView> {
  List<Map<String, dynamic>> connectedApps = [
    {
      "id": 1,
      "name": "Google Calendar",
      "description": "Sync tasks and deadlines with your calendar",
      "icon": Icons.calendar_today,
      "isConnected": true,
      "permissions": ["Read calendar", "Create events", "Update events"],
      "lastSync": "2024-06-19 10:30:00",
      "color": Colors.blue
    },
    {
      "id": 2,
      "name": "Slack",
      "description": "Get project notifications in your workspace",
      "icon": Icons.chat,
      "isConnected": true,
      "permissions": ["Send messages", "Read channels", "Access user info"],
      "lastSync": "2024-06-19 09:15:00",
      "color": Colors.purple
    },
    {
      "id": 3,
      "name": "GitHub",
      "description": "Track code commits and repository activities",
      "icon": Icons.code,
      "isConnected": false,
      "permissions": ["Read repositories", "Access commit history", "Manage webhooks"],
      "lastSync": null,
      "color": Colors.grey
    },
    {
      "id": 4,
      "name": "Jira",
      "description": "Import issues and track development progress",
      "icon": Icons.bug_report,
      "isConnected": true,
      "permissions": ["Read issues", "Update status", "Create comments"],
      "lastSync": "2024-06-19 08:45:00",
      "color": Colors.orange
    },
    {
      "id": 5,
      "name": "Trello",
      "description": "Sync boards and cards with project tasks",
      "icon": Icons.dashboard,
      "isConnected": false,
      "permissions": ["Read boards", "Create cards", "Update lists"],
      "lastSync": null,
      "color": Colors.green
    },
    {
      "id": 6,
      "name": "Microsoft Teams",
      "description": "Share updates and collaborate with team",
      "icon": Icons.groups,
      "isConnected": true,
      "permissions": ["Send messages", "Read channels", "Schedule meetings"],
      "lastSync": "2024-06-19 07:20:00",
      "color": Colors.indigo
    }
  ];

  List<Map<String, dynamic>> availableApps = [
    {
      "id": 7,
      "name": "Notion",
      "description": "Sync project documentation and notes",
      "icon": Icons.note,
      "category": "Documentation",
      "color": Colors.black
    },
    {
      "id": 8,
      "name": "Asana",
      "description": "Import tasks and project timelines",
      "icon": Icons.task_alt,
      "category": "Project Management",
      "color": Colors.pink
    },
    {
      "id": 9,
      "name": "Zapier",
      "description": "Automate workflows between apps",
      "icon": Icons.sync,
      "category": "Automation",
      "color": Colors.amber
    },
    {
      "id": 10,
      "name": "Dropbox",
      "description": "Access and share project files",
      "icon": Icons.cloud_upload,
      "category": "File Storage",
      "color": Colors.blue
    }
  ];

  int selectedTab = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third-Party Apps"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshConnections,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTab,
              tabs: [
                Tab(text: "Connected", icon: Icon(Icons.link)),
                Tab(text: "Available", icon: Icon(Icons.store)),
              ],
              tabChildren: [
                _buildConnectedAppsTab(),
                _buildAvailableAppsTab(),
              ],
            ),
    );
  }

  Widget _buildConnectedAppsTab() {
    List<Map<String, dynamic>> connected = connectedApps.where((app) => app["isConnected"] == true).toList();
    
    if (connected.isEmpty) {
      return _buildEmptyState(
        icon: Icons.link_off,
        title: "No Connected Apps",
        subtitle: "Connect third-party apps to enhance your project management experience",
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Connected Applications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${connected.length} apps connected",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ...connected.map((app) => _buildConnectedAppCard(app)).toList(),
        ],
      ),
    );
  }

  Widget _buildAvailableAppsTab() {
    if (availableApps.isEmpty) {
      return _buildEmptyState(
        icon: Icons.store,
        title: "No Available Apps",
        subtitle: "Check back later for new integrations",
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Integrations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Expand your workflow with these apps",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ...availableApps.map((app) => _buildAvailableAppCard(app)).toList(),
        ],
      ),
    );
  }

  Widget _buildConnectedAppCard(Map<String, dynamic> app) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (app["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  app["icon"] as IconData,
                  color: app["color"] as Color,
                  size: 24,
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
                            "${app["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Connected",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXxs),
                    Text(
                      "${app["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    if (app["lastSync"] != null) ...[
                      SizedBox(height: spXs),
                      Text(
                        "Last sync: ${DateTime.parse(app["lastSync"]).dMMMy}",
                        style: TextStyle(
                          color: disabledColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Configure",
                  size: bs.sm,
                  onPressed: () => _configureApp(app),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Disconnect",
                  size: bs.sm,
                  color: dangerColor,
                  onPressed: () => _disconnectApp(app),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableAppCard(Map<String, dynamic> app) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (app["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  app["icon"] as IconData,
                  color: app["color"] as Color,
                  size: 24,
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
                            "${app["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${app["category"]}",
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXxs),
                    Text(
                      "${app["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Connect",
              size: bs.sm,
              onPressed: () => _connectApp(app),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshConnections() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});
    
    ss("Connections refreshed successfully");
  }

  void _configureApp(Map<String, dynamic> app) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Text(
              "Configure ${app["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Permissions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...(app["permissions"] as List).map((permission) => 
                    Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 16),
                          SizedBox(width: spXs),
                          Text("$permission"),
                        ],
                      ),
                    ),
                  ).toList(),
                ],
              ),
            ),
            QButton(
              label: "Save Configuration",
              size: bs.md,
              onPressed: () {
                back();
                ss("Configuration saved successfully");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _disconnectApp(Map<String, dynamic> app) async {
    bool isConfirmed = await confirm("Are you sure you want to disconnect ${app["name"]}?");
    if (isConfirmed) {
      int index = connectedApps.indexWhere((item) => item["id"] == app["id"]);
      if (index != -1) {
        connectedApps[index]["isConnected"] = false;
        setState(() {});
        ss("${app["name"]} disconnected successfully");
      }
    }
  }

  void _connectApp(Map<String, dynamic> app) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    Map<String, dynamic> newConnectedApp = {
      ...app,
      "isConnected": true,
      "permissions": ["Basic access", "Read data", "Send notifications"],
      "lastSync": DateTime.now().toString(),
    };

    connectedApps.add(newConnectedApp);
    availableApps.removeWhere((item) => item["id"] == app["id"]);

    loading = false;
    setState(() {});
    
    ss("${app["name"]} connected successfully");
  }
}
