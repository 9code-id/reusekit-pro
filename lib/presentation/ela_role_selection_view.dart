import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaRoleSelectionView extends StatefulWidget {
  const ElaRoleSelectionView({super.key});

  @override
  State<ElaRoleSelectionView> createState() => _ElaRoleSelectionViewState();
}

class _ElaRoleSelectionViewState extends State<ElaRoleSelectionView> {
  String selectedRole = "";

  List<Map<String, dynamic>> roles = [
    {
      "id": "student",
      "title": "Student",
      "description": "Access courses, assignments, and track your learning progress",
      "icon": Icons.school,
      "features": [
        "Access to course materials",
        "Submit assignments",
        "Track progress and grades",
        "Join discussion forums",
        "Take quizzes and exams",
      ],
      "color": primaryColor,
    },
    {
      "id": "teacher",
      "title": "Teacher",
      "description": "Create courses, manage students, and track their performance",
      "icon": Icons.person_2,
      "features": [
        "Create and manage courses",
        "Upload learning materials",
        "Create assignments and quizzes",
        "Grade student submissions",
        "Monitor student progress",
      ],
      "color": successColor,
    },
    {
      "id": "parent",
      "title": "Parent",
      "description": "Monitor your child's learning progress and communicate with teachers",
      "icon": Icons.family_restroom,
      "features": [
        "View child's progress",
        "Communicate with teachers",
        "Access grade reports",
        "Receive notifications",
        "Schedule parent-teacher meetings",
      ],
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spXl),
            
            // Header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.group,
                      size: 50,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Choose Your Role",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Select your role to customize your learning experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spXl),

            // Role Options
            Text(
              "Available Roles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            ...roles.map((role) => GestureDetector(
              onTap: () {
                selectedRole = role["id"];
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: selectedRole == role["id"]
                    ? Border.all(color: role["color"] as Color, width: 2)
                    : Border.all(color: disabledOutlineBorderColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (role["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            role["icon"] as IconData,
                            size: 32,
                            color: role["color"] as Color,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${role["title"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${role["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (selectedRole == role["id"])
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: role["color"] as Color,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Key Features:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(role["features"] as List<String>).map((feature) => Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: role["color"] as Color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            )),

            SizedBox(height: spLg),

            // Continue Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue as ${_getRoleTitle()}",
                size: bs.md,
                onPressed: selectedRole.isNotEmpty ? () {
                  _handleRoleSelection();
                } : null,
              ),
            ),
            SizedBox(height: spMd),

            // Skip for now
            Center(
              child: GestureDetector(
                onTap: () {
                  _showSkipDialog();
                },
                child: Text(
                  "Skip for now",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: spLg),

            // Additional Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: infoColor.withAlpha(40),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Good to Know",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• You can change your role later in settings\n• Each role has different permissions and features\n• Teachers and parents may require additional verification\n• Students have immediate access to all learning features",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }

  String _getRoleTitle() {
    if (selectedRole.isEmpty) return "Role";
    return roles.firstWhere((role) => role["id"] == selectedRole)["title"];
  }

  void _handleRoleSelection() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    switch (selectedRole) {
      case "student":
        // navigateTo(ElaStudentProfileView())
        break;
      case "teacher":
        // navigateTo(ElaTeacherProfileView())
        break;
      case "parent":
        // navigateTo(ElaParentProfileView())
        break;
    }
    
    ss("Role selected successfully! Setting up your profile...");
  }

  void _showSkipDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Skip Role Selection?",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "You can select your role later, but some features may be limited until you do.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spLg),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    color: disabledColor,
                    size: bs.md,
                    onPressed: () {
                      back();
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Skip",
                    size: bs.md,
                    onPressed: () {
                      back();
                      // navigateTo(ElaHomeView())
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],
        ),
      ),
    );
  }
}
