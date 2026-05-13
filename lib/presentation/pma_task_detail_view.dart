import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTaskDetailView extends StatefulWidget {
  const PmaTaskDetailView({super.key});

  @override
  State<PmaTaskDetailView> createState() => _PmaTaskDetailViewState();
}

class _PmaTaskDetailViewState extends State<PmaTaskDetailView> {
  int currentTab = 0;
  String newComment = "";
  
  Map<String, dynamic> taskData = {
    "id": 1,
    "title": "Implement User Authentication",
    "description": "Develop secure user authentication system with JWT tokens and password encryption. This includes login, logout, password reset, and session management features.",
    "project": "E-commerce Platform",
    "assignee": "John Smith",
    "creator": "Sarah Wilson",
    "priority": "High",
    "status": "In Progress",
    "dueDate": "2024-06-20",
    "createdDate": "2024-06-01",
    "lastUpdated": "2024-06-15",
    "progress": 75,
    "estimatedHours": 40,
    "actualHours": 30,
    "remainingHours": 10,
    "category": "Backend",
    "labels": ["authentication", "security", "jwt", "backend"],
    "subtasks": [
      {
        "id": 1,
        "title": "Setup JWT library",
        "completed": true,
        "completedDate": "2024-06-03",
        "assignee": "John Smith",
      },
      {
        "id": 2,
        "title": "Create login endpoint",
        "completed": true,
        "completedDate": "2024-06-05",
        "assignee": "John Smith",
      },
      {
        "id": 3,
        "title": "Implement password hashing",
        "completed": true,
        "completedDate": "2024-06-08",
        "assignee": "John Smith",
      },
      {
        "id": 4,
        "title": "Add refresh token logic",
        "completed": false,
        "assignee": "John Smith",
      },
      {
        "id": 5,
        "title": "Write unit tests",
        "completed": false,
        "assignee": "John Smith",
      },
      {
        "id": 6,
        "title": "Integration testing",
        "completed": false,
        "assignee": "John Smith",
      },
    ],
    "attachments": [
      {
        "id": 1,
        "name": "authentication_flow.pdf",
        "type": "PDF",
        "size": "2.5 MB",
        "uploadedBy": "Sarah Wilson",
        "uploadedDate": "2024-06-02",
      },
      {
        "id": 2,
        "name": "jwt_implementation.md",
        "type": "Markdown",
        "size": "156 KB",
        "uploadedBy": "John Smith",
        "uploadedDate": "2024-06-05",
      },
      {
        "id": 3,
        "name": "security_requirements.docx",
        "type": "Document",
        "size": "890 KB",
        "uploadedBy": "Security Team",
        "uploadedDate": "2024-06-01",
      },
    ],
    "comments": [
      {
        "id": 1,
        "author": "Sarah Wilson",
        "message": "Please make sure to follow the security guidelines provided in the attached document.",
        "timestamp": "2024-06-02 09:30:00",
        "edited": false,
      },
      {
        "id": 2,
        "author": "John Smith",
        "message": "JWT library has been successfully integrated. Login endpoint is working as expected.",
        "timestamp": "2024-06-05 14:15:00",
        "edited": false,
      },
      {
        "id": 3,
        "author": "Security Team",
        "message": "Looks good so far. Please ensure password hashing uses bcrypt with salt rounds >= 12.",
        "timestamp": "2024-06-06 11:20:00",
        "edited": false,
      },
      {
        "id": 4,
        "author": "John Smith",
        "message": "Password hashing implemented with bcrypt and 12 salt rounds. Moving on to refresh token logic.",
        "timestamp": "2024-06-08 16:45:00",
        "edited": false,
      },
      {
        "id": 5,
        "author": "Michael Chen",
        "message": "Great progress! Let me know if you need help with the refresh token implementation.",
        "timestamp": "2024-06-10 10:30:00",
        "edited": false,
      },
    ],
    "timeLog": [
      {
        "date": "2024-06-03",
        "hours": 6,
        "description": "Setup JWT library and initial configuration",
        "user": "John Smith",
      },
      {
        "date": "2024-06-04",
        "hours": 4,
        "description": "Research best practices for JWT implementation",
        "user": "John Smith",
      },
      {
        "date": "2024-06-05",
        "hours": 8,
        "description": "Implemented login endpoint with basic authentication",
        "user": "John Smith",
      },
      {
        "date": "2024-06-06",
        "hours": 2,
        "description": "Code review and documentation",
        "user": "John Smith",
      },
      {
        "date": "2024-06-08",
        "hours": 6,
        "description": "Implemented secure password hashing with bcrypt",
        "user": "John Smith",
      },
      {
        "date": "2024-06-12",
        "hours": 4,
        "description": "Started work on refresh token logic",
        "user": "John Smith",
      },
    ]
  };

