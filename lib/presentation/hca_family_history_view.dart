import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaFamilyHistoryView extends StatefulWidget {
  const HcaFamilyHistoryView({super.key});

  @override
  State<HcaFamilyHistoryView> createState() => _HcaFamilyHistoryViewState();
}

class _HcaFamilyHistoryViewState extends State<HcaFamilyHistoryView> {
  int currentTab = 0;
  
  // Family members data
  List<Map<String, dynamic>> familyMembers = [
    {
      "id": 1,
      "name": "John Smith",
      "relation": "Father",
      "age": 65,
      "status": "Deceased",
      "conditions": ["Diabetes", "Heart Disease"],
      "causeOfDeath": "Heart Attack",
      "ageAtDeath": 65,
      "avatar": "https://picsum.photos/80/80?random=1&keyword=man"
    },
    {
      "id": 2,
      "name": "Mary Smith",
      "relation": "Mother",
      "age": 62,
      "status": "Living",
      "conditions": ["Hypertension", "Arthritis"],
      "causeOfDeath": null,
      "ageAtDeath": null,
      "avatar": "https://picsum.photos/80/80?random=2&keyword=woman"
    },
    {
      "id": 3,
      "name": "Robert Smith",
      "relation": "Brother",
      "age": 35,
      "status": "Living",
      "conditions": ["Asthma"],
      "causeOfDeath": null,
      "ageAtDeath": null,
      "avatar": "https://picsum.photos/80/80?random=3&keyword=man"
    },
    {
      "id": 4,
      "name": "Linda Johnson",
      "relation": "Sister",
      "age": 32,
      "status": "Living",
      "conditions": ["None"],
      "causeOfDeath": null,
      "ageAtDeath": null,
      "avatar": "https://picsum.photos/80/80?random=4&keyword=woman"
    },
  ];

  // Genetic conditions data
  List<Map<String, dynamic>> geneticConditions = [
    {
      "condition": "Diabetes Type 2",
      "risk": "High",
      "affectedMembers": 2,
      "totalMembers": 4,
      "percentage": 50,
      "description": "Family history shows increased risk for diabetes",
      "recommendations": ["Regular glucose monitoring", "Healthy diet", "Regular exercise"],
      "color": dangerColor
    },
    {
      "condition": "Heart Disease",
      "risk": "Moderate",
      "affectedMembers": 1,
      "totalMembers": 4,
      "percentage": 25,
      "description": "One family member with heart disease history",
      "recommendations": ["Regular cardiac checkups", "Low sodium diet", "Stress management"],
      "color": warningColor
    },
    {
      "condition": "Hypertension",
      "risk": "Moderate",
      "affectedMembers": 1,
      "totalMembers": 4,
      "percentage": 25,
      "description": "Family history of high blood pressure",
      "recommendations": ["Regular BP monitoring", "Reduce salt intake", "Exercise regularly"],
      "color": warningColor
    },
    {
      "condition": "Cancer",
      "risk": "Low",
      "affectedMembers": 0,
      "totalMembers": 4,
      "percentage": 0,
      "description": "No family history of cancer",
      "recommendations": ["Regular screening", "Healthy lifestyle", "Avoid smoking"],
      "color": successColor
    },
  ];

  // Form fields for adding new member
  String memberName = "";
  String selectedRelation = "";
  String memberAge = "";
  String selectedStatus = "";
  String selectedConditions = "";
  String causeOfDeath = "";
  String ageAtDeath = "";

  List<Map<String, dynamic>> relationItems = [
    {"label": "Father", "value": "Father"},
    {"label": "Mother", "value": "Mother"},
    {"label": "Brother", "value": "Brother"},
    {"label": "Sister", "value": "Sister"},
    {"label": "Son", "value": "Son"},
    {"label": "Daughter", "value": "Daughter"},
    {"label": "Grandfather", "value": "Grandfather"},
    {"label": "Grandmother", "value": "Grandmother"},
    {"label": "Uncle", "value": "Uncle"},
    {"label": "Aunt", "value": "Aunt"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "Living", "value": "Living"},
    {"label": "Deceased", "value": "Deceased"},
  ];

  List<Map<String, dynamic>> conditionItems = [
    {"label": "None", "value": "None"},
    {"label": "Diabetes", "value": "Diabetes"},
    {"label": "Heart Disease", "value": "Heart Disease"},
    {"label": "Hypertension", "value": "Hypertension"},
    {"label": "Cancer", "value": "Cancer"},
    {"label": "Asthma", "value": "Asthma"},
    {"label": "Arthritis", "value": "Arthritis"},
    {"label": "Stroke", "value": "Stroke"},
    {"label": "Kidney Disease", "value": "Kidney Disease"},
    {"label": "Mental Health", "value": "Mental Health"},
  ];

