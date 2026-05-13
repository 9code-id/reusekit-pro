import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome5View extends StatefulWidget {
  @override
  State<GrlWelcome5View> createState() => _GrlWelcome5ViewState();
}

class _GrlWelcome5ViewState extends State<GrlWelcome5View> {
  String fullName = "";
  String email = "";
  String company = "";
  String role = "";
  List<String> selectedInterests = [];
  
  final List<Map<String, dynamic>> interests = [
    {"label": "Design", "icon": Icons.palette, "selected": false},
    {"label": "Development", "icon": Icons.code, "selected": false},
    {"label": "Marketing", "icon": Icons.campaign, "selected": false},
    {"label": "Analytics", "icon": Icons.analytics, "selected": false},
    {"label": "Sales", "icon": Icons.trending_up, "selected": false},
    {"label": "Management", "icon": Icons.business, "selected": false},
    {"label": "Finance", "icon": Icons.account_balance, "selected": false},
    {"label": "Support", "icon": Icons.support_agent, "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Setup"),
        actions: [
          GestureDetector(
            onTap: () {
              // navigateTo('');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Tell us about yourself",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Help us personalize your experience by sharing some basic information.",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Personal Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Personal Information",
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
                    label: "Full Name",
                    value: fullName,
                    hint: "Enter your full name",
                    onChanged: (value) {
                      fullName = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Email Address",
                    value: email,
                    hint: "Enter your email address",
                    onChanged: (value) {
                      email = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Work Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Work Information",
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
                    label: "Company (Optional)",
                    value: company,
                    hint: "Enter your company name",
                    onChanged: (value) {
                      company = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Role (Optional)",
                    value: role,
                    hint: "Enter your job title",
                    onChanged: (value) {
                      role = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Interests
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Your Interests",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Select areas that interest you most (optional)",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: interests.map((interest) {
                      final isSelected = selectedInterests.contains(interest["label"]);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedInterests.remove(interest["label"]);
                          } else {
                            selectedInterests.add(interest["label"]);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                interest["icon"],
                                size: 16,
                                color: isSelected ? Colors.white : disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${interest["label"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Progress Indicator
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile Completion",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${_calculateProgress()}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                Container(
                  width: double.infinity,
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _calculateProgress() / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: sp2xl),
            
            // Action Button
            QButton(
              label: "Complete Setup",
              size: bs.md,
              onPressed: () {
                // navigateTo('');
              },
            ),
            
            SizedBox(height: spSm),
            
            Container(
              width: double.infinity,
              child: Text(
                "You can update this information later in your profile settings.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
  
  int _calculateProgress() {
    int progress = 0;
    if (fullName.isNotEmpty) progress += 30;
    if (email.isNotEmpty) progress += 30;
    if (company.isNotEmpty) progress += 15;
    if (role.isNotEmpty) progress += 15;
    if (selectedInterests.isNotEmpty) progress += 10;
    return progress;
  }
}
