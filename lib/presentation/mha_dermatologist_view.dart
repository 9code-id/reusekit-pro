import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaDermatologistView extends StatefulWidget {
  const MhaDermatologistView({super.key});

  @override
  State<MhaDermatologistView> createState() => _MhaDermatologistViewState();
}

class _MhaDermatologistViewState extends State<MhaDermatologistView> {
  String selectedTreatment = "All";
  String selectedLocation = "All";
  bool showEmergencyAvailable = false;
  String searchQuery = "";

  List<Map<String, dynamic>> dermatologists = [
    {
      "id": 1,
      "name": "Dr. Amanda Williams",
      "specialty": "Medical Dermatology",
      "hospital": "Skin Care Medical Center",
      "experience": 12,
      "rating": 4.9,
      "reviews": 387,
      "fee": 120.0,
      "image": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "location": "Downtown",
      "availability": "Available Today",
      "nextSlot": "1:30 PM",
      "emergencyAvailable": true,
      "treatments": ["Acne Treatment", "Skin Cancer Screening", "Dermatitis"],
      "languages": ["English", "Spanish"],
      "qualifications": ["MD Dermatology", "Board Certified"]
    },
    {
      "id": 2,
      "name": "Dr. James Chen",
      "specialty": "Cosmetic Dermatology",
      "hospital": "Aesthetic Skin Institute",
      "experience": 15,
      "rating": 4.8,
      "reviews": 445,
      "fee": 180.0,
      "image": "https://picsum.photos/100/100?random=2&keyword=doctor",
      "location": "Uptown",
      "availability": "Available Tomorrow",
      "nextSlot": "10:00 AM",
      "emergencyAvailable": false,
      "treatments": ["Botox", "Laser Treatment", "Chemical Peels"],
      "languages": ["English", "Mandarin"],
      "qualifications": ["MD Dermatology", "Fellowship in Cosmetic Dermatology"]
    },
    {
      "id": 3,
      "name": "Dr. Sarah Rodriguez",
      "specialty": "Pediatric Dermatology",
      "hospital": "Children's Skin Center",
      "experience": 10,
      "rating": 4.9,
      "reviews": 298,
      "fee": 110.0,
      "image": "https://picsum.photos/100/100?random=3&keyword=doctor",
      "location": "Medical District",
      "availability": "Available Today",
      "nextSlot": "3:15 PM",
      "emergencyAvailable": true,
      "treatments": ["Eczema", "Childhood Rashes", "Birthmark Treatment"],
      "languages": ["English", "Spanish", "French"],
      "qualifications": ["MD Dermatology", "Pediatric Dermatology Board"]
    },
    {
      "id": 4,
      "name": "Dr. Michael Thompson",
      "specialty": "Dermatopathology",
      "hospital": "Advanced Dermatology Lab",
      "experience": 18,
      "rating": 4.7,
      "reviews": 156,
      "fee": 200.0,
      "image": "https://picsum.photos/100/100?random=4&keyword=doctor",
      "location": "Research Center",
      "availability": "Available Next Week",
      "nextSlot": "Mon 9:00 AM",
      "emergencyAvailable": false,
      "treatments": ["Skin Biopsy", "Mole Analysis", "Cancer Diagnosis"],
      "languages": ["English"],
      "qualifications": ["MD Dermatology", "Fellowship in Dermatopathology"]
    },
    {
      "id": 5,
      "name": "Dr. Lisa Park",
      "specialty": "Surgical Dermatology",
      "hospital": "Dermatology Surgery Center",
      "experience": 14,
      "rating": 4.8,
      "reviews": 234,
      "fee": 250.0,
      "image": "https://picsum.photos/100/100?random=5&keyword=doctor",
      "location": "Surgery Center",
      "availability": "Available Today",
      "nextSlot": "4:00 PM",
      "emergencyAvailable": true,
      "treatments": ["Mohs Surgery", "Skin Cancer Removal", "Scar Revision"],
      "languages": ["English", "Korean"],
      "qualifications": ["MD Dermatology", "Fellowship in Mohs Surgery"]
    }
  ];

  List<Map<String, dynamic>> get filteredDermatologists {
    return dermatologists.where((doctor) {
      bool matchesSearch = searchQuery.isEmpty ||
          (doctor["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (doctor["specialty"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesTreatment = selectedTreatment == "All" ||
          (doctor["treatments"] as List).any((treatment) => 
              (treatment as String).contains(selectedTreatment));
      
      bool matchesLocation = selectedLocation == "All" || 
          doctor["location"] == selectedLocation;
      
      bool matchesEmergency = !showEmergencyAvailable || 
          (doctor["emergencyAvailable"] as bool);
      
      return matchesSearch && matchesTreatment && matchesLocation && matchesEmergency;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dermatologists"),
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
            _buildSearchBar(),
            _buildTreatmentCategories(),
            _buildQuickFilters(),
            _buildStatsSection(),
            _buildDermatologistsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
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
                      hintText: "Search dermatologists...",
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

  Widget _buildTreatmentCategories() {
    List<String> treatments = [
      "All",
      "Acne Treatment",
      "Skin Cancer",
      "Cosmetic",
      "Pediatric",
      "Surgery"
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Treatment Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: treatments.map((treatment) {
            bool isSelected = selectedTreatment == treatment;
            return Container(
              margin: EdgeInsets.only(right: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedTreatment = treatment;
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
                    treatment,
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
                Icon(Icons.local_hospital, color: dangerColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Emergency Available",
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
            value: showEmergencyAvailable,
            onChanged: (value) {
              showEmergencyAvailable = value;
              setState(() {});
            },
            activeColor: dangerColor,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
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
                  "${filteredDermatologists.length} Dermatologists",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Skin care specialists available",
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
              Icons.face,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDermatologistsList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Available Dermatologists",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Sort by Rating",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        ...filteredDermatologists.map((doctor) => _buildDoctorCard(doctor)),
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
                        if (doctor["emergencyAvailable"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.local_hospital, color: dangerColor, size: 10),
                                SizedBox(width: 2),
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
          // Treatments
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (doctor["treatments"] as List<String>).take(3).map((treatment) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  treatment,
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
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
                "${(doctor["experience"] as int)} years",
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
                  label: "Book Appointment",
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
              value: selectedLocation,
              decoration: InputDecoration(labelText: "Location"),
              items: ["All", "Downtown", "Uptown", "Medical District", "Research Center", "Surgery Center"].map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                selectedLocation = value ?? "All";
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
