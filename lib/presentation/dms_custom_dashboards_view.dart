import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsCustomDashboardsView extends StatefulWidget {
  const DmsCustomDashboardsView({super.key});

  @override
  State<DmsCustomDashboardsView> createState() => _DmsCustomDashboardsViewState();
}

class _DmsCustomDashboardsViewState extends State<DmsCustomDashboardsView> {
  bool loading = false;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLayout = "Grid";
  
  List<String> categories = ["All", "Analytics", "Sales", "Marketing", "Operations", "Finance"];
  List<String> layouts = ["Grid", "List"];
  
  List<Map<String, dynamic>> dashboards = [
    {
      "id": 1,
      "name": "Sales Performance Dashboard",
      "category": "Sales",
      "widgets": 6,
      "created": "2024-01-15",
      "lastModified": "2024-01-20",
      "isActive": true,
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=dashboard",
      "description": "Track sales metrics and performance indicators"
    },
    {
      "id": 2,
      "name": "Marketing Analytics",
      "category": "Marketing", 
      "widgets": 8,
      "created": "2024-01-10",
      "lastModified": "2024-01-18",
      "isActive": true,
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=analytics",
      "description": "Monitor marketing campaigns and ROI"
    },
    {
      "id": 3,
      "name": "Financial Overview",
      "category": "Finance",
      "widgets": 5,
      "created": "2024-01-08",
      "lastModified": "2024-01-16",
      "isActive": false,
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=finance",
      "description": "Financial metrics and budget tracking"
    },
    {
      "id": 4,
      "name": "Operations Dashboard",
      "category": "Operations",
      "widgets": 7,
      "created": "2024-01-05",
      "lastModified": "2024-01-14",
      "isActive": true,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=operations",
      "description": "Operational efficiency and workflow monitoring"
    }
  ];
  
