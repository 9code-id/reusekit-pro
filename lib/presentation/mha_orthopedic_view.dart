import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaOrthopedicView extends StatefulWidget {
  const MhaOrthopedicView({super.key});

  @override
  State<MhaOrthopedicView> createState() => _MhaOrthopedicViewState();
}

class _MhaOrthopedicViewState extends State<MhaOrthopedicView> {
  String selectedSpecialty = "All";
  String selectedTreatment = "All";
  bool showSurgeryAvailable = false;
  String searchQuery = "";

  List<Map<String, dynamic>> orthopedicDoctors = [
    {
      "id": 1,
      "name": "Dr. Michael Johnson",
      "specialty": "Sports Medicine",
      "hospital": "Sports Injury Center",
      "experience": 16,
      "rating": 4.9,
      "reviews": 423,
      "fee": 180.0,
      "image": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "availability": "Available Today",
      "nextSlot": "2:00 PM",
      "surgeryAvailable": true,
      "treatments": ["ACL Repair", "Shoulder Surgery", "Joint Replacement"],
      "specializations": ["Knee Surgery", "Sports Injuries", "Arthroscopy"],
      "languages": ["English", "Spanish"],
      "qualifications": ["MD Orthopedics", "Fellowship in Sports Medicine"]
    },
    {
      "id": 2,
      "name": "Dr. Sarah Lee",
      "specialty": "Joint Replacement",
      "hospital": "Advanced Orthopedic Institute",
      "experience": 20,
      "rating": 4.8,
      "reviews": 378,
      "fee": 220.0,
      "image": "https://picsum.photos/100/100?random=2&keyword=doctor",
      "availability": "Available Tomorrow",
      "nextSlot": "9:30 AM",
      "surgeryAvailable": true,
      "treatments": ["Hip Replacement", "Knee Replacement", "Revision Surgery"],
      "specializations": ["Hip Surgery", "Knee Surgery", "Complex Revisions"],
      "languages": ["English", "Korean"],
      "qualifications": ["MD Orthopedics", "Fellowship in Joint Replacement"]
    },
    {
      "id": 3,
      "name": "Dr. Robert Chen",
      "specialty": "Spine Surgery",
      "hospital": "Spine Care Center",
      "experience": 18,
      "rating": 4.7,
      "reviews": 256,
      "fee": 250.0,
      "image": "https://picsum.photos/100/100?random=3&keyword=doctor",
      "availability": "Available Next Week",
      "nextSlot": "Mon 10:00 AM",
      "surgeryAvailable": true,
      "treatments": ["Spinal Fusion", "Disc Surgery", "Scoliosis Correction"],
      "specializations": ["Minimally Invasive Spine", "Complex Deformity", "Disc Replacement"],
      "languages": ["English", "Mandarin"],
      "qualifications": ["MD Orthopedics", "Fellowship in Spine Surgery"]
    },
    {
      "id": 4,
      "name": "Dr. Emily Rodriguez",
      "specialty": "Pediatric Orthopedics",
      "hospital": "Children's Orthopedic Center",
      "experience": 12,
      "rating": 4.9,
      "reviews": 289,
      "fee": 160.0,
      "image": "https://picsum.photos/100/100?random=4&keyword=doctor",
      "availability": "Available Today",
      "nextSlot": "3:30 PM",
      "surgeryAvailable": false,
      "treatments": ["Growth Plate Injuries", "Scoliosis Treatment", "Clubfoot Correction"],
      "specializations": ["Congenital Disorders", "Growth Abnormalities", "Pediatric Trauma"],
      "languages": ["English", "Spanish", "French"],
      "qualifications": ["MD Orthopedics", "Fellowship in Pediatric Orthopedics"]
    },
    {
      "id": 5,
      "name": "Dr. David Wilson",
      "specialty": "Hand & Wrist Surgery",
      "hospital": "Hand Surgery Specialists",
      "experience": 14,
      "rating": 4.8,
      "reviews": 198,
      "fee": 190.0,
      "image": "https://picsum.photos/100/100?random=5&keyword=doctor",
      "availability": "Available Tomorrow",
      "nextSlot": "11:15 AM",
      "surgeryAvailable": true,
      "treatments": ["Carpal Tunnel", "Trigger Finger", "Fracture Repair"],
      "specializations": ["Microsurgery", "Nerve Repair", "Tendon Surgery"],
      "languages": ["English"],
      "qualifications": ["MD Orthopedics", "Fellowship in Hand Surgery"]
    }
  ];

  List<Map<String, dynamic>> get filteredDoctors {
    return orthopedicDoctors.where((doctor) {
      bool matchesSearch = searchQuery.isEmpty ||
          (doctor["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (doctor["specialty"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesSpecialty = selectedSpecialty == "All" || 
          doctor["specialty"] == selectedSpecialty;
      
      bool matchesTreatment = selectedTreatment == "All" ||
          (doctor["treatments"] as List).any((treatment) => 
              (treatment as String).contains(selectedTreatment));
      
      bool matchesSurgery = !showSurgeryAvailable || 
          (doctor["surgeryAvailable"] as bool);
      
      return matchesSearch && matchesSpecialty && matchesTreatment && matchesSurgery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orthopedic Specialists"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            _buildSpecialtyFilters(),
            _buildQuickFilters(),
            _buildStatsCard(),
            _buildDoctorsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: disabledColor),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: disabledBoldColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search orthopedic specialists...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: disabledBoldColor),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialtyFilters() {
    List<String> specialties = [
      "All",
      "Sports Medicine",
      "Joint Replacement",
      "Spine Surgery",
      "Pediatric",
      "Hand & Wrist"
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Orthopedic Specialties",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: specialties.map((specialty) {
            bool isSelected = selectedSpecialty == specialty;
            return Container(
              margin: EdgeInsets.only(right: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedSpecialty = specialty;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Text(
                    specialty,
                    style: TextStyle(
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.local_hospital, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Surgery Available",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: showSurgeryAvailable,
            onChanged: (value) {
              showSurgeryAvailable = value;
              setState(() {});
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${filteredDoctors.length} Orthopedic Specialists",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Bone and joint specialists available",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.healing,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Available Specialists",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Sort by Experience",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        ...filteredDoctors.map((doctor) => _buildDoctorCard(doctor)),
      ],
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${doctor["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                        if (doctor["surgeryAvailable"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.local_hospital, color: primaryColor, size: 10),
                                SizedBox(width: 2),
                                Text(
                                  "Surgery",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${doctor["specialty"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${doctor["hospital"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${doctor["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          " (${doctor["reviews"]} reviews)",
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
          Divider(color: disabledColor),
          // Specializations
          Column(
            spacing: spXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Specializations:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (doctor["specializations"] as List<String>).map((spec) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      spec,
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, color: successColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${doctor["availability"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${(doctor["experience"] as int)} years exp",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${((doctor["fee"] as double).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Book Consultation",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            DropdownButtonFormField<String>(
              value: selectedTreatment,
              decoration: InputDecoration(labelText: "Treatment Type"),
              items: ["All", "Surgery", "Replacement", "Repair", "Correction"].map((treatment) {
                return DropdownMenuItem(
                  value: treatment,
                  child: Text(treatment),
                );
              }).toList(),
              onChanged: (value) {
                selectedTreatment = value ?? "All";
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }
}
