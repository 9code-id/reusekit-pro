import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaDentistView extends StatefulWidget {
  const MhaDentistView({super.key});

  @override
  State<MhaDentistView> createState() => _MhaDentistViewState();
}

class _MhaDentistViewState extends State<MhaDentistView> {
  List<Map<String, dynamic>> dentists = [
    {
      "id": "DEN001",
      "name": "Dr. Amanda Thompson",
      "specialty": "General Dentistry",
      "subSpecialty": "Cosmetic Dentistry",
      "rating": 4.9,
      "reviews": 145,
      "experience": 12,
      "education": "University of Pennsylvania School of Dental Medicine",
      "image": "https://picsum.photos/200/200?random=1&keyword=dentist",
      "clinic": "Bright Smile Dental Clinic",
      "location": "Downtown Dental Center",
      "distance": 1.8,
      "consultationFee": 180,
      "available": true,
      "nextSlot": "Today 2:30 PM",
      "languages": ["English", "Spanish"],
      "certifications": ["Board Certified", "Cosmetic Dentistry Specialist"],
      "services": ["Teeth Cleaning", "Teeth Whitening", "Veneers", "Root Canal", "Dental Implants"],
      "emergencyService": true,
    },
    {
      "id": "DEN002",
      "name": "Dr. James Rodriguez",
      "specialty": "Orthodontics",
      "subSpecialty": "Invisalign Specialist",
      "rating": 4.8,
      "reviews": 198,
      "experience": 15,
      "education": "Harvard School of Dental Medicine",
      "image": "https://picsum.photos/200/200?random=2&keyword=dentist",
      "clinic": "Perfect Smile Orthodontics",
      "location": "Medical Plaza",
      "distance": 2.4,
      "consultationFee": 220,
      "available": false,
      "nextSlot": "Tomorrow 10:00 AM",
      "languages": ["English", "Spanish", "Portuguese"],
      "certifications": ["Orthodontic Specialist", "Invisalign Provider"],
      "services": ["Braces", "Invisalign", "Retainers", "Bite Correction", "TMJ Treatment"],
      "emergencyService": false,
    },
    {
      "id": "DEN003",
      "name": "Dr. Sarah Kim",
      "specialty": "Pediatric Dentistry",
      "subSpecialty": "Children's Oral Health",
      "rating": 4.9,
      "reviews": 87,
      "experience": 8,
      "education": "Columbia University College of Dental Medicine",
      "image": "https://picsum.photos/200/200?random=3&keyword=dentist",
      "clinic": "Kids Dental Care",
      "location": "Family Health Center",
      "distance": 3.1,
      "consultationFee": 160,
      "available": true,
      "nextSlot": "Today 4:00 PM",
      "languages": ["English", "Korean"],
      "certifications": ["Pediatric Dental Specialist", "Sedation Dentistry"],
      "services": ["Pediatric Cleanings", "Fluoride Treatment", "Sealants", "Space Maintainers"],
      "emergencyService": true,
    },
    {
      "id": "DEN004",
      "name": "Dr. Michael Foster",
      "specialty": "Oral Surgery",
      "subSpecialty": "Implant Surgery",
      "rating": 4.7,
      "reviews": 112,
      "experience": 18,
      "education": "University of California San Francisco",
      "image": "https://picsum.photos/200/200?random=4&keyword=dentist",
      "clinic": "Advanced Oral Surgery Center",
      "location": "Surgical Specialty Building",
      "distance": 4.7,
      "consultationFee": 300,
      "available": true,
      "nextSlot": "Tomorrow 9:00 AM",
      "languages": ["English"],
      "certifications": ["Oral Surgery Specialist", "Implant Surgery Certified"],
      "services": ["Tooth Extraction", "Dental Implants", "Bone Grafting", "Wisdom Teeth"],
      "emergencyService": true,
    },
    {
      "id": "DEN005",
      "name": "Dr. Lisa Chen",
      "specialty": "Periodontics",
      "subSpecialty": "Gum Disease Treatment",
      "rating": 4.8,
      "reviews": 76,
      "experience": 10,
      "education": "New York University College of Dentistry",
      "image": "https://picsum.photos/200/200?random=5&keyword=dentist",
      "clinic": "Gum Health Specialists",
      "location": "Periodontal Care Center",
      "distance": 3.8,
      "consultationFee": 250,
      "available": false,
      "nextSlot": "Tomorrow 2:00 PM",
      "languages": ["English", "Mandarin"],
      "certifications": ["Periodontal Specialist", "Laser Therapy Certified"],
      "services": ["Gum Treatment", "Scaling", "Gum Surgery", "Laser Therapy", "Maintenance"],
      "emergencyService": false,
    },
  ];

