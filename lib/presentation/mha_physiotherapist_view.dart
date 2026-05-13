import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaPhysiotherapistView extends StatefulWidget {
  const MhaPhysiotherapistView({super.key});

  @override
  State<MhaPhysiotherapistView> createState() => _MhaPhysiotherapistViewState();
}

class _MhaPhysiotherapistViewState extends State<MhaPhysiotherapistView> {
  String searchQuery = "";
  String selectedSpecialty = "All";
  String selectedServiceType = "All";
  String selectedExperience = "All";
  bool showFilters = false;
  int selectedTabIndex = 0;

  List<Map<String, dynamic>> physiotherapists = [
    {
      "name": "Dr. Lisa Anderson",
      "specialization": "Orthopedic Physiotherapy",
      "experience": "12 years",
      "rating": 4.9,
      "reviews": 287,
      "clinic": "Sports Medicine Center",
      "location": "Downtown",
      "distance": "1.5 km",
      "consultationFee": 85.0,
      "sessionFee": 65.0,
      "isAvailable": true,
      "nextSlot": "Today 2:00 PM",
      "image": "https://picsum.photos/100/100?random=11&keyword=physiotherapist",
      "education": "DPT from University of Pittsburgh",
      "languages": ["English", "Spanish"],
      "specialties": ["Sports Injuries", "Post-Surgery Rehab", "Back Pain", "Joint Mobility"],
      "services": ["Manual Therapy", "Exercise Therapy", "Dry Needling", "Ultrasound"],
      "homeVisit": true,
      "telehealth": false
    },
    {
      "name": "Dr. Mark Thompson",
      "specialization": "Neurological Physiotherapy",
      "experience": "15 years",
      "rating": 4.8,
      "reviews": 234,
      "clinic": "Neuro Rehabilitation Center",
      "location": "Midtown",
      "distance": "2.8 km",
      "consultationFee": 95.0,
      "sessionFee": 75.0,
      "isAvailable": true,
      "nextSlot": "Tomorrow 10:30 AM",
      "image": "https://picsum.photos/100/100?random=12&keyword=physiotherapist",
      "education": "DPT from Northwestern University",
      "languages": ["English"],
      "specialties": ["Stroke Recovery", "Spinal Cord Injury", "Parkinson's Disease", "Balance Disorders"],
      "services": ["Gait Training", "Balance Training", "Functional Mobility", "Adaptive Equipment"],
      "homeVisit": true,
      "telehealth": true
    },
    {
      "name": "Dr. Sarah Kim",
      "specialization": "Pediatric Physiotherapy",
      "experience": "10 years",
      "rating": 4.9,
      "reviews": 198,
      "clinic": "Children's Therapy Center",
      "location": "West Side",
      "distance": "3.2 km",
      "consultationFee": 90.0,
      "sessionFee": 70.0,
      "isAvailable": false,
      "nextSlot": "Monday 11:00 AM",
      "image": "https://picsum.photos/100/100?random=13&keyword=physiotherapist",
      "education": "DPT from Boston University",
      "languages": ["English", "Korean"],
      "specialties": ["Developmental Delays", "Cerebral Palsy", "Muscular Dystrophy", "Autism Spectrum"],
      "services": ["Play-Based Therapy", "Sensory Integration", "Motor Skills Training", "Family Education"],
      "homeVisit": false,
      "telehealth": true
    },
    {
      "name": "Dr. Michael Johnson",
      "specialization": "Cardiopulmonary Physiotherapy",
      "experience": "18 years",
      "rating": 4.7,
      "reviews": 156,
      "clinic": "Heart & Lung Rehab Center",
      "location": "Uptown",
      "distance": "4.1 km",
      "consultationFee": 100.0,
      "sessionFee": 80.0,
      "isAvailable": true,
      "nextSlot": "Today 4:30 PM",
      "image": "https://picsum.photos/100/100?random=14&keyword=physiotherapist",
      "education": "DPT from Duke University",
      "languages": ["English", "German"],
      "specialties": ["Cardiac Rehab", "Pulmonary Rehab", "COPD Management", "Post-Surgery Recovery"],
      "services": ["Exercise Training", "Breathing Techniques", "Endurance Building", "Lifestyle Counseling"],
      "homeVisit": false,
      "telehealth": true
    },
    {
      "name": "Dr. Jennifer Martinez",
      "specialization": "Women's Health Physiotherapy",
      "experience": "14 years",
      "rating": 4.8,
      "reviews": 312,
      "clinic": "Women's Wellness Center",
      "location": "East Side",
      "distance": "3.8 km",
      "consultationFee": 88.0,
      "sessionFee": 68.0,
      "isAvailable": true,
      "nextSlot": "Tomorrow 1:15 PM",
      "image": "https://picsum.photos/100/100?random=15&keyword=physiotherapist",
      "education": "DPT from Emory University",
      "languages": ["English", "Spanish"],
      "specialties": ["Pelvic Floor Dysfunction", "Prenatal Care", "Postpartum Recovery", "Incontinence"],
      "services": ["Pelvic Floor Training", "Core Strengthening", "Prenatal Exercise", "Pain Management"],
      "homeVisit": true,
      "telehealth": true
    }
  ];

