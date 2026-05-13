import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHospitalListView extends StatefulWidget {
  const MhaHospitalListView({super.key});

  @override
  State<MhaHospitalListView> createState() => _MhaHospitalListViewState();
}

class _MhaHospitalListViewState extends State<MhaHospitalListView> {
  List<Map<String, dynamic>> hospitals = [
    {
      "id": "HOS001",
      "name": "City General Hospital",
      "specialty": "Multi-Specialty",
      "rating": 4.8,
      "reviews": 2543,
      "distance": 2.3,
      "address": "123 Medical Center Dr, Downtown",
      "phone": "+1 (555) 123-4567",
      "emergency": true,
      "accreditation": "Joint Commission",
      "image": "https://picsum.photos/400/300?random=1&keyword=hospital",
      "services": ["Emergency", "Surgery", "ICU", "Maternity", "Cardiology"],
      "beds": 450,
      "establishedYear": 1985,
      "insurance": ["Blue Cross", "Aetna", "Medicare", "Medicaid"],
    },
    {
      "id": "HOS002",
      "name": "St. Mary's Medical Center",
      "specialty": "Cardiac Care",
      "rating": 4.9,
      "reviews": 1876,
      "distance": 4.1,
      "address": "456 Heart Ave, Medical District",
      "phone": "+1 (555) 987-6543",
      "emergency": true,
      "accreditation": "AAAHC",
      "image": "https://picsum.photos/400/300?random=2&keyword=medical",
      "services": ["Cardiology", "Cardiac Surgery", "Emergency", "ICU"],
      "beds": 320,
      "establishedYear": 1978,
      "insurance": ["United Health", "Blue Cross", "Cigna"],
    },
    {
      "id": "HOS003",
      "name": "Children's Healthcare Center",
      "specialty": "Pediatrics",
      "rating": 4.7,
      "reviews": 1234,
      "distance": 3.8,
      "address": "789 Kids Way, Family District",
      "phone": "+1 (555) 456-7890",
      "emergency": true,
      "accreditation": "Joint Commission",
      "image": "https://picsum.photos/400/300?random=3&keyword=pediatric",
      "services": ["Pediatrics", "NICU", "Pediatric Surgery", "Emergency"],
      "beds": 200,
      "establishedYear": 1992,
      "insurance": ["Blue Cross", "Aetna", "Medicaid"],
    },
    {
      "id": "HOS004",
      "name": "Women's Health Institute",
      "specialty": "Women's Health",
      "rating": 4.6,
      "reviews": 987,
      "distance": 5.2,
      "address": "321 Women's Blvd, Healthcare Plaza",
      "phone": "+1 (555) 321-9876",
      "emergency": false,
      "accreditation": "AAAHC",
      "image": "https://picsum.photos/400/300?random=4&keyword=women",
      "services": ["Obstetrics", "Gynecology", "Maternity", "Fertility"],
      "beds": 150,
      "establishedYear": 2001,
      "insurance": ["United Health", "Blue Cross", "Aetna"],
    },
    {
      "id": "HOS005",
      "name": "Regional Cancer Center",
      "specialty": "Oncology",
      "rating": 4.9,
      "reviews": 756,
      "distance": 6.7,
      "address": "654 Hope Street, Medical Campus",
      "phone": "+1 (555) 654-3210",
      "emergency": false,
      "accreditation": "Joint Commission",
      "image": "https://picsum.photos/400/300?random=5&keyword=cancer",
      "services": ["Oncology", "Radiation Therapy", "Chemotherapy", "Surgery"],
      "beds": 180,
      "establishedYear": 1995,
      "insurance": ["Medicare", "Blue Cross", "United Health"],
    },
    {
      "id": "HOS006",
      "name": "Orthopedic Specialty Hospital",
      "specialty": "Orthopedics",
      "rating": 4.5,
      "reviews": 543,
      "distance": 7.9,
      "address": "987 Bone & Joint Ave, Sports District",
      "phone": "+1 (555) 789-0123",
      "emergency": false,
      "accreditation": "AAAHC",
      "image": "https://picsum.photos/400/300?random=6&keyword=orthopedic",
      "services": ["Orthopedics", "Sports Medicine", "Physical Therapy"],
      "beds": 100,
      "establishedYear": 2005,
      "insurance": ["Cigna", "Aetna", "Blue Cross"],
    },
  ];

  String searchQuery = "";
  String selectedSpecialty = "All";
  bool showEmergencyOnly = false;
  String sortBy = "Distance";

  List<String> specialties = [
    "All", "Multi-Specialty", "Cardiac Care", "Pediatrics", 
    "Women's Health", "Oncology", "Orthopedics"
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredHospitals = hospitals.where((hospital) {
      bool matchesSearch = hospital["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          hospital["specialty"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSpecialty = selectedSpecialty == "All" || hospital["specialty"] == selectedSpecialty;
      bool matchesEmergency = !showEmergencyOnly || hospital["emergency"] == true;
      
      return matchesSearch && matchesSpecialty && matchesEmergency;
    }).toList();

    // Sort hospitals
    if (sortBy == "Distance") {
      filteredHospitals.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
    } else if (sortBy == "Rating") {
      filteredHospitals.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    } else if (sortBy == "Name") {
      filteredHospitals.sort((a, b) => a["name"].toString().compareTo(b["name"].toString()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Hospitals Near You"),
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
                    label: "Search hospitals...",
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

            // Quick Filters
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
                      {"label": "Distance", "value": "Distance"},
                      {"label": "Rating", "value": "Rating"},
                      {"label": "Name", "value": "Name"},
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

            // Emergency Filter
            QSwitch(
              items: [
                {
                  "label": "Emergency services only",
                  "value": true,
                  "checked": showEmergencyOnly,
                }
              ],
              value: [if (showEmergencyOnly) {"label": "Emergency services only", "value": true, "checked": true}],
              onChanged: (values, ids) {
                showEmergencyOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Results Count
            Text(
              "${filteredHospitals.length} hospitals found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Hospital List
            ...filteredHospitals.map((hospital) {
              return Container(
                padding: EdgeInsets.all(spSm),
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
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${hospital["image"]}",
                            width: 80,
                            height: 80,
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
                                      "${hospital["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (hospital["emergency"] == true)
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
                                        "24/7",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                "${hospital["specialty"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
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
                                    "${hospital["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${hospital["reviews"]} reviews)",
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
                                    Icons.location_on,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${hospital["distance"]} km away",
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

                    // Hospital Info
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
                                Icons.location_on,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${hospital["address"]}",
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
                                Icons.phone,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${hospital["phone"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.hotel,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${hospital["beds"]} beds",
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
                      children: (hospital["services"] as List).map((service) {
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

                    // Insurance
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Accepts: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (hospital["insurance"] as List).join(", "),
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
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
                            label: "View Details",
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
            if (filteredHospitals.length >= 6)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Hospitals",
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
