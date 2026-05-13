import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmSkillMatrixView extends StatefulWidget {
  const FsmSkillMatrixView({super.key});

  @override
  State<FsmSkillMatrixView> createState() => _FsmSkillMatrixViewState();
}

class _FsmSkillMatrixViewState extends State<FsmSkillMatrixView> {
  List<Map<String, dynamic>> technicians = [
    {
      "id": "1",
      "name": "John Smith",
      "role": "Senior Technician",
      "department": "Electrical",
      "experience": "8 years",
      "certifications": ["Electrical License", "Safety Certified"],
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "skills": {
        "Electrical": {"level": 5, "certified": true},
        "Plumbing": {"level": 3, "certified": false},
        "HVAC": {"level": 4, "certified": true},
        "Mechanical": {"level": 2, "certified": false},
        "Security": {"level": 3, "certified": false},
      }
    },
    {
      "id": "2",
      "name": "Sarah Johnson",
      "role": "Lead Technician", 
      "department": "HVAC",
      "experience": "6 years",
      "certifications": ["HVAC Certified", "EPA Certified"],
      "avatar": "https://picsum.photos/100/100?random=2&keyword=person",
      "skills": {
        "Electrical": {"level": 2, "certified": false},
        "Plumbing": {"level": 4, "certified": false},
        "HVAC": {"level": 5, "certified": true},
        "Mechanical": {"level": 4, "certified": true},
        "Security": {"level": 1, "certified": false},
      }
    },
    {
      "id": "3",
      "name": "Mike Davis",
      "role": "Technician",
      "department": "Plumbing",
      "experience": "4 years",
      "certifications": ["Plumbing License"],
      "avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "skills": {
        "Electrical": {"level": 2, "certified": false},
        "Plumbing": {"level": 5, "certified": true},
        "HVAC": {"level": 3, "certified": false},
        "Mechanical": {"level": 3, "certified": false},
        "Security": {"level": 2, "certified": false},
      }
    },
    {
      "id": "4",
      "name": "Emma Wilson",
      "role": "Junior Technician",
      "department": "General",
      "experience": "2 years",
      "certifications": ["Basic Safety"],
      "avatar": "https://picsum.photos/100/100?random=4&keyword=person",
      "skills": {
        "Electrical": {"level": 3, "certified": false},
        "Plumbing": {"level": 2, "certified": false},
        "HVAC": {"level": 2, "certified": false},
        "Mechanical": {"level": 4, "certified": false},
        "Security": {"level": 4, "certified": true},
      }
    }
  ];

  List<String> skillCategories = ["Electrical", "Plumbing", "HVAC", "Mechanical", "Security"];
  String selectedFilter = "All";
  String selectedSkill = "";
  bool showSkillForm = false;
  String selectedTechnician = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skill Matrix"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showSkillForm = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFilterSection(),
            _buildSkillOverview(),
            _buildSkillMatrix(),
            if (showSkillForm) _buildSkillForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.filter_list, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Filter Skills",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Experience Level",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Expert (5)", "value": "5"},
                    {"label": "Advanced (4)", "value": "4"},
                    {"label": "Intermediate (3)", "value": "3"},
                    {"label": "Beginner (1-2)", "value": "2"},
                  ],
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Skill Category",
                  items: [
                    {"label": "All Skills", "value": ""},
                    ...skillCategories.map((skill) => {
                      "label": skill,
                      "value": skill
                    }).toList(),
                  ],
                  value: selectedSkill,
                  onChanged: (value, label) {
                    selectedSkill = value;
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

  Widget _buildSkillOverview() {
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
            "Skill Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: skillCategories.map((skill) => _buildSkillSummaryCard(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillSummaryCard(String skill) {
    int expertCount = 0;
    int certifiedCount = 0;
    
    for (var tech in technicians) {
      if (tech["skills"][skill] != null) {
        if ((tech["skills"][skill]["level"] as int) >= 4) expertCount++;
        if (tech["skills"][skill]["certified"] == true) certifiedCount++;
      }
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: primaryColor.withAlpha(30)),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Text(
              skill,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "$expertCount",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            Text(
              "Experts",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified, size: 12, color: infoColor),
                SizedBox(width: spXs),
                Text(
                  "$certifiedCount",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillMatrix() {
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
            "Technician Skills Matrix",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: technicians.map((tech) => _buildTechnicianSkillCard(tech)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicianSkillCard(Map<String, dynamic> technician) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${technician["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${technician["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${technician["role"]} • ${technician["department"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Experience: ${technician["experience"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  selectedTechnician = technician["id"];
                  showSkillForm = true;
                  setState(() {});
                },
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: skillCategories.map((skill) => _buildSkillLevelRow(skill, technician["skills"][skill])).toList(),
          ),
          if ((technician["certifications"] as List).isNotEmpty) ...[
            Divider(),
            Row(
              children: [
                Icon(Icons.verified, size: 16, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "Certifications:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    (technician["certifications"] as List).join(", "),
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSkillLevelRow(String skillName, Map<String, dynamic>? skillData) {
    if (skillData == null) return SizedBox();
    
    int level = skillData["level"] as int;
    bool certified = skillData["certified"] as bool;
    
    Color levelColor = level >= 5 ? successColor :
                      level >= 4 ? infoColor :
                      level >= 3 ? warningColor : dangerColor;

    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            skillName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Row(
            children: List.generate(5, (index) => Container(
              margin: EdgeInsets.only(right: spXs),
              width: 16,
              height: 8,
              decoration: BoxDecoration(
                color: index < level ? levelColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            )),
          ),
        ),
        SizedBox(width: spSm),
        if (certified)
          Icon(Icons.verified, size: 16, color: successColor)
        else
          SizedBox(width: 16),
        SizedBox(width: spSm),
        Text(
          "$level/5",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: levelColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillForm() {
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
              Text(
                selectedTechnician.isEmpty ? "Add Skills" : "Update Skills",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showSkillForm = false;
                  selectedTechnician = "";
                  setState(() {});
                },
                child: Icon(Icons.close, color: disabledBoldColor),
              ),
            ],
          ),
          if (selectedTechnician.isEmpty)
            QDropdownField(
              label: "Select Technician",
              items: technicians.map((tech) => {
                "label": "${tech["name"]}",
                "value": "${tech["id"]}"
              }).toList(),
              value: "",
              onChanged: (value, label) {},
            ),
          QDropdownField(
            label: "Skill Category",
            items: skillCategories.map((skill) => {
              "label": skill,
              "value": skill
            }).toList(),
            value: "",
            onChanged: (value, label) {},
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Skill Level",
                  items: [
                    {"label": "1 - Novice", "value": "1"},
                    {"label": "2 - Beginner", "value": "2"},
                    {"label": "3 - Intermediate", "value": "3"},
                    {"label": "4 - Advanced", "value": "4"},
                    {"label": "5 - Expert", "value": "5"},
                  ],
                  value: "",
                  onChanged: (value, label) {},
                ),
              ),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Certified",
                      "value": true,
                      "checked": false,
                    }
                  ],
                  value: [],
                  onChanged: (values, ids) {},
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Notes / Comments",
            value: "",
            onChanged: (value) {},
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    showSkillForm = false;
                    selectedTechnician = "";
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Save Skills",
                  size: bs.sm,
                  onPressed: () {
                    ss("Skill matrix updated successfully");
                    showSkillForm = false;
                    selectedTechnician = "";
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
}
