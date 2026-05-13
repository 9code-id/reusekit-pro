import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmEditProjectView extends StatefulWidget {
  const TpmEditProjectView({super.key});

  @override
  State<TpmEditProjectView> createState() => _TpmEditProjectViewState();
}

class _TpmEditProjectViewState extends State<TpmEditProjectView> {
  final formKey = GlobalKey<FormState>();
  
  // Project basic info
  String projectName = "Mobile Banking App Redesign";
  String projectDescription = "Complete redesign of the mobile banking application to improve user experience and add new features including biometric authentication, investment tracking, and enhanced security measures.";
  String projectManager = "pm_001";
  String projectPriority = "High";
  String projectStatus = "In Progress";
  List<String> projectTags = ["mobile", "banking", "fintech", "ui-ux"];
  String newTag = "";
  
  // Timeline
  DateTime startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime endDate = DateTime.now().add(Duration(days: 60));
  int estimatedHours = 480;
  
  // Budget
  double totalBudget = 75000.0;
  double spentBudget = 35000.0;
  String currency = "USD";
  
  // Team
  List<String> selectedTeamMembers = ["member_001", "member_002", "member_003", "member_005"];
  
  // Settings
  bool isPublic = false;
  bool allowComments = true;
  bool sendNotifications = true;
  bool trackTime = true;
  String accessLevel = "Team Only";
  
  // Client info
  String clientName = "First National Bank";
  String clientContact = "sarah.johnson@fnb.com";
  
  // Data
  List<Map<String, dynamic>> teamMembers = [
    {
      "id": "member_001",
      "name": "Sarah Johnson",
      "email": "sarah.j@company.com",
      "role": "Product Manager",
      "avatar": "https://picsum.photos/100/100?random=21",
      "isSelected": true
    },
    {
      "id": "member_002", 
      "name": "Mike Chen",
      "email": "mike.c@company.com",
      "role": "Frontend Developer",
      "avatar": "https://picsum.photos/100/100?random=22",
      "isSelected": true
    },
    {
      "id": "member_003",
      "name": "Emily Davis",
      "email": "emily.d@company.com", 
      "role": "UI/UX Designer",
      "avatar": "https://picsum.photos/100/100?random=23",
      "isSelected": true
    },
    {
      "id": "member_004",
      "name": "Alex Rodriguez",
      "email": "alex.r@company.com",
      "role": "Backend Developer", 
      "avatar": "https://picsum.photos/100/100?random=24",
      "isSelected": false
    },
    {
      "id": "member_005",
      "name": "Lisa Wang",
      "email": "lisa.w@company.com",
      "role": "QA Engineer",
      "avatar": "https://picsum.photos/100/100?random=25",
      "isSelected": true
    },
    {
      "id": "member_006",
      "name": "David Kim",
      "email": "david.k@company.com",
      "role": "DevOps Engineer",
      "avatar": "https://picsum.photos/100/100?random=26",
      "isSelected": false
    }
  ];

