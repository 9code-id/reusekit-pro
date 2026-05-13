import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaDoctorSearchView extends StatefulWidget {
  const HcaDoctorSearchView({super.key});

  @override
  State<HcaDoctorSearchView> createState() => _HcaDoctorSearchViewState();
}

class _HcaDoctorSearchViewState extends State<HcaDoctorSearchView> {
  String searchQuery = "";
  String selectedSpecialty = "";
  String selectedLocation = "";
  String selectedInsurance = "";
  String selectedAvailability = "";
  String selectedRating = "";
  String sortBy = "Name";
  bool isAscending = true;

  final List<Map<String, dynamic>> specialties = [
    {"label": "All Specialties", "value": ""},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Dermatology", "value": "dermatology"},
    {"label": "General Medicine", "value": "general"},
    {"label": "Orthopedics", "value": "orthopedics"},
    {"label": "Pediatrics", "value": "pediatrics"},
    {"label": "Psychiatry", "value": "psychiatry"},
    {"label": "Surgery", "value": "surgery"},
  ];

  final List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": ""},
    {"label": "Building A", "value": "building_a"},
    {"label": "Building B", "value": "building_b"},
    {"label": "Building C", "value": "building_c"},
    {"label": "Building D", "value": "building_d"},
  ];

  final List<Map<String, dynamic>> insuranceOptions = [
    {"label": "All Insurance", "value": ""},
    {"label": "Blue Cross Blue Shield", "value": "bcbs"},
    {"label": "Aetna", "value": "aetna"},
    {"label": "Cigna", "value": "cigna"},
    {"label": "United Healthcare", "value": "united"},
    {"label": "Medicare", "value": "medicare"},
  ];

  final List<Map<String, dynamic>> availabilityOptions = [
    {"label": "Any Time", "value": ""},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "Next 2 Weeks", "value": "2weeks"},
    {"label": "Next Month", "value": "month"},
  ];

  final List<Map<String, dynamic>> ratingOptions = [
    {"label": "All Ratings", "value": ""},
    {"label": "4.5+ Stars", "value": "4.5"},
    {"label": "4.0+ Stars", "value": "4.0"},
    {"label": "3.5+ Stars", "value": "3.5"},
  ];

  final List<String> sortOptions = ["Name", "Rating", "Experience", "Availability"];

  final List<Map<String, dynamic>> doctors = [
    {
      "id": "DOC-001",
      "name": "Dr. Michael Chen",
      "specialty": "Cardiology",
      "subSpecialty": "Interventional Cardiology",
      "rating": 4.8,
      "experience": 15,
      "image": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "location": "Building A, Suite 205",
      "phone": "+1 (555) 123-4567",
      "email": "mchen@hospital.com",
      "education": "Harvard Medical School",
      "certifications": ["Board Certified Cardiologist", "Interventional Cardiology"],
      "languages": ["English", "Mandarin"],
      "acceptedInsurance": ["bcbs", "aetna", "cigna", "united"],
      "availability": "week",
      "nextAvailable": "Dec 28, 2024",
      "consultationFee": 200.00,
      "about": "Dr. Chen specializes in interventional cardiology with over 15 years of experience treating complex heart conditions.",
      "achievements": ["Top Doctor 2023", "Excellence in Patient Care Award"],
      "patientReviews": 324,
      "weeklySlots": 40,
      "bookedSlots": 28,
    },
    {
      "id": "DOC-002",
      "name": "Dr. Lisa Park",
      "specialty": "Dermatology",
      "subSpecialty": "Cosmetic Dermatology",
      "rating": 4.9,
      "experience": 12,
      "image": "https://picsum.photos/100/100?random=2&keyword=doctor",
      "location": "Building B, Suite 301",
      "phone": "+1 (555) 234-5678",
      "email": "lpark@hospital.com",
      "education": "Johns Hopkins Medical School",
      "certifications": ["Board Certified Dermatologist", "Cosmetic Surgery"],
      "languages": ["English", "Korean"],
      "acceptedInsurance": ["bcbs", "aetna", "united", "medicare"],
      "availability": "2weeks",
      "nextAvailable": "Jan 5, 2025",
      "consultationFee": 250.00,
      "about": "Dr. Park is a leading dermatologist specializing in both medical and cosmetic dermatology treatments.",
      "achievements": ["Best Dermatologist 2023", "Innovation in Skincare Award"],
      "patientReviews": 256,
      "weeklySlots": 35,
      "bookedSlots": 30,
    },
    {
      "id": "DOC-003",
      "name": "Dr. James Wilson",
      "specialty": "General Medicine",
      "subSpecialty": "Family Medicine",
      "rating": 4.7,
      "experience": 20,
      "image": "https://picsum.photos/100/100?random=3&keyword=doctor",
      "location": "Building A, Suite 103",
      "phone": "+1 (555) 345-6789",
      "email": "jwilson@hospital.com",
      "education": "Stanford Medical School",
      "certifications": ["Board Certified Family Medicine", "Geriatric Medicine"],
      "languages": ["English", "Spanish"],
      "acceptedInsurance": ["bcbs", "aetna", "cigna", "united", "medicare"],
      "availability": "today",
      "nextAvailable": "Dec 26, 2024",
      "consultationFee": 150.00,
      "about": "Dr. Wilson provides comprehensive family medicine care with a focus on preventive health and chronic disease management.",
      "achievements": ["Physician of the Year 2022", "Community Service Award"],
      "patientReviews": 512,
      "weeklySlots": 50,
      "bookedSlots": 35,
    },
    {
      "id": "DOC-004",
      "name": "Dr. Sarah Martinez",
      "specialty": "Pediatrics",
      "subSpecialty": "Adolescent Medicine",
      "rating": 4.9,
      "experience": 10,
      "image": "https://picsum.photos/100/100?random=4&keyword=doctor",
      "location": "Building C, Suite 201",
      "phone": "+1 (555) 456-7890",
      "email": "smartinez@hospital.com",
      "education": "UCLA Medical School",
      "certifications": ["Board Certified Pediatrician", "Adolescent Medicine"],
      "languages": ["English", "Spanish"],
      "acceptedInsurance": ["bcbs", "aetna", "united"],
      "availability": "month",
      "nextAvailable": "Jan 8, 2025",
      "consultationFee": 180.00,
      "about": "Dr. Martinez specializes in pediatric and adolescent medicine, providing compassionate care for children and teens.",
      "achievements": ["Outstanding Pediatrician 2023", "Patient Choice Award"],
      "patientReviews": 189,
      "weeklySlots": 30,
      "bookedSlots": 25,
    },
    {
      "id": "DOC-005",
      "name": "Dr. Robert Kim",
      "specialty": "Orthopedics",
      "subSpecialty": "Sports Medicine",
      "rating": 4.6,
      "experience": 18,
      "image": "https://picsum.photos/100/100?random=5&keyword=doctor",
      "location": "Building C, Suite 301",
      "phone": "+1 (555) 567-8901",
      "email": "rkim@hospital.com",
      "education": "Mayo Clinic Medical School",
      "certifications": ["Board Certified Orthopedic Surgeon", "Sports Medicine"],
      "languages": ["English", "Korean"],
      "acceptedInsurance": ["bcbs", "cigna", "united"],
      "availability": "2weeks",
      "nextAvailable": "Jan 10, 2025",
      "consultationFee": 275.00,
      "about": "Dr. Kim is an orthopedic surgeon specializing in sports injuries and joint replacement surgery.",
      "achievements": ["Top Orthopedic Surgeon 2023", "Research Excellence Award"],
      "patientReviews": 298,
      "weeklySlots": 25,
      "bookedSlots": 20,
    },
    {
      "id": "DOC-006",
      "name": "Dr. Emily Davis",
      "specialty": "Psychiatry",
      "subSpecialty": "Anxiety & Depression",
      "rating": 4.8,
      "experience": 14,
      "image": "https://picsum.photos/100/100?random=6&keyword=doctor",
      "location": "Building D, Suite 401",
      "phone": "+1 (555) 678-9012",
      "email": "edavis@hospital.com",
      "education": "Columbia Medical School",
      "certifications": ["Board Certified Psychiatrist", "Cognitive Behavioral Therapy"],
      "languages": ["English", "French"],
      "acceptedInsurance": ["bcbs", "aetna", "cigna", "medicare"],
      "availability": "week",
      "nextAvailable": "Jan 2, 2025",
      "consultationFee": 300.00,
      "about": "Dr. Davis specializes in treating anxiety, depression, and other mental health conditions using evidence-based approaches.",
      "achievements": ["Mental Health Advocate 2023", "Excellence in Therapy Award"],
      "patientReviews": 167,
      "weeklySlots": 20,
      "bookedSlots": 18,
    },
  ];

  List<Map<String, dynamic>> get filteredDoctors {
    List<Map<String, dynamic>> filtered = doctors;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((doctor) =>
          doctor["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          doctor["specialty"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          doctor["subSpecialty"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Apply specialty filter
    if (selectedSpecialty.isNotEmpty) {
      filtered = filtered.where((doctor) =>
          doctor["specialty"].toLowerCase() == selectedSpecialty.toLowerCase()
      ).toList();
    }

    // Apply location filter
    if (selectedLocation.isNotEmpty) {
      filtered = filtered.where((doctor) =>
          doctor["location"].toLowerCase().contains(selectedLocation.replaceAll('_', ' '))
      ).toList();
    }

    // Apply insurance filter
    if (selectedInsurance.isNotEmpty) {
      filtered = filtered.where((doctor) =>
          (doctor["acceptedInsurance"] as List).contains(selectedInsurance)
      ).toList();
    }

    // Apply availability filter
    if (selectedAvailability.isNotEmpty) {
      filtered = filtered.where((doctor) =>
          doctor["availability"] == selectedAvailability
      ).toList();
    }

    // Apply rating filter
    if (selectedRating.isNotEmpty) {
      double minRating = double.parse(selectedRating);
      filtered = filtered.where((doctor) =>
          (doctor["rating"] as double) >= minRating
      ).toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      int comparison = 0;
      switch (sortBy) {
        case "Name":
          comparison = a["name"].compareTo(b["name"]);
          break;
        case "Rating":
          comparison = (b["rating"] as double).compareTo(a["rating"] as double);
          break;
        case "Experience":
          comparison = (b["experience"] as int).compareTo(a["experience"] as int);
          break;
        case "Availability":
          List<String> availabilityOrder = ["today", "week", "2weeks", "month"];
          int aIndex = availabilityOrder.indexOf(a["availability"]);
          int bIndex = availabilityOrder.indexOf(b["availability"]);
          comparison = aIndex.compareTo(bIndex);
          break;
      }
      return isAscending ? comparison : -comparison;
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Doctor"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search doctors, specialties...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Quick Filters
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Quick Filters:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        selectedSpecialty = "";
                        selectedLocation = "";
                        selectedInsurance = "";
                        selectedAvailability = "";
                        selectedRating = "";
                        searchQuery = "";
                        setState(() {});
                      },
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Specialty",
                        items: specialties,
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
                        label: "Availability",
                        items: availabilityOptions,
                        value: selectedAvailability,
                        onChanged: (value, label) {
                          selectedAvailability = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Text(
                  "${filteredDoctors.length} doctors found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _showSortDialog();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sort: $sortBy",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spSm),

          // Doctors List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          // Doctor Image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusMd),
                              child: Image.network(
                                "${doctor["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          // Doctor Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${doctor["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${doctor["specialty"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (doctor["subSpecialty"].isNotEmpty) ...[
                                  Text(
                                    "${doctor["subSpecialty"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          Icons.star,
                                          size: 14,
                                          color: starIndex < (doctor["rating"] as double).floor() 
                                              ? warningColor 
                                              : disabledColor,
                                        );
                                      }),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${doctor["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "(${doctor["patientReviews"]} reviews)",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Availability Badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: doctor["availability"] == "today" 
                                  ? successColor.withAlpha(20)
                                  : doctor["availability"] == "week"
                                      ? infoColor.withAlpha(20)
                                      : warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              doctor["availability"] == "today" ? "Available Today" :
                              doctor["availability"] == "week" ? "This Week" :
                              doctor["availability"] == "2weeks" ? "Next 2 Weeks" :
                              "Next Month",
                              style: TextStyle(
                                fontSize: 10,
                                color: doctor["availability"] == "today" 
                                    ? successColor
                                    : doctor["availability"] == "week"
                                        ? infoColor
                                        : warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Experience and Location
                      Row(
                        children: [
                          Icon(
                            Icons.work,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${doctor["experience"]} years experience",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${doctor["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // About
                      Text(
                        "${doctor["about"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: spSm),

                      // Languages and Fee
                      Row(
                        children: [
                          Text(
                            "Languages: ${(doctor["languages"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Fee: \$${(doctor["consultationFee"] as double).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Availability Status
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 14,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Next available: ${doctor["nextAvailable"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(doctor["weeklySlots"] as int) - (doctor["bookedSlots"] as int)} slots available",
                              style: TextStyle(
                                fontSize: 11,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Profile",
                              size: bs.sm,
                              onPressed: () {
                                si("Opening profile for ${doctor["name"]}");
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Book Appointment",
                              size: bs.sm,
                              onPressed: () {
                                ss("Booking with ${doctor["name"]}");
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Advanced Filters"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDropdownField(
                label: "Location",
                items: locations,
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Insurance",
                items: insuranceOptions,
                value: selectedInsurance,
                onChanged: (value, label) {
                  selectedInsurance = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Minimum Rating",
                items: ratingOptions,
                value: selectedRating,
                onChanged: (value, label) {
                  selectedRating = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
              back();
            },
            child: Text("Apply Filters"),
          ),
        ],
      ),
    );
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sort Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Sort by",
              items: sortOptions.map((option) => {
                "label": option,
                "value": option,
              }).toList(),
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QSwitch(
              label: "Sort Order",
              items: [
                {
                  "label": "Ascending",
                  "value": true,
                  "checked": isAscending,
                }
              ],
              value: [if (isAscending) {"label": "Ascending", "value": true, "checked": true}],
              onChanged: (values, ids) {
                isAscending = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
              back();
            },
            child: Text("Apply Sort"),
          ),
        ],
      ),
    );
  }
}
