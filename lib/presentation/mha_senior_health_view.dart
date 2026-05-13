import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaSeniorHealthView extends StatefulWidget {
  const MhaSeniorHealthView({super.key});

  @override
  State<MhaSeniorHealthView> createState() => _MhaSeniorHealthViewState();
}

class _MhaSeniorHealthViewState extends State<MhaSeniorHealthView> {
  int selectedTab = 0;

  Map<String, dynamic> userProfile = {
    "name": "Robert Anderson",
    "age": 68,
    "avatar": "https://picsum.photos/80/80?random=1&keyword=elderly",
    "height": 175,
    "weight": 72.5,
    "bloodType": "B+",
    "emergencyContact": "Mary Anderson",
    "emergencyPhone": "+1-555-0123",
    "primaryPhysician": "Dr. James Wilson",
    "lastPhysical": "2024-03-15"
  };

  List<Map<String, dynamic>> chronicConditions = [
    {
      "condition": "Hypertension",
      "diagnosedDate": "2018-05-12",
      "status": "Controlled",
      "medication": "Lisinopril 10mg",
      "lastReading": "135/82 mmHg",
      "icon": Icons.monitor_heart,
      "color": "warning"
    },
    {
      "condition": "Type 2 Diabetes",
      "diagnosedDate": "2020-08-20",
      "status": "Well Managed",
      "medication": "Metformin 500mg",
      "lastReading": "A1C: 6.8%",
      "icon": Icons.medical_services,
      "color": "success"
    },
    {
      "condition": "Osteoarthritis",
      "diagnosedDate": "2019-11-05",
      "status": "Moderate",
      "medication": "Ibuprofen as needed",
      "lastReading": "Joint mobility fair",
      "icon": Icons.accessibility_new,
      "color": "info"
    }
  ];

  List<Map<String, dynamic>> medications = [
    {
      "name": "Lisinopril",
      "dosage": "10mg",
      "frequency": "Once daily",
      "timeToTake": "Morning with breakfast",
      "refillDate": "2024-06-20",
      "prescribedBy": "Dr. James Wilson",
      "indication": "Blood pressure control"
    },
    {
      "name": "Metformin",
      "dosage": "500mg",
      "frequency": "Twice daily",
      "timeToTake": "With meals",
      "refillDate": "2024-06-15",
      "prescribedBy": "Dr. James Wilson",
      "indication": "Diabetes management"
    },
    {
      "name": "Vitamin D3",
      "dosage": "2000 IU",
      "frequency": "Once daily",
      "timeToTake": "With breakfast",
      "refillDate": "2024-07-10",
      "prescribedBy": "Dr. James Wilson",
      "indication": "Bone health"
    },
    {
      "name": "Omega-3",
      "dosage": "1000mg",
      "frequency": "Once daily",
      "timeToTake": "With dinner",
      "refillDate": "2024-06-30",
      "prescribedBy": "Dr. James Wilson",
      "indication": "Heart health"
    }
  ];

  List<Map<String, dynamic>> vitalSigns = [
    {
      "vital": "Blood Pressure",
      "current": "135/82",
      "target": "<130/80",
      "status": "Slightly High",
      "lastChecked": "2024-05-10",
      "icon": Icons.monitor_heart,
      "color": "warning"
    },
    {
      "vital": "Blood Sugar",
      "current": "142 mg/dL",
      "target": "<140 mg/dL",
      "status": "Good",
      "lastChecked": "2024-05-12",
      "icon": Icons.water_drop,
      "color": "success"
    },
    {
      "vital": "Weight",
      "current": "72.5 kg",
      "target": "70-75 kg",
      "status": "Within Range",
      "lastChecked": "2024-05-10",
      "icon": Icons.monitor_weight,
      "color": "success"
    },
    {
      "vital": "Heart Rate",
      "current": "68 bpm",
      "target": "60-80 bpm",
      "status": "Normal",
      "lastChecked": "2024-05-10",
      "icon": Icons.favorite,
      "color": "success"
    }
  ];

