import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaOphthalmologistView extends StatefulWidget {
  const MhaOphthalmologistView({super.key});

  @override
  State<MhaOphthalmologistView> createState() => _MhaOphthalmologistViewState();
}

class _MhaOphthalmologistViewState extends State<MhaOphthalmologistView> {
  String selectedService = "All";
  String selectedExperience = "All";
  bool showEmergencyServices = false;
  String searchQuery = "";

  List<Map<String, dynamic>> ophthalmologists = [
    {
      "id": 1,
      "name": "Dr. Jennifer Adams",
      "specialty": "Retinal Diseases",
      "hospital": "Eye Care Center",
      "experience": 15,
      "rating": 4.9,
      "reviews": 342,
      "fee": 160.0,
      "image": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "availability": "Available Today",
      "nextSlot": "2:30 PM",
      "emergencyServices": true,
      "services": ["Diabetic Retinopathy", "Macular Degeneration", "Retinal Detachment"],
      "procedures": ["Laser Surgery", "Injections", "Vitrectomy"],
      "languages": ["English", "Spanish"],
      "qualifications": ["MD Ophthalmology", "Fellowship in Retinal Diseases"]
    },
    {
      "id": 2,
      "name": "Dr. Mark Thompson",
      "specialty": "Cataract Surgery",
      "hospital": "Vision Surgery Institute",
      "experience": 20,
      "rating": 4.8,
      "reviews": 456,
      "fee": 200.0,
      "image": "https://picsum.photos/100/100?random=2&keyword=doctor",
      "availability": "Available Tomorrow",
      "nextSlot": "9:00 AM",
      "emergencyServices": false,
      "services": ["Cataract Surgery", "Lens Implants", "Refractive Surgery"],
      "procedures": ["Phacoemulsification", "Premium IOL", "Multifocal Lenses"],
      "languages": ["English"],
      "qualifications": ["MD Ophthalmology", "Fellowship in Anterior Segment"]
    },
    {
      "id": 3,
      "name": "Dr. Lisa Chen",
      "specialty": "Pediatric Ophthalmology",
      "hospital": "Children's Eye Center",
      "experience": 12,
      "rating": 4.9,
      "reviews": 278,
      "fee": 140.0,
      "image": "https://picsum.photos/100/100?random=3&keyword=doctor",
      "availability": "Available Today",
      "nextSlot": "4:00 PM",
      "emergencyServices": true,
      "services": ["Strabismus", "Amblyopia", "Pediatric Cataracts"],
      "procedures": ["Eye Muscle Surgery", "Vision Therapy", "Glasses Fitting"],
      "languages": ["English", "Mandarin", "Spanish"],
      "qualifications": ["MD Ophthalmology", "Fellowship in Pediatric Ophthalmology"]
    },
    {
      "id": 4,
      "name": "Dr. Robert Martinez",
      "specialty": "Glaucoma",
      "hospital": "Glaucoma Treatment Center",
      "experience": 18,
      "rating": 4.7,
      "reviews": 234,
      "fee": 180.0,
      "image": "https://picsum.photos/100/100?random=4&keyword=doctor",
      "availability": "Available Next Week",
      "nextSlot": "Mon 10:30 AM",
      "emergencyServices": false,
      "services": ["Glaucoma Surgery", "Pressure Management", "Laser Treatment"],
      "procedures": ["Trabeculectomy", "Tube Shunt", "SLT Laser"],
      "languages": ["English", "Spanish"],
      "qualifications": ["MD Ophthalmology", "Fellowship in Glaucoma"]
    },
    {
      "id": 5,
      "name": "Dr. Sarah Kim",
      "specialty": "Corneal Diseases",
      "hospital": "Cornea Specialists",
      "experience": 14,
      "rating": 4.8,
      "reviews": 189,
      "fee": 170.0,
      "image": "https://picsum.photos/100/100?random=5&keyword=doctor",
      "availability": "Available Today",
      "nextSlot": "1:15 PM",
      "emergencyServices": true,
      "services": ["Corneal Transplant", "Keratoconus", "Dry Eye Treatment"],
      "procedures": ["DSEK", "PKP", "Cross-linking"],
      "languages": ["English", "Korean"],
      "qualifications": ["MD Ophthalmology", "Fellowship in Corneal Diseases"]
    }
  ];

  List<Map<String, dynamic>> get filteredOphthalmologists {
    return ophthalmologists.where((doctor) {
      bool matchesSearch = searchQuery.isEmpty ||
          (doctor["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (doctor["specialty"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesService = selectedService == "All" ||
          (doctor["services"] as List).any((service) => 
              (service as String).contains(selectedService));
      
      bool matchesExperience = selectedExperience == "All" ||
          (selectedExperience == "10+" && (doctor["experience"] as int) >= 10) ||
          (selectedExperience == "15+" && (doctor["experience"] as int) >= 15) ||
          (selectedExperience == "20+" && (doctor["experience"] as int) >= 20);
      
      bool matchesEmergency = !showEmergencyServices || 
          (doctor["emergencyServices"] as bool);
      
      return matchesSearch && matchesService && matchesExperience && matchesEmergency;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eye Specialists"),
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
            _buildServiceCategories(),
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
                      hintText: "Search eye specialists...",
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

  Widget _buildServiceCategories() {
    List<String> services = [
      "All",
      "Cataract",
      "Retinal",
      "Glaucoma",
      "Corneal",
      "Pediatric"
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Eye Care Services",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: services.map((service) {
            bool isSelected = selectedService == service;
            return Container(
              margin: EdgeInsets.only(right: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedService = service;
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
                    service,
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
                  "Emergency Services",
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
            value: showEmergencyServices,
            onChanged: (value) {
              showEmergencyServices = value;
              setState(() {});
            },
            activeColor: dangerColor,
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
                  "${filteredOphthalmologists.length} Eye Specialists",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Comprehensive eye care available",
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
              Icons.visibility,
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
              "Available Ophthalmologists",
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
        ...filteredOphthalmologists.map((doctor) => _buildDoctorCard(doctor)),
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
                        if (doctor["emergencyServices"] as bool)
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
          // Services
          Column(
            spacing: spXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Services:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (doctor["services"] as List<String>).take(3).map((service) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      service,
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
                  label: "Book Examination",
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
              value: selectedExperience,
              decoration: InputDecoration(labelText: "Experience Level"),
              items: ["All", "10+", "15+", "20+"].map((exp) {
                return DropdownMenuItem(
                  value: exp,
                  child: Text(exp == "All" ? "All Experience Levels" : "$exp years"),
                );
              }).toList(),
              onChanged: (value) {
                selectedExperience = value ?? "All";
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
