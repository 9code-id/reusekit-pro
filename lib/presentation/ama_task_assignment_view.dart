import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaTaskAssignmentView extends StatefulWidget {
  const AmaTaskAssignmentView({Key? key}) : super(key: key);

  @override
  State<AmaTaskAssignmentView> createState() => _AmaTaskAssignmentViewState();
}

class _AmaTaskAssignmentViewState extends State<AmaTaskAssignmentView> {
  int currentTab = 0;
  String selectedPriority = "All";
  String selectedStatus = "All";
  String selectedWorker = "All";
  String taskTitle = "";
  String taskDescription = "";
  String assignedWorker = "";
  String taskPriority = "Medium";
  String taskDueDate = DateTime.now().add(Duration(days: 7)).toString().substring(0, 10);
  bool showCreateTask = false;

  final List<Map<String, dynamic>> tasks = [
    {
      "id": "TSK001",
      "title": "Irrigation System Maintenance",
      "description": "Check and clean all irrigation pipes and sprinklers in sector A",
      "assignedTo": "John Smith",
      "assignedBy": "Farm Manager",
      "priority": "High",
      "status": "In Progress",
      "dueDate": "2024-01-15",
      "progress": 60,
      "category": "Maintenance",
      "timeEstimate": "4 hours",
      "location": "Sector A",
      "equipment": ["Wrench", "Pipe cleaner", "Pressure gauge"],
    },
    {
      "id": "TSK002",
      "title": "Crop Health Inspection",
      "description": "Inspect tomato plants for pests and diseases in greenhouse 2",
      "assignedTo": "Maria Garcia",
      "assignedBy": "Head Agronomist",
      "priority": "High",
      "status": "Pending",
      "dueDate": "2024-01-12",
      "progress": 0,
      "category": "Inspection",
      "timeEstimate": "2 hours",
      "location": "Greenhouse 2",
      "equipment": ["Magnifying glass", "Sample containers", "Camera"],
    },
    {
      "id": "TSK003",
      "title": "Fertilizer Application",
      "description": "Apply organic fertilizer to corn fields in sector C",
      "assignedTo": "David Johnson",
      "assignedBy": "Field Supervisor",
      "priority": "Medium",
      "status": "Completed",
      "dueDate": "2024-01-10",
      "progress": 100,
      "category": "Cultivation",
      "timeEstimate": "6 hours",
      "location": "Sector C",
      "equipment": ["Spreader", "Protective gear", "Measuring tools"],
    },
    {
      "id": "TSK004",
      "title": "Equipment Calibration",
      "description": "Calibrate harvesting equipment for optimal performance",
      "assignedTo": "Robert Wilson",
      "assignedBy": "Maintenance Chief",
      "priority": "Medium",
      "status": "In Progress",
      "dueDate": "2024-01-18",
      "progress": 30,
      "category": "Maintenance",
      "timeEstimate": "3 hours",
      "location": "Equipment Shed",
      "equipment": ["Calibration tools", "Manual", "Computer"],
    },
    {
      "id": "TSK005",
      "title": "Soil Testing",
      "description": "Collect and test soil samples from all sectors for pH and nutrients",
      "assignedTo": "Sarah Brown",
      "assignedBy": "Soil Specialist",
      "priority": "Low",
      "status": "Pending",
      "dueDate": "2024-01-20",
      "progress": 0,
      "category": "Analysis",
      "timeEstimate": "8 hours",
      "location": "All Sectors",
      "equipment": ["Soil auger", "Test kit", "Labels", "Storage bags"],
    },
  ];

