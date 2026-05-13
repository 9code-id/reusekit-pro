import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaFamilyHealthView extends StatefulWidget {
  const MhaFamilyHealthView({super.key});

  @override
  State<MhaFamilyHealthView> createState() => _MhaFamilyHealthViewState();
}

class _MhaFamilyHealthViewState extends State<MhaFamilyHealthView> {
  int selectedTab = 0;
  String selectedMember = "";
  List<Map<String, dynamic>> familyMembers = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "relation": "Self",
      "age": 35,
      "bloodType": "O+",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "healthStatus": "Good",
      "lastCheckup": "2024-05-15",
      "medications": 2,
      "allergies": ["Peanuts", "Shellfish"],
      "chronicConditions": [],
      "upcomingAppointments": 1,
      "vitals": {
        "bloodPressure": "120/80",
        "heartRate": 72,
        "weight": 65.5,
        "height": 165
      }
    },
    {
      "id": "2", 
      "name": "Michael Johnson",
      "relation": "Spouse",
      "age": 38,
      "bloodType": "A+",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "healthStatus": "Good",
      "lastCheckup": "2024-04-20",
      "medications": 1,
      "allergies": ["Dust"],
      "chronicConditions": ["Hypertension"],
      "upcomingAppointments": 2,
      "vitals": {
        "bloodPressure": "135/85",
        "heartRate": 78,
        "weight": 75.2,
        "height": 178
      }
    },
    {
      "id": "3",
      "name": "Emma Johnson", 
      "relation": "Daughter",
      "age": 12,
      "bloodType": "O+",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=girl",
      "healthStatus": "Excellent",
      "lastCheckup": "2024-03-10",
      "medications": 0,
      "allergies": [],
      "chronicConditions": [],
      "upcomingAppointments": 1,
      "vitals": {
        "bloodPressure": "110/70",
        "heartRate": 85,
        "weight": 42.0,
        "height": 152
      }
    },
    {
      "id": "4",
      "name": "James Johnson",
      "relation": "Son", 
      "age": 8,
      "bloodType": "A+",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=boy",
      "healthStatus": "Good",
      "lastCheckup": "2024-03-10",
      "medications": 0,
      "allergies": ["Cats"],
      "chronicConditions": ["Asthma"],
      "upcomingAppointments": 1,
      "vitals": {
        "bloodPressure": "105/65",
        "heartRate": 90,
        "weight": 28.5,
        "height": 130
      }
    }
  ];

  List<Map<String, dynamic>> healthTips = [
    {
      "title": "Family Exercise Time",
      "description": "Schedule regular physical activities that the whole family can enjoy together",
      "icon": Icons.directions_run,
      "category": "Fitness"
    },
    {
      "title": "Healthy Meal Planning",
      "description": "Plan nutritious meals that cater to everyone's dietary needs and preferences",
      "icon": Icons.restaurant,
      "category": "Nutrition"
    },
    {
      "title": "Sleep Hygiene",
      "description": "Establish consistent bedtime routines for better family sleep health",
      "icon": Icons.bedtime,
      "category": "Sleep"
    },
    {
      "title": "Mental Wellness",
      "description": "Practice mindfulness and stress management techniques as a family",
      "icon": Icons.psychology,
      "category": "Mental Health"
    }
  ];

  @override
  void initState() {
    super.initState();
    selectedMember = familyMembers[0]["id"];
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Family Health",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.family_restroom)),
        Tab(text: "Members", icon: Icon(Icons.people)),
        Tab(text: "Records", icon: Icon(Icons.medical_information)),
        Tab(text: "Tips", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildMembersTab(),
        _buildRecordsTab(), 
        _buildTipsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Family Health Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Family Health Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Total Members",
                        "${familyMembers.length}",
                        Icons.people,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard(
                        "Upcoming Appointments",
                        "${familyMembers.fold(0, (sum, member) => sum + (member["upcomingAppointments"] as int))}",
                        Icons.event,
                        warningColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Active Medications",
                        "${familyMembers.fold(0, (sum, member) => sum + (member["medications"] as int))}",
                        Icons.medication,
                        successColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard(
                        "Chronic Conditions",
                        "${familyMembers.fold(0, (sum, member) => sum + (member["chronicConditions"] as List).length)}",
                        Icons.medical_services,
                        dangerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Activities
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildActivityItem(
                  "Sarah Johnson completed annual checkup",
                  "2 days ago",
                  Icons.check_circle,
                  successColor,
                ),
                _buildActivityItem(
                  "Michael's blood pressure reading uploaded",
                  "5 days ago", 
                  Icons.monitor_heart,
                  infoColor,
                ),
                _buildActivityItem(
                  "Emma's vaccination reminder set",
                  "1 week ago",
                  Icons.vaccines,
                  warningColor,
                ),
                _buildActivityItem(
                  "James' asthma medication refilled",
                  "2 weeks ago",
                  Icons.medication,
                  primaryColor,
                ),
              ],
            ),
          ),

          // Health Alerts
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(76)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: dangerColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Health Alerts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Michael's blood pressure is slightly elevated\n• James needs asthma inhaler refill in 3 days\n• Emma's annual vaccination is due next month",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Family Members",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                label: "Add Member",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          ...familyMembers.map((member) => _buildMemberCard(member)),
        ],
      ),
    );
  }

  Widget _buildRecordsTab() {
    final selectedMemberData = familyMembers.firstWhere(
      (member) => member["id"] == selectedMember,
      orElse: () => familyMembers[0],
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Medical Records",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Member Selector
          QDropdownField(
            label: "Select Family Member",
            items: familyMembers.map((member) => {
              "label": "${member["name"]} (${member["relation"]})",
              "value": member["id"],
            }).toList(),
            value: selectedMember,
            onChanged: (value, label) {
              selectedMember = value;
              setState(() {});
            },
          ),

          // Health Information
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Health Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard("Age", "${selectedMemberData["age"]} years"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildInfoCard("Blood Type", "${selectedMemberData["bloodType"]}"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard("Height", "${selectedMemberData["vitals"]["height"]} cm"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildInfoCard("Weight", "${selectedMemberData["vitals"]["weight"]} kg"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Vital Signs
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Latest Vital Signs",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildVitalCard(
                        "Blood Pressure",
                        "${selectedMemberData["vitals"]["bloodPressure"]}",
                        Icons.monitor_heart,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildVitalCard(
                        "Heart Rate",
                        "${selectedMemberData["vitals"]["heartRate"]} bpm",
                        Icons.favorite,
                        dangerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Allergies & Conditions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Allergies & Conditions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if ((selectedMemberData["allergies"] as List).isNotEmpty) ...[
                  Text(
                    "Allergies:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: (selectedMemberData["allergies"] as List).map((allergy) => 
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$allergy",
                          style: TextStyle(
                            color: warningColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ],
                if ((selectedMemberData["chronicConditions"] as List).isNotEmpty) ...[
                  Text(
                    "Chronic Conditions:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: (selectedMemberData["chronicConditions"] as List).map((condition) => 
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$condition",
                          style: TextStyle(
                            color: dangerColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ],
                if ((selectedMemberData["allergies"] as List).isEmpty && 
                    (selectedMemberData["chronicConditions"] as List).isEmpty)
                  Text(
                    "No allergies or chronic conditions recorded",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Family Health Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          ...healthTips.map((tip) => _buildTipCard(tip)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("${member["avatar"]}"),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${member["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${member["relation"]} • ${member["age"]} years old",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: member["healthStatus"] == "Excellent" ? successColor : 
                                   member["healthStatus"] == "Good" ? primaryColor : warningColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${member["healthStatus"]}",
                          style: TextStyle(
                            color: member["healthStatus"] == "Excellent" ? successColor : 
                                   member["healthStatus"] == "Good" ? primaryColor : warningColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.arrow_forward_ios,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildMemberStat("Last Checkup", "${member["lastCheckup"]}"),
              ),
              Expanded(
                child: _buildMemberStat("Medications", "${member["medications"]}"),
              ),
              Expanded(
                child: _buildMemberStat("Appointments", "${member["upcomingAppointments"]}"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(tip["icon"], color: primaryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tip["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${tip["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${tip["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
