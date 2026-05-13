import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProjectListView extends StatefulWidget {
  const ComaProjectListView({Key? key}) : super(key: key);

  @override
  State<ComaProjectListView> createState() => _ComaProjectListViewState();
}

class _ComaProjectListViewState extends State<ComaProjectListView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  int currentView = 0;

  List<Map<String, dynamic>> projects = [
    {
      "id": 1,
      "name": "Riverside Commercial Complex",
      "client": "Riverside Development Corp",
      "status": "in_progress",
      "type": "commercial",
      "progress": 65.0,
      "startDate": "2024-01-15",
      "endDate": "2024-12-30",
      "budget": 2500000.0,
      "spent": 1625000.0,
      "location": "Downtown District",
      "manager": "Sarah Wilson",
      "team": 8,
      "image": "https://picsum.photos/300/200?random=1&keyword=construction"
    },
    {
      "id": 2,
      "name": "Green Valley Housing Project",
      "client": "Valley Homes LLC",
      "status": "planning",
      "type": "residential",
      "progress": 15.0,
      "startDate": "2024-03-01",
      "endDate": "2025-06-15",
      "budget": 1800000.0,
      "spent": 270000.0,
      "location": "Green Valley Suburbs",
      "manager": "Mike Chen",
      "team": 12,
      "image": "https://picsum.photos/300/200?random=2&keyword=housing"
    },
    {
      "id": 3,
      "name": "Highway Bridge Renovation",
      "client": "State Transportation Dept",
      "status": "completed",
      "type": "infrastructure",
      "progress": 100.0,
      "startDate": "2023-08-01",
      "endDate": "2024-02-28",
      "budget": 3200000.0,
      "spent": 3150000.0,
      "location": "Highway 101",
      "manager": "David Brown",
      "team": 15,
      "image": "https://picsum.photos/300/200?random=3&keyword=bridge"
    },
    {
      "id": 4,
      "name": "Medical Center Expansion",
      "client": "Central Medical Group",
      "status": "delayed",
      "type": "healthcare",
      "progress": 45.0,
      "startDate": "2023-11-01",
      "endDate": "2024-08-30",
      "budget": 4500000.0,
      "spent": 2025000.0,
      "location": "Medical District",
      "manager": "Lisa Garcia",
      "team": 18,
      "image": "https://picsum.photos/300/200?random=4&keyword=hospital"
    },
    {
      "id": 5,
      "name": "Smart Office Tower",
      "client": "TechPark Solutions",
      "status": "in_progress",
      "type": "commercial",
      "progress": 78.0,
      "startDate": "2023-09-15",
      "endDate": "2024-07-20",
      "budget": 6800000.0,
      "spent": 5304000.0,
      "location": "Tech District",
      "manager": "Robert Kim",
      "team": 22,
      "image": "https://picsum.photos/300/200?random=5&keyword=office"
    },
    {
      "id": 6,
      "name": "Elementary School Rebuild",
      "client": "City Education Board",
      "status": "planning",
      "type": "education",
      "progress": 8.0,
      "startDate": "2024-06-01",
      "endDate": "2025-08-15",
      "budget": 2100000.0,
      "spent": 168000.0,
      "location": "Oakwood District",
      "manager": "Emma Davis",
      "team": 10,
      "image": "https://picsum.photos/300/200?random=6&keyword=school"
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Projects", "value": "all"},
    {"label": "Planning", "value": "planning"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Delayed", "value": "delayed"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Commercial", "value": "commercial"},
    {"label": "Residential", "value": "residential"},
    {"label": "Infrastructure", "value": "infrastructure"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Education", "value": "education"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return primaryColor;
      case 'planning':
        return infoColor;
      case 'delayed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'in_progress':
        return 'In Progress';
      case 'planning':
        return 'Planning';
      case 'delayed':
        return 'Delayed';
      default:
        return 'Unknown';
    }
  }

  List<Map<String, dynamic>> get filteredProjects {
    return projects.where((project) {
      bool matchesSearch = project["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          project["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          project["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || project["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || project["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Construction Projects"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('ComaCreateProjectView')
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search projects...",
                        value: searchQuery,
                        hint: "Search by name, client, or location",
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
                if (selectedStatus != "all" || selectedType != "all") ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Active Filters:",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      if (selectedStatus != "all")
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _getStatusLabel(selectedStatus),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              GestureDetector(
                                onTap: () {
                                  selectedStatus = "all";
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (selectedType != "all") ...[
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                selectedType.toString().toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              GestureDetector(
                                onTap: () {
                                  selectedType = "all";
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentView = 0;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: currentView == 0 ? primaryColor : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: currentView == 0 ? primaryColor : disabledOutlineBorderColor,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.grid_view,
                              color: currentView == 0 ? Colors.white : disabledBoldColor,
                              size: 18,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Grid View",
                              style: TextStyle(
                                color: currentView == 0 ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentView = 1;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: currentView == 1 ? primaryColor : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: currentView == 1 ? primaryColor : disabledOutlineBorderColor,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.list,
                              color: currentView == 1 ? Colors.white : disabledBoldColor,
                              size: 18,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "List View",
                              style: TextStyle(
                                color: currentView == 1 ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: currentView == 0 ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('ComaCreateProjectView')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: filteredProjects.map((project) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${project["image"]}",
                  height: 140,
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
                            "${project["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(project["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusLabel(project["status"]),
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor(project["status"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${project["client"]}",
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
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${project["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(project["progress"] as num).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (project["progress"] as num) / 100,
                          backgroundColor: disabledOutlineBorderColor,
                          valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(project["status"])),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${project["team"]} team members",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${((project["budget"] as num) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('ComaProjectDetailView')
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) {
        final project = filteredProjects[index];
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusMd)),
                child: Image.network(
                  "${project["image"]}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${project["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(project["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getStatusLabel(project["status"]),
                              style: TextStyle(
                                fontSize: 10,
                                color: _getStatusColor(project["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${project["client"]}",
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
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${project["location"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${(project["progress"] as num).toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: (project["progress"] as num) / 100,
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(project["status"])),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(spSm),
                child: QButton(
                  icon: Icons.arrow_forward,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('ComaProjectDetailView')
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledOutlineBorderColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Filter Projects",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Project Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Project Type",
              items: typeOptions,
              value: selectedType,
              onChanged: (value, label) {
                selectedType = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear All",
                    size: bs.sm,
                    color: disabledBoldColor,
                    onPressed: () {
                      selectedStatus = "all";
                      selectedType = "all";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Filters",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
