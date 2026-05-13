import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaGynecologistView extends StatefulWidget {
  const MhaGynecologistView({super.key});

  @override
  State<MhaGynecologistView> createState() => _MhaGynecologistViewState();
}

class _MhaGynecologistViewState extends State<MhaGynecologistView> {
  String searchQuery = "";
  String selectedLocation = "All Locations";
  String selectedExperience = "All Experience";
  String selectedSpecialty = "All Specialties";
  String selectedAvailability = "All";

  List<Map<String, dynamic>> locationItems = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Downtown Medical Center", "value": "Downtown Medical Center"},
    {"label": "Westside Women's Clinic", "value": "Westside Women's Clinic"},
    {"label": "Eastside Health Plaza", "value": "Eastside Health Plaza"},
    {"label": "Northside Medical Complex", "value": "Northside Medical Complex"},
    {"label": "Southside Women's Center", "value": "Southside Women's Center"},
  ];

  List<Map<String, dynamic>> experienceItems = [
    {"label": "All Experience", "value": "All Experience"},
    {"label": "5+ Years", "value": "5+ Years"},
    {"label": "10+ Years", "value": "10+ Years"},
    {"label": "15+ Years", "value": "15+ Years"},
    {"label": "20+ Years", "value": "20+ Years"},
  ];

  List<Map<String, dynamic>> specialtyItems = [
    {"label": "All Specialties", "value": "All Specialties"},
    {"label": "General Gynecology", "value": "General Gynecology"},
    {"label": "Reproductive Endocrinology", "value": "Reproductive Endocrinology"},
    {"label": "Maternal-Fetal Medicine", "value": "Maternal-Fetal Medicine"},
    {"label": "Gynecologic Oncology", "value": "Gynecologic Oncology"},
    {"label": "Minimally Invasive Surgery", "value": "Minimally Invasive Surgery"},
  ];

  List<Map<String, dynamic>> availabilityItems = [
    {"label": "All", "value": "All"},
    {"label": "Available Today", "value": "Available Today"},
    {"label": "Available This Week", "value": "Available This Week"},
    {"label": "Emergency Available", "value": "Emergency Available"},
  ];

  List<Map<String, dynamic>> gynecologists = [
    {
      "id": 1,
      "name": "Dr. Sarah Mitchell",
      "specialty": "General Gynecology",
      "subSpecialty": "Women's Health & Preventive Care",
      "experience": 12,
      "rating": 4.8,
      "reviewCount": 156,
      "image": "https://picsum.photos/120/120?random=1&keyword=doctor",
      "location": "Downtown Medical Center",
      "address": "123 Health Plaza, Downtown",
      "phone": "+1 (555) 123-4567",
      "consultationFee": 150,
      "availableToday": true,
      "emergencyAvailable": false,
      "telemedicine": true,
      "education": "MD - Harvard Medical School",
      "certifications": ["Board Certified Gynecologist", "ACOG Fellow"],
      "languages": ["English", "Spanish"],
      "services": [
        "Annual Gynecologic Exams",
        "Pap Smear Testing",
        "Birth Control Counseling",
        "STD Testing & Treatment",
        "Menopause Management"
      ],
      "nextAvailable": "Today 2:30 PM",
      "insurance": ["Blue Cross", "Aetna", "Cigna", "UnitedHealth"],
    },
    {
      "id": 2,
      "name": "Dr. Emily Rodriguez",
      "specialty": "Reproductive Endocrinology",
      "subSpecialty": "Fertility & IVF Specialist",
      "experience": 15,
      "rating": 4.9,
      "reviewCount": 203,
      "image": "https://picsum.photos/120/120?random=2&keyword=doctor",
      "location": "Westside Women's Clinic",
      "address": "456 Fertility Avenue, Westside",
      "phone": "+1 (555) 234-5678",
      "consultationFee": 200,
      "availableToday": false,
      "emergencyAvailable": false,
      "telemedicine": true,
      "education": "MD, PhD - Johns Hopkins University",
      "certifications": ["Board Certified REI", "IVF Specialist"],
      "languages": ["English", "Portuguese"],
      "services": [
        "Fertility Evaluation",
        "IVF Treatment",
        "Egg Freezing",
        "Hormone Therapy",
        "PCOS Treatment"
      ],
      "nextAvailable": "Tomorrow 10:00 AM",
      "insurance": ["Blue Cross", "Aetna", "Kaiser"],
    },
    {
      "id": 3,
      "name": "Dr. Jennifer Park",
      "specialty": "Maternal-Fetal Medicine",
      "subSpecialty": "High-Risk Pregnancy Specialist",
      "experience": 18,
      "rating": 4.7,
      "reviewCount": 128,
      "image": "https://picsum.photos/120/120?random=3&keyword=doctor",
      "location": "Eastside Health Plaza",
      "address": "789 Maternal Care Blvd, Eastside",
      "phone": "+1 (555) 345-6789",
      "consultationFee": 180,
      "availableToday": true,
      "emergencyAvailable": true,
      "telemedicine": false,
      "education": "MD - Stanford Medical School",
      "certifications": ["Board Certified MFM", "Ultrasound Specialist"],
      "languages": ["English", "Korean", "Mandarin"],
      "services": [
        "High-Risk Pregnancy Care",
        "Genetic Counseling",
        "Prenatal Diagnosis",
        "Fetal Surgery Consultation",
        "Multiple Pregnancy Management"
      ],
      "nextAvailable": "Today 4:15 PM",
      "insurance": ["Blue Cross", "Cigna", "UnitedHealth", "Medicare"],
    },
    {
      "id": 4,
      "name": "Dr. Amanda Thompson",
      "specialty": "Gynecologic Oncology",
      "subSpecialty": "Cancer Treatment Specialist",
      "experience": 20,
      "rating": 4.9,
      "reviewCount": 94,
      "image": "https://picsum.photos/120/120?random=4&keyword=doctor",
      "location": "Northside Medical Complex",
      "address": "321 Cancer Care Center, Northside",
      "phone": "+1 (555) 456-7890",
      "consultationFee": 250,
      "availableToday": false,
      "emergencyAvailable": true,
      "telemedicine": true,
      "education": "MD - Mayo Clinic School of Medicine",
      "certifications": ["Board Certified Gyn Oncology", "Surgical Oncology"],
      "languages": ["English", "French"],
      "services": [
        "Gynecologic Cancer Treatment",
        "Ovarian Cancer Surgery",
        "Cervical Cancer Treatment",
        "Endometrial Cancer Care",
        "Chemotherapy Management"
      ],
      "nextAvailable": "Monday 9:00 AM",
      "insurance": ["Blue Cross", "Aetna", "Cigna", "UnitedHealth"],
    },
    {
      "id": 5,
      "name": "Dr. Lisa Chen",
      "specialty": "Minimally Invasive Surgery",
      "subSpecialty": "Robotic & Laparoscopic Surgery",
      "experience": 14,
      "rating": 4.8,
      "reviewCount": 167,
      "image": "https://picsum.photos/120/120?random=5&keyword=doctor",
      "location": "Southside Women's Center",
      "address": "654 Surgical Plaza, Southside",
      "phone": "+1 (555) 567-8901",
      "consultationFee": 175,
      "availableToday": true,
      "emergencyAvailable": false,
      "telemedicine": true,
      "education": "MD - UCLA School of Medicine",
      "certifications": ["Board Certified MIGS", "Robotic Surgery Certified"],
      "languages": ["English", "Mandarin", "Cantonese"],
      "services": [
        "Laparoscopic Surgery",
        "Robotic Hysterectomy",
        "Endometriosis Treatment",
        "Fibroid Removal",
        "Pelvic Floor Repair"
      ],
      "nextAvailable": "Today 1:45 PM",
      "insurance": ["Blue Cross", "Aetna", "Kaiser", "UnitedHealth"],
    },
  ];

  List<Map<String, dynamic>> get filteredGynecologists {
    return gynecologists.where((gynecologist) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${gynecologist["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${gynecologist["specialty"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${gynecologist["subSpecialty"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesLocation = selectedLocation == "All Locations" ||
          gynecologist["location"] == selectedLocation;
      
      bool matchesExperience = selectedExperience == "All Experience" ||
          (selectedExperience == "5+ Years" && (gynecologist["experience"] as int) >= 5) ||
          (selectedExperience == "10+ Years" && (gynecologist["experience"] as int) >= 10) ||
          (selectedExperience == "15+ Years" && (gynecologist["experience"] as int) >= 15) ||
          (selectedExperience == "20+ Years" && (gynecologist["experience"] as int) >= 20);
      
      bool matchesSpecialty = selectedSpecialty == "All Specialties" ||
          gynecologist["specialty"] == selectedSpecialty;
      
      bool matchesAvailability = selectedAvailability == "All" ||
          (selectedAvailability == "Available Today" && gynecologist["availableToday"] == true) ||
          (selectedAvailability == "Available This Week" && (gynecologist["availableToday"] == true || "${gynecologist["nextAvailable"]}".contains("Tomorrow"))) ||
          (selectedAvailability == "Emergency Available" && gynecologist["emergencyAvailable"] == true);
      
      return matchesSearch && matchesLocation && matchesExperience && matchesSpecialty && matchesAvailability;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gynecologists"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navigate to favorites
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search gynecologists, specialties...",
              value: searchQuery,
              hint: "Dr. Smith, fertility specialist, PCOS...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Quick Filters
            Text(
              "Quick Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locationItems,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Experience",
                    items: experienceItems,
                    value: selectedExperience,
                    onChanged: (value, label) {
                      selectedExperience = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Specialty",
                    items: specialtyItems,
                    value: selectedSpecialty,
                    onChanged: (value, label) {
                      selectedSpecialty = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Availability",
                    items: availabilityItems,
                    value: selectedAvailability,
                    onChanged: (value, label) {
                      selectedAvailability = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredGynecologists.length} Gynecologists Found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spXs,
                  children: [
                    Icon(
                      Icons.sort,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "Sort by Rating",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Emergency Notice
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.emergency,
                    color: dangerColor,
                    size: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emergency Gynecological Care",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "For urgent gynecological issues, call 911 or visit the nearest ER",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Gynecologists List
            ...filteredGynecologists.map((gynecologist) => _buildGynecologistCard(gynecologist)),
          ],
        ),
      ),
    );
  }

  Widget _buildGynecologistCard(Map<String, dynamic> gynecologist) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${gynecologist["image"]}",
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${gynecologist["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                          onPressed: () {
                            // Add to favorites
                          },
                        ),
                      ],
                    ),
                    Text(
                      "${gynecologist["specialty"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      "${gynecologist["subSpecialty"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      spacing: spXs,
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 14,
                        ),
                        Text(
                          "${gynecologist["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "(${gynecologist["reviewCount"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text("•", style: TextStyle(color: disabledBoldColor)),
                        Text(
                          "${gynecologist["experience"]} years exp",
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

          // Education & Certifications
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: spXs,
                  children: [
                    Icon(
                      Icons.school,
                      size: 14,
                      color: infoColor,
                    ),
                    Expanded(
                      child: Text(
                        "${gynecologist["education"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spXs,
                  children: [
                    Icon(
                      Icons.verified,
                      size: 14,
                      color: successColor,
                    ),
                    Expanded(
                      child: Text(
                        "${(gynecologist["certifications"] as List).join(", ")}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Location & Contact
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Row(
                  spacing: spXs,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: primaryColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${gynecologist["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${gynecologist["address"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Call doctor
                },
                child: Row(
                  spacing: spXs,
                  children: [
                    Icon(
                      Icons.phone,
                      size: 14,
                      color: successColor,
                    ),
                    Text(
                      "Call",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Services
          Column(
            spacing: spXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Specializes in:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (gynecologist["services"] as List).take(3).map((service) => Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: secondaryColor.withAlpha(30)),
                  ),
                  child: Text(
                    "$service",
                    style: TextStyle(
                      fontSize: 10,
                      color: secondaryColor,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),

          // Availability & Features
          Row(
            spacing: spSm,
            children: [
              if (gynecologist["availableToday"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: successColor,
                      ),
                      Text(
                        "Available Today",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              if (gynecologist["emergencyAvailable"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.emergency,
                        size: 10,
                        color: dangerColor,
                      ),
                      Text(
                        "Emergency",
                        style: TextStyle(
                          fontSize: 10,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              if (gynecologist["telemedicine"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.video_call,
                        size: 10,
                        color: infoColor,
                      ),
                      Text(
                        "Telemedicine",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // Fee & Next Available
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Consultation Fee",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${gynecologist["consultationFee"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Next Available",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${gynecologist["nextAvailable"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Languages
          Row(
            spacing: spXs,
            children: [
              Icon(
                Icons.language,
                size: 12,
                color: disabledBoldColor,
              ),
              Text(
                "Languages: ${(gynecologist["languages"] as List).join(", ")}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to gynecologist profile
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Book Appointment",
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
  }
}