  List<Map<String, dynamic>> widgetLibrary = [
    {
      "id": 1,
      "name": "Revenue Chart",
      "type": "Chart",
      "icon": Icons.trending_up,
      "category": "Analytics",
      "description": "Display revenue trends over time"
    },
    {
      "id": 2,
      "name": "Sales Funnel",
      "type": "Funnel",
      "icon": Icons.filter_list,
      "category": "Sales",
      "description": "Visualize sales conversion stages"
    },
    {
      "id": 3,
      "name": "KPI Cards",
      "type": "Cards",
      "icon": Icons.dashboard,
      "category": "Analytics",
      "description": "Key performance indicator cards"
    },
    {
      "id": 4,
      "name": "Task Progress",
      "type": "Progress",
      "icon": Icons.assignment,
      "category": "Operations",
      "description": "Track task completion progress"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Dashboards"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateDashboardDialog();
            },
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: spLg),
                _buildFilters(),
                SizedBox(height: spLg),
                _buildDashboardList(),
                SizedBox(height: spLg),
                _buildWidgetLibrary(),
              ],
            ),
          ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard Management",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Create and customize your data visualization dashboards",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.dashboard_customize,
            size: 48,
            color: Colors.white.withAlpha(150),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: QTextField(
                label: "Search dashboards",
                value: searchQuery,
                hint: "Search by name or description",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
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
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Layout",
                items: layouts.map((layout) => {
                  "label": layout,
                  "value": layout,
                }).toList(),
                value: selectedLayout,
                onChanged: (value, label) {
                  selectedLayout = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              label: "Create Dashboard",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                _showCreateDashboardDialog();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDashboardList() {
    var filteredDashboards = dashboards.where((dashboard) {
      bool matchesSearch = dashboard["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          dashboard["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || dashboard["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "My Dashboards",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${filteredDashboards.length}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        selectedLayout == "Grid"
          ? ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredDashboards.map((dashboard) {
                return _buildDashboardCard(dashboard);
              }).toList(),
            )
          : Column(
              children: filteredDashboards.map((dashboard) {
                return _buildDashboardListItem(dashboard);
              }).toList(),
            ),
      ],
    );
  }

  Widget _buildDashboardCard(Map<String, dynamic> dashboard) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: dashboard["isActive"] ? primaryColor : disabledOutlineBorderColor,
          width: dashboard["isActive"] ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Image.network(
              "${dashboard["thumbnail"]}",
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${dashboard["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dashboard["isActive"] ? successColor : disabledColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${dashboard["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.widgets,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${dashboard["widgets"]} widgets",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${dashboard["category"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          _editDashboard(dashboard);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        _showDashboardActions(dashboard);
                      },
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

  Widget _buildDashboardListItem(Map<String, dynamic> dashboard) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: dashboard["isActive"] ? primaryColor : disabledOutlineBorderColor,
          width: dashboard["isActive"] ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${dashboard["thumbnail"]}",
              width: 80,
              height: 60,
              fit: BoxFit.cover,
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
                        "${dashboard["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dashboard["isActive"] ? successColor : disabledColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${dashboard["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${dashboard["widgets"]} widgets",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(color: disabledColor),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${dashboard["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                label: "Edit",
                size: bs.sm,
                onPressed: () {
                  _editDashboard(dashboard);
                },
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showDashboardActions(dashboard);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetLibrary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Widget Library",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: widgetLibrary.map((widget) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          widget["icon"],
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${widget["type"]}",
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
                  SizedBox(height: spSm),
                  Text(
                    "${widget["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Add Widget",
                      size: bs.sm,
                      onPressed: () {
                        _addWidgetToDashboard(widget);
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showCreateDashboardDialog() {
    String dashboardName = "";
    String selectedCat = "Analytics";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Dashboard"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Dashboard Name",
              value: dashboardName,
              onChanged: (value) {
                dashboardName = value;
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Category",
              items: categories.where((c) => c != "All").map((cat) => {
                "label": cat,
                "value": cat,
              }).toList(),
              value: selectedCat,
              onChanged: (value, label) {
                selectedCat = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: () {
              if (dashboardName.isNotEmpty) {
                _createDashboard(dashboardName, selectedCat);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _createDashboard(String name, String category) {
    Map<String, dynamic> newDashboard = {
      "id": dashboards.length + 1,
      "name": name,
      "category": category,
      "widgets": 0,
      "created": DateTime.now().toString().substring(0, 10),
      "lastModified": DateTime.now().toString().substring(0, 10),
      "isActive": true,
      "thumbnail": "https://picsum.photos/300/200?random=${dashboards.length + 5}&keyword=dashboard",
      "description": "New dashboard for $category analytics"
    };
    
    dashboards.insert(0, newDashboard);
    setState(() {});
    ss("Dashboard created successfully");
  }

  void _editDashboard(Map<String, dynamic> dashboard) {
    ss("Opening dashboard editor for ${dashboard["name"]}");
  }

  void _showDashboardActions(Map<String, dynamic> dashboard) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${dashboard["name"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _duplicateDashboard(dashboard);
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.copy),
                    SizedBox(width: spSm),
                    Text("Duplicate"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _shareDashboard(dashboard);
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: spSm),
                    Text("Share"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _exportDashboard(dashboard);
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: spSm),
                    Text("Export"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _deleteDashboard(dashboard);
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.delete, color: dangerColor),
                    SizedBox(width: spSm),
                    Text("Delete", style: TextStyle(color: dangerColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _duplicateDashboard(Map<String, dynamic> dashboard) {
    Map<String, dynamic> duplicate = Map.from(dashboard);
    duplicate["id"] = dashboards.length + 1;
    duplicate["name"] = "${dashboard["name"]} (Copy)";
    duplicate["created"] = DateTime.now().toString().substring(0, 10);
    duplicate["lastModified"] = DateTime.now().toString().substring(0, 10);
    
    dashboards.insert(0, duplicate);
    setState(() {});
    ss("Dashboard duplicated successfully");
  }

  void _shareDashboard(Map<String, dynamic> dashboard) {
    ss("Sharing dashboard: ${dashboard["name"]}");
  }

  void _exportDashboard(Map<String, dynamic> dashboard) {
    ss("Exporting dashboard: ${dashboard["name"]}");
  }

  void _deleteDashboard(Map<String, dynamic> dashboard) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this dashboard?");
    if (isConfirmed) {
      dashboards.removeWhere((d) => d["id"] == dashboard["id"]);
      setState(() {});
      ss("Dashboard deleted successfully");
    }
  }

  void _addWidgetToDashboard(Map<String, dynamic> widget) {
    ss("Widget ${widget["name"]} added to dashboard");
  }
}
