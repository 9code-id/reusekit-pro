import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaClinicListView extends StatefulWidget {
  const MhaClinicListView({super.key});

  @override
  State<MhaClinicListView> createState() => _MhaClinicListViewState();
}

class _MhaClinicListViewState extends State<MhaClinicListView> {
  List<Map<String, dynamic>> clinics = [
    {
      "id": "CLI001",
      "name": "Family Care Clinic",
      "specialty": "Family Medicine",
      "rating": 4.7,
      "reviews": 890,
      "distance": 1.2,
      "address": "456 Health Street, Medical Plaza",
      "phone": "+1 (555) 234-5678",
      "image": "https://picsum.photos/400/300?random=1&keyword=clinic",
      "doctors": 8,
      "openNow": true,
      "nextAvailable": "Today 3:00 PM",
      "services": ["General Checkups", "Vaccinations", "Lab Tests", "Minor Surgery"],
      "hours": "Mon-Fri: 8:00 AM - 6:00 PM, Sat: 9:00 AM - 2:00 PM",
      "insurance": ["Blue Cross", "Aetna", "Medicare"],
      "waitTime": "15 mins",
    },
    {
      "id": "CLI002",
      "name": "QuickCare Medical Center",
      "specialty": "Urgent Care",
      "rating": 4.5,
      "reviews": 1245,
      "distance": 2.1,
      "address": "789 Urgent Ave, Downtown",
      "phone": "+1 (555) 345-6789",
      "image": "https://picsum.photos/400/300?random=2&keyword=urgent",
      "doctors": 12,
      "openNow": true,
      "nextAvailable": "Walk-in available",
      "services": ["Urgent Care", "X-Ray", "Lab Tests", "Stitches"],
      "hours": "Daily: 8:00 AM - 10:00 PM",
      "insurance": ["United Health", "Blue Cross", "Cigna"],
      "waitTime": "25 mins",
    },
    {
      "id": "CLI003",
      "name": "Women's Health Clinic",
      "specialty": "Women's Health",
      "rating": 4.9,
      "reviews": 567,
      "distance": 2.8,
      "address": "321 Women's Way, Health District",
      "phone": "+1 (555) 456-7890",
      "image": "https://picsum.photos/400/300?random=3&keyword=women",
      "doctors": 6,
      "openNow": false,
      "nextAvailable": "Tomorrow 9:00 AM",
      "services": ["Gynecology", "Prenatal Care", "Mammography", "Family Planning"],
      "hours": "Mon-Fri: 9:00 AM - 5:00 PM",
      "insurance": ["Blue Cross", "Aetna", "United Health"],
      "waitTime": "10 mins",
    },
    {
      "id": "CLI004",
      "name": "Children's Health Center",
      "specialty": "Pediatrics",
      "rating": 4.8,
      "reviews": 723,
      "distance": 3.5,
      "address": "654 Kids Boulevard, Family Zone",
      "phone": "+1 (555) 567-8901",
      "image": "https://picsum.photos/400/300?random=4&keyword=pediatric",
      "doctors": 10,
      "openNow": true,
      "nextAvailable": "Today 4:30 PM",
      "services": ["Pediatric Care", "Immunizations", "Development Screening", "Sports Physicals"],
      "hours": "Mon-Fri: 8:00 AM - 6:00 PM, Sat: 10:00 AM - 4:00 PM",
      "insurance": ["Medicare", "Medicaid", "Blue Cross"],
      "waitTime": "20 mins",
    },
    {
      "id": "CLI005",
      "name": "Wellness Plus Clinic",
      "specialty": "Preventive Care",
      "rating": 4.6,
      "reviews": 456,
      "distance": 4.2,
      "address": "987 Wellness Road, Health Park",
      "phone": "+1 (555) 678-9012",
      "image": "https://picsum.photos/400/300?random=5&keyword=wellness",
      "doctors": 7,
      "openNow": true,
      "nextAvailable": "Today 5:00 PM",
      "services": ["Health Screenings", "Wellness Exams", "Nutrition Counseling", "Fitness Assessment"],
      "hours": "Mon-Fri: 7:00 AM - 7:00 PM, Sat: 8:00 AM - 4:00 PM",
      "insurance": ["Cigna", "Aetna", "United Health"],
      "waitTime": "12 mins",
    },
  ];

  String searchQuery = "";
  String selectedSpecialty = "All";
  bool showOpenOnly = false;
  String sortBy = "Distance";

  List<String> specialties = [
    "All", "Family Medicine", "Urgent Care", "Women's Health", 
    "Pediatrics", "Preventive Care"
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredClinics = clinics.where((clinic) {
      bool matchesSearch = clinic["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          clinic["specialty"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSpecialty = selectedSpecialty == "All" || clinic["specialty"] == selectedSpecialty;
      bool matchesOpen = !showOpenOnly || clinic["openNow"] == true;
      
      return matchesSearch && matchesSpecialty && matchesOpen;
    }).toList();

    // Sort clinics
    if (sortBy == "Distance") {
      filteredClinics.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
    } else if (sortBy == "Rating") {
      filteredClinics.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    } else if (sortBy == "Wait Time") {
      filteredClinics.sort((a, b) => a["waitTime"].toString().compareTo(b["waitTime"].toString()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Clinics Near You"),
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
                    label: "Search clinics...",
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
                      {"label": "Wait Time", "value": "Wait Time"},
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

            // Open Now Filter
            QSwitch(
              items: [
                {
                  "label": "Open now only",
                  "value": true,
                  "checked": showOpenOnly,
                }
              ],
              value: [if (showOpenOnly) {"label": "Open now only", "value": true, "checked": true}],
              onChanged: (values, ids) {
                showOpenOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Results Count
            Text(
              "${filteredClinics.length} clinics found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Clinic List
            ...filteredClinics.map((clinic) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: clinic["openNow"] 
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
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${clinic["image"]}",
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
                                      "${clinic["name"]}",
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
                                      color: clinic["openNow"] 
                                          ? successColor.withAlpha(20)
                                          : dangerColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      clinic["openNow"] ? "Open" : "Closed",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: clinic["openNow"] ? successColor : dangerColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${clinic["specialty"]}",
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
                                    "${clinic["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${clinic["reviews"]} reviews)",
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
                                    "${clinic["distance"]} km away",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "Wait: ${clinic["waitTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
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

                    // Clinic Details
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
                                  "${clinic["address"]}",
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
                                "${clinic["phone"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.people,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${clinic["doctors"]} doctors",
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
                                Icons.access_time,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${clinic["hours"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Next Available
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: clinic["openNow"] 
                            ? successColor.withAlpha(10)
                            : warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.event_available,
                            size: 16,
                            color: clinic["openNow"] ? successColor : warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Next available: ",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${clinic["nextAvailable"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: clinic["openNow"] ? successColor : warningColor,
                              fontWeight: FontWeight.w600,
                            ),
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
                      children: (clinic["services"] as List).map((service) {
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
                            (clinic["insurance"] as List).join(", "),
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
                            label: clinic["openNow"] ? "Book Now" : "Schedule",
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
            if (filteredClinics.length >= 5)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Clinics",
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
