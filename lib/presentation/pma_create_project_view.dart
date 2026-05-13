import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaCreateProjectView extends StatefulWidget {
  const PmaCreateProjectView({super.key});

  @override
  State<PmaCreateProjectView> createState() => _PmaCreateProjectViewState();
}

class _PmaCreateProjectViewState extends State<PmaCreateProjectView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  // Basic Information
  String projectName = "";
  String description = "";
  String client = "";
  String selectedStatus = "planning";
  String selectedPriority = "medium";
  
  // Timeline & Budget
  DateTime startDate = DateTime.now();
  DateTime dueDate = DateTime.now().add(Duration(days: 30));
  String budget = "";
  
  // Team & Assignment
  String projectManager = "";
  List<String> selectedTeamMembers = [];
  
  // Additional Details
  String objectives = "";
  String deliverables = "";
  String risks = "";
  List<String> attachments = [];

  List<Map<String, dynamic>> statusItems = [
    {"label": "Planning", "value": "planning"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Review", "value": "review"},
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
    {"label": "Alex Wilson", "value": "alex_wilson", "checked": false},
    {"label": "Lisa Brown", "value": "lisa_brown", "checked": false},
    {"label": "David Lee", "value": "david_lee", "checked": false},
    {"label": "Jessica Kim", "value": "jessica_kim", "checked": false},
    {"label": "Tom Garcia", "value": "tom_garcia", "checked": false},
    {"label": "Amy Liu", "value": "amy_liu", "checked": false},
    {"label": "Chris Taylor", "value": "chris_taylor", "checked": false},
    {"label": "Rachel Green", "value": "rachel_green", "checked": false},
  ];

  void _createProject() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Project created successfully");
    back();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Project"),
        centerTitle: true,
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
                          colors: [primaryColor, primaryColor.withAlpha(180)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Create New Project",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Set up a new project with team members and deliverables",
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
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Create Project",
                        size: bs.md,
                        onPressed: _createProject,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: infoColor.withAlpha(50),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "You can edit project details and add more team members after creation.",
                              style: TextStyle(
                                fontSize: 14,
                                color: infoColor,
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
