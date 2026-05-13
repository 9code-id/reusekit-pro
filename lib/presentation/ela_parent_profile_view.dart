import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaParentProfileView extends StatefulWidget {
  const ElaParentProfileView({Key? key}) : super(key: key);

  @override
  State<ElaParentProfileView> createState() => _ElaParentProfileViewState();
}

class _ElaParentProfileViewState extends State<ElaParentProfileView> {
  final formKey = GlobalKey<FormState>();

  // Parent Information
  String parentName = "";
  String email = "";
  String phone = "";
  String occupation = "";
  String workplace = "";
  String profileImage = "";

  // Relationship Information
  String relationshipType = "Father";
  List<Map<String, dynamic>> relationshipOptions = [
    {"label": "Father", "value": "Father"},
    {"label": "Mother", "value": "Mother"},
    {"label": "Guardian", "value": "Guardian"},
    {"label": "Grandfather", "value": "Grandfather"},
    {"label": "Grandmother", "value": "Grandmother"},
    {"label": "Uncle", "value": "Uncle"},
    {"label": "Aunt", "value": "Aunt"},
    {"label": "Other", "value": "Other"},
  ];

  // Children Information
  List<Map<String, dynamic>> children = [];
  String childName = "";
  String childGrade = "Grade 1";
  String childSchool = "";
  List<Map<String, dynamic>> gradeOptions = [
    {"label": "Kindergarten", "value": "Kindergarten"},
    {"label": "Grade 1", "value": "Grade 1"},
    {"label": "Grade 2", "value": "Grade 2"},
    {"label": "Grade 3", "value": "Grade 3"},
    {"label": "Grade 4", "value": "Grade 4"},
    {"label": "Grade 5", "value": "Grade 5"},
    {"label": "Grade 6", "value": "Grade 6"},
    {"label": "Grade 7", "value": "Grade 7"},
    {"label": "Grade 8", "value": "Grade 8"},
    {"label": "Grade 9", "value": "Grade 9"},
    {"label": "Grade 10", "value": "Grade 10"},
    {"label": "Grade 11", "value": "Grade 11"},
    {"label": "Grade 12", "value": "Grade 12"},
  ];

  // Notification Preferences
  bool progressReports = true;
  bool assignmentDeadlines = true;
  bool teacherMessages = true;
  bool eventReminders = true;
  bool attendanceAlerts = true;
  bool gradeUpdates = true;

  // Emergency Contact
  String emergencyContactName = "";
  String emergencyContactPhone = "";
  String emergencyContactRelation = "";

  bool loading = false;

  void _addChild() {
    if (childName.isNotEmpty && childSchool.isNotEmpty) {
      children.add({
        "name": childName,
        "grade": childGrade,
        "school": childSchool,
      });
      childName = "";
      childGrade = "Grade 1";
      childSchool = "";
      setState(() {});
      ss("Child added successfully");
    } else {
      se("Please fill all child information");
    }
  }

  void _removeChild(int index) {
    children.removeAt(index);
    setState(() {});
    ss("Child removed");
  }