  String searchQuery = "";
  String selectedSpecialty = "All";
  bool showAvailableOnly = false;
  bool showEmergencyOnly = false;
  String sortBy = "Rating";

  List<String> specialties = [
    "All", "General Dentistry", "Orthodontics", "Pediatric Dentistry", 
    "Oral Surgery", "Periodontics", "Endodontics"
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDentists = dentists.where((dentist) {
      bool matchesSearch = dentist["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          dentist["specialty"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          dentist["subSpecialty"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSpecialty = selectedSpecialty == "All" || dentist["specialty"] == selectedSpecialty;
      bool matchesAvailability = !showAvailableOnly || dentist["available"] == true;
      bool matchesEmergency = !showEmergencyOnly || dentist["emergencyService"] == true;
      
      return matchesSearch && matchesSpecialty && matchesAvailability && matchesEmergency;
    }).toList();

    // Sort dentists
    if (sortBy == "Rating") {
      filteredDentists.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    } else if (sortBy == "Experience") {
      filteredDentists.sort((a, b) => (b["experience"] as int).compareTo(a["experience"] as int));
    } else if (sortBy == "Fee") {
      filteredDentists.sort((a, b) => (a["consultationFee"] as int).compareTo(b["consultationFee"] as int));
    } else if (sortBy == "Distance") {
      filteredDentists.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Find Dentists"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.map),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
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
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search dentists...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Options
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Specialty",
                    items: specialties.map((specialty) => {
                      "label": specialty,
                      "value": specialty,
                    }).toList(),
                    value: selectedSpecialty,
                    onChanged: (value, label) {
                      selectedSpecialty = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: [
                      {"label": "Rating", "value": "Rating"},
                      {"label": "Experience", "value": "Experience"},
                      {"label": "Fee", "value": "Fee"},
                      {"label": "Distance", "value": "Distance"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Additional Filters
            QSwitch(
              items: [
                {
                  "label": "Available today only",
                  "value": "available",
                  "checked": showAvailableOnly,
                },
                {
                  "label": "Emergency services",
                  "value": "emergency",
                  "checked": showEmergencyOnly,
                }
              ],
              value: [
                if (showAvailableOnly) {"label": "Available today only", "value": "available", "checked": true},
                if (showEmergencyOnly) {"label": "Emergency services", "value": "emergency", "checked": true}
              ],
              onChanged: (values, ids) {
                showAvailableOnly = values.any((v) => v["value"] == "available");
                showEmergencyOnly = values.any((v) => v["value"] == "emergency");
                setState(() {});
              },
            ),

            // Results Count
            Text(
              "${filteredDentists.length} dentists found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Dentists List
            ...filteredDentists.map((dentist) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: dentist["available"] 
                      ? Border(left: BorderSide(width: 4, color: successColor))
                      : dentist["emergencyService"]
                          ? Border(left: BorderSide(width: 4, color: dangerColor))
                          : null,
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${dentist["image"]}",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${dentist["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    spacing: spXs,
                                    children: [
                                      if (dentist["available"] == true)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Available",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                        ),
                                      if (dentist["emergencyService"] == true)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: dangerColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Emergency",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: dangerColor,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                "${dentist["specialty"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: secondaryColor,
                                ),
                              ),
                              Text(
                                "${dentist["subSpecialty"]}",
                                style: TextStyle(
                                  fontSize: 12,
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
                                  SizedBox(width: 2),
                                  Text(
                                    "${dentist["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${dentist["reviews"]} reviews)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.work,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${dentist["experience"]} years experience",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Clinic Info
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_hospital,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${dentist["clinic"]}, ${dentist["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.school,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${dentist["education"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${dentist["distance"]} km",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Fee and Availability
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Consultation: \$${(dentist["consultationFee"] as int)}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.event_available,
                          size: 16,
                          color: dentist["available"] ? successColor : warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${dentist["nextSlot"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: dentist["available"] ? successColor : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // Services
                    Text(
                      "Services:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (dentist["services"] as List).map((service) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
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

                    // Certifications
                    if ((dentist["certifications"] as List).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Certifications:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            ...(dentist["certifications"] as List).map((cert) {
                              return Text(
                                "• $cert",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                    // Languages
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Languages: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (dentist["languages"] as List).join(", "),
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
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
                            label: dentist["available"] ? "Book Now" : "Schedule",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        QButton(
                          icon: Icons.call,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        QButton(
                          icon: Icons.directions,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        QButton(
                          icon: Icons.favorite_border,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Load More Button
            if (filteredDentists.length >= 5)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Dentists",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }
}
