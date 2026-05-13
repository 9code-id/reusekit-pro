import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProjectDetailView extends StatefulWidget {
  const ComaProjectDetailView({Key? key}) : super(key: key);

  @override
  State<ComaProjectDetailView> createState() => _ComaProjectDetailViewState();
}

class _ComaProjectDetailViewState extends State<ComaProjectDetailView> {
  int currentTab = 0;

  Map<String, dynamic> project = {
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
    "description": "A state-of-the-art commercial complex featuring modern office spaces, retail outlets, and entertainment facilities. The project includes sustainable design elements and smart building technologies.",
    "image": "https://picsum.photos/400/250?random=1&keyword=construction",
    "images": [
      "https://picsum.photos/300/200?random=1&keyword=construction",
      "https://picsum.photos/300/200?random=2&keyword=building",
      "https://picsum.photos/300/200?random=3&keyword=architecture",
      "https://picsum.photos/300/200?random=4&keyword=commercial"
    ],
    "permits": [
      {
        "name": "Building Permit",
        "status": "approved",
        "issueDate": "2023-12-15",
        "expiryDate": "2025-12-15"
      },
      {
        "name": "Environmental Clearance",
        "status": "approved",
        "issueDate": "2023-11-20",
        "expiryDate": "2025-11-20"
      },
      {
        "name": "Fire Safety Certificate",
        "status": "pending",
        "issueDate": "",
        "expiryDate": ""
      }
    ],
    "milestones": [
      {
        "name": "Foundation Work",
        "status": "completed",
        "progress": 100.0,
        "startDate": "2024-01-15",
        "endDate": "2024-03-30",
        "budget": 450000.0,
        "spent": 445000.0
      },
      {
        "name": "Structural Framework",
        "status": "completed",
        "progress": 100.0,
        "startDate": "2024-04-01",
        "endDate": "2024-07-15",
        "budget": 850000.0,
        "spent": 865000.0
      },
      {
        "name": "Interior Construction",
        "status": "in_progress",
        "progress": 45.0,
        "startDate": "2024-07-16",
        "endDate": "2024-11-30",
        "budget": 750000.0,
        "spent": 325000.0
      },
      {
        "name": "Final Finishes",
        "status": "pending",
        "progress": 0.0,
        "startDate": "2024-12-01",
        "endDate": "2024-12-30",
        "budget": 450000.0,
        "spent": 0.0
      }
    ],
    "team_members": [
      {
        "name": "Sarah Wilson",
        "role": "Project Manager",
        "phone": "+1 555-0101",
        "email": "sarah.wilson@company.com",
        "avatar": "https://picsum.photos/60/60?random=1&keyword=person"
      },
      {
        "name": "Mike Chen",
        "role": "Site Engineer",
        "phone": "+1 555-0102",
        "email": "mike.chen@company.com",
        "avatar": "https://picsum.photos/60/60?random=2&keyword=person"
      },
      {
        "name": "David Brown",
        "role": "Safety Officer",
        "phone": "+1 555-0103",
        "email": "david.brown@company.com",
        "avatar": "https://picsum.photos/60/60?random=3&keyword=person"
      },
      {
        "name": "Lisa Garcia",
        "role": "Quality Control",
        "phone": "+1 555-0104",
        "email": "lisa.garcia@company.com",
        "avatar": "https://picsum.photos/60/60?random=4&keyword=person"
      }
    ],
    "materials": [
      {
        "name": "Steel Reinforcement Bars",
        "quantity": "250 tons",
        "unit_cost": 850.0,
        "total_cost": 212500.0,
        "supplier": "MetalCorp Industries",
        "status": "delivered"
      },
      {
        "name": "Concrete Mix",
        "quantity": "800 m³",
        "unit_cost": 120.0,
        "total_cost": 96000.0,
        "supplier": "BuildMix Solutions",
        "status": "delivered"
      },
      {
        "name": "Glass Panels",
        "quantity": "150 units",
        "unit_cost": 450.0,
        "total_cost": 67500.0,
        "supplier": "GlassTech Corp",
        "status": "ordered"
      }
    ]
  };

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return primaryColor;
      case 'planning':
      case 'pending':
        return infoColor;
      case 'delayed':
        return dangerColor;
      case 'approved':
        return successColor;
      case 'ordered':
        return warningColor;
      case 'delivered':
        return successColor;
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
      case 'pending':
        return 'Pending';
      case 'delayed':
        return 'Delayed';
      case 'approved':
        return 'Approved';
      case 'ordered':
        return 'Ordered';
      case 'delivered':
        return 'Delivered';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              //navigateTo('ComaEditProjectView')
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectHeader(),
            _buildProgressSection(),
            _buildTabSection(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectHeader() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              "${project["image"]}",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${project["name"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(project["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        _getStatusLabel(project["status"]),
                        style: TextStyle(
                          fontSize: 12,
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
                    fontSize: fsH6,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${project["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Manager: ${project["manager"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${project["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    double progressValue = (project["progress"] as num) / 100;
    double budgetUsed = ((project["spent"] as num) / (project["budget"] as num));
    
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Project Overview",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Progress",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(project["progress"] as num).toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: fsH5,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Budget Used",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(budgetUsed * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: fsH5,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: budgetUsed,
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(project["startDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "End Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(project["endDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Budget",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$${((project["budget"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount Spent",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$${((project["spent"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildTabButton("Overview", 0, Icons.dashboard),
          _buildTabButton("Milestones", 1, Icons.flag),
          _buildTabButton("Team", 2, Icons.people),
          _buildTabButton("Materials", 3, Icons.inventory),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index, IconData icon) {
    bool isActive = currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          currentTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? Colors.white : disabledBoldColor,
              ),
              SizedBox(height: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.white : disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildMilestonesTab();
      case 2:
        return _buildTeamTab();
      case 3:
        return _buildMaterialsTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Project Images",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                QHorizontalScroll(
                  children: (project["images"] as List).map((image) {
                    return Container(
                      width: 150,
                      height: 100,
                      margin: EdgeInsets.only(right: spSm),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "$image",
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Permits & Approvals",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...(project["permits"] as List).map((permit) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getStatusColor(permit["status"]).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: _getStatusColor(permit["status"]).withAlpha(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(permit["status"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            permit["status"] == "approved" ? Icons.check : Icons.hourglass_empty,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${permit["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              if (permit["issueDate"].toString().isNotEmpty)
                                Text(
                                  "Issued: ${DateTime.parse(permit["issueDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(permit["status"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusLabel(permit["status"]),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonesTab() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        children: (project["milestones"] as List).map((milestone) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
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
                    Expanded(
                      child: Text(
                        "${milestone["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(milestone["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _getStatusLabel(milestone["status"]),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getStatusColor(milestone["status"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
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
                      "${(milestone["progress"] as num).toStringAsFixed(0)}%",
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
                  value: (milestone["progress"] as num) / 100,
                  backgroundColor: disabledOutlineBorderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(milestone["status"])),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Date",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(milestone["startDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Date",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(milestone["endDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Budget",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((milestone["budget"] as num) / 1000).toStringAsFixed(0)}K",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTeamTab() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        children: (project["team_members"] as List).map((member) {
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
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage("${member["avatar"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${member["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${member["role"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 12,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${member["phone"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 12,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${member["email"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(height: spXs),
                    QButton(
                      icon: Icons.email,
                      size: bs.sm,
                      color: secondaryColor,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMaterialsTab() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        children: (project["materials"] as List).map((material) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
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
                    Expanded(
                      child: Text(
                        "${material["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(material["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _getStatusLabel(material["status"]),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getStatusColor(material["status"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Supplier: ${material["supplier"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${material["quantity"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit Cost",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((material["unit_cost"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Cost",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((material["total_cost"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Timeline View",
                    icon: Icons.timeline,
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      //navigateTo('ComaProjectTimelineView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share Project",
                    icon: Icons.share,
                    size: bs.sm,
                    color: secondaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.download,
                    size: bs.sm,
                    color: successColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Archive Project",
                    icon: Icons.archive,
                    size: bs.sm,
                    color: warningColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