  Future<void> _saveProfile() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(seconds: 2));

      loading = false;
      setState(() {});

      ss("Parent profile created successfully!");
      //navigateTo Dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parent Profile Setup"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () async {
              await confirm(
                  "Create a comprehensive parent profile to monitor your children's educational progress, communicate with teachers, and stay updated on school activities.");
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
                  spacing: spSm,
                  children: [
                    // Profile Image Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          QImagePicker(
                            label: "Profile Photo",
                            value: profileImage,
                            hint: "Upload your profile picture",
                            helper: "This will help teachers identify you",
                            onChanged: (value) {
                              profileImage = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Personal Information Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
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
                            "Personal Information",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          QTextField(
                            label: "Full Name *",
                            value: parentName,
                            hint: "Enter your full name",
                            validator: Validator.required,
                            onChanged: (value) {
                              parentName = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Email Address *",
                            value: email,
                            hint: "Enter your email address",
                            validator: Validator.email,
                            onChanged: (value) {
                              email = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Phone Number *",
                            value: phone,
                            hint: "Enter your phone number",
                            validator: Validator.required,
                            onChanged: (value) {
                              phone = value;
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Relationship to Child *",
                            items: relationshipOptions,
                            value: relationshipType,
                            onChanged: (value, label) {
                              relationshipType = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Occupation",
                            value: occupation,
                            hint: "Enter your occupation",
                            onChanged: (value) {
                              occupation = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Workplace",
                            value: workplace,
                            hint: "Enter your workplace",
                            onChanged: (value) {
                              workplace = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Children Information Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
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
                                  "Children Information",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              QButton(
                                label: "Add Child",
                                icon: Icons.add,
                                size: bs.sm,
                                onPressed: _addChild,
                              ),
                            ],
                          ),
                          QTextField(
                            label: "Child's Full Name",
                            value: childName,
                            hint: "Enter child's full name",
                            onChanged: (value) {
                              childName = value;
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Grade Level",
                            items: gradeOptions,
                            value: childGrade,
                            onChanged: (value, label) {
                              childGrade = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "School Name",
                            value: childSchool,
                            hint: "Enter school name",
                            onChanged: (value) {
                              childSchool = value;
                              setState(() {});
                            },
                          ),
                          if (children.isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Text(
                              "Added Children (${children.length})",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            ...children.asMap().entries.map((entry) {
                              final index = entry.key;
                              final child = entry.value;
                              return Container(
                                padding: EdgeInsets.all(spSm),
                                margin: EdgeInsets.only(top: spXs),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: disabledOutlineBorderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.child_care,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${child["name"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "${child["grade"]} • ${child["school"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _removeChild(index),
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: dangerColor,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ],
                      ),
                    ),

                    // Emergency Contact Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
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
                            "Emergency Contact",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          QTextField(
                            label: "Emergency Contact Name",
                            value: emergencyContactName,
                            hint: "Enter emergency contact name",
                            onChanged: (value) {
                              emergencyContactName = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Emergency Contact Phone",
                            value: emergencyContactPhone,
                            hint: "Enter emergency contact phone",
                            onChanged: (value) {
                              emergencyContactPhone = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Relationship",
                            value: emergencyContactRelation,
                            hint: "Enter relationship to emergency contact",
                            onChanged: (value) {
                              emergencyContactRelation = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Notification Preferences Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
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
                            "Notification Preferences",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Choose what notifications you'd like to receive",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          QSwitch(
                            items: [
                              {
                                "label": "Progress Reports",
                                "value": "progress_reports",
                                "checked": progressReports,
                              }
                            ],
                            value: [
                              if (progressReports)
                                {
                                  "label": "Progress Reports",
                                  "value": "progress_reports",
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              progressReports = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                          QSwitch(
                            items: [
                              {
                                "label": "Assignment Deadlines",
                                "value": "assignment_deadlines",
                                "checked": assignmentDeadlines,
                              }
                            ],
                            value: [
                              if (assignmentDeadlines)
                                {
                                  "label": "Assignment Deadlines",
                                  "value": "assignment_deadlines",
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              assignmentDeadlines = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                          QSwitch(
                            items: [
                              {
                                "label": "Teacher Messages",
                                "value": "teacher_messages",
                                "checked": teacherMessages,
                              }
                            ],
                            value: [
                              if (teacherMessages)
                                {
                                  "label": "Teacher Messages",
                                  "value": "teacher_messages",
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              teacherMessages = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                          QSwitch(
                            items: [
                              {
                                "label": "Event Reminders",
                                "value": "event_reminders",
                                "checked": eventReminders,
                              }
                            ],
                            value: [
                              if (eventReminders)
                                {
                                  "label": "Event Reminders",
                                  "value": "event_reminders",
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              eventReminders = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                          QSwitch(
                            items: [
                              {
                                "label": "Attendance Alerts",
                                "value": "attendance_alerts",
                                "checked": attendanceAlerts,
                              }
                            ],
                            value: [
                              if (attendanceAlerts)
                                {
                                  "label": "Attendance Alerts",
                                  "value": "attendance_alerts",
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              attendanceAlerts = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                          QSwitch(
                            items: [
                              {
                                "label": "Grade Updates",
                                "value": "grade_updates",
                                "checked": gradeUpdates,
                              }
                            ],
                            value: [
                              if (gradeUpdates)
                                {
                                  "label": "Grade Updates",
                                  "value": "grade_updates",
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              gradeUpdates = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Privacy & Terms Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
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
                            "Privacy & Terms",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: infoColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.security,
                                      color: infoColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Data Privacy Notice",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "By creating a parent profile, you consent to the processing of your personal data and your children's educational information in accordance with our Privacy Policy.",
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

                    // Save Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Complete Profile Setup",
                        size: bs.md,
                        onPressed: _saveProfile,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
