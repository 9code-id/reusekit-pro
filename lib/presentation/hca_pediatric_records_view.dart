import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPediatricRecordsView extends StatefulWidget {
  const HcaPediatricRecordsView({super.key});

  @override
  State<HcaPediatricRecordsView> createState() => _HcaPediatricRecordsViewState();
}

class _HcaPediatricRecordsViewState extends State<HcaPediatricRecordsView> {
  int currentTab = 0;
  String selectedChildId = "1";
  
  // Children data
  List<Map<String, dynamic>> children = [
    {
      "id": "1",
      "name": "Emma Johnson",
      "dateOfBirth": "2018-03-15",
      "gender": "Female",
      "bloodType": "A+",
      "allergies": ["Peanuts", "Dairy"],
      "height": 105,
      "weight": 18.5,
      "avatar": "https://picsum.photos/80/80?random=1&keyword=girl",
      "pediatrician": {
        "name": "Dr. Sarah Wilson",
        "phone": "+1-555-0123",
        "clinic": "Children's Health Center"
      }
    },
    {
      "id": "2",
      "name": "Liam Johnson",
      "dateOfBirth": "2020-07-22",
      "gender": "Male",
      "bloodType": "O+",
      "allergies": ["None"],
      "height": 92,
      "weight": 14.2,
      "avatar": "https://picsum.photos/80/80?random=2&keyword=boy",
      "pediatrician": {
        "name": "Dr. Sarah Wilson",
        "phone": "+1-555-0123",
        "clinic": "Children's Health Center"
      }
    },
  ];

  // Growth data
  Map<String, List<Map<String, dynamic>>> growthData = {
    "1": [
      {"date": "2024-12-01", "height": 105, "weight": 18.5, "age": "6y 9m"},
      {"date": "2024-09-01", "height": 103, "weight": 17.8, "age": "6y 6m"},
      {"date": "2024-06-01", "height": 101, "weight": 17.2, "age": "6y 3m"},
      {"date": "2024-03-01", "height": 99, "weight": 16.5, "age": "6y 0m"},
      {"date": "2023-12-01", "height": 97, "weight": 15.8, "age": "5y 9m"},
    ],
    "2": [
      {"date": "2024-12-01", "height": 92, "weight": 14.2, "age": "4y 5m"},
      {"date": "2024-09-01", "height": 90, "weight": 13.8, "age": "4y 2m"},
      {"date": "2024-06-01", "height": 88, "weight": 13.2, "age": "3y 11m"},
      {"date": "2024-03-01", "height": 86, "weight": 12.8, "age": "3y 8m"},
      {"date": "2023-12-01", "height": 84, "weight": 12.2, "age": "3y 5m"},
    ],
  };

  // Vaccination records
  Map<String, List<Map<String, dynamic>>> vaccinationRecords = {
    "1": [
      {
        "vaccine": "MMR Booster",
        "date": "2024-03-15",
        "status": "Completed",
        "nextDue": null,
        "notes": "No adverse reactions",
        "provider": "Dr. Sarah Wilson"
      },
      {
        "vaccine": "Flu Shot",
        "date": "2024-10-15",
        "status": "Completed",
        "nextDue": "2025-10-15",
        "notes": "Annual vaccination",
        "provider": "Dr. Sarah Wilson"
      },
      {
        "vaccine": "COVID-19",
        "date": "2024-08-20",
        "status": "Completed",
        "nextDue": null,
        "notes": "Pediatric dose",
        "provider": "Dr. Sarah Wilson"
      },
    ],
    "2": [
      {
        "vaccine": "DTaP",
        "date": "2024-07-22",
        "status": "Completed",
        "nextDue": null,
        "notes": "4th dose completed",
        "provider": "Dr. Sarah Wilson"
      },
      {
        "vaccine": "Flu Shot",
        "date": "2024-10-15",
        "status": "Completed",
        "nextDue": "2025-10-15",
        "notes": "Annual vaccination",
        "provider": "Dr. Sarah Wilson"
      },
      {
        "vaccine": "Varicella",
        "date": "2025-01-22",
        "status": "Scheduled",
        "nextDue": null,
        "notes": "Scheduled for 1st birthday + 3 months",
        "provider": "Dr. Sarah Wilson"
      },
    ],
  };

