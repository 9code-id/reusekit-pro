import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaPsychiatristView extends StatefulWidget {
  const MhaPsychiatristView({super.key});

  @override
  State<MhaPsychiatristView> createState() => _MhaPsychiatristViewState();
}

class _MhaPsychiatristViewState extends State<MhaPsychiatristView> {
  String searchQuery = "";
  String selectedSpecialty = "All";
  String selectedTherapyType = "All";
  String selectedAvailability = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> psychiatrists = [
    {
      "name": "Dr. Amanda Foster",
      "specialization": "Adult Psychiatry",
      "experience": "16 years",
      "rating": 4.9,
      "reviews": 324,
      "hospital": "Mental Health Institute",
      "location": "Downtown",
      "distance": "1.8 km",
      "consultationFee": 180.0,
      "isAvailable": true,
      "nextSlot": "Today 3:00 PM",
      "image": "https://picsum.photos/100/100?random=6&keyword=psychiatrist",
      "education": "MD, Psychiatry from Columbia University",
      "languages": ["English", "Spanish"],
      "therapyTypes": ["CBT", "DBT", "Psychodynamic"],
      "conditions": ["Depression", "Anxiety", "PTSD", "Bipolar Disorder"],
      "teletherapy": true,
      "inPerson": true
    },
    {
      "name": "Dr. Robert Kim",
      "specialization": "Child & Adolescent Psychiatry",
      "experience": "14 years",
      "rating": 4.8,
      "reviews": 267,
      "hospital": "Children's Mental Health Center",
      "location": "Midtown",
      "distance": "2.5 km",
      "consultationFee": 200.0,
      "isAvailable": true,
      "nextSlot": "Tomorrow 11:00 AM",
      "image": "https://picsum.photos/100/100?random=7&keyword=psychiatrist",
      "education": "MD from Stanford Medical School",
      "languages": ["English", "Korean"],
      "therapyTypes": ["Play Therapy", "Family Therapy", "CBT"],
      "conditions": ["ADHD", "Autism", "OCD", "Eating Disorders"],
      "teletherapy": true,
      "inPerson": true
    },
    {
      "name": "Dr. Sarah Martinez",
      "specialization": "Addiction Psychiatry",
      "experience": "19 years",
      "rating": 4.7,
      "reviews": 198,
      "hospital": "Recovery Center",
      "location": "West Side",
      "distance": "3.2 km",
      "consultationFee": 220.0,
      "isAvailable": false,
      "nextSlot": "Monday 2:00 PM",
      "image": "https://picsum.photos/100/100?random=8&keyword=psychiatrist",
      "education": "MD from University of California",
      "languages": ["English", "Spanish", "Portuguese"],
      "therapyTypes": ["Motivational Interviewing", "CBT", "Group Therapy"],
      "conditions": ["Substance Abuse", "Alcohol Addiction", "Drug Dependency", "Dual Diagnosis"],
      "teletherapy": true,
      "inPerson": true
    },
    {
      "name": "Dr. Jennifer Walsh",
      "specialization": "Geriatric Psychiatry",
      "experience": "22 years",
      "rating": 4.6,
      "reviews": 156,
      "hospital": "Senior Care Medical Center",
      "location": "Uptown",
      "distance": "4.1 km",
      "consultationFee": 190.0,
      "isAvailable": true,
      "nextSlot": "Today 5:30 PM",
      "image": "https://picsum.photos/100/100?random=9&keyword=psychiatrist",
      "education": "MD from Johns Hopkins",
      "languages": ["English"],
      "therapyTypes": ["Cognitive Therapy", "Reminiscence Therapy", "Behavioral Therapy"],
      "conditions": ["Dementia", "Late-life Depression", "Anxiety in Elderly", "Alzheimer's"],
      "teletherapy": false,
      "inPerson": true
    },
    {
      "name": "Dr. Michael Thompson",
      "specialization": "Forensic Psychiatry",
      "experience": "17 years",
      "rating": 4.5,
      "reviews": 89,
      "hospital": "Justice Medical Center",
      "location": "East Side",
      "distance": "5.0 km",
      "consultationFee": 250.0,
      "isAvailable": true,
      "nextSlot": "Tomorrow 9:00 AM",
      "image": "https://picsum.photos/100/100?random=10&keyword=psychiatrist",
      "education": "MD, JD from Harvard",
      "languages": ["English", "French"],
      "therapyTypes": ["Risk Assessment", "Court Evaluation", "Treatment Planning"],
      "conditions": ["Criminal Behavior", "Violence Risk", "Competency Evaluation", "Insanity Defense"],
      "teletherapy": false,
      "inPerson": true
    }
  ];

