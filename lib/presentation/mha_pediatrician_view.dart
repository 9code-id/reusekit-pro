import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaPediatricianView extends StatefulWidget {
  const MhaPediatricianView({super.key});

  @override
  State<MhaPediatricianView> createState() => _MhaPediatricianViewState();
}

class _MhaPediatricianViewState extends State<MhaPediatricianView> {
  List<Map<String, dynamic>> pediatricians = [
    {
      "id": "PED001",
      "name": "Dr. Emily Johnson",
      "specialty": "Pediatrics",
      "subSpecialty": "General Pediatrics",
      "rating": 4.9,
      "reviews": 234,
      "experience": 15,
      "education": "Johns Hopkins School of Medicine",
      "image": "https://picsum.photos/200/200?random=1&keyword=pediatrician",
      "hospital": "Children's Medical Center",
      "location": "Pediatric Wing",
      "distance": 2.1,
      "consultationFee": 200,
      "available": true,
      "nextSlot": "Today 3:00 PM",
      "languages": ["English", "Spanish"],
      "ageGroups": ["Newborn", "Infant", "Toddler", "School Age", "Adolescent"],
      "specializations": ["Well-child visits", "Immunizations", "Growth monitoring", "Behavioral health"],
      "emergencyService": true,
      "telehealth": true,
    },
    {
      "id": "PED002",
      "name": "Dr. Michael Rodriguez",
      "specialty": "Pediatric Cardiology",
      "subSpecialty": "Congenital Heart Disease",
      "rating": 4.8,
      "reviews": 156,
      "experience": 18,
      "education": "Harvard Medical School",
      "image": "https://picsum.photos/200/200?random=2&keyword=pediatrician",
      "hospital": "Children's Heart Institute",
      "location": "Cardiac Care Center",
      "distance": 3.4,
      "consultationFee": 350,
      "available": false,
      "nextSlot": "Tomorrow 10:00 AM",
      "languages": ["English", "Spanish", "Portuguese"],
      "ageGroups": ["Newborn", "Infant", "Toddler", "School Age", "Adolescent"],
      "specializations": ["Heart defects", "Cardiac surgery", "Echo studies", "Heart rhythm disorders"],
      "emergencyService": true,
      "telehealth": false,
    },
    {
      "id": "PED003",
      "name": "Dr. Sarah Kim",
      "specialty": "Pediatric Neurology",
      "subSpecialty": "Developmental Neurology",
      "rating": 4.9,
      "reviews": 89,
      "experience": 12,
      "education": "Stanford School of Medicine",
      "image": "https://picsum.photos/200/200?random=3&keyword=pediatrician",
      "hospital": "Neurological Development Center",
      "location": "Pediatric Neuro Wing",
      "distance": 4.2,
      "consultationFee": 320,
      "available": true,
      "nextSlot": "Today 4:30 PM",
      "languages": ["English", "Korean"],
      "ageGroups": ["Infant", "Toddler", "School Age", "Adolescent"],
      "specializations": ["Autism evaluation", "ADHD", "Epilepsy", "Learning disabilities"],
      "emergencyService": false,
      "telehealth": true,
    },
    {
      "id": "PED004",
      "name": "Dr. David Wilson",
      "specialty": "Pediatric Pulmonology",
      "subSpecialty": "Asthma & Allergies",
      "rating": 4.7,
      "reviews": 178,
      "experience": 14,
      "education": "University of California San Francisco",
      "image": "https://picsum.photos/200/200?random=4&keyword=pediatrician",
      "hospital": "Children's Respiratory Center",
      "location": "Pulmonary Care Unit",
      "distance": 2.8,
      "consultationFee": 280,
      "available": true,
      "nextSlot": "Tomorrow 11:00 AM",
      "languages": ["English"],
      "ageGroups": ["Infant", "Toddler", "School Age", "Adolescent"],
      "specializations": ["Asthma management", "Allergies", "Breathing disorders", "Sleep studies"],
      "emergencyService": true,
      "telehealth": true,
    },
    {
      "id": "PED005",
      "name": "Dr. Lisa Chen",
      "specialty": "Adolescent Medicine",
      "subSpecialty": "Teen Health & Development",
      "rating": 4.8,
      "reviews": 134,
      "experience": 10,
      "education": "Columbia University College of Physicians",
      "image": "https://picsum.photos/200/200?random=5&keyword=pediatrician",
      "hospital": "Teen Health Clinic",
      "location": "Adolescent Care Center",
      "distance": 1.9,
      "consultationFee": 220,
      "available": false,
      "nextSlot": "Tomorrow 2:00 PM",
      "languages": ["English", "Mandarin"],
      "ageGroups": ["Adolescent"],
      "specializations": ["Puberty counseling", "Mental health", "Sports medicine", "Reproductive health"],
      "emergencyService": false,
      "telehealth": true,
    },
  ];

  String searchQuery = "";
  String selectedSpecialty = "All";
  String selectedAgeGroup = "All";
  bool showAvailableOnly = false;
  bool showTelehealthOnly = false;
  String sortBy = "Rating";