  // Medical visits
  Map<String, List<Map<String, dynamic>>> medicalVisits = {
    "1": [
      {
        "date": "2024-12-10",
        "type": "Annual Checkup",
        "provider": "Dr. Sarah Wilson",
        "reason": "Routine annual physical examination",
        "findings": "Healthy development, growth on track",
        "recommendations": ["Continue regular physical activity", "Maintain balanced diet"],
        "status": "Completed",
        "followUp": null
      },
      {
        "date": "2024-08-15",
        "type": "Sick Visit",
        "provider": "Dr. Sarah Wilson",
        "reason": "Persistent cough and mild fever",
        "findings": "Upper respiratory infection",
        "recommendations": ["Rest and fluids", "Children's acetaminophen as needed"],
        "status": "Completed",
        "followUp": "Follow up if symptoms persist beyond 7 days"
      },
      {
        "date": "2024-03-15",
        "type": "Birthday Checkup",
        "provider": "Dr. Sarah Wilson",
        "reason": "6th birthday wellness visit",
        "findings": "Excellent health, meeting all milestones",
        "recommendations": ["Continue current diet", "Start learning to ride bike"],
        "status": "Completed",
        "followUp": "Next annual checkup in March 2025"
      },
    ],
    "2": [
      {
        "date": "2024-11-20",
        "type": "Well-Child Visit",
        "provider": "Dr. Sarah Wilson",
        "reason": "4-year wellness checkup",
        "findings": "Normal development, speech progressing well",
        "recommendations": ["Encourage reading together", "Limit screen time"],
        "status": "Completed",
        "followUp": "Next visit in 6 months"
      },
      {
        "date": "2024-07-22",
        "type": "Birthday Checkup",
        "provider": "Dr. Sarah Wilson",
        "reason": "4th birthday wellness visit",
        "findings": "Healthy growth, social skills developing",
        "recommendations": ["Prepare for preschool", "Continue potty training"],
        "status": "Completed",
        "followUp": "Schedule kindergarten physical next year"
      },
    ],
  };

  // Form fields for adding new records
  String visitDate = "";
  String selectedVisitType = "";
  String visitReason = "";
  String visitFindings = "";
  String visitRecommendations = "";
  String visitProvider = "";

  List<Map<String, dynamic>> visitTypeItems = [
    {"label": "Annual Checkup", "value": "Annual Checkup"},
    {"label": "Well-Child Visit", "value": "Well-Child Visit"},
    {"label": "Sick Visit", "value": "Sick Visit"},
    {"label": "Vaccination", "value": "Vaccination"},
    {"label": "Follow-up", "value": "Follow-up"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "Specialist Referral", "value": "Specialist Referral"},
  ];

  Map<String, dynamic> get selectedChild {
    return children.firstWhere((child) => child["id"] == selectedChildId);
  }

  int _calculateAge(String dateOfBirth) {
    DateTime birthDate = DateTime.parse(dateOfBirth);
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  String _getAgeString(String dateOfBirth) {
    DateTime birthDate = DateTime.parse(dateOfBirth);
    DateTime now = DateTime.now();
    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    
    if (months < 0) {
      years--;
      months += 12;
    }
    
    if (years > 0) {
      return "${years}y ${months}m";
    } else {
      return "${months}m";
    }
  }

  void _addMedicalVisit() {
    if (visitDate.isEmpty || selectedVisitType.isEmpty || visitReason.isEmpty) {
      se("Please fill in required fields");
      return;
    }

    setState(() {
      if (medicalVisits[selectedChildId] == null) {
        medicalVisits[selectedChildId] = [];
      }
      medicalVisits[selectedChildId]!.insert(0, {
        "date": visitDate,
        "type": selectedVisitType,
        "provider": visitProvider.isEmpty ? "Dr. Sarah Wilson" : visitProvider,
        "reason": visitReason,
        "findings": visitFindings,
        "recommendations": visitRecommendations.split(",").map((e) => e.trim()).toList(),
        "status": "Completed",
        "followUp": null,
      });
    });

    _clearVisitForm();
    ss("Medical visit added successfully");
  }

  void _clearVisitForm() {
    visitDate = "";
    selectedVisitType = "";
    visitReason = "";
    visitFindings = "";
    visitRecommendations = "";
    visitProvider = "";
    setState(() {});
  }

  Widget _buildChildSelector() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor, width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage("${selectedChild["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${selectedChild["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getAgeString(selectedChild["dateOfBirth"])} • ${selectedChild["gender"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (children.length > 1)
            QButton(
              label: "Switch Child",
              size: bs.sm,
              onPressed: () {
                _showChildSelector();
              },
            ),
        ],
      ),
    );
  }

  void _showChildSelector() {
    // Implementation for child selector dialog would go here
    // For now, just cycle through children
    int currentIndex = children.indexWhere((child) => child["id"] == selectedChildId);
    int nextIndex = (currentIndex + 1) % children.length;
    setState(() {
      selectedChildId = children[nextIndex]["id"];
    });
  }

