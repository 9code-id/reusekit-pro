import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProjectMilestonesView extends StatefulWidget {
  const ComaProjectMilestonesView({Key? key}) : super(key: key);

  @override
  State<ComaProjectMilestonesView> createState() => _ComaProjectMilestonesViewState();
}

class _ComaProjectMilestonesViewState extends State<ComaProjectMilestonesView> {
  String selectedFilter = "all";
  String searchQuery = "";
  
  Map<String, dynamic> project = {
    "name": "Riverside Commercial Complex",
    "status": "in_progress",
    "progress": 65.0,
    "totalBudget": 2500000.0,
    "spentBudget": 1625000.0,
  };

  List<Map<String, dynamic>> milestones = [
    {
      "id": 1,
      "name": "Foundation Work",
      "description": "Complete foundation excavation, reinforcement, and concrete pouring",
      "status": "completed",
      "progress": 100.0,
      "startDate": "2024-01-15",
      "endDate": "2024-03-30",
      "actualEndDate": "2024-03-28",
      "budget": 450000.0,
      "spent": 445000.0,
      "priority": "critical",
      "category": "construction",
      "responsible": "Construction Team A",
      "dependencies": [],
      "deliverables": [
        "Foundation excavation complete",
        "Steel reinforcement installation",
        "Concrete pouring and curing",
        "Foundation inspection approval"
      ],
      "issues": [],
      "completionPercentage": 100.0
    },
    {
      "id": 2,
      "name": "Structural Framework",
      "description": "Installation of main structural steel framework and building skeleton",
      "status": "completed",
      "progress": 100.0,
      "startDate": "2024-04-01",
      "endDate": "2024-07-15",
      "actualEndDate": "2024-07-20",
      "budget": 850000.0,
      "spent": 865000.0,
      "priority": "critical",
      "category": "construction",
      "responsible": "Steel Installation Team",
      "dependencies": ["Foundation Work"],
      "deliverables": [
        "Steel framework installation",
        "Structural welding complete",
        "Building skeleton erected",
        "Structural engineer approval"
      ],
      "issues": [
        "Delayed delivery of steel materials - 5 days",
        "Weather delays during installation"
      ],
      "completionPercentage": 100.0
    },
    {
      "id": 3,
      "name": "Interior Construction",
      "description": "Interior walls, flooring, ceiling, and basic infrastructure installation",
      "status": "in_progress",
      "progress": 45.0,
      "startDate": "2024-07-16",
      "endDate": "2024-11-30",
      "actualEndDate": null,
      "budget": 750000.0,
      "spent": 325000.0,
      "priority": "high",
      "category": "interior",
      "responsible": "Interior Construction Team",
      "dependencies": ["Structural Framework"],
      "deliverables": [
        "Interior wall framing",
        "Drywall installation",
        "Flooring installation",
        "Ceiling systems",
        "Interior painting"
      ],
      "issues": [
        "Material shortage for flooring - resolved",
        "Electrical coordination required"
      ],
      "completionPercentage": 45.0
    },
    {
      "id": 4,
      "name": "Electrical & Plumbing Systems",
      "description": "Installation of electrical wiring, plumbing, and HVAC systems",
      "status": "in_progress",
      "progress": 30.0,
      "startDate": "2024-08-01",
      "endDate": "2024-12-15",
      "actualEndDate": null,
      "budget": 600000.0,
      "spent": 180000.0,
      "priority": "high",
      "category": "systems",
      "responsible": "MEP Team",
      "dependencies": ["Interior Construction"],
      "deliverables": [
        "Electrical rough-in complete",
        "Plumbing installation",
        "HVAC system installation",
        "System testing and commissioning"
      ],
      "issues": [
        "Coordination with interior team needed",
        "HVAC equipment delivery pending"
      ],
      "completionPercentage": 30.0
    },
    {
      "id": 5,
      "name": "Final Finishes",
      "description": "Final interior finishes, fixtures, and detail work",
      "status": "pending",
      "progress": 0.0,
      "startDate": "2024-12-01",
      "endDate": "2024-12-30",
      "actualEndDate": null,
      "budget": 450000.0,
      "spent": 0.0,
      "priority": "medium",
      "category": "finishing",
      "responsible": "Finishing Team",
      "dependencies": ["Interior Construction", "Electrical & Plumbing Systems"],
      "deliverables": [
        "Final paint and trim work",
        "Fixture installation",
        "Flooring finishes",
        "Final cleaning",
        "Quality inspection"
      ],
      "issues": [],
      "completionPercentage": 0.0
    },
    {
      "id": 6,
      "name": "Landscaping & Exterior",
      "description": "Exterior landscaping, parking, and site finishing work",
      "status": "scheduled",
      "progress": 0.0,
      "startDate": "2024-11-15",
      "endDate": "2025-01-15",
      "actualEndDate": null,
      "budget": 300000.0,
      "spent": 0.0,
      "priority": "medium",
      "category": "exterior",
      "responsible": "Landscaping Team",
      "dependencies": ["Interior Construction"],
      "deliverables": [
        "Parking lot construction",
        "Landscape installation",
        "Exterior lighting",
        "Signage installation",
        "Site cleanup"
      ],
      "issues": [],
      "completionPercentage": 0.0
    },
    {
      "id": 7,
      "name": "Final Inspection & Handover",
      "description": "Final inspections, certifications, and project handover",
      "status": "scheduled",
      "progress": 0.0,
      "startDate": "2025-01-15",
      "endDate": "2025-01-30",
      "actualEndDate": null,
      "budget": 100000.0,
      "spent": 0.0,
      "priority": "critical",
      "category": "completion",
      "responsible": "Project Manager",
      "dependencies": ["Final Finishes", "Landscaping & Exterior"],
      "deliverables": [
        "Building inspection approval",
        "Fire safety certification",
        "Occupancy permit",
        "Project documentation",
        "Client handover"
      ],
      "issues": [],
      "completionPercentage": 0.0
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Milestones", "value": "all"},
    {"label": "Completed", "value": "completed"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Pending", "value": "pending"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Critical Priority", "value": "critical"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return primaryColor;
      case 'pending':
        return warningColor;
      case 'scheduled':
        return infoColor;
      case 'delayed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return primaryColor;
      case 'low':
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
      case 'pending':
        return 'Pending';
      case 'scheduled':
        return 'Scheduled';
      case 'delayed':
        return 'Delayed';
      default:
        return 'Unknown';
    }
  }

  List<Map<String, dynamic>> get filteredMilestones {
    return milestones.where((milestone) {
      bool matchesSearch = milestone["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          milestone["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          milestone["responsible"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "all" || 
          milestone["status"] == selectedFilter ||
          milestone["priority"] == selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Milestones"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddMilestoneDialog(),
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProjectOverview(),
          _buildSearchBar(),
          _buildMilestoneStats(),
          Expanded(
            child: _buildMilestonesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectOverview() {
    double overallProgress = (project["progress"] as num).toDouble();
    double budgetUsed = ((project["spentBudget"] as num) / (project["totalBudget"] as num)) * 100;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${project["name"]}",
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
                        "Overall Progress",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${overallProgress.toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: fsH5,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: overallProgress / 100,
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
                        "Budget Progress",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${budgetUsed.toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: fsH5,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: budgetUsed / 100,
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: QTextField(
              label: "Search milestones...",
              value: searchQuery,
              hint: "Search by name, description, or responsible person",
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
    );
  }

  Widget _buildMilestoneStats() {
    int completedCount = milestones.where((m) => m["status"] == "completed").length;
    int inProgressCount = milestones.where((m) => m["status"] == "in_progress").length;
    int pendingCount = milestones.where((m) => m["status"] == "pending" || m["status"] == "scheduled").length;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      color: Colors.white,
      child: Row(
        children: [
          _buildStatChip("Completed", completedCount, successColor),
          SizedBox(width: spSm),
          _buildStatChip("In Progress", inProgressCount, primaryColor),
          SizedBox(width: spSm),
          _buildStatChip("Upcoming", pendingCount, infoColor),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spXs),
          Text(
            "$label ($count)",
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonesList() {
    List<Map<String, dynamic>> sortedMilestones = filteredMilestones;
    sortedMilestones.sort((a, b) => DateTime.parse(a["startDate"]).compareTo(DateTime.parse(b["startDate"])));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: sortedMilestones.map((milestone) => _buildMilestoneCard(milestone)).toList(),
      ),
    );
  }

  Widget _buildMilestoneCard(Map<String, dynamic> milestone) {
    Color statusColor = _getStatusColor(milestone["status"]);
    Color priorityColor = _getPriorityColor(milestone["priority"]);
    double progressValue = (milestone["progress"] as num) / 100;
    double budgetUsed = milestone["spent"] > 0 ? ((milestone["spent"] as num) / (milestone["budget"] as num)) : 0.0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: statusColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(10),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
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
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _getStatusLabel(milestone["status"]),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${milestone["priority"].toString().toUpperCase()}",
                        style: TextStyle(
                          fontSize: 9,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${milestone["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  backgroundColor: disabledOutlineBorderColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                                ),
                              ),
                              SizedBox(width: spSm),
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
                            "Responsible",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${milestone["responsible"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryColor,
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
                            "Budget",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((milestone["budget"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
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
                            "Spent",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((milestone["spent"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 12,
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
                            "Budget Used",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(budgetUsed * 100).toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: budgetUsed > 1.0 ? dangerColor : primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                if ((milestone["dependencies"] as List).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Text(
                    "Dependencies",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (milestone["dependencies"] as List).map((dep) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$dep",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                
                if ((milestone["issues"] as List).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning,
                              size: 14,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Issues (${(milestone["issues"] as List).length})",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (milestone["issues"] as List).map((issue) {
                            return Text(
                              "• $issue",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
                
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        color: infoColor,
                        onPressed: () => _showMilestoneDetails(milestone),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () => _showEditMilestoneDialog(milestone),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () => _showMilestoneOptions(milestone),
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
              "Filter Milestones",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Filter By",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear Filter",
                    size: bs.sm,
                    color: disabledBoldColor,
                    onPressed: () {
                      selectedFilter = "all";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Filter",
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

  void _showAddMilestoneDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Milestone"),
        content: Text("Feature to add new project milestones would be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("New milestone added successfully");
            },
            child: Text("Add Milestone"),
          ),
        ],
      ),
    );
  }

  void _showEditMilestoneDialog(Map<String, dynamic> milestone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Milestone"),
        content: Text("Edit milestone: ${milestone["name"]}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Milestone updated successfully");
            },
            child: Text("Save Changes"),
          ),
        ],
      ),
    );
  }

  void _showMilestoneDetails(Map<String, dynamic> milestone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
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
              "${milestone["name"]}",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Deliverables",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Expanded(
              child: ListView.builder(
                itemCount: (milestone["deliverables"] as List).length,
                itemBuilder: (context, index) {
                  String deliverable = (milestone["deliverables"] as List)[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          milestone["status"] == "completed" ? Icons.check_circle : Icons.radio_button_unchecked,
                          size: 16,
                          color: milestone["status"] == "completed" ? successColor : disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            deliverable,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showMilestoneOptions(Map<String, dynamic> milestone) {
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
            Text(
              "${milestone["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Mark Complete",
                    icon: Icons.check,
                    size: bs.sm,
                    color: successColor,
                    onPressed: () {
                      Navigator.pop(context);
                      si("Milestone marked as completed");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Add Issue",
                    icon: Icons.warning,
                    size: bs.sm,
                    color: warningColor,
                    onPressed: () {
                      Navigator.pop(context);
                      si("Issue logged for milestone");
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
                    label: "Reschedule",
                    icon: Icons.schedule,
                    size: bs.sm,
                    color: infoColor,
                    onPressed: () {
                      Navigator.pop(context);
                      si("Milestone rescheduled");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Delete",
                    icon: Icons.delete,
                    size: bs.sm,
                    color: dangerColor,
                    onPressed: () async {
                      Navigator.pop(context);
                      bool isConfirmed = await confirm("Delete this milestone?");
                      if (isConfirmed) {
                        se("Milestone deleted");
                      }
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