  final List<Map<String, dynamic>> workers = [
    {
      "id": "WRK001",
      "name": "John Smith",
      "role": "Field Worker",
      "avatar": "https://picsum.photos/50/50?random=1",
      "activeTasks": 2,
      "completedTasks": 15,
      "rating": 4.8,
      "skills": ["Irrigation", "Maintenance", "Equipment Operation"],
    },
    {
      "id": "WRK002",
      "name": "Maria Garcia",
      "role": "Crop Specialist",
      "avatar": "https://picsum.photos/50/50?random=2",
      "activeTasks": 1,
      "completedTasks": 23,
      "rating": 4.9,
      "skills": ["Pest Control", "Plant Health", "Quality Assessment"],
    },
    {
      "id": "WRK003",
      "name": "David Johnson",
      "role": "Equipment Operator",
      "avatar": "https://picsum.photos/50/50?random=3",
      "activeTasks": 3,
      "completedTasks": 18,
      "rating": 4.7,
      "skills": ["Heavy Machinery", "Fertilizer Application", "Harvesting"],
    },
    {
      "id": "WRK004",
      "name": "Robert Wilson",
      "role": "Maintenance Technician",
      "avatar": "https://picsum.photos/50/50?random=4",
      "activeTasks": 1,
      "completedTasks": 31,
      "rating": 4.9,
      "skills": ["Mechanical Repair", "Electrical Systems", "Calibration"],
    },
    {
      "id": "WRK005",
      "name": "Sarah Brown",
      "role": "Laboratory Analyst",
      "avatar": "https://picsum.photos/50/50?random=5",
      "activeTasks": 2,
      "completedTasks": 12,
      "rating": 4.6,
      "skills": ["Soil Analysis", "Quality Testing", "Data Recording"],
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesPriority = selectedPriority == "All" || task["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All" || task["status"] == selectedStatus;
      bool matchesWorker = selectedWorker == "All" || task["assignedTo"] == selectedWorker;
      return matchesPriority && matchesStatus && matchesWorker;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Pending":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(task["priority"]),
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
                      "ID: ${task["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs/2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(task["priority"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${task["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["assignedTo"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.calendar_today,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["dueDate"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progress: ${task["progress"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs/2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(task["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${task["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(task["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: (task["progress"] as int) / 100,
                      backgroundColor: disabledColor.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation(_getStatusColor(task["status"])),
                    ),
                  ],
                ),
              ),
            ],
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
                "${task["location"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.access_time,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["timeEstimate"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${worker["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${worker["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${worker["role"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs/2),
                    Text(
                      "${worker["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Active: ${worker["activeTasks"]}",
                      style: TextStyle(
                        fontSize: 12,
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
                label: "Assign",
                size: bs.sm,
                onPressed: () {
                  assignedWorker = worker["name"];
                  setState(() {});
                },
              ),
              SizedBox(height: spXs),
              Text(
                "Completed: ${worker["completedTasks"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTaskForm() {
    return Container(
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
              Text(
                "Create New Task",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showCreateTask = false;
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Task Title",
            value: taskTitle,
            hint: "Enter task title",
            onChanged: (value) {
              taskTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Task Description",
            value: taskDescription,
            hint: "Describe the task in detail",
            onChanged: (value) {
              taskDescription = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Assign to Worker",
                  items: workers.map((worker) => {
                    "label": "${worker["name"]} - ${worker["role"]}",
                    "value": worker["name"],
                  }).toList(),
                  value: assignedWorker,
                  onChanged: (value, label) {
                    assignedWorker = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "High", "value": "High"},
                    {"label": "Medium", "value": "Medium"},
                    {"label": "Low", "value": "Low"},
                  ],
                  value: taskPriority,
                  onChanged: (value, label) {
                    taskPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDatePicker(
            label: "Due Date",
            value: DateTime.parse(taskDueDate),
            onChanged: (value) {
              taskDueDate = value.toString().substring(0, 10);
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledColor,
                  onPressed: () {
                    showCreateTask = false;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create Task",
                  onPressed: () {
                    if (taskTitle.isNotEmpty && assignedWorker.isNotEmpty) {
                      // Add task logic here
                      ss("Task created successfully!");
                      showCreateTask = false;
                      taskTitle = "";
                      taskDescription = "";
                      assignedWorker = "";
                      setState(() {});
                    } else {
                      se("Please fill in all required fields");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return Column(
      children: [
        if (showCreateTask) ...[
          _buildCreateTaskForm(),
          SizedBox(height: spMd),
        ],
        Container(
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
                    child: QDropdownField(
                      label: "Priority",
                      items: [
                        {"label": "All Priorities", "value": "All"},
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
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: [
                        {"label": "All Status", "value": "All"},
                        {"label": "Pending", "value": "Pending"},
                        {"label": "In Progress", "value": "In Progress"},
                        {"label": "Completed", "value": "Completed"},
                      ],
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Assigned Worker",
                items: [
                  {"label": "All Workers", "value": "All"},
                  ...workers.map((worker) => {
                    "label": "${worker["name"]}",
                    "value": worker["name"],
                  }).toList(),
                ],
                value: selectedWorker,
                onChanged: (value, label) {
                  selectedWorker = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
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
            QButton(
              label: "New Task",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                showCreateTask = true;
                setState(() {});
              },
            ),
          ],
        ),
        SizedBox(height: spSm),
        Expanded(
          child: ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              return _buildTaskCard(filteredTasks[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWorkersTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${workers.length}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Workers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${workers.where((w) => (w["activeTasks"] as int) > 0).length}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Active Workers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${(workers.map((w) => w["rating"] as double).reduce((a, b) => a + b) / workers.length).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Avg Rating",
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
        ),
        SizedBox(height: spMd),
        Row(
          children: [
            Text(
              "Available Workers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "Add Worker",
              icon: Icons.person_add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spSm),
        Expanded(
          child: ListView.builder(
            itemCount: workers.length,
            itemBuilder: (context, index) {
              return _buildWorkerCard(workers[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReportsTab() {
    final completedTasks = tasks.where((task) => task["status"] == "Completed").length;
    final inProgressTasks = tasks.where((task) => task["status"] == "In Progress").length;
    final pendingTasks = tasks.where((task) => task["status"] == "Pending").length;
    final overdueTasksCount = tasks.where((task) => 
      DateTime.parse(task["dueDate"]).isBefore(DateTime.now()) && 
      task["status"] != "Completed"
    ).length;

    return SingleChildScrollView(
      child: Column(
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment_turned_in,
                      size: 40,
                      color: successColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$completedTasks",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Completed Tasks",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.hourglass_empty,
                      size: 40,
                      color: warningColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$inProgressTasks",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "In Progress",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.pending_actions,
                      size: 40,
                      color: infoColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$pendingTasks",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Pending Tasks",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 40,
                      color: dangerColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$overdueTasksCount",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Overdue Tasks",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
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
                  "Task Categories Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...tasks.map((task) => task["category"]).toSet().map((category) {
                  int count = tasks.where((task) => task["category"] == category).length;
                  double percentage = (count / tasks.length) * 100;
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$category",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "$count tasks (${percentage.toStringAsFixed(1)}%)",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: disabledColor.withAlpha(30),
                          valueColor: AlwaysStoppedAnimation(primaryColor),
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Task Assignment",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Tasks", icon: Icon(Icons.assignment)),
        Tab(text: "Workers", icon: Icon(Icons.people)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        Padding(
          padding: EdgeInsets.all(spMd),
          child: _buildTasksTab(),
        ),
        Padding(
          padding: EdgeInsets.all(spMd),
          child: _buildWorkersTab(),
        ),
        Padding(
          padding: EdgeInsets.all(spMd),
          child: _buildReportsTab(),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