  Widget _buildOverviewTab() {
    Map<String, dynamic> child = selectedChild;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChildSelector(),
          
          // Child basic info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage("${child["avatar"]}"),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${child["name"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Born: ${DateTime.parse(child["dateOfBirth"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Age: ${_getAgeString(child["dateOfBirth"])}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Quick stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.height,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Height",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${child["height"]} cm",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.monitor_weight,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Weight",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${child["weight"]} kg",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.bloodtype,
                        color: dangerColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Blood Type",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${child["bloodType"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Allergies
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
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
                    Icon(
                      Icons.warning,
                      color: dangerColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Allergies",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                if ((child["allergies"] as List).first == "None")
                  Text(
                    "No known allergies",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (child["allergies"] as List).map((allergy) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$allergy",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Pediatrician info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
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
                    Icon(
                      Icons.local_hospital,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Pediatrician",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${child["pediatrician"]["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${child["pediatrician"]["clinic"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${child["pediatrician"]["phone"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Recent visits
          Text(
            "Recent Medical Visits",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          if (medicalVisits[selectedChildId] != null && medicalVisits[selectedChildId]!.isNotEmpty)
            Column(
              children: medicalVisits[selectedChildId]!.take(2).map((visit) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.medical_services,
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
                              "${visit["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${DateTime.parse(visit["date"]).dMMMy} • ${visit["provider"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${visit["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          else
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
                    Icons.medical_services,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No medical visits recorded",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGrowthTab() {
    List<Map<String, dynamic>> childGrowthData = growthData[selectedChildId] ?? [];
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChildSelector(),
          
          Text(
            "Growth Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          // Current measurements
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.height,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Current Height",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(230),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${selectedChild["height"]} cm",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.monitor_weight,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Current Weight",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(230),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${selectedChild["weight"]} kg",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Growth history
          Text(
            "Growth History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          if (childGrowthData.isEmpty)
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
                    Icons.trending_up,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No growth data available",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: childGrowthData.map((record) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${DateTime.parse(record["date"]).day}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(record["date"]).month}/${DateTime.parse(record["date"]).year.toString().substring(2)}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Age: ${record["age"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Height: ${record["height"]} cm",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Weight: ${record["weight"]} kg",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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

  Widget _buildVaccinationTab() {
    List<Map<String, dynamic>> childVaccinations = vaccinationRecords[selectedChildId] ?? [];
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChildSelector(),
          
          Text(
            "Vaccination Records",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          if (childVaccinations.isEmpty)
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
                    Icons.vaccines,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No vaccination records",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: childVaccinations.map((vaccination) {
                Color statusColor = vaccination["status"] == "Completed" ? successColor : 
                                  vaccination["status"] == "Scheduled" ? warningColor : dangerColor;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: statusColor, width: 1),
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
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.vaccines,
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
                                  "${vaccination["vaccine"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${DateTime.parse(vaccination["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${vaccination["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      if (vaccination["provider"] != null) ...[
                        Text(
                          "Provider: ${vaccination["provider"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                      ],
                      if (vaccination["notes"] != null && vaccination["notes"].toString().isNotEmpty) ...[
                        Text(
                          "Notes: ${vaccination["notes"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                      ],
                      if (vaccination["nextDue"] != null)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor, width: 1),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: infoColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Next due: ${DateTime.parse(vaccination["nextDue"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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

  Widget _buildMedicalVisitsTab() {
    List<Map<String, dynamic>> childVisits = medicalVisits[selectedChildId] ?? [];
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChildSelector(),
          
          Row(
            children: [
              Expanded(
                child: Text(
                  "Medical Visits",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Visit",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _showAddVisitForm();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),

          if (childVisits.isEmpty)
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
                    Icons.medical_services,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No medical visits recorded",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Add your child's medical visits and checkups",
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
              children: childVisits.map((visit) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
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
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.medical_services,
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
                                  "${visit["type"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${DateTime.parse(visit["date"]).dMMMy} • ${visit["provider"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${visit["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Reason: ${visit["reason"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (visit["findings"] != null && visit["findings"].toString().isNotEmpty) ...[
                        SizedBox(height: spXs),
                        Text(
                          "Findings: ${visit["findings"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                      if (visit["recommendations"] != null && (visit["recommendations"] as List).isNotEmpty) ...[
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
                          children: (visit["recommendations"] as List).map((rec) {
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
                      if (visit["followUp"] != null && visit["followUp"].toString().isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: spSm),
                          padding: EdgeInsets.all(spXs),
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
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${visit["followUp"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                            ],
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

  void _showAddVisitForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Medical Visit"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDatePicker(
                label: "Visit Date",
                value: DateTime.now(),
                onChanged: (value) {
                  visitDate = value.toString().split(' ')[0];
                },
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Visit Type",
                items: visitTypeItems,
                value: selectedVisitType,
                onChanged: (value, label) {
                  selectedVisitType = value;
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Reason for Visit",
                value: visitReason,
                onChanged: (value) {
                  visitReason = value;
                },
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Findings",
                value: visitFindings,
                onChanged: (value) {
                  visitFindings = value;
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Recommendations",
                value: visitRecommendations,
                hint: "Separate multiple recommendations with commas",
                onChanged: (value) {
                  visitRecommendations = value;
                },
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Cancel",
            color: disabledBoldColor,
            size: bs.sm,
            onPressed: () {
              _clearVisitForm();
              Navigator.pop(context);
            },
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Add Visit",
            size: bs.sm,
            onPressed: () {
              _addMedicalVisit();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Pediatric Records",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.child_care)),
        Tab(text: "Growth", icon: Icon(Icons.trending_up)),
        Tab(text: "Vaccines", icon: Icon(Icons.vaccines)),
        Tab(text: "Visits", icon: Icon(Icons.medical_services)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildGrowthTab(),
        _buildVaccinationTab(),
        _buildMedicalVisitsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
