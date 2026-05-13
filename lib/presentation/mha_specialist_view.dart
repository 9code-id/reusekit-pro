import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaSpecialistView extends StatefulWidget {
  const MhaSpecialistView({super.key});

  @override
  State<MhaSpecialistView> createState() => _MhaSpecialistViewState();
}

class _MhaSpecialistViewState extends State<MhaSpecialistView> {
  List<Map<String, dynamic>> specialists = [
    {
      "id": "SPEC001",
      "name": "Dr. Sarah Wilson",
      "specialty": "Cardiology",
      "subSpecialty": "Interventional Cardiology",
      "rating": 4.9,
      "reviews": 234,
      "experience": 15,
      "education": "Harvard Medical School",
      "image": "https://picsum.photos/200/200?random=1&keyword=doctor",
      "hospital": "City General Hospital",
      "location": "Downtown Medical Center",
      "distance": 2.3,
      "consultationFee": 350,
      "available": true,
      "nextSlot": "Today 3:00 PM",
      "languages": ["English", "Spanish"],
      "awards": ["Best Cardiologist 2023", "Excellence in Patient Care"],
      "specializations": ["Heart Disease", "Cardiac Surgery", "Angioplasty", "Heart Failure"],
    },
    {
      "id": "SPEC002",
      "name": "Dr. Michael Chen",
      "specialty": "Neurology",
      "subSpecialty": "Stroke & Cerebrovascular Disease",
      "rating": 4.8,
      "reviews": 189,
      "experience": 12,
      "education": "Johns Hopkins University",
      "image": "https://picsum.photos/200/200?random=2&keyword=doctor",
      "hospital": "Neurological Institute",
      "location": "Medical District",
      "distance": 3.7,
      "consultationFee": 400,
      "available": false,
      "nextSlot": "Tomorrow 10:00 AM",
      "languages": ["English", "Mandarin"],
      "awards": ["Neurologist of the Year 2022"],
      "specializations": ["Stroke Treatment", "Epilepsy", "Parkinson's Disease", "Memory Disorders"],
    },
    {
      "id": "SPEC003",
      "name": "Dr. Emily Rodriguez",
      "specialty": "Oncology",
      "subSpecialty": "Breast Cancer Specialist",
      "rating": 4.9,
      "reviews": 156,
      "experience": 18,
      "education": "Stanford Medical School",
      "image": "https://picsum.photos/200/200?random=3&keyword=doctor",
      "hospital": "Cancer Treatment Center",
      "location": "Oncology Campus",
      "distance": 4.2,
      "consultationFee": 450,
      "available": true,
      "nextSlot": "Today 4:30 PM",
      "languages": ["English", "Spanish", "Portuguese"],
      "awards": ["Excellence in Cancer Care", "Research Excellence Award"],
      "specializations": ["Breast Cancer", "Chemotherapy", "Immunotherapy", "Clinical Trials"],
    },
    {
      "id": "SPEC004",
      "name": "Dr. Robert Johnson",
      "specialty": "Orthopedics",
      "subSpecialty": "Sports Medicine",
      "rating": 4.7,
      "reviews": 298,
      "experience": 20,
      "education": "Mayo Clinic College",
      "image": "https://picsum.photos/200/200?random=4&keyword=doctor",
      "hospital": "Sports Medicine Center",
      "location": "Athletic District",
      "distance": 5.1,
      "consultationFee": 320,
      "available": true,
      "nextSlot": "Today 2:00 PM",
      "languages": ["English"],
      "awards": ["Sports Medicine Excellence", "Top Orthopedic Surgeon"],
      "specializations": ["Joint Replacement", "Sports Injuries", "Arthroscopy", "Fracture Care"],
    },
    {
      "id": "SPEC005",
      "name": "Dr. Lisa Park",
      "specialty": "Dermatology",
      "subSpecialty": "Cosmetic Dermatology",
      "rating": 4.8,
      "reviews": 167,
      "experience": 10,
      "education": "UCLA Medical School",
      "image": "https://picsum.photos/200/200?random=5&keyword=doctor",
      "hospital": "Skin & Beauty Clinic",
      "location": "Aesthetic Center",
      "distance": 3.9,
      "consultationFee": 280,
      "available": false,
      "nextSlot": "Tomorrow 11:30 AM",
      "languages": ["English", "Korean"],
      "awards": ["Best Dermatologist 2023"],
      "specializations": ["Skin Cancer", "Acne Treatment", "Anti-Aging", "Laser Therapy"],
    },
  ];

  String searchQuery = "";
  String selectedSpecialty = "All";
  bool showAvailableOnly = false;
  String sortBy = "Rating";

  List<String> specialties = [
    "All", "Cardiology", "Neurology", "Oncology", "Orthopedics", 
    "Dermatology", "Psychiatry", "Endocrinology", "Gastroenterology"
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSpecialists = specialists.where((specialist) {
      bool matchesSearch = specialist["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          specialist["specialty"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          specialist["subSpecialty"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSpecialty = selectedSpecialty == "All" || specialist["specialty"] == selectedSpecialty;
      bool matchesAvailability = !showAvailableOnly || specialist["available"] == true;
      
      return matchesSearch && matchesSpecialty && matchesAvailability;
    }).toList();

    // Sort specialists
    if (sortBy == "Rating") {
      filteredSpecialists.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    } else if (sortBy == "Experience") {
      filteredSpecialists.sort((a, b) => (b["experience"] as int).compareTo(a["experience"] as int));
    } else if (sortBy == "Fee") {
      filteredSpecialists.sort((a, b) => (a["consultationFee"] as int).compareTo(b["consultationFee"] as int));
    } else if (sortBy == "Distance") {
      filteredSpecialists.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Find Specialists"),
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
                    label: "Search specialists...",
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

            // Available Only Filter
            QSwitch(
              items: [
                {
                  "label": "Available today only",
                  "value": true,
                  "checked": showAvailableOnly,
                }
              ],
              value: [if (showAvailableOnly) {"label": "Available today only", "value": true, "checked": true}],
              onChanged: (values, ids) {
                showAvailableOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Results Count
            Text(
              "${filteredSpecialists.length} specialists found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Specialists List
            ...filteredSpecialists.map((specialist) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: specialist["available"] 
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
                            "${specialist["image"]}",
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
                                      "${specialist["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: specialist["available"] 
                                          ? successColor.withAlpha(20)
                                          : dangerColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      specialist["available"] ? "Available" : "Busy",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: specialist["available"] ? successColor : dangerColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${specialist["specialty"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: secondaryColor,
                                ),
                              ),
                              Text(
                                "${specialist["subSpecialty"]}",
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
                                    "${specialist["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${specialist["reviews"]} reviews)",
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
                                    "${specialist["experience"]} years experience",
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

                    // Education & Hospital
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
                                Icons.school,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${specialist["education"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                  "${specialist["hospital"]}, ${specialist["location"]}",
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
                                "${specialist["distance"]} km",
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
                            "Consultation: \$${(specialist["consultationFee"] as int)}",
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
                          color: specialist["available"] ? successColor : warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${specialist["nextSlot"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: specialist["available"] ? successColor : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
                      children: (specialist["specializations"] as List).map((specialization) {
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

                    // Awards & Languages
                    if ((specialist["awards"] as List).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Awards:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                            ...(specialist["awards"] as List).map((award) {
                              return Text(
                                "• $award",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: warningColor,
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
                            (specialist["languages"] as List).join(", "),
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
                            label: specialist["available"] ? "Book Now" : "Schedule",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
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
            if (filteredSpecialists.length >= 5)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Specialists",
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