  List<Map<String, dynamic>> get filteredPhysiotherapists {
    return physiotherapists.where((therapist) {
      final matchesSearch = searchQuery.isEmpty ||
          (therapist["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (therapist["specialization"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (therapist["clinic"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesSpecialty = selectedSpecialty == "All" ||
          (therapist["specialization"] as String).contains(selectedSpecialty);
      
      final matchesService = selectedServiceType == "All" ||
          (selectedServiceType == "Home Visit" && (therapist["homeVisit"] as bool)) ||
          (selectedServiceType == "Telehealth" && (therapist["telehealth"] as bool)) ||
          (selectedServiceType == "In-Clinic");
      
      final matchesExperience = selectedExperience == "All" ||
          _matchesExperienceFilter(therapist["experience"] as String);
      
      return matchesSearch && matchesSpecialty && matchesService && matchesExperience;
    }).toList();
  }

  bool _matchesExperienceFilter(String experience) {
    final years = int.tryParse(experience.split(' ')[0]) ?? 0;
    switch (selectedExperience) {
      case "0-5 years":
        return years <= 5;
      case "5-10 years":
        return years > 5 && years <= 10;
      case "10+ years":
        return years > 10;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Physiotherapists"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showPhysioInfo,
          ),
        ],
      ),
      body: Column(
        children: [
          // Service Types Quick Access
          Container(
            margin: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: _buildServiceCard(
                    "In-Clinic",
                    Icons.local_hospital,
                    primaryColor,
                    "Professional equipment\nFull assessment",
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildServiceCard(
                    "Home Visit",
                    Icons.home,
                    successColor,
                    "Convenient care\nComfort of home",
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildServiceCard(
                    "Telehealth",
                    Icons.video_call,
                    infoColor,
                    "Remote guidance\nExercise coaching",
                  ),
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
                    label: "Search physiotherapists...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
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
                            {"label": "Orthopedic", "value": "Orthopedic"},
                            {"label": "Neurological", "value": "Neurological"},
                            {"label": "Pediatric", "value": "Pediatric"},
                            {"label": "Cardiopulmonary", "value": "Cardiopulmonary"},
                            {"label": "Women's Health", "value": "Women's Health"},
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
                          label: "Service Type",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "In-Clinic", "value": "In-Clinic"},
                            {"label": "Home Visit", "value": "Home Visit"},
                            {"label": "Telehealth", "value": "Telehealth"},
                          ],
                          value: selectedServiceType,
                          onChanged: (value, label) {
                            selectedServiceType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Experience",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "0-5 years", "value": "0-5 years"},
                      {"label": "5-10 years", "value": "5-10 years"},
                      {"label": "10+ years", "value": "10+ years"},
                    ],
                    value: selectedExperience,
                    onChanged: (value, label) {
                      selectedExperience = value;
                      setState(() {});
                    },
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
                  "${filteredPhysiotherapists.length} physiotherapists found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.verified,
                  size: 16,
                  color: successColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Licensed Professionals",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Physiotherapists List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredPhysiotherapists.length,
              itemBuilder: (context, index) {
                final therapist = filteredPhysiotherapists[index];
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
                      // Therapist Header
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${therapist["image"]}",
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
                                        "${therapist["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        if (therapist["homeVisit"] as bool)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: spXs / 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: successColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Icon(
                                              Icons.home,
                                              size: 12,
                                              color: successColor,
                                            ),
                                          ),
                                        SizedBox(width: spXs / 2),
                                        if (therapist["telehealth"] as bool)
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
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${therapist["specialization"]}",
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
                                      "${therapist["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      " (${therapist["reviews"]} reviews)",
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

                      // Specialties
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
                        children: (therapist["specialties"] as List).take(3).map((specialty) {
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
                              "$specialty",
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

                      // Services Offered
                      Text(
                        "Services:",
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
                        children: (therapist["services"] as List).take(3).map((service) {
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
                              "$service",
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

                      // Location and Fees
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
                                      "${therapist["location"]} • ${therapist["distance"]}",
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
                                      "Next: ${therapist["nextSlot"]}",
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
                                "\$${(therapist["sessionFee"] as double).toStringAsFixed(0)}",
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
                              Text(
                                "Consultation: \$${(therapist["consultationFee"] as double).toStringAsFixed(0)}",
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
                                // Navigate to therapist detail
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Book Session",
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

  Widget _buildServiceCard(String title, IconData icon, Color color, String description) {
    return GestureDetector(
      onTap: () {
        selectedServiceType = title;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: selectedServiceType == title 
                ? color 
                : color.withAlpha(30),
            width: selectedServiceType == title ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            SizedBox(height: spXs),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPhysioInfo() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Physiotherapy",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Physiotherapy helps restore movement and function when someone is affected by injury, illness, or disability.",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Icon(Icons.healing, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Treatment of injuries and movement disorders",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.fitness_center, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Exercise therapy and strength training",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.accessibility_new, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Pain management and mobility improvement",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