  List<Map<String, dynamic>> preventiveCare = [
    {
      "care": "Annual Physical",
      "lastDate": "2024-03-15",
      "nextDue": "2025-03-15",
      "status": "Current",
      "importance": "Essential for overall health monitoring"
    },
    {
      "care": "Eye Exam",
      "lastDate": "2023-11-20",
      "nextDue": "2024-11-20",
      "status": "Due Soon",
      "importance": "Monitor for glaucoma, cataracts, macular degeneration"
    },
    {
      "care": "Hearing Test",
      "lastDate": "2023-08-15",
      "nextDue": "2024-08-15",
      "status": "Overdue",
      "importance": "Early detection of hearing loss"
    },
    {
      "care": "Bone Density",
      "lastDate": "2023-01-10",
      "nextDue": "2025-01-10",
      "status": "Current",
      "importance": "Monitor for osteoporosis"
    },
    {
      "care": "Colonoscopy",
      "lastDate": "2021-06-15",
      "nextDue": "2024-06-15",
      "status": "Due Now",
      "importance": "Colon cancer screening"
    }
  ];

  List<Map<String, dynamic>> safetyTips = [
    {
      "category": "Fall Prevention",
      "tips": [
        "Remove throw rugs and clutter",
        "Install grab bars in bathroom",
        "Ensure adequate lighting",
        "Wear non-slip shoes",
        "Exercise to improve balance"
      ],
      "icon": Icons.warning,
      "color": "danger"
    },
    {
      "category": "Medication Safety",
      "tips": [
        "Use pill organizers",
        "Set medication reminders",
        "Review meds with doctor regularly",
        "Never share medications",
        "Store medications properly"
      ],
      "icon": Icons.medication,
      "color": "primary"
    },
    {
      "category": "Emergency Preparedness",
      "tips": [
        "Keep emergency contacts handy",
        "Wear medical alert bracelet",
        "Have emergency kit ready",
        "Know when to call 911",
        "Keep phone within reach"
      ],
      "icon": Icons.emergency,
      "color": "warning"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Senior Health",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.elderly)),
        Tab(text: "Conditions", icon: Icon(Icons.medical_services)),
        Tab(text: "Medications", icon: Icon(Icons.medication)),
        Tab(text: "Vitals", icon: Icon(Icons.monitor_heart)),
        Tab(text: "Prevention", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Safety", icon: Icon(Icons.security)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildConditionsTab(),
        _buildMedicationsTab(),
        _buildVitalsTab(),
        _buildPreventionTab(),
        _buildSafetyTab(),
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
          // User Profile
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage("${userProfile["avatar"]}"),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${userProfile["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${userProfile["age"]} years old • ${userProfile["height"]} cm",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Dr. ${userProfile["primaryPhysician"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Last Physical: ${userProfile["lastPhysical"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Emergency Contact
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(76)),
            ),
            child: Row(
              children: [
                Icon(Icons.emergency, color: dangerColor, size: 24),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Emergency Contact",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "${userProfile["emergencyContact"]}",
                        style: TextStyle(
                          color: dangerColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${userProfile["emergencyPhone"]}",
                        style: TextStyle(
                          color: dangerColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Health Summary
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
                  "Health Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Active Conditions",
                        "${chronicConditions.length}",
                        Icons.medical_services,
                        warningColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard(
                        "Medications",
                        "${medications.length}",
                        Icons.medication,
                        primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Weight",
                        "${userProfile["weight"]} kg",
                        Icons.monitor_weight,
                        successColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard(
                        "Blood Type",
                        "${userProfile["bloodType"]}",
                        Icons.bloodtype,
                        infoColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Activity
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
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildActivityItem(
                  "Blood pressure reading recorded",
                  "2 days ago • 135/82 mmHg",
                  Icons.monitor_heart,
                  primaryColor,
                ),
                _buildActivityItem(
                  "Blood sugar logged",
                  "Today • 142 mg/dL",
                  Icons.water_drop,
                  successColor,
                ),
                _buildActivityItem(
                  "Medication refill reminder",
                  "Metformin due in 5 days",
                  Icons.medication,
                  warningColor,
                ),
                _buildActivityItem(
                  "Appointment scheduled",
                  "Eye exam - June 15, 2024",
                  Icons.event,
                  infoColor,
                ),
              ],
            ),
          ),

          // Health Tips for Seniors
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
                  "Senior Health Tips",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildHealthTip(
                  "Stay Active",
                  "Regular gentle exercise helps maintain strength and balance",
                  Icons.directions_walk,
                  successColor,
                ),
                _buildHealthTip(
                  "Social Connection",
                  "Maintain relationships to support mental and emotional health",
                  Icons.people,
                  primaryColor,
                ),
                _buildHealthTip(
                  "Regular Checkups",
                  "Keep up with preventive care and routine screenings",
                  Icons.medical_information,
                  infoColor,
                ),
                _buildHealthTip(
                  "Medication Management",
                  "Use pill organizers and set reminders for medications",
                  Icons.schedule,
                  warningColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionsTab() {
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
                "Chronic Conditions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                label: "Add Condition",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          ...chronicConditions.map((condition) => _buildConditionCard(condition)),

          // Condition Management Tips
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
                  "Managing Multiple Conditions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildManagementTip(
                  "Medication Coordination",
                  "Work with your pharmacy to synchronize refill dates",
                  Icons.medication,
                  primaryColor,
                ),
                _buildManagementTip(
                  "Regular Monitoring",
                  "Keep track of symptoms and vital signs daily",
                  Icons.trending_up,
                  successColor,
                ),
                _buildManagementTip(
                  "Healthcare Team",
                  "Ensure all doctors know about your conditions and medications",
                  Icons.medical_services,
                  infoColor,
                ),
                _buildManagementTip(
                  "Lifestyle Modifications",
                  "Follow dietary and exercise recommendations consistently",
                  Icons.fitness_center,
                  warningColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationsTab() {
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
                "Current Medications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                label: "Add Medication",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          ...medications.map((medication) => _buildMedicationCard(medication)),

          // Medication Reminders
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(76)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Upcoming Refills",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Metformin - Due June 15, 2024\n• Lisinopril - Due June 20, 2024\n• Omega-3 - Due June 30, 2024",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Medication Safety
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
                  "Medication Safety Tips",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildSafetyTip(
                  "Use a pill organizer with daily compartments",
                  Icons.view_module,
                  primaryColor,
                ),
                _buildSafetyTip(
                  "Set alarms or reminders for medication times",
                  Icons.alarm,
                  successColor,
                ),
                _buildSafetyTip(
                  "Never stop medications without consulting your doctor",
                  Icons.warning,
                  dangerColor,
                ),
                _buildSafetyTip(
                  "Keep an updated medication list with you",
                  Icons.list_alt,
                  infoColor,
                ),
                _buildSafetyTip(
                  "Store medications properly - away from heat and moisture",
                  Icons.home,
                  warningColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalsTab() {
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
                "Vital Signs Monitoring",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                label: "Log Reading",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: vitalSigns.map((vital) {
              Color vitalColor = _getColorFromString(vital["color"]);
              return _buildVitalCard(vital, vitalColor);
            }).toList(),
          ),

          // Vital Signs Trends
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
                  "Trends & History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(12),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.show_chart, size: 40, color: primaryColor),
                      SizedBox(height: spSm),
                      Text(
                        "Vital Signs Chart",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Track your vitals over time",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Monitoring Guidelines
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
                  "Monitoring Guidelines",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildGuidelineItem(
                  "Blood Pressure",
                  "Check daily, same time each day",
                  "Target: <130/80 mmHg",
                ),
                _buildGuidelineItem(
                  "Blood Sugar",
                  "Check before meals and at bedtime",
                  "Target: 80-130 mg/dL before meals",
                ),
                _buildGuidelineItem(
                  "Weight",
                  "Weigh yourself weekly at the same time",
                  "Report sudden changes to doctor",
                ),
                _buildGuidelineItem(
                  "Heart Rate",
                  "Check pulse rate during vitals",
                  "Normal: 60-100 bpm at rest",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreventionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preventive Care Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...preventiveCare.map((care) => _buildPreventiveCareCard(care)),

          // Vaccination Schedule
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
                  "Recommended Vaccinations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildVaccinationItem("Annual Flu Shot", "Due October 2024", "Current"),
                _buildVaccinationItem("COVID-19 Booster", "Due December 2024", "Current"),
                _buildVaccinationItem("Pneumonia Vaccine", "Due 2027", "Current"),
                _buildVaccinationItem("Shingles Vaccine", "Completed 2023", "Complete"),
                _buildVaccinationItem("Tdap Booster", "Due 2029", "Current"),
              ],
            ),
          ),

          // Health Screening Importance
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(76)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Why Preventive Care Matters",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Regular screenings and preventive care help detect health issues early when they're most treatable. Staying up-to-date with recommended care can significantly improve your quality of life and health outcomes.",
                  style: TextStyle(
                    color: infoColor,
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

  Widget _buildSafetyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Senior Safety Guidelines",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...safetyTips.map((category) => _buildSafetyCategoryCard(category)),

          // Emergency Preparedness
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
                  "Emergency Kit Essentials",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildEmergencyItem("Medication list and 7-day supply", Icons.medication),
                _buildEmergencyItem("Medical alert bracelet or necklace", Icons.watch),
                _buildEmergencyItem("Emergency contact information", Icons.contact_phone),
                _buildEmergencyItem("Flashlight and extra batteries", Icons.flashlight_on),
                _buildEmergencyItem("First aid kit and supplies", Icons.medical_services),
                _buildEmergencyItem("Important documents (insurance, ID)", Icons.description),
              ],
            ),
          ),

          // Warning Signs
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
                      "Call 911 Immediately If You Experience:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Chest pain or pressure\n• Difficulty breathing\n• Sudden weakness or numbness\n• Severe dizziness or falls\n• Confusion or altered mental state\n• Severe bleeding that won't stop",
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

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, Color color) {
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
                subtitle,
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

  Widget _buildHealthTip(String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Icon(icon, color: color, size: 16),
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
                description,
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

  Widget _buildConditionCard(Map<String, dynamic> condition) {
    Color conditionColor = _getColorFromString(condition["color"]);

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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: conditionColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(condition["icon"], color: conditionColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${condition["condition"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Diagnosed: ${condition["diagnosedDate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: conditionColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${condition["status"]}",
                  style: TextStyle(
                    color: conditionColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Medication:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${condition["medication"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Latest Reading:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${condition["lastReading"]}",
                      style: TextStyle(
                        color: conditionColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(Map<String, dynamic> medication) {
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.medication, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${medication["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${medication["dosage"]} • ${medication["frequency"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Text(
            "Take: ${medication["timeToTake"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Text(
            "For: ${medication["indication"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Prescribed by: ${medication["prescribedBy"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 11,
                ),
              ),
              Text(
                "Refill: ${medication["refillDate"]}",
                style: TextStyle(
                  color: warningColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard(Map<String, dynamic> vital, Color color) {
    return Container(
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
              Icon(vital["icon"], color: color, size: 24),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${vital["vital"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${vital["current"]}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "Target: ${vital["target"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 11,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${vital["status"]}",
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "${vital["lastChecked"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildManagementTip(String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Icon(icon, color: color, size: 16),
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
                description,
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

  Widget _buildSafetyTip(String tip, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreventiveCareCard(Map<String, dynamic> care) {
    Color statusColor = care["status"] == "Overdue" ? dangerColor :
                       care["status"] == "Due Soon" || care["status"] == "Due Now" ? warningColor : successColor;

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
              Expanded(
                child: Text(
                  "${care["care"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${care["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Last: ${care["lastDate"]} • Next Due: ${care["nextDue"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Text(
            "${care["importance"]}",
            style: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaccinationItem(String vaccine, String schedule, String status) {
    Color statusColor = status == "Complete" ? successColor : 
                       status == "Current" ? primaryColor : warningColor;

    return Row(
      children: [
        Icon(Icons.vaccines, color: statusColor, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vaccine,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                schedule,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: statusColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuidelineItem(String vital, String frequency, String target) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vital,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: primaryColor,
          ),
        ),
        Text(
          frequency,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
        Text(
          target,
          style: TextStyle(
            color: successColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSafetyCategoryCard(Map<String, dynamic> category) {
    Color categoryColor = _getColorFromString(category["color"]);

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
                  color: categoryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(category["icon"], color: categoryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Text(
                "${category["category"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ...(category["tips"] as List).map((tip) => 
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: categoryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "$tip",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyItem(String item, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            item,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Color _getColorFromString(String colorString) {
    switch (colorString) {
      case "primary": return primaryColor;
      case "success": return successColor;
      case "warning": return warningColor;
      case "danger": return dangerColor;
      case "info": return infoColor;
      default: return primaryColor;
    }
  }
}
