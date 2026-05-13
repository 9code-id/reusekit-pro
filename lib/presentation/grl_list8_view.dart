import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlList8View extends StatefulWidget {
  @override
  State<GrlList8View> createState() => _GrlList8ViewState();
}

class _GrlList8ViewState extends State<GrlList8View> {
  String searchQuery = "";
  String selectedSpecialty = "All";
  String selectedLocation = "All";
  
  List<Map<String, dynamic>> specialtyOptions = [
    {"label": "All", "value": "All"},
    {"label": "Cardiology", "value": "Cardiology"},
    {"label": "Dermatology", "value": "Dermatology"},
    {"label": "Neurology", "value": "Neurology"},
    {"label": "Pediatrics", "value": "Pediatrics"},
    {"label": "Orthopedics", "value": "Orthopedics"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All", "value": "All"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Midtown", "value": "Midtown"},
    {"label": "Uptown", "value": "Uptown"},
    {"label": "Suburbs", "value": "Suburbs"},
  ];

  List<Map<String, dynamic>> doctors = [
    {
      "id": "DOC-001",
      "name": "Dr. Emily Rodriguez",
      "specialty": "Cardiology",
      "hospital": "City Medical Center",
      "location": "Downtown",
      "experience": 15,
      "rating": 4.9,
      "reviews": 287,
      "consultationFee": 150,
      "availableSlots": ["09:00", "11:00", "14:00", "16:00"],
      "languages": ["English", "Spanish"],
      "image": "https://picsum.photos/200/200?random=71&keyword=doctor",
      "education": "Harvard Medical School",
      "about": "Specializes in interventional cardiology with focus on minimally invasive procedures.",
      "isAvailable": true,
      "nextAvailable": "Today",
    },
    {
      "id": "DOC-002",
      "name": "Dr. Michael Chen",
      "specialty": "Dermatology",
      "hospital": "Skin Care Institute",
      "location": "Midtown",
      "experience": 12,
      "rating": 4.7,
      "reviews": 189,
      "consultationFee": 120,
      "availableSlots": ["10:00", "13:00", "15:00"],
      "languages": ["English", "Mandarin"],
      "image": "https://picsum.photos/200/200?random=72&keyword=doctor",
      "education": "Johns Hopkins University",
      "about": "Expert in cosmetic and medical dermatology, including laser treatments.",
      "isAvailable": true,
      "nextAvailable": "Tomorrow",
    },
    {
      "id": "DOC-003",
      "name": "Dr. Sarah Johnson",
      "specialty": "Neurology",
      "hospital": "Brain & Spine Center",
      "location": "Uptown",
      "experience": 18,
      "rating": 4.8,
      "reviews": 345,
      "consultationFee": 180,
      "availableSlots": ["08:00", "12:00", "17:00"],
      "languages": ["English"],
      "image": "https://picsum.photos/200/200?random=73&keyword=doctor",
      "education": "Mayo Clinic College",
      "about": "Leading neurologist specializing in epilepsy and movement disorders.",
      "isAvailable": false,
      "nextAvailable": "Next Week",
    },
    {
      "id": "DOC-004",
      "name": "Dr. David Kim",
      "specialty": "Pediatrics",
      "hospital": "Children's Hospital",
      "location": "Suburbs",
      "experience": 10,
      "rating": 4.6,
      "reviews": 156,
      "consultationFee": 100,
      "availableSlots": ["09:00", "11:00", "14:00", "16:00", "18:00"],
      "languages": ["English", "Korean"],
      "image": "https://picsum.photos/200/200?random=74&keyword=doctor",
      "education": "Stanford Medical School",
      "about": "Compassionate pediatrician with expertise in child development and vaccines.",
      "isAvailable": true,
      "nextAvailable": "Today",
    },
    {
      "id": "DOC-005",
      "name": "Dr. Lisa Martinez",
      "specialty": "Orthopedics",
      "hospital": "Joint & Bone Clinic",
      "location": "Downtown",
      "experience": 14,
      "rating": 4.5,
      "reviews": 234,
      "consultationFee": 160,
      "availableSlots": ["08:00", "13:00", "15:00"],
      "languages": ["English", "Spanish"],
      "image": "https://picsum.photos/200/200?random=75&keyword=doctor",
      "education": "UCLA Medical School",
      "about": "Orthopedic surgeon specializing in sports medicine and joint replacement.",
      "isAvailable": true,
      "nextAvailable": "Tomorrow",
    },
  ];

  List<Map<String, dynamic>> get filteredDoctors {
    return doctors.where((doctor) {
      bool matchesSearch = "${doctor["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${doctor["specialty"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${doctor["hospital"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSpecialty = selectedSpecialty == "All" || doctor["specialty"] == selectedSpecialty;
      bool matchesLocation = selectedLocation == "All" || doctor["location"] == selectedLocation;
      return matchesSearch && matchesSpecialty && matchesLocation;
    }).toList();
  }

  Color getAvailabilityColor(bool isAvailable) {
    return isAvailable ? successColor : dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Doctors"),
        actions: [
          Icon(Icons.favorite_border),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Quality Healthcare",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${doctors.length} specialist doctors • ${doctors.where((d) => d["isAvailable"] == true).length} available today",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search doctors",
                    value: searchQuery,
                    hint: "Search by name, specialty, or hospital...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Specialty",
                    items: specialtyOptions,
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
                    label: "Location",
                    items: locationOptions,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Doctors (${filteredDoctors.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                final availabilityColor = getAvailabilityColor(doctor["isAvailable"] as bool);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: availabilityColor,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage("${doctor["image"]}"),
                              ),
                              Positioned(
                                bottom: 2,
                                right: 2,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: availabilityColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${doctor["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: availabilityColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${doctor["nextAvailable"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: availabilityColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${doctor["specialty"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_hospital,
                                      color: disabledBoldColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${doctor["hospital"]}",
                                      style: TextStyle(
                                        fontSize: 13,
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

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Experience",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${doctor["experience"]} years",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Consultation Fee",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${doctor["consultationFee"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < (doctor["rating"] as double).floor()
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: warningColor,
                                      size: 16,
                                    );
                                  }),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${doctor["rating"]} (${doctor["reviews"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Education: ${doctor["education"]}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${doctor["about"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${doctor["location"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Languages",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      (doctor["languages"] as List).join(", "),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "Available Slots: ${(doctor["availableSlots"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Book Appointment",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.message,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spXs),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
