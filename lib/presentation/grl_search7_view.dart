import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSearch7View extends StatefulWidget {
  @override
  State<GrlSearch7View> createState() => _GrlSearch7ViewState();
}

class _GrlSearch7ViewState extends State<GrlSearch7View> {
  String searchQuery = "";
  String selectedSpecialty = "all";
  String selectedLocation = "all";
  String selectedAvailability = "all";
  String selectedInsurance = "all";
  bool isEmergencyOnly = false;

  List<String> quickSearches = [
    "dentist near me",
    "cardiologist",
    "pediatrician",
    "dermatologist",
    "emergency care"
  ];

  List<Map<String, dynamic>> specialties = [
    {"label": "All Specialties", "value": "all"},
    {"label": "General Practice", "value": "general"},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Dermatology", "value": "dermatology"},
    {"label": "Pediatrics", "value": "pediatrics"},
    {"label": "Dentistry", "value": "dentistry"},
    {"label": "Orthopedics", "value": "orthopedics"}
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "all"},
    {"label": "Within 5 miles", "value": "5_miles"},
    {"label": "Within 10 miles", "value": "10_miles"},
    {"label": "Within 25 miles", "value": "25_miles"},
    {"label": "Any Distance", "value": "any"}
  ];

  List<Map<String, dynamic>> availability = [
    {"label": "All Times", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "Next 2 Weeks", "value": "two_weeks"},
    {"label": "Flexible", "value": "flexible"}
  ];

  List<Map<String, dynamic>> insurance = [
    {"label": "All Insurance", "value": "all"},
    {"label": "Blue Cross", "value": "blue_cross"},
    {"label": "Aetna", "value": "aetna"},
    {"label": "Cigna", "value": "cigna"},
    {"label": "Kaiser", "value": "kaiser"},
    {"label": "Self Pay", "value": "self_pay"}
  ];

  List<Map<String, dynamic>> doctors = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "specialty": "Cardiology",
      "title": "Cardiologist",
      "rating": 4.9,
      "reviews": 342,
      "experience": 15,
      "photo": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "clinic": "Heart Care Medical Center",
      "address": "123 Medical Drive, Downtown",
      "distance": "2.3 miles",
      "phone": "(555) 123-4567",
      "nextAvailable": "Today 3:00 PM",
      "acceptsInsurance": ["Blue Cross", "Aetna", "Cigna"],
      "languages": ["English", "Spanish"],
      "featured": true,
      "emergency": false,
      "telemedicine": true,
      "consultation_fee": 150,
      "education": "Harvard Medical School",
      "certifications": ["Board Certified Cardiologist", "Advanced Heart Failure"]
    },
    {
      "id": 2,
      "name": "Dr. Michael Chen",
      "specialty": "Dermatology",
      "title": "Dermatologist",
      "rating": 4.8,
      "reviews": 256,
      "experience": 12,
      "photo": "https://picsum.photos/100/100?random=2&keyword=doctor",
      "clinic": "Clear Skin Dermatology",
      "address": "456 Health Plaza, Midtown",
      "distance": "1.8 miles",
      "phone": "(555) 234-5678",
      "nextAvailable": "Tomorrow 10:30 AM",
      "acceptsInsurance": ["Kaiser", "Blue Cross", "Self Pay"],
      "languages": ["English", "Mandarin"],
      "featured": false,
      "emergency": false,
      "telemedicine": true,
      "consultation_fee": 120,
      "education": "UCSF Medical School",
      "certifications": ["Board Certified Dermatologist", "Mohs Surgery"]
    },
    {
      "id": 3,
      "name": "Dr. Emily Rodriguez",
      "specialty": "Pediatrics",
      "title": "Pediatrician",
      "rating": 4.9,
      "reviews": 189,
      "experience": 8,
      "photo": "https://picsum.photos/100/100?random=3&keyword=doctor",
      "clinic": "Children's Health Center",
      "address": "789 Kids Way, Suburbs",
      "distance": "3.5 miles",
      "phone": "(555) 345-6789",
      "nextAvailable": "Today 4:15 PM",
      "acceptsInsurance": ["Aetna", "Cigna", "Blue Cross"],
      "languages": ["English", "Spanish", "Portuguese"],
      "featured": true,
      "emergency": false,
      "telemedicine": false,
      "consultation_fee": 100,
      "education": "Johns Hopkins University",
      "certifications": ["Board Certified Pediatrician", "Child Development"]
    },
    {
      "id": 4,
      "name": "Dr. Robert Williams",
      "specialty": "General Practice",
      "title": "Family Medicine",
      "rating": 4.7,
      "reviews": 423,
      "experience": 20,
      "photo": "https://picsum.photos/100/100?random=4&keyword=doctor",
      "clinic": "Family Care Medical Group",
      "address": "321 Main Street, City Center",
      "distance": "0.8 miles",
      "phone": "(555) 456-7890",
      "nextAvailable": "Today 2:00 PM",
      "acceptsInsurance": ["Blue Cross", "Aetna", "Kaiser", "Cigna"],
      "languages": ["English"],
      "featured": false,
      "emergency": true,
      "telemedicine": true,
      "consultation_fee": 80,
      "education": "Stanford Medical School",
      "certifications": ["Board Certified Family Medicine", "Geriatric Care"]
    }
  ];

  List<Map<String, dynamic>> get filteredDoctors {
    List<Map<String, dynamic>> filtered = doctors;
    
    if (selectedSpecialty != "all") {
      filtered = filtered.where((doctor) => 
        doctor["specialty"].toString().toLowerCase().contains(selectedSpecialty.toLowerCase())
      ).toList();
    }
    
    if (isEmergencyOnly) {
      filtered = filtered.where((doctor) => doctor["emergency"] as bool).toList();
    }
    
    return filtered;
  }

  Color getSpecialtyColor(String specialty) {
    switch (specialty.toLowerCase()) {
      case "cardiology":
        return dangerColor;
      case "dermatology":
        return warningColor;
      case "pediatrics":
        return successColor;
      case "general practice":
        return infoColor;
      case "dentistry":
        return primaryColor;
      case "orthopedics":
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Doctors"),
        actions: [
          IconButton(
            icon: Icon(Icons.medical_services),
            onPressed: () {
              // Emergency services
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Favorite doctors
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Emergency Banner
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor),
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
                          "Medical Emergency?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Call 911 or visit your nearest emergency room",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Call 911",
                    size: bs.sm,
                    onPressed: () {
                      // Call emergency
                    },
                  ),
                ],
              ),
            ),

            // Search Bar
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Search doctors, specialties...",
                          value: searchQuery,
                          hint: "e.g. cardiologist, Dr. Smith",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.location_on,
                          color: primaryColor,
                        ),
                        onPressed: () {
                          // Use current location
                        },
                      ),
                    ],
                  ),
                  
                  // Quick Filters Row
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
                          items: availability,
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

            // Emergency Toggle
            QSwitch(
              items: [
                {
                  "label": "Emergency Care Only",
                  "value": true,
                  "checked": isEmergencyOnly,
                }
              ],
              value: [if (isEmergencyOnly) {"label": "Emergency Care Only", "value": true, "checked": true}],
              onChanged: (values, ids) {
                isEmergencyOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Content based on search state
            if (searchQuery.isEmpty) ...[
              // Quick Searches
              Text(
                "Popular Searches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: quickSearches.map((search) {
                    return GestureDetector(
                      onTap: () {
                        searchQuery = search;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowXs],
                          border: Border.all(color: primaryColor.withAlpha(50)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_hospital,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              search,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Featured Doctors
              SizedBox(height: spMd),
              Text(
                "Featured Doctors",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: doctors.where((doctor) => doctor["featured"] as bool).map((doctor) {
                  return Container(
                    width: 250,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                    child: Column(
                      children: [
                        // Featured Badge
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Featured Doctor",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Doctor Info
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            spacing: spXs,
                            children: [
                              // Photo and Basic Info
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusLg),
                                    child: Image.network(
                                      "${doctor["photo"]}",
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${doctor["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${doctor["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: warningColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${(doctor["rating"] as double).toStringAsFixed(1)}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "(${(doctor["reviews"] as int)})",
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

                              // Specialty Badge
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: getSpecialtyColor(doctor["specialty"]).withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${doctor["specialty"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: getSpecialtyColor(doctor["specialty"]),
                                  ),
                                ),
                              ),

                              // Location and Distance
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${doctor["clinic"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              // Next Available
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Next: ${doctor["nextAvailable"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ),

                              // Fee
                              Text(
                                "Consultation: \$${(doctor["consultation_fee"] as int)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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

              // Services
              SizedBox(height: spMd),
              Text(
                "Healthcare Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.all(spXs),
                minItemWidth: 200,
                children: [
                  {
                    "title": "Telemedicine",
                    "icon": Icons.video_call,
                    "description": "Virtual consultations from home",
                    "color": infoColor
                  },
                  {
                    "title": "Emergency Care",
                    "icon": Icons.emergency,
                    "description": "24/7 urgent medical care",
                    "color": dangerColor
                  },
                  {
                    "title": "Preventive Care",
                    "icon": Icons.health_and_safety,
                    "description": "Regular checkups and screenings",
                    "color": successColor
                  },
                  {
                    "title": "Specialist Care",
                    "icon": Icons.medical_services,
                    "description": "Expert care for specific conditions",
                    "color": primaryColor
                  }
                ].map((service) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (service["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            service["icon"] as IconData,
                            size: 32,
                            color: service["color"] as Color,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${service["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${service["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            // Search Results
            if (searchQuery.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredDoctors.length} doctors found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Sort: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Distance",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),

              // Doctor Cards
              Column(
                spacing: spSm,
                children: filteredDoctors.map((doctor) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: (doctor["featured"] as bool)
                          ? Border.all(color: primaryColor, width: 1)
                          : null,
                    ),
                    child: Column(
                      children: [
                        // Emergency/Featured Badges
                        if ((doctor["featured"] as bool) || (doctor["emergency"] as bool)) ...[
                          Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                if (doctor["featured"] as bool) ...[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(radiusSm),
                                          topRight: (doctor["emergency"] as bool) 
                                              ? Radius.zero 
                                              : Radius.circular(radiusSm),
                                        ),
                                      ),
                                      child: Text(
                                        "Featured",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                if (doctor["emergency"] as bool) ...[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: (doctor["featured"] as bool) 
                                              ? Radius.zero 
                                              : Radius.circular(radiusSm),
                                          topRight: Radius.circular(radiusSm),
                                        ),
                                      ),
                                      child: Text(
                                        "Emergency Care",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],

                        // Doctor Information
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              // Main Info Row
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusLg),
                                    child: Image.network(
                                      "${doctor["photo"]}",
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs,
                                      children: [
                                        Text(
                                          "${doctor["name"]}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${doctor["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: getSpecialtyColor(doctor["specialty"]).withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${doctor["specialty"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: getSpecialtyColor(doctor["specialty"]),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: warningColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${(doctor["rating"] as double).toStringAsFixed(1)}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "(${(doctor["reviews"] as int)} reviews)",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Text(
                                              "${(doctor["experience"] as int)} years exp.",
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
                                  if (doctor["telemedicine"] as bool) ...[
                                    Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.video_call,
                                        size: 20,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),

                              // Clinic Information
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${doctor["clinic"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            "${doctor["address"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${doctor["distance"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 16,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${doctor["phone"]}",
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

                              // Availability and Pricing
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Next Available",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: successColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${doctor["nextAvailable"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Consultation Fee",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "\$${(doctor["consultation_fee"] as int)}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // Insurance and Languages
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Accepts Insurance:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: spXs,
                                    children: (doctor["acceptsInsurance"] as List).map((insurance) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$insurance",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: infoColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),

                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Book Appointment",
                                      size: bs.sm,
                                      onPressed: () {
                                        // Book appointment
                                      },
                                    ),
                                  ),
                                  if (doctor["telemedicine"] as bool) ...[
                                    SizedBox(width: spSm),
                                    QButton(
                                      icon: Icons.video_call,
                                      size: bs.sm,
                                      onPressed: () {
                                        // Start video call
                                      },
                                    ),
                                  ],
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.favorite_border,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Add to favorites
                                    },
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
          ],
        ),
      ),
    );
  }
}