  List<Map<String, dynamic>> projectManagers = [
    {"label": "Sarah Johnson", "value": "pm_001"},
    {"label": "Mike Chen", "value": "pm_002"}, 
    {"label": "Emily Davis", "value": "pm_003"},
    {"label": "Alex Rodriguez", "value": "pm_004"}
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Planning", "value": "Planning"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "On Hold", "value": "On Hold"},
    {"label": "Review", "value": "Review"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"}
  ];

  List<Map<String, dynamic>> accessLevelOptions = [
    {"label": "Public", "value": "Public"},
    {"label": "Team Only", "value": "Team Only"},
    {"label": "Managers Only", "value": "Managers Only"},
    {"label": "Private", "value": "Private"}
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD - US Dollar", "value": "USD"},
    {"label": "EUR - Euro", "value": "EUR"},
    {"label": "GBP - British Pound", "value": "GBP"},
    {"label": "JPY - Japanese Yen", "value": "JPY"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Project"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _saveProject,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              _buildBasicInfoSection(),
              _buildTimelineSection(),
              _buildBudgetSection(),
              _buildTeamSection(),
              _buildClientSection(),
              _buildTagsSection(),
              _buildSettingsSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
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
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Project Name",
            value: projectName,
            validator: Validator.required,
            onChanged: (value) {
              projectName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Project Description",
            value: projectDescription,
            validator: Validator.required,
            onChanged: (value) {
              projectDescription = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Project Manager",
                  items: projectManagers,
                  value: projectManager,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    projectManager = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityOptions,
                  value: projectPriority,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    projectPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Status", 
            items: statusOptions,
            value: projectStatus,
            validator: Validator.required,
            onChanged: (value, label) {
              projectStatus = value;
              setState(() {});
            },
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
            "Timeline & Duration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
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
                  label: "End Date",
                  value: endDate,
                  onChanged: (value) {
                    endDate = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Estimated Hours",
            value: estimatedHours.toString(),
            validator: Validator.required,
            onChanged: (value) {
              estimatedHours = int.tryParse(value) ?? 0;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Duration: ${endDate.difference(startDate).inDays} days",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Hours/Day: ${(estimatedHours / endDate.difference(startDate).inDays).toStringAsFixed(1)}",
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
    );
  }

  Widget _buildBudgetSection() {
    double remainingBudget = totalBudget - spentBudget;
    double spentPercentage = (spentBudget / totalBudget) * 100;

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
            "Budget & Costs",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QNumberField(
                  label: "Total Budget",
                  value: totalBudget.toString(),
                  validator: Validator.required,
                  onChanged: (value) {
                    totalBudget = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Currency",
                  items: currencyOptions,
                  value: currency,
                  onChanged: (value, label) {
                    currency = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Budget Overview",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${spentPercentage.toStringAsFixed(1)}% used",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: spentPercentage / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    spentPercentage > 80 ? dangerColor : 
                    spentPercentage > 60 ? warningColor : successColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Spent",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${spentBudget.currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Remaining",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${remainingBudget.currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
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

  Widget _buildTeamSection() {
    List<Map<String, dynamic>> selectedMembers = teamMembers.where((m) => selectedTeamMembers.contains(m["id"])).toList();
    
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Team Members",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Manage Team",
                size: bs.sm,
                onPressed: _showTeamSelectionSheet,
              ),
            ],
          ),
          if (selectedMembers.isNotEmpty) ...[
            Text(
              "${selectedMembers.length} members assigned",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: selectedMembers.map((member) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage("${member["avatar"]}"),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${member["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ] else ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Text(
                  "No team members assigned yet",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildClientSection() {
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
            "Client Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Client Name",
            value: clientName,
            onChanged: (value) {
              clientName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Client Contact",
            value: clientContact,
            onChanged: (value) {
              clientContact = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection() {
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
            "Project Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Add Tag",
                  value: newTag,
                  hint: "Enter tag name",
                  onChanged: (value) {
                    newTag = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add",
                size: bs.sm,
                onPressed: _addTag,
              ),
            ],
          ),
          if (projectTags.isNotEmpty) ...[
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: projectTags.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.tag,
                        size: 16,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        tag,
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () => _removeTag(tag),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
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
            "Project Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Access Level",
            items: accessLevelOptions,
            value: accessLevel,
            onChanged: (value, label) {
              accessLevel = value;
              setState(() {});
            },
          ),
          QSwitch(
            label: "Project Visibility",
            items: [
              {
                "label": "Make project public",
                "value": true,
                "checked": isPublic,
              }
            ],
            value: [if (isPublic) {"label": "Make project public", "value": true, "checked": true}],
            onChanged: (values, ids) {
              isPublic = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            label: "Communication Settings",
            items: [
              {
                "label": "Allow comments",
                "value": "comments",
                "checked": allowComments,
              },
              {
                "label": "Send notifications",
                "value": "notifications", 
                "checked": sendNotifications,
              }
            ],
            value: [
              if (allowComments) {"label": "Allow comments", "value": "comments", "checked": true},
              if (sendNotifications) {"label": "Send notifications", "value": "notifications", "checked": true}
            ],
            onChanged: (values, ids) {
              allowComments = values.any((v) => v["value"] == "comments");
              sendNotifications = values.any((v) => v["value"] == "notifications");
              setState(() {});
            },
          ),
          QSwitch(
            label: "Time Tracking",
            items: [
              {
                "label": "Enable time tracking for this project",
                "value": true,
                "checked": trackTime,
              }
            ],
            value: [if (trackTime) {"label": "Enable time tracking for this project", "value": true, "checked": true}],
            onChanged: (values, ids) {
              trackTime = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Update Project",
            onPressed: _saveProject,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Archive Project",
                color: warningColor,
                onPressed: _archiveProject,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Delete Project",
                color: dangerColor,
                onPressed: _deleteProject,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showTeamSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Team Members",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QButton(
                      label: "Done",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(spMd),
                  itemCount: teamMembers.length,
                  itemBuilder: (context, index) {
                    final member = teamMembers[index];
                    bool isSelected = selectedTeamMembers.contains(member["id"]);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${member["role"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${member["email"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isSelected) {
                                selectedTeamMembers.remove(member["id"]);
                              } else {
                                selectedTeamMembers.add(member["id"]);
                              }
                              setModalState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: isSelected ? primaryColor : Colors.grey[400]!,
                                ),
                              ),
                              child: Icon(
                                isSelected ? Icons.check : Icons.add,
                                color: isSelected ? Colors.white : Colors.grey[600],
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addTag() {
    if (newTag.trim().isNotEmpty && !projectTags.contains(newTag.trim().toLowerCase())) {
      projectTags.add(newTag.trim().toLowerCase());
      newTag = "";
      setState(() {});
    }
  }

  void _removeTag(String tag) {
    projectTags.remove(tag);
    setState(() {});
  }

  void _saveProject() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Project updated successfully!");
      back();
    }
  }

  void _archiveProject() async {
    bool isConfirmed = await confirm("Are you sure you want to archive this project? It will be moved to archived projects.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Project archived successfully!");
      back();
    }
  }

  void _deleteProject() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this project? This action cannot be undone.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Project deleted successfully!");
      back();
    }
  }
}