  Widget _buildTaskHeader() {
    Color statusColor = _getStatusColor(taskData["status"]);
    Color priorityColor = _getPriorityColor(taskData["priority"]);
    bool isOverdue = DateTime.parse(taskData["dueDate"]).isBefore(DateTime.now()) && taskData["status"] != "Done";

    return Container(
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
                child: Text(
                  "${taskData["title"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
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
                  "${taskData["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${taskData["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              _buildInfoItem("Project", "${taskData["project"]}", Icons.business),
              SizedBox(width: spLg),
              _buildInfoItem("Assignee", "${taskData["assignee"]}", Icons.person),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildInfoItem("Due Date", "${DateTime.parse(taskData["dueDate"]).dMMMy}", Icons.schedule),
              SizedBox(width: spLg),
              _buildInfoItem("Priority", "${taskData["priority"]}", Icons.flag),
            ],
          ),
          SizedBox(height: spLg),
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
                      height: 8,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (taskData["progress"] as int) / 100,
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
                "${taskData["progress"]}%",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              _buildTimeInfo("Estimated", "${taskData["estimatedHours"]}h", primaryColor),
              SizedBox(width: spMd),
              _buildTimeInfo("Actual", "${taskData["actualHours"]}h", warningColor),
              SizedBox(width: spMd),
              _buildTimeInfo("Remaining", "${taskData["remainingHours"]}h", infoColor),
            ],
          ),
          if ((taskData["labels"] as List).isNotEmpty) ...[
            SizedBox(height: spLg),
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: (taskData["labels"] as List).map((label) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "#$label",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
          ],
          SizedBox(height: spLg),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Task",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('PmaEditTaskView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {
                  ss("Task shared successfully!");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  //showTaskOptions
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: disabledBoldColor,
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
                value,
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
    );
  }

  Widget _buildTimeInfo(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtasks() {
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
                "Subtasks (${(taskData["subtasks"] as List).where((st) => st["completed"]).length}/${(taskData["subtasks"] as List).length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //addSubtask
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...(taskData["subtasks"] as List).map((subtask) => _buildSubtaskItem(subtask)),
        ],
      ),
    );
  }

  Widget _buildSubtaskItem(Map<String, dynamic> subtask) {
    bool isCompleted = subtask["completed"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isCompleted ? successColor.withAlpha(10) : primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isCompleted ? successColor.withAlpha(30) : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              subtask["completed"] = !subtask["completed"];
              if (subtask["completed"]) {
                subtask["completedDate"] = DateTime.now().toString().split(' ')[0];
              } else {
                subtask["completedDate"] = null;
              }
              setState(() {});
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCompleted ? successColor : Colors.transparent,
                border: Border.all(
                  color: isCompleted ? successColor : disabledBoldColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: isCompleted
                  ? Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${subtask["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (subtask["completedDate"] != null) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Completed on ${DateTime.parse(subtask["completedDate"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              //editSubtask
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttachments() {
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
                "Attachments (${(taskData["attachments"] as List).length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //addAttachment
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...(taskData["attachments"] as List).map((attachment) => _buildAttachmentItem(attachment)),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(Map<String, dynamic> attachment) {
    IconData fileIcon = _getFileIcon(attachment["type"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(
            fileIcon,
            color: primaryColor,
            size: 24,
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
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${attachment["size"]} • Uploaded by ${attachment["uploadedBy"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "on ${DateTime.parse(attachment["uploadedDate"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Downloading ${attachment["name"]}...");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              //showAttachmentOptions
            },
          ),
        ],
      ),
    );
  }

  Widget _buildComments() {
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
          Text(
            "Comments (${(taskData["comments"] as List).length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Add a comment...",
            value: newComment,
            onChanged: (value) {
              newComment = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Post Comment",
              size: bs.sm,
              onPressed: () {
                if (newComment.isNotEmpty) {
                  (taskData["comments"] as List).add({
                    "id": (taskData["comments"] as List).length + 1,
                    "author": "Current User",
                    "message": newComment,
                    "timestamp": DateTime.now().toString(),
                    "edited": false,
                  });
                  newComment = "";
                  setState(() {});
                  ss("Comment posted successfully!");
                }
              },
            ),
          ),
          SizedBox(height: spLg),
          ...(taskData["comments"] as List).reversed.map((comment) => _buildCommentItem(comment)),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: primaryColor,
                child: Text(
                  "${comment["author"]}".split(" ").map((n) => n[0]).join(""),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${comment["author"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(comment["timestamp"]).dMMMy} at ${DateTime.parse(comment["timestamp"]).toString().split(' ')[1].substring(0, 5)}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (comment["edited"] as bool)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spXs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "EDITED",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${comment["message"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeLog() {
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
          Text(
            "Time Log",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...(taskData["timeLog"] as List).map((log) => _buildTimeLogItem(log)),
        ],
      ),
    );
  }

  Widget _buildTimeLogItem(Map<String, dynamic> log) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${log["hours"]}h",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${log["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${DateTime.parse(log["date"]).dMMMy} • ${log["user"]}",
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
    );
  }

  IconData _getFileIcon(String type) {
    switch (type.toLowerCase()) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "markdown":
        return Icons.description;
      case "document":
        return Icons.insert_drive_file;
      case "image":
        return Icons.image;
      default:
        return Icons.attach_file;
    }
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
    return QTabBar(
      title: "Task Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "Subtasks", icon: Icon(Icons.checklist)),
        Tab(text: "Files", icon: Icon(Icons.attach_file)),
        Tab(text: "Comments", icon: Icon(Icons.comment)),
        Tab(text: "Time Log", icon: Icon(Icons.access_time)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTaskHeader(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSubtasks(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAttachments(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildComments(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTimeLog(),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
