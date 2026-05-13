import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaMilestoneDetailView extends StatefulWidget {
  const PmaMilestoneDetailView({super.key});

  @override
  State<PmaMilestoneDetailView> createState() => _PmaMilestoneDetailViewState();
}

class _PmaMilestoneDetailViewState extends State<PmaMilestoneDetailView> {
  Map<String, dynamic> milestone = {
    "id": "1",
    "title": "Frontend Development Complete",
    "description": "Complete all frontend components including user interface, responsive design, and interactive elements for the e-commerce platform. This milestone covers the entire frontend development phase from wireframes to final implementation.",
    "project": "E-commerce Platform",
    "projectColor": Colors.blue,
    "status": "in_progress",
    "priority": "high",
    "progress": 75,
    "startDate": "2024-05-15",
    "dueDate": "2024-06-25",
    "estimatedHours": 160,
    "actualHours": 120,
    "assignedTo": "Sarah Johnson",
    "assignedAvatar": "https://picsum.photos/60/60?random=1",
    "assignedEmail": "sarah.johnson@company.com",
    "createdDate": "2024-05-01",
    "lastUpdated": "2024-06-18",
    "budget": 12800.0,
    "spentBudget": 9600.0,
    "isOverdue": false,
    "daysUntilDue": 7,
    "tags": ["frontend", "ui/ux", "responsive", "e-commerce"],
    "dependencies": [
      {
        "id": "dep1",
        "title": "Design System Complete",
        "status": "completed",
        "type": "prerequisite"
      },
      {
        "id": "dep2",
        "title": "API Endpoints Ready",
        "status": "in_progress",
        "type": "prerequisite"
      }
    ],
    "tasks": [
      {
        "id": "task1",
        "title": "Homepage Layout",
        "description": "Create responsive homepage with hero section and product showcase",
        "status": "completed",
        "priority": "high",
        "assignedTo": "Sarah Johnson",
        "completedDate": "2024-05-20",
        "estimatedHours": 16,
        "actualHours": 14,
      },
      {
        "id": "task2",
        "title": "Product Catalog Pages",
        "description": "Implement product listing, filtering, and search functionality",
        "status": "completed",
        "priority": "high",
        "assignedTo": "Sarah Johnson",
        "completedDate": "2024-05-28",
        "estimatedHours": 24,
        "actualHours": 26,
      },
      {
        "id": "task3",
        "title": "Shopping Cart Component",
        "description": "Build interactive shopping cart with add/remove/update functionality",
        "status": "completed",
        "priority": "medium",
        "assignedTo": "Mike Chen",
        "completedDate": "2024-06-05",
        "estimatedHours": 20,
        "actualHours": 18,
      },
      {
        "id": "task4",
        "title": "Checkout Process",
        "description": "Multi-step checkout with payment integration and order summary",
        "status": "in_progress",
        "priority": "high",
        "assignedTo": "Sarah Johnson",
        "completedDate": null,
        "estimatedHours": 32,
        "actualHours": 24,
      },
      {
        "id": "task5",
        "title": "User Dashboard",
        "description": "User account dashboard with order history and profile management",
        "status": "not_started",
        "priority": "medium",
        "assignedTo": "Emma Davis",
        "completedDate": null,
        "estimatedHours": 28,
        "actualHours": 0,
      },
      {
        "id": "task6",
        "title": "Mobile Responsiveness",
        "description": "Ensure full mobile responsiveness across all pages",
        "status": "in_progress",
        "priority": "high",
        "assignedTo": "Sarah Johnson",
        "completedDate": null,
        "estimatedHours": 20,
        "actualHours": 12,
      },
      {
        "id": "task7",
        "title": "Performance Optimization",
        "description": "Optimize loading times and implement lazy loading",
        "status": "not_started",
        "priority": "medium",
        "assignedTo": "Mike Chen",
        "completedDate": null,
        "estimatedHours": 16,
        "actualHours": 0,
      },
      {
        "id": "task8",
        "title": "Cross-browser Testing",
        "description": "Test compatibility across all major browsers",
        "status": "not_started",
        "priority": "low",
        "assignedTo": "Emma Davis",
        "completedDate": null,
        "estimatedHours": 12,
        "actualHours": 0,
      },
    ],
    "comments": [
      {
        "id": "comment1",
        "author": "Sarah Johnson",
        "authorAvatar": "https://picsum.photos/40/40?random=1",
        "content": "Homepage layout is complete and responsive. Moving on to checkout process next.",
        "timestamp": "2024-06-15 10:30:00",
        "type": "update"
      },
      {
        "id": "comment2",
        "author": "Project Manager",
        "authorAvatar": "https://picsum.photos/40/40?random=7",
        "content": "Great progress! Please ensure mobile testing is prioritized as we approach the deadline.",
        "timestamp": "2024-06-16 14:20:00",
        "type": "feedback"
      },
      {
        "id": "comment3",
        "author": "Mike Chen",
        "authorAvatar": "https://picsum.photos/40/40?random=2",
        "content": "Shopping cart component is ready and tested. Integration with backend API is working smoothly.",
        "timestamp": "2024-06-17 09:15:00",
        "type": "update"
      },
    ],
    "attachments": [
      {
        "id": "att1",
        "name": "Frontend_Design_Mockups.pdf",
        "type": "pdf",
        "size": "2.4 MB",
        "uploadedBy": "Sarah Johnson",
        "uploadedDate": "2024-05-20"
      },
      {
        "id": "att2",
        "name": "Component_Documentation.docx",
        "type": "document",
        "size": "856 KB",
        "uploadedBy": "Mike Chen",
        "uploadedDate": "2024-06-10"
      },
      {
        "id": "att3",
        "name": "Mobile_Screenshots.zip",
        "type": "archive",
        "size": "1.2 MB",
        "uploadedBy": "Emma Davis",
        "uploadedDate": "2024-06-15"
      },
    ]
  };

  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> comments = [];
  String newComment = "";