  List<Map<String, dynamic>> get filteredPsychiatrists {
    return psychiatrists.where((doctor) {
      final matchesSearch = searchQuery.isEmpty ||
          (doctor["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (doctor["specialization"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (doctor["hospital"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesSpecialty = selectedSpecialty == "All" ||
          (doctor["specialization"] as String).contains(selectedSpecialty);
      
      final matchesTherapy = selectedTherapyType == "All" ||
          (doctor["therapyTypes"] as List).any((type) => type == selectedTherapyType);
      
      final matchesAvailability = selectedAvailability == "All" ||
          (selectedAvailability == "Available Now" && (doctor["isAvailable"] as bool)) ||
          (selectedAvailability == "Teletherapy" && (doctor["teletherapy"] as bool));
      
      return matchesSearch && matchesSpecialty && matchesTherapy && matchesAvailability;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Psychiatrists"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.emergency),
            onPressed: _showEmergencyHelp,
          ),
        ],
      ),
      body: Column(
        children: [
          // Crisis Support Banner
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emergency,
                  color: dangerColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Crisis Support Available 24/7",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Call 988 for immediate mental health support",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Call Now",
                  size: bs.sm,
                  onPressed: () {
                    // Make emergency call
                  },
                ),
              ],
            ),
          ),

          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search psychiatrists...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.psychology,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Filters Section
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Specialty",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Adult Psychiatry", "value": "Adult"},
                            {"label": "Child & Adolescent", "value": "Child"},
                            {"label": "Addiction", "value": "Addiction"},
                            {"label": "Geriatric", "value": "Geriatric"},
                            {"label": "Forensic", "value": "Forensic"},
                          ],
                          value: selectedSpecialty,
                          onChanged: (value, label) {
                            selectedSpecialty = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Therapy Type",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "CBT", "value": "CBT"},
                            {"label": "DBT", "value": "DBT"},
                            {"label": "Family Therapy", "value": "Family Therapy"},
                            {"label": "Group Therapy", "value": "Group Therapy"},
                            {"label": "Play Therapy", "value": "Play Therapy"},
                          ],
                          value: selectedTherapyType,
                          onChanged: (value, label) {
                            selectedTherapyType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Availability",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Available Now", "value": "Available Now"},
                      {"label": "Teletherapy", "value": "Teletherapy"},
                      {"label": "In-Person", "value": "In-Person"},
                    ],
                    value: selectedAvailability,
                    onChanged: (value, label) {
                      selectedAvailability = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

          // Quick Access Options
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedAvailability = "Teletherapy";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_call,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Teletherapy",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedAvailability = "Available Now";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Available Now",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredPsychiatrists.length} psychiatrists found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.security,
                  size: 16,
                  color: successColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "HIPAA Compliant",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Psychiatrists List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredPsychiatrists.length,
              itemBuilder: (context, index) {
                final doctor = filteredPsychiatrists[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor Header
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${doctor["image"]}",
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${doctor["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        if (doctor["teletherapy"] as bool)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: spXs / 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: infoColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Icon(
                                              Icons.video_call,
                                              size: 12,
                                              color: infoColor,
                                            ),
                                          ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: spXs / 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: doctor["isAvailable"] as bool
                                                ? successColor.withAlpha(20)
                                                : warningColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            doctor["isAvailable"] as bool ? "Available" : "Busy",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: doctor["isAvailable"] as bool
                                                  ? successColor
                                                  : warningColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${doctor["specialization"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs / 2),
                                    Text(
                                      "${doctor["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      " (${doctor["reviews"]} reviews)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Therapy Types
                      Text(
                        "Therapy Approaches:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs / 2,
                        children: (doctor["therapyTypes"] as List).map((type) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: spXs / 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$type",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: spSm),

                      // Specialization Conditions
                      Text(
                        "Specializes in:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs / 2,
                        children: (doctor["conditions"] as List).take(3).map((condition) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: spXs / 2,
                            ),
                            decoration: BoxDecoration(
                              color: secondaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$condition",
                              style: TextStyle(
                                fontSize: 10,
                                color: secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: spSm),

                      // Location and Fee
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${doctor["location"]} • ${doctor["distance"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Next: ${doctor["nextSlot"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(doctor["consultationFee"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "per session",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Profile",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to psychiatrist detail
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: doctor["teletherapy"] as bool
                                  ? "Video Session"
                                  : "Book Appointment",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to booking
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyHelp() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.emergency,
                  color: dangerColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Text(
                  "Emergency Mental Health Support",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: dangerColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Crisis Lifeline: 988",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "24/7 suicide & crisis support",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Call",
                        size: bs.sm,
                        onPressed: () {
                          // Make emergency call
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.chat,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Crisis Text Line",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Text HOME to 741741",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Text",
                        size: bs.sm,
                        onPressed: () {
                          // Open texting
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "If you're experiencing thoughts of self-harm or suicide, please reach out immediately. You are not alone.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
