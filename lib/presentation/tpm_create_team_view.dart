import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmCreateTeamView extends StatefulWidget {
  const TpmCreateTeamView({super.key});

  @override
  State<TpmCreateTeamView> createState() => _TpmCreateTeamViewState();
}

class _TpmCreateTeamViewState extends State<TpmCreateTeamView> {
  final formKey = GlobalKey<FormState>();
  
  String teamName = "";
  String description = "";
  String department = "";
  String location = "";
  String workingHours = "9:00 AM - 6:00 PM";
  String timezone = "EST";
  String teamLead = "";
  double budget = 0.0;
  List<String> selectedMembers = [];
  List<String> teamSkills = [];
  List<String> attachments = [];
  
  bool isEditMode = false;
  String newSkill = "";

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Design", "value": "Design"},
    {"label": "Product Management", "value": "Product Management"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Analytics", "value": "Analytics"},
    {"label": "Human Resources", "value": "Human Resources"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "New York Office", "value": "New York"},
    {"label": "San Francisco Office", "value": "San Francisco"},
    {"label": "Austin Office", "value": "Austin"},
    {"label": "Seattle Office", "value": "Seattle"},
    {"label": "Boston Office", "value": "Boston"},
    {"label": "Los Angeles Office", "value": "Los Angeles"},
    {"label": "Remote", "value": "Remote"},
    {"label": "Hybrid", "value": "Hybrid"},
  ];

  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "EST (Eastern)", "value": "EST"},
    {"label": "CST (Central)", "value": "CST"},
    {"label": "MST (Mountain)", "value": "MST"},
    {"label": "PST (Pacific)", "value": "PST"},
    {"label": "UTC", "value": "UTC"},
  ];

  List<Map<String, dynamic>> teamLeadOptions = [
    {"label": "Alice Johnson", "value": "alice_johnson"},
    {"label": "Bob Smith", "value": "bob_smith"},
    {"label": "Charlie Brown", "value": "charlie_brown"},
    {"label": "Diana Wilson", "value": "diana_wilson"},
    {"label": "Eve Davis", "value": "eve_davis"},
    {"label": "Frank Miller", "value": "frank_miller"},
  ];

  List<Map<String, dynamic>> availableMembers = [
    {"label": "John Doe", "value": "john_doe"},
    {"label": "Jane Smith", "value": "jane_smith"},
    {"label": "Mike Johnson", "value": "mike_johnson"},
    {"label": "Sarah Wilson", "value": "sarah_wilson"},
    {"label": "David Brown", "value": "david_brown"},
    {"label": "Lisa Davis", "value": "lisa_davis"},
    {"label": "Tom Miller", "value": "tom_miller"},
    {"label": "Amy Garcia", "value": "amy_garcia"},
    {"label": "Chris Martinez", "value": "chris_martinez"},
    {"label": "Emma Taylor", "value": "emma_taylor"},
  ];

  List<String> predefinedSkills = [
    "Flutter", "React Native", "iOS", "Android", "Firebase", "Node.js", 
    "Python", "Java", "TypeScript", "JavaScript", "Dart", "Swift", "Kotlin",
    "UI/UX Design", "Figma", "Adobe XD", "Sketch", "Photoshop", "Illustrator",
    "Project Management", "Agile", "Scrum", "Kanban", "DevOps", "CI/CD",
    "AWS", "Docker", "Kubernetes", "Testing", "QA", "Automation",
    "Machine Learning", "Data Analysis", "SQL", "Marketing", "SEO",
  ];

  void _addSkill() {
    if (newSkill.isNotEmpty && !teamSkills.contains(newSkill)) {
      setState(() {
        teamSkills.add(newSkill);
        newSkill = "";
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      teamSkills.remove(skill);
    });
  }

  void _saveTeam() async {
    if (formKey.currentState!.validate()) {
      if (teamSkills.isEmpty) {
        se("Please add at least one skill for the team");
        return;
      }
      
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss(isEditMode ? "Team updated successfully" : "Team created successfully");
      back();
    }
  }

  void _showSkillPicker() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 500),
          child: Column(
            children: [
              Text(
                "Select Skills",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: predefinedSkills.map((skill) {
                      bool isSelected = teamSkills.contains(skill);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              teamSkills.remove(skill);
                            } else {
                              teamSkills.add(skill);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledBoldColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: spSm),
              QButton(
                label: "Done",
                size: bs.sm,
                onPressed: () => back(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "Edit Team" : "Create New Team"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveTeam,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Basic Information
              Container(
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
                      label: "Team Name",
                      value: teamName,
                      hint: "Enter team name",
                      validator: Validator.required,
                      onChanged: (value) {
                        teamName = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe the team's purpose and responsibilities",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Department",
                            items: departmentOptions,
                            value: department,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              department = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Location",
                            items: locationOptions,
                            value: location,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              location = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Work Schedule
              Container(
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
                      "Work Schedule",
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
                            label: "Working Hours",
                            value: workingHours,
                            hint: "e.g., 9:00 AM - 6:00 PM",
                            onChanged: (value) {
                              workingHours = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Timezone",
                            items: timezoneOptions,
                            value: timezone,
                            onChanged: (value, label) {
                              timezone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Team Leadership
              Container(
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
                      "Team Leadership",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Team Lead",
                      items: teamLeadOptions,
                      value: teamLead,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        teamLead = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Budget
              Container(
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
                      "Budget Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QNumberField(
                      label: "Annual Budget (\$)",
                      value: budget.toString(),
                      hint: "Enter team budget",
                      validator: Validator.required,
                      onChanged: (value) {
                        budget = double.tryParse("$value") ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Team Members
              Container(
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
                        Text(
                          "Team Members (${selectedMembers.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Optional",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Select team members from available employees",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 200),
                      child: SingleChildScrollView(
                        child: Column(
                          children: availableMembers.map((member) {
                            bool isSelected = selectedMembers.contains(member["value"]);
                            return CheckboxListTile(
                              title: Text(
                                member["label"],
                                style: TextStyle(fontSize: 14),
                              ),
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedMembers.add(member["value"]);
                                  } else {
                                    selectedMembers.remove(member["value"]);
                                  }
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Skills & Technologies
              Container(
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
                        Text(
                          "Skills & Technologies",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Browse Skills",
                          size: bs.sm,
                          icon: Icons.list,
                          onPressed: _showSkillPicker,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Add Custom Skill",
                            value: newSkill,
                            hint: "Enter skill name",
                            onChanged: (value) {
                              newSkill = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add",
                          size: bs.sm,
                          onPressed: _addSkill,
                        ),
                      ],
                    ),
                    if (teamSkills.isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: teamSkills.map((skill) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  skill,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                GestureDetector(
                                  onTap: () => _removeSkill(skill),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    if (teamSkills.isEmpty)
                      Container(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          children: [
                            Icon(
                              Icons.code,
                              size: 48,
                              color: disabledColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "No skills added yet",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Add skills to define team capabilities",
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

              // Attachments
              Container(
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
                      "Team Documents",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QAttachmentPicker(
                      label: "Upload Documents",
                      value: attachments,
                      hint: "Attach team charter, guidelines, or other documents",
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: isEditMode ? "Update Team" : "Create Team",
                  size: bs.md,
                  onPressed: _saveTeam,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
