import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmCreateProjectView extends StatefulWidget {
  const TpmCreateProjectView({super.key});

  @override
  State<TpmCreateProjectView> createState() => _TpmCreateProjectViewState();
}

class _TpmCreateProjectViewState extends State<TpmCreateProjectView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Basic Information
  String projectName = "";
  String projectDescription = "";
  String selectedCategory = "Development";
  String selectedPriority = "medium";
  String selectedClient = "";

  // Timeline
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 90));

  // Budget
  String budgetAmount = "";
  String budgetCurrency = "USD";

  // Team
  String selectedManager = "";
  List<String> selectedTeamMembers = [];

  // Project Settings
  bool isPublic = false;
  bool allowComments = true;
  bool enableNotifications = true;
  bool autoAssignTasks = false;

  // Tags
  String newTag = "";
  List<String> projectTags = [];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Development", "value": "Development"},
    {"label": "Design", "value": "Design"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Research", "value": "Research"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Consulting", "value": "Consulting"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> currencyItems = [
    {"label": "USD (\$)", "value": "USD"},
    {"label": "EUR (€)", "value": "EUR"},
    {"label": "GBP (£)", "value": "GBP"},
    {"label": "JPY (¥)", "value": "JPY"},
  ];

  List<Map<String, dynamic>> clientOptions = [
    {"label": "TechCorp Inc.", "value": "TechCorp Inc."},
    {"label": "CreativeStudio", "value": "CreativeStudio"},
    {"label": "DataTech Solutions", "value": "DataTech Solutions"},
    {"label": "Marketing Pro", "value": "Marketing Pro"},
    {"label": "SecureCorpLtd", "value": "SecureCorpLtd"},
    {"label": "New Client", "value": "New Client"},
  ];

  List<Map<String, dynamic>> managerOptions = [
    {
      "label": "Sarah Johnson",
      "value": "sarah_johnson",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
      "role": "Senior Project Manager"
    },
    {
      "label": "Michael Chen",
      "value": "michael_chen",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
      "role": "Technical Lead"
    },
    {
      "label": "Emily Rodriguez",
      "value": "emily_rodriguez",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
      "role": "Creative Director"
    },
  ];

  List<Map<String, dynamic>> teamMemberOptions = [
    {
      "label": "Alex Thompson",
      "value": "alex_thompson",
      "avatar": "https://picsum.photos/40/40?random=10&keyword=man",
      "role": "Frontend Developer",
      "selected": false
    },
    {
      "label": "Maria Garcia",
      "value": "maria_garcia",
      "avatar": "https://picsum.photos/40/40?random=11&keyword=woman",
      "role": "UI Designer",
      "selected": false
    },
    {
      "label": "James Wilson",
      "value": "james_wilson",
      "avatar": "https://picsum.photos/40/40?random=12&keyword=man",
      "role": "Backend Developer",
      "selected": false
    },
    {
      "label": "Sophie Chen",
      "value": "sophie_chen",
      "avatar": "https://picsum.photos/40/40?random=13&keyword=woman",
      "role": "QA Engineer",
      "selected": false
    },
    {
      "label": "David Park",
      "value": "david_park",
      "avatar": "https://picsum.photos/40/40?random=14&keyword=man",
      "role": "DevOps Engineer",
      "selected": false
    },
    {
      "label": "Lisa Anderson",
      "value": "lisa_anderson",
      "avatar": "https://picsum.photos/40/40?random=15&keyword=woman",
      "role": "Business Analyst",
      "selected": false
    },
  ];

  Color getPriorityColor(String priority) {
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

  void _addTag() {
    if (newTag.trim().isNotEmpty && !projectTags.contains(newTag.trim())) {
      projectTags.add(newTag.trim());
      newTag = "";
      setState(() {});
    }
  }

  void _removeTag(String tag) {
    projectTags.remove(tag);
    setState(() {});
  }

  void _toggleTeamMember(String memberId) {
    int index = teamMemberOptions.indexWhere((member) => member["value"] == memberId);
    if (index != -1) {
      teamMemberOptions[index]["selected"] = !teamMemberOptions[index]["selected"];
      
      if (teamMemberOptions[index]["selected"]) {
        selectedTeamMembers.add(memberId);
      } else {
        selectedTeamMembers.remove(memberId);
      }
      setState(() {});
    }
  }

  void _createProject() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }

    if (selectedTeamMembers.isEmpty) {
      se("Please select at least one team member");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    // Create project logic would go here
    ss("Project '${projectName}' created successfully!");
    
    await Future.delayed(Duration(seconds: 1));
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Project"),
        actions: [
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: _createProject,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Section
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
                    Row(
                      children: [
                        Icon(Icons.info, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Basic Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    QTextField(
                      label: "Project Name",
                      value: projectName,
                      validator: Validator.required,
                      hint: "Enter project name...",
                      onChanged: (value) {
                        projectName = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "Project Description",
                      value: projectDescription,
                      validator: Validator.required,
                      hint: "Describe your project goals, scope, and requirements...",
                      onChanged: (value) {
                        projectDescription = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: categoryItems,
                            value: selectedCategory,
                            onChanged: (value, label) {
                              selectedCategory = value;
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
                            onChanged: (value, label) {
                              selectedPriority = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Client",
                      items: clientOptions,
                      value: selectedClient,
                      onChanged: (value, label) {
                        selectedClient = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Timeline Section
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
                    Row(
                      children: [
                        Icon(Icons.schedule, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Project Timeline",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
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
                              // Ensure end date is after start date
                              if (endDate.isBefore(startDate)) {
                                endDate = startDate.add(Duration(days: 30));
                              }
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
                              if (value.isAfter(startDate)) {
                                endDate = value;
                                setState(() {});
                              } else {
                                se("End date must be after start date");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: primaryColor, size: 16),
                          SizedBox(width: spSm),
                          Text(
                            "Project duration: ${endDate.difference(startDate).inDays} days",
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Budget Section
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
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Budget Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: QNumberField(
                            label: "Budget Amount",
                            value: budgetAmount,
                            validator: Validator.required,
                            hint: "Enter budget amount...",
                            onChanged: (value) {
                              budgetAmount = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Currency",
                            items: currencyItems,
                            value: budgetCurrency,
                            onChanged: (value, label) {
                              budgetCurrency = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Team Assignment Section
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
                    Row(
                      children: [
                        Icon(Icons.people, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Team Assignment",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    QDropdownField(
                      label: "Project Manager",
                      items: managerOptions,
                      value: selectedManager,
                      onChanged: (value, label) {
                        selectedManager = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Team Members:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...teamMemberOptions.map((member) {
                      bool isSelected = member["selected"] == true;
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: GestureDetector(
                          onTap: () => _toggleTeamMember("${member["value"]}"),
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage("${member["avatar"]}"),
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
                                        "${member["label"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? primaryColor : disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${member["role"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    if (selectedTeamMembers.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${selectedTeamMembers.length} team ${selectedTeamMembers.length == 1 ? 'member' : 'members'} selected",
                          style: TextStyle(
                            fontSize: 13,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Project Tags Section
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
                    Row(
                      children: [
                        Icon(Icons.label, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Project Tags",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Add Tag",
                            value: newTag,
                            hint: "Enter tag name...",
                            onChanged: (value) {
                              newTag = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: newTag.trim().isNotEmpty ? _addTag : null,
                        ),
                      ],
                    ),
                    if (projectTags.isNotEmpty)
                      Column(
                        children: [
                          SizedBox(height: spMd),
                          Wrap(
                            spacing: spSm,
                            runSpacing: spXs,
                            children: projectTags.map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      tag,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    GestureDetector(
                                      onTap: () => _removeTag(tag),
                                      child: Icon(
                                        Icons.close,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Project Settings Section
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
                    Row(
                      children: [
                        Icon(Icons.settings, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Project Settings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    QSwitch(
                      items: [
                        {
                          "label": "Make project public",
                          "value": true,
                          "checked": isPublic,
                        }
                      ],
                      value: [if (isPublic) {"label": "Make project public", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        if (values.isNotEmpty) {
                          isPublic = values.isNotEmpty;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: spXs),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow team comments",
                          "value": true,
                          "checked": allowComments,
                        }
                      ],
                      value: [if (allowComments) {"label": "Allow team comments", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        if (values.isNotEmpty) {
                          allowComments = values.isNotEmpty;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: spXs),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable email notifications",
                          "value": true,
                          "checked": enableNotifications,
                        }
                      ],
                      value: [if (enableNotifications) {"label": "Enable email notifications", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        if (values.isNotEmpty) {
                          enableNotifications = values.isNotEmpty;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: spXs),
                    QSwitch(
                      items: [
                        {
                          "label": "Auto-assign tasks to team members",
                          "value": true,
                          "checked": autoAssignTasks,
                        }
                      ],
                      value: [if (autoAssignTasks) {"label": "Auto-assign tasks to team members", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        if (values.isNotEmpty) {
                          autoAssignTasks = values.isNotEmpty;
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Project Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.summarize, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Project Summary",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    if (projectName.isNotEmpty)
                      Text(
                        "• Project: $projectName",
                        style: TextStyle(fontSize: 13, color: primaryColor),
                      ),
                    if (selectedCategory.isNotEmpty)
                      Text(
                        "• Category: $selectedCategory",
                        style: TextStyle(fontSize: 13, color: primaryColor),
                      ),
                    if (selectedPriority.isNotEmpty)
                      Text(
                        "• Priority: ${selectedPriority.toUpperCase()}",
                        style: TextStyle(fontSize: 13, color: getPriorityColor(selectedPriority)),
                      ),
                    Text(
                      "• Duration: ${endDate.difference(startDate).inDays} days",
                      style: TextStyle(fontSize: 13, color: primaryColor),
                    ),
                    if (budgetAmount.isNotEmpty)
                      Text(
                        "• Budget: $budgetAmount $budgetCurrency",
                        style: TextStyle(fontSize: 13, color: primaryColor),
                      ),
                    if (selectedTeamMembers.isNotEmpty)
                      Text(
                        "• Team: ${selectedTeamMembers.length} ${selectedTeamMembers.length == 1 ? 'member' : 'members'}",
                        style: TextStyle(fontSize: 13, color: primaryColor),
                      ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Create Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Project",
                  size: bs.md,
                  onPressed: _createProject,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