  void _addFamilyMember() {
    if (memberName.isEmpty || selectedRelation.isEmpty) {
      se("Please fill in required fields");
      return;
    }

    setState(() {
      familyMembers.add({
        "id": familyMembers.length + 1,
        "name": memberName,
        "relation": selectedRelation,
        "age": int.tryParse(memberAge) ?? 0,
        "status": selectedStatus,
        "conditions": selectedConditions.split(",").map((e) => e.trim()).toList(),
        "causeOfDeath": selectedStatus == "Deceased" ? causeOfDeath : null,
        "ageAtDeath": selectedStatus == "Deceased" ? int.tryParse(ageAtDeath) : null,
        "avatar": "https://picsum.photos/80/80?random=${familyMembers.length + 5}&keyword=person"
      });
    });

    _clearForm();
    ss("Family member added successfully");
  }

  void _clearForm() {
    memberName = "";
    selectedRelation = "";
    memberAge = "";
    selectedStatus = "";
    selectedConditions = "";
    causeOfDeath = "";
    ageAtDeath = "";
    setState(() {});
  }

  void _deleteFamilyMember(int id) async {
    bool isConfirmed = await confirm("Are you sure you want to remove this family member?");
    if (isConfirmed) {
      setState(() {
        familyMembers.removeWhere((member) => member["id"] == id);
      });
      ss("Family member removed successfully");
    }
  }

  Widget _buildFamilyMemberCard(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: member["status"] == "Deceased" ? disabledColor : successColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${member["relation"]} • ${member["age"]} years old",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: member["status"] == "Living" ? successColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${member["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.delete,
                color: dangerColor,
                size: bs.sm,
                onPressed: () => _deleteFamilyMember(member["id"]),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Medical Conditions:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (member["conditions"] as List).map((condition) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: condition == "None" ? disabledColor : warningColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$condition",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          if (member["status"] == "Deceased") ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cause of Death: ${member["causeOfDeath"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Age at Death: ${member["ageAtDeath"]} years",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGeneticRiskCard(Map<String, dynamic> condition) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: condition["color"],
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: condition["color"],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.health_and_safety,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${condition["condition"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${condition["risk"]} Risk",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: condition["color"],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "${condition["affectedMembers"]}/${condition["totalMembers"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: condition["color"],
                    ),
                  ),
                  Text(
                    "${condition["percentage"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (condition["percentage"] as int) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: condition["color"],
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${condition["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Recommendations:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Column(
            children: (condition["recommendations"] as List).map((rec) {
              return Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "$rec",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyTreeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Document your family's medical history to understand genetic risks and make informed health decisions.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Family Members (${familyMembers.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Member",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    currentTab = 2;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          if (familyMembers.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledColor, width: 1),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.family_restroom,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No family members added yet",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Start building your family tree by adding family members",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: familyMembers.map((member) {
                return _buildFamilyMemberCard(member);
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildGeneticRiskTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Genetic risk analysis based on your family medical history. Consult with healthcare providers for personalized advice.",
                    style: TextStyle(
                      fontSize: 14,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Genetic Risk Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: geneticConditions.map((condition) {
              return _buildGeneticRiskCard(condition);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMemberTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Family Member",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Full Name",
            value: memberName,
            hint: "Enter family member's full name",
            validator: Validator.required,
            onChanged: (value) {
              memberName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Relationship",
            items: relationItems,
            value: selectedRelation,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedRelation = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QNumberField(
            label: "Age",
            value: memberAge,
            hint: "Enter current age or age at death",
            validator: Validator.required,
            onChanged: (value) {
              memberAge = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Status",
            items: statusItems,
            value: selectedStatus,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Medical Conditions",
            items: conditionItems,
            value: selectedConditions,
            hint: "Select known medical conditions",
            onChanged: (value, label) {
              selectedConditions = value;
              setState(() {});
            },
          ),
          if (selectedStatus == "Deceased") ...[
            SizedBox(height: spSm),
            QTextField(
              label: "Cause of Death",
              value: causeOfDeath,
              hint: "Enter cause of death",
              onChanged: (value) {
                causeOfDeath = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Age at Death",
              value: ageAtDeath,
              hint: "Enter age at time of death",
              onChanged: (value) {
                ageAtDeath = value;
                setState(() {});
              },
            ),
          ],
          SizedBox(height: spLg),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Clear Form",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: _clearForm,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Member",
                  size: bs.md,
                  onPressed: _addFamilyMember,
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
    return QTabBar(
      title: "Family History",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Family Tree", icon: Icon(Icons.family_restroom)),
        Tab(text: "Genetic Risk", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Add Member", icon: Icon(Icons.person_add)),
      ],
      tabChildren: [
        _buildFamilyTreeTab(),
        _buildGeneticRiskTab(),
        _buildAddMemberTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