  List<String> specialties = [
    "All", "General Pediatrics", "Pediatric Cardiology", "Pediatric Neurology", 
    "Pediatric Pulmonology", "Adolescent Medicine", "Pediatric Gastroenterology"
  ];

  List<String> ageGroups = [
    "All", "Newborn", "Infant", "Toddler", "School Age", "Adolescent"
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPediatricians = pediatricians.where((pediatrician) {
      bool matchesSearch = pediatrician["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          pediatrician["specialty"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          pediatrician["subSpecialty"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSpecialty = selectedSpecialty == "All" || pediatrician["specialty"].toString().contains(selectedSpecialty) || pediatrician["subSpecialty"].toString().contains(selectedSpecialty);
      bool matchesAgeGroup = selectedAgeGroup == "All" || (pediatrician["ageGroups"] as List).contains(selectedAgeGroup);
      bool matchesAvailability = !showAvailableOnly || pediatrician["available"] == true;
      bool matchesTelehealth = !showTelehealthOnly || pediatrician["telehealth"] == true;
      
      return matchesSearch && matchesSpecialty && matchesAgeGroup && matchesAvailability && matchesTelehealth;
    }).toList();

    // Sort pediatricians
    if (sortBy == "Rating") {
      filteredPediatricians.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    } else if (sortBy == "Experience") {
      filteredPediatricians.sort((a, b) => (b["experience"] as int).compareTo(a["experience"] as int));
    } else if (sortBy == "Fee") {
      filteredPediatricians.sort((a, b) => (a["consultationFee"] as int).compareTo(b["consultationFee"] as int));
    } else if (sortBy == "Distance") {
      filteredPediatricians.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Find Pediatricians"),
        actions: [
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
                    label: "Search pediatricians...",
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
                    label: "Age Group",
                    items: ageGroups.map((age) => {
                      "label": age,
                      "value": age,
                    }).toList(),
                    value: selectedAgeGroup,
                    onChanged: (value, label) {
                      selectedAgeGroup = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
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

            // Additional Filters
            QSwitch(
              items: [
                {
                  "label": "Available today only",
                  "value": "available",
                  "checked": showAvailableOnly,
                },
                {
                  "label": "Telehealth available",
                  "value": "telehealth",
                  "checked": showTelehealthOnly,
                }
              ],
              value: [
                if (showAvailableOnly) {"label": "Available today only", "value": "available", "checked": true},
                if (showTelehealthOnly) {"label": "Telehealth available", "value": "telehealth", "checked": true}
              ],
              onChanged: (values, ids) {
                showAvailableOnly = values.any((v) => v["value"] == "available");
                showTelehealthOnly = values.any((v) => v["value"] == "telehealth");
                setState(() {});
              },
            ),

            // Results Count
            Text(
              "${filteredPediatricians.length} pediatricians found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Pediatricians List
            ...filteredPediatricians.map((pediatrician) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: pediatrician["available"] 
                      ? Border(left: BorderSide(width: 4, color: successColor))
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
                            "${pediatrician["image"]}",
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
                                      "${pediatrician["name"]}",
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
                                      if (pediatrician["available"] == true)
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
                                      if (pediatrician["telehealth"] == true)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Telehealth",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: infoColor,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                "${pediatrician["specialty"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: secondaryColor,
                                ),
                              ),
                              Text(
                                "${pediatrician["subSpecialty"]}",
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
                                    "${pediatrician["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${pediatrician["reviews"]} reviews)",
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
                                    "${pediatrician["experience"]} years experience",
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

                    // Hospital & Education Info
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
                                  "${pediatrician["hospital"]}, ${pediatrician["location"]}",
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
                                  "${pediatrician["education"]}",
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
                                "${pediatrician["distance"]} km",
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
                            "Consultation: \$${(pediatrician["consultationFee"] as int)}",
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
                          color: pediatrician["available"] ? successColor : warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${pediatrician["nextSlot"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: pediatrician["available"] ? successColor : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // Age Groups
                    Text(
                      "Age Groups:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (pediatrician["ageGroups"] as List).map((age) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$age",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Specializations
                    Text(
                      "Specializations:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (pediatrician["specializations"] as List).map((specialization) {
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
                            "$specialization",
                            style: TextStyle(
                              fontSize: 10,
                              color: secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Services Available
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          if (pediatrician["emergencyService"] == true) ...[
                            Icon(
                              Icons.emergency,
                              size: 16,
                              color: dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Emergency Care",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: spSm),
                          ],
                          if (pediatrician["telehealth"] == true) ...[
                            Icon(
                              Icons.videocam,
                              size: 16,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Telehealth",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
                            (pediatrician["languages"] as List).join(", "),
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
                            label: pediatrician["available"] ? "Book Now" : "Schedule",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        if (pediatrician["telehealth"] == true)
                          QButton(
                            icon: Icons.videocam,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        QButton(
                          icon: Icons.call,
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
            if (filteredPediatricians.length >= 5)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Pediatricians",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