  @override
  void initState() {
    super.initState();
    tasks = List<Map<String, dynamic>>.from(milestone["tasks"]);
    comments = List<Map<String, dynamic>>.from(milestone["comments"]);
  }

  int get completedTasks => tasks.where((task) => task["status"] == "completed").length;
  int get totalTasks => tasks.length;
  double get taskCompletionRate => totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Milestone Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editMilestone,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareMilestone,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildMilestoneHeader(),
            _buildProgressSection(),
            _buildTasksSection(),
            _buildDependenciesSection(),
            _buildTimelineSection(),
            _buildBudgetSection(),
            _buildCommentsSection(),
            _buildAttachmentsSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _updateMilestoneStatus,
        backgroundColor: primaryColor,
        icon: Icon(Icons.update, color: Colors.white),
        label: Text("Update Status", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildMilestoneHeader() {
    String status = milestone["status"];
    String priority = milestone["priority"];
    int progress = milestone["progress"] as int;
    bool isOverdue = milestone["isOverdue"] as bool;
    
    Color statusColor = _getStatusColor(status);
    Color priorityColor = _getPriorityColor(priority);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: isOverdue ? Border.all(color: dangerColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (milestone["projectColor"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.flag,
                  color: milestone["projectColor"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${milestone["project"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: milestone["projectColor"] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${milestone["title"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (isOverdue) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "OVERDUE",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
          Text(
            "${milestone["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  status.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: priorityColor),
                ),
                child: Text(
                  "$priority PRIORITY",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "$progress%",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Start Date", "${milestone["startDate"]}"),
              ),
              Expanded(
                child: _buildInfoItem("Due Date", "${milestone["dueDate"]}"),
              ),
              Expanded(
                child: _buildInfoItem("Days Left", "${milestone["daysUntilDue"]}"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    int estimatedHours = milestone["estimatedHours"] as int;
    int actualHours = milestone["actualHours"] as int;
    double budget = milestone["budget"] as double;
    double spentBudget = milestone["spentBudget"] as double;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Progress Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: LinearProgressIndicator(
              value: (milestone["progress"] as int) / 100,
              backgroundColor: Colors.transparent,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildProgressMetric(
                  "Tasks",
                  "$completedTasks/$totalTasks",
                  "${taskCompletionRate.toStringAsFixed(0)}%",
                  Icons.task_alt,
                  primaryColor,
                ),
              ),
              Expanded(
                child: _buildProgressMetric(
                  "Hours",
                  "$actualHours/$estimatedHours",
                  "${estimatedHours > 0 ? ((actualHours / estimatedHours) * 100).toStringAsFixed(0) : 0}%",
                  Icons.schedule,
                  infoColor,
                ),
              ),
              Expanded(
                child: _buildProgressMetric(
                  "Budget",
                  "\$${spentBudget.currency}/\$${budget.currency}",
                  "${budget > 0 ? ((spentBudget / budget) * 100).toStringAsFixed(0) : 0}%",
                  Icons.attach_money,
                  successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressMetric(String label, String value, String percentage, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Tasks ($completedTasks/$totalTasks)",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                label: "Add Task",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _addTask,
              ),
            ],
          ),
          ...tasks.map((task) => _buildTaskItem(task)).toList(),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    String status = task["status"];
    String priority = task["priority"];
    bool isCompleted = status == "completed";
    
    Color statusColor = _getTaskStatusColor(status);
    Color priorityColor = _getPriorityColor(priority);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isCompleted ? successColor.withAlpha(10) : Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isCompleted ? successColor.withAlpha(100) : disabledOutlineBorderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isCompleted ? successColor : disabledBoldColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${task["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? disabledBoldColor : null,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  priority.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          if (task["description"] != null) ...[
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "${task["description"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.only(left: 28),
            child: Row(
              children: [
                Text(
                  "${task["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "${task["actualHours"]}h / ${task["estimatedHours"]}h",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (isCompleted && task["completedDate"] != null) ...[
                  SizedBox(width: spSm),
                  Text(
                    "Completed: ${task["completedDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDependenciesSection() {
    List<Map<String, dynamic>> dependencies = milestone["dependencies"] as List<Map<String, dynamic>>;
    
    if (dependencies.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Dependencies",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...dependencies.map((dependency) => _buildDependencyItem(dependency)).toList(),
        ],
      ),
    );
  }

  Widget _buildDependencyItem(Map<String, dynamic> dependency) {
    String status = dependency["status"];
    Color statusColor = _getStatusColor(status);
    bool isCompleted = status == "completed";

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.schedule,
            color: statusColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${dependency["title"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
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
              status.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Timeline & Assignment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage("${milestone["assignedAvatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${milestone["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${milestone["assignedEmail"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Reassign",
                size: bs.sm,
                onPressed: _reassignMilestone,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTimelineItem("Created", "${milestone["createdDate"]}", Icons.add_circle),
              ),
              Expanded(
                child: _buildTimelineItem("Last Updated", "${milestone["lastUpdated"]}", Icons.update),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String label, String date, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBudgetSection() {
    double budget = milestone["budget"] as double;
    double spentBudget = milestone["spentBudget"] as double;
    double remainingBudget = budget - spentBudget;
    double budgetUtilization = budget > 0 ? (spentBudget / budget) * 100 : 0;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Budget Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildBudgetItem("Total Budget", "\$${budget.currency}", primaryColor),
              ),
              Expanded(
                child: _buildBudgetItem("Spent", "\$${spentBudget.currency}", dangerColor),
              ),
              Expanded(
                child: _buildBudgetItem("Remaining", "\$${remainingBudget.currency}", successColor),
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: LinearProgressIndicator(
              value: budgetUtilization / 100,
              backgroundColor: Colors.transparent,
              color: budgetUtilization > 90 ? dangerColor : budgetUtilization > 75 ? warningColor : successColor,
            ),
          ),
          Text(
            "${budgetUtilization.toStringAsFixed(1)}% of budget utilized",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetItem(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Comments & Updates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...comments.map((comment) => _buildCommentItem(comment)).toList(),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Add Comment",
                  value: newComment,
                  hint: "Share an update or ask a question...",
                  onChanged: (value) {
                    newComment = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Post",
                size: bs.sm,
                onPressed: _addComment,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${comment["authorAvatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${comment["author"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${comment["timestamp"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${comment["content"]}",
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsSection() {
    List<Map<String, dynamic>> attachments = milestone["attachments"] as List<Map<String, dynamic>>;
    
    if (attachments.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Attachments (${attachments.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                label: "Add File",
                icon: Icons.attach_file,
                size: bs.sm,
                onPressed: _addAttachment,
              ),
            ],
          ),
          ...attachments.map((attachment) => _buildAttachmentItem(attachment)).toList(),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(Map<String, dynamic> attachment) {
    IconData icon = _getFileIcon(attachment["type"]);
    Color iconColor = _getFileColor(attachment["type"]);

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: iconColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: iconColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${attachment["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${attachment["size"]} • ${attachment["uploadedBy"]} • ${attachment["uploadedDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.download,
            color: disabledBoldColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "not_started":
        return warningColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTaskStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "not_started":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getFileIcon(String type) {
    switch (type) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "document":
        return Icons.description;
      case "archive":
        return Icons.archive;
      case "image":
        return Icons.image;
      default:
        return Icons.attach_file;
    }
  }

  Color _getFileColor(String type) {
    switch (type) {
      case "pdf":
        return dangerColor;
      case "document":
        return infoColor;
      case "archive":
        return warningColor;
      case "image":
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _editMilestone() {
    si("Edit milestone details");
  }

  void _shareMilestone() {
    si("Share milestone details");
  }

  void _updateMilestoneStatus() {
    si("Update milestone status");
  }

  void _addTask() {
    si("Add new task to milestone");
  }

  void _reassignMilestone() {
    si("Reassign milestone to another team member");
  }

  void _addComment() {
    if (newComment.isNotEmpty) {
      Map<String, dynamic> comment = {
        "id": "comment${comments.length + 1}",
        "author": "Current User",
        "authorAvatar": "https://picsum.photos/40/40?random=8",
        "content": newComment,
        "timestamp": DateTime.now().toString().substring(0, 19),
        "type": "update"
      };
      
      setState(() {
        comments.add(comment);
        newComment = "";
      });
      
      ss("Comment added successfully");
    }
  }

  void _addAttachment() {
    si("Add attachment to milestone");
  }
}
