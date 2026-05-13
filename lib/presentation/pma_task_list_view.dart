import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTaskListView extends StatefulWidget {
  const PmaTaskListView({super.key});

  @override
  State<PmaTaskListView> createState() => _PmaTaskListViewState();
}

class _PmaTaskListViewState extends State<PmaTaskListView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedPriority = "";
  String selectedAssignee = "";
  String selectedProject = "";
  String sortBy = "Due Date";
  bool isGridView = false;
  
  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Implement User Authentication",
      "description": "Develop secure user authentication system with JWT tokens",
      "project": "E-commerce Platform",
      "assignee": "John Smith",
      "priority": "High",
      "status": "In Progress",
      "dueDate": "2024-06-20",
      "createdDate": "2024-06-01",
      "progress": 75,
      "estimatedHours": 40,
      "actualHours": 30,
      "category": "Backend",
      "labels": ["authentication", "security"],
    },
    {
      "id": 2,
      "title": "Design Product Catalog UI",
      "description": "Create responsive product catalog interface",
      "project": "E-commerce Platform",
      "assignee": "Sarah Wilson",
      "priority": "Medium",
      "status": "To Do",
      "dueDate": "2024-06-25",
      "createdDate": "2024-06-05",
      "progress": 0,
      "estimatedHours": 32,
      "actualHours": 0,
      "category": "Frontend",
      "labels": ["ui", "design"],
    },
    {
      "id": 3,
      "title": "Database Schema Review",
      "description": "Review and optimize database schema",
      "project": "Mobile Banking App",
      "assignee": "Michael Chen",
      "priority": "High",
      "status": "Review",
      "dueDate": "2024-06-18",
      "createdDate": "2024-06-08",
      "progress": 90,
      "estimatedHours": 16,
      "actualHours": 14,
      "category": "Database",
      "labels": ["database", "optimization"],
    },
    {
      "id": 4,
      "title": "Security Testing",
      "description": "Perform comprehensive security testing",
      "project": "Mobile Banking App",
      "assignee": "Emily Rodriguez",
      "priority": "Critical",
      "status": "Overdue",
      "dueDate": "2024-06-15",
      "createdDate": "2024-06-01",
      "progress": 60,
      "estimatedHours": 48,
      "actualHours": 35,
      "category": "Testing",
      "labels": ["security", "testing"],
    },
    {
      "id": 5,
      "title": "API Documentation",
      "description": "Complete API documentation for all endpoints",
      "project": "CRM System",
      "assignee": "David Thompson",
      "priority": "Low",
      "status": "Done",
      "dueDate": "2024-06-10",
      "createdDate": "2024-05-20",
      "progress": 100,
      "estimatedHours": 24,
      "actualHours": 22,
      "category": "Documentation",
      "labels": ["api", "documentation"],
    },
    {
      "id": 6,
      "title": "Payment Gateway Integration",
      "description": "Integrate multiple payment gateways",
      "project": "E-commerce Platform",
      "assignee": "Alex Johnson",
      "priority": "High",
      "status": "In Progress",
      "dueDate": "2024-06-22",
      "createdDate": "2024-06-03",
      "progress": 45,
      "estimatedHours": 36,
      "actualHours": 18,
      "category": "Integration",
      "labels": ["payment", "integration"],
    },
    {
      "id": 7,
      "title": "Mobile App Testing",
      "description": "Complete testing for mobile banking app",
      "project": "Mobile Banking App",
      "assignee": "Lisa Anderson",
      "priority": "Medium",
      "status": "In Progress",
      "dueDate": "2024-06-28",
      "createdDate": "2024-06-10",
      "progress": 30,
      "estimatedHours": 40,
      "actualHours": 12,
      "category": "Testing",
      "labels": ["mobile", "testing"],
    },
    {
      "id": 8,
      "title": "User Manual Creation",
      "description": "Create comprehensive user manual",
      "project": "CRM System",
      "assignee": "Robert Kim",
      "priority": "Low",
      "status": "To Do",
      "dueDate": "2024-07-05",
      "createdDate": "2024-06-12",
      "progress": 0,
      "estimatedHours": 20,
      "actualHours": 0,
      "category": "Documentation",
      "labels": ["manual", "documentation"],
    }
  ];

  List<Map<String, dynamic>> get filteredTasks {
    List<Map<String, dynamic>> filtered = tasks.where((task) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${task["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty ||
          task["status"] == selectedStatus;
      
      bool matchesPriority = selectedPriority.isEmpty ||
          task["priority"] == selectedPriority;
      
      bool matchesAssignee = selectedAssignee.isEmpty ||
          task["assignee"] == selectedAssignee;
      
      bool matchesProject = selectedProject.isEmpty ||
          task["project"] == selectedProject;
      
      return matchesSearch && matchesStatus && matchesPriority && matchesAssignee && matchesProject;
    }).toList();

    // Sort the filtered list
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Due Date":
          return DateTime.parse(a["dueDate"]).compareTo(DateTime.parse(b["dueDate"]));
        case "Priority":
          Map<String, int> priorityOrder = {"Critical": 0, "High": 1, "Medium": 2, "Low": 3};
          return (priorityOrder[a["priority"]] ?? 4).compareTo(priorityOrder[b["priority"]] ?? 4);
        case "Progress":
          return (b["progress"] as int).compareTo(a["progress"] as int);
        case "Title":
          return a["title"].compareTo(b["title"]);
        default:
          return 0;
      }
    });

    return filtered;
  }

  Widget _buildTaskListHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                  label: "Search tasks...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: isGridView ? Icons.list : Icons.grid_view,
                size: bs.sm,
                onPressed: () {
                  isGridView = !isGridView;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All Status", "value": ""},
                    {"label": "To Do", "value": "To Do"},
                    {"label": "In Progress", "value": "In Progress"},
                    {"label": "Review", "value": "Review"},
                    {"label": "Done", "value": "Done"},
                    {"label": "Overdue", "value": "Overdue"},
                  ],
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "All Priority", "value": ""},
                    {"label": "Critical", "value": "Critical"},
                    {"label": "High", "value": "High"},
                    {"label": "Medium", "value": "Medium"},
                    {"label": "Low", "value": "Low"},
                  ],
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Assignee",
                  items: [
                    {"label": "All Assignees", "value": ""},
                    {"label": "John Smith", "value": "John Smith"},
                    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
                    {"label": "Michael Chen", "value": "Michael Chen"},
                    {"label": "Emily Rodriguez", "value": "Emily Rodriguez"},
                    {"label": "David Thompson", "value": "David Thompson"},
                    {"label": "Alex Johnson", "value": "Alex Johnson"},
                    {"label": "Lisa Anderson", "value": "Lisa Anderson"},
                    {"label": "Robert Kim", "value": "Robert Kim"},
                  ],
                  value: selectedAssignee,
                  onChanged: (value, label) {
                    selectedAssignee = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: [
                    {"label": "All Projects", "value": ""},
                    {"label": "E-commerce Platform", "value": "E-commerce Platform"},
                    {"label": "Mobile Banking App", "value": "Mobile Banking App"},
                    {"label": "CRM System", "value": "CRM System"},
                  ],
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Sort By",
            items: [
              {"label": "Due Date", "value": "Due Date"},
              {"label": "Priority", "value": "Priority"},
              {"label": "Progress", "value": "Progress"},
              {"label": "Title", "value": "Title"},
            ],
            value: sortBy,
            onChanged: (value, label) {
              sortBy = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTaskListItem(Map<String, dynamic> task) {
    Color statusColor = _getStatusColor(task["status"]);
    Color priorityColor = _getPriorityColor(task["priority"]);
    bool isOverdue = DateTime.parse(task["dueDate"]).isBefore(DateTime.now()) && task["status"] != "Done";

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isOverdue ? dangerColor : statusColor,
          ),
        ),
      ),
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
                      "${task["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${task["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${task["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${task["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (task["progress"] as int) / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Text(
                "${task["progress"]}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.business,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["project"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["assignee"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: isOverdue ? dangerColor : disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Due: ${DateTime.parse(task["dueDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: isOverdue ? dangerColor : disabledBoldColor,
                  fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              Spacer(),
              Icon(
                Icons.access_time,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["actualHours"]}h / ${task["estimatedHours"]}h",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((task["labels"] as List).isNotEmpty) ...[
            SizedBox(height: spMd),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (task["labels"] as List).map((label) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "#$label",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('PmaTaskDetailView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('PmaEditTaskView')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.check,
                size: bs.sm,
                onPressed: () {
                  if (task["status"] != "Done") {
                    task["status"] = "Done";
                    task["progress"] = 100;
                    setState(() {});
                    ss("Task marked as completed!");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskGridItem(Map<String, dynamic> task) {
    Color statusColor = _getStatusColor(task["status"]);
    Color priorityColor = _getPriorityColor(task["priority"]);
    bool isOverdue = DateTime.parse(task["dueDate"]).isBefore(DateTime.now()) && task["status"] != "Done";

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(
            width: 4,
            color: isOverdue ? dangerColor : statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${task["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${task["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spMd),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (task["progress"] as int) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${task["progress"]}% Complete",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${task["assignee"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Due: ${DateTime.parse(task["dueDate"]).dMMMy}",
            style: TextStyle(
              fontSize: 10,
              color: isOverdue ? dangerColor : disabledBoldColor,
              fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View",
              size: bs.sm,
              onPressed: () {
                //navigateTo('PmaTaskDetailView')
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "To Do":
        return disabledBoldColor;
      case "In Progress":
        return warningColor;
      case "Review":
        return infoColor;
      case "Done":
        return successColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('PmaCreateTaskView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildTaskListHeader(),
            SizedBox(height: spLg),
            Row(
              children: [
                Text(
                  "Tasks (${filteredTasks.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  isGridView ? "Grid View" : "List View",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            if (isGridView) ...[
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredTasks.map((task) => _buildTaskGridItem(task)).toList(),
              ),
            ] else ...[
              ...filteredTasks.map((task) => _buildTaskListItem(task)),
            ],
          ],
        ),
      ),
    );
  }
}
