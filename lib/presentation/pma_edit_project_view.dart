import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaEditProjectView extends StatefulWidget {
  const PmaEditProjectView({super.key});

  @override
  State<PmaEditProjectView> createState() => _PmaEditProjectViewState();
}

class _PmaEditProjectViewState extends State<PmaEditProjectView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  // Basic Information
  String projectName = "Mobile App Redesign";
  String description = "Complete redesign of the mobile application UI/UX with modern design principles and improved user experience";
  String client = "TechCorp Inc.";
  String selectedStatus = "in_progress";
  String selectedPriority = "high";
  
  // Timeline & Budget
  DateTime startDate = DateTime.parse("2025-05-01");
  DateTime dueDate = DateTime.parse("2025-07-15");
  String budget = "50000";
  
  // Team & Assignment
  String projectManager = "john_doe";
  List<String> selectedTeamMembers = ["sarah_johnson", "mike_chen", "alex_wilson"];
  
  // Additional Details
  String objectives = "Improve user experience and modernize the mobile app interface";
  String deliverables = "New UI designs, updated mobile app, user testing results";
  String risks = "Tight timeline, resource constraints, user adoption challenges";
  List<String> attachments = [
    "https://picsum.photos/400/300?random=1",
    "https://picsum.photos/400/300?random=2",
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "Planning", "value": "planning"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Review", "value": "review"},
    {"label": "Completed", "value": "completed"},
    {"label": "On Hold", "value": "on_hold"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
  ];

  List<Map<String, dynamic>> managerItems = [
    {"label": "John Doe", "value": "john_doe"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Chen", "value": "mike_chen"},
    {"label": "Emily Davis", "value": "emily_davis"},
  ];

  List<Map<String, dynamic>> teamMemberItems = [
    {"label": "Alex Wilson", "value": "alex_wilson", "checked": true},
    {"label": "Lisa Brown", "value": "lisa_brown", "checked": false},
    {"label": "David Lee", "value": "david_lee", "checked": false},
    {"label": "Jessica Kim", "value": "jessica_kim", "checked": false},
    {"label": "Tom Garcia", "value": "tom_garcia", "checked": false},
    {"label": "Amy Liu", "value": "amy_liu", "checked": false},
    {"label": "Chris Taylor", "value": "chris_taylor", "checked": false},
    {"label": "Rachel Green", "value": "rachel_green", "checked": false},
    {"label": "Sarah Johnson", "value": "sarah_johnson", "checked": true},
    {"label": "Mike Chen", "value": "mike_chen", "checked": true},
  ];

  void _updateProject() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Project updated successfully");
    back();
  }

  void _deleteProject() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this project? This action cannot be undone.");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Project deleted successfully");
    back();
  }

  void _archiveProject() async {
    bool isConfirmed = await confirm("Are you sure you want to archive this project?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    ss("Project archived successfully");
  }

  Widget _buildBasicInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Project Name",
            value: projectName,
            validator: Validator.required,
            hint: "Enter project name",
            onChanged: (value) {
              projectName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Description",
            value: description,
            validator: Validator.required,
            hint: "Describe the project goals and scope",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Client",
            value: client,
            hint: "Client or company name",
            onChanged: (value) {
              client = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: selectedStatus,
                  validator: Validator.required,
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
                  items: priorityItems,
                  value: selectedPriority,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineBudgetSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Timeline & Budget",
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
                child: QDatePicker(
                  label: "Start Date",
                  value: startDate,
                  onChanged: (value) {
                    startDate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "Due Date",
                  value: dueDate,
                  onChanged: (value) {
                    dueDate = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QNumberField(
            label: "Budget (\$)",
            value: budget,
            hint: "Enter project budget",
            onChanged: (value) {
              budget = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Team Assignment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Project Manager",
            items: managerItems,
            value: projectManager,
            validator: Validator.required,
            onChanged: (value, label) {
              projectManager = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            label: "Team Members",
            items: teamMemberItems,
            value: teamMemberItems.where((item) => item["checked"] == true).toList(),
            onChanged: (values, ids) {
              // Update checked status
              for (var item in teamMemberItems) {
                item["checked"] = values.any((v) => v["value"] == item["value"]);
              }
              selectedTeamMembers = values.map((v) => v["value"] as String).toList();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalDetailsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Project Objectives",
            value: objectives,
            hint: "List the main objectives and goals",
            onChanged: (value) {
              objectives = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Deliverables",
            value: deliverables,
            hint: "List expected deliverables and outcomes",
            onChanged: (value) {
              deliverables = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Risks & Challenges",
            value: risks,
            hint: "Identify potential risks and mitigation strategies",
            onChanged: (value) {
              risks = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMultiImagePicker(
            label: "Project Attachments",
            value: attachments,
            hint: "Upload relevant documents and files",
            maxImages: 10,
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Project Actions",
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
                  label: "Archive Project",
                  size: bs.sm,
                  onPressed: _archiveProject,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _deleteProject,
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: Text(
                          "Delete Project",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Project"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              //navigateTo('PmaProjectDetailView')
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [warningColor, warningColor.withAlpha(180)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.edit,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Edit Project",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Update project details, team members, and settings",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildBasicInfoSection(),
                    _buildTimelineBudgetSection(),
                    _buildTeamSection(),
                    _buildAdditionalDetailsSection(),
                    _buildActionSection(),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Update Project",
                        size: bs.md,
                        onPressed: _updateProject,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: warningColor.withAlpha(50),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_outlined,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Changes will be saved and all team members will be notified of the updates.",
                              style: TextStyle(
                                fontSize: 14,
                                color: warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
