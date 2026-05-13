import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaCardiologistView extends StatefulWidget {
  const MhaCardiologistView({super.key});

  @override
  State<MhaCardiologistView> createState() => _MhaCardiologistViewState();
}

class _MhaCardiologistViewState extends State<MhaCardiologistView> {
  String selectedSpecialty = "All";
  String selectedRating = "All";
  String selectedAvailability = "All";
  bool showOnlineConsultation = false;

  List<Map<String, dynamic>> cardiologists = [
    {
      "id": 1,
      "name": "Dr. Sarah Mitchell",
      "specialty": "Interventional Cardiology",
      "hospital": "Heart Care Medical Center",
      "experience": 15,
      "rating": 4.9,
      "reviews": 324,
      "fee": 150.0,
      "image": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "availability": "Available Today",
      "nextSlot": "2:30 PM",
      "onlineConsultation": true,
      "qualifications": ["MD Cardiology", "Fellowship in Interventional Cardiology"],
      "languages": ["English", "Spanish"],
      "address": "123 Medical Plaza, Suite 200"
    },
    {
      "id": 2,
      "name": "Dr. Michael Chen",
      "specialty": "Electrophysiology",
      "hospital": "Cardiac Institute",
      "experience": 18,
      "rating": 4.8,
      "reviews": 412,
      "fee": 175.0,
      "image": "https://picsum.photos/100/100?random=2&keyword=doctor",
      "availability": "Available Tomorrow",
      "nextSlot": "10:00 AM",
      "onlineConsultation": true,
      "qualifications": ["MD Cardiology", "Fellowship in Electrophysiology"],
      "languages": ["English", "Mandarin"],
      "address": "456 Heart Street, Floor 3"
    },
    {
      "id": 3,
      "name": "Dr. Emily Rodriguez",
      "specialty": "Pediatric Cardiology",
      "hospital": "Children's Heart Center",
      "experience": 12,
      "rating": 4.9,
      "reviews": 287,
      "fee": 140.0,
      "image": "https://picsum.photos/100/100?random=3&keyword=doctor",
      "availability": "Available Today",
      "nextSlot": "4:15 PM",
      "onlineConsultation": false,
      "qualifications": ["MD Pediatrics", "Fellowship in Pediatric Cardiology"],
      "languages": ["English", "Spanish", "French"],
      "address": "789 Children's Way, Building A"
    },
    {
      "id": 4,
      "name": "Dr. Robert Anderson",
      "specialty": "Cardiac Surgery",
      "hospital": "Advanced Cardiac Center",
      "experience": 22,
      "rating": 4.7,
      "reviews": 156,
      "fee": 200.0,
      "image": "https://picsum.photos/100/100?random=4&keyword=doctor",
      "availability": "Available Next Week",
      "nextSlot": "Mon 9:00 AM",
      "onlineConsultation": false,
      "qualifications": ["MD Surgery", "Fellowship in Cardiac Surgery"],
      "languages": ["English"],
      "address": "321 Surgery Center, Floor 5"
    },
    {
      "id": 5,
      "name": "Dr. Lisa Thompson",
      "specialty": "Preventive Cardiology",
      "hospital": "Wellness Heart Clinic",
      "experience": 10,
      "rating": 4.8,
      "reviews": 298,
      "fee": 120.0,
      "image": "https://picsum.photos/100/100?random=5&keyword=doctor",
      "availability": "Available Today",
      "nextSlot": "3:45 PM",
      "onlineConsultation": true,
      "qualifications": ["MD Internal Medicine", "Board Certified Cardiology"],
      "languages": ["English", "German"],
      "address": "654 Wellness Boulevard, Suite 100"
    }
  ];

  List<Map<String, dynamic>> get filteredCardiologists {
    return cardiologists.where((doctor) {
      bool matchesSpecialty = selectedSpecialty == "All" || 
          (doctor["specialty"] as String).contains(selectedSpecialty);
      bool matchesRating = selectedRating == "All" || 
          (doctor["rating"] as double) >= double.parse(selectedRating);
      bool matchesAvailability = selectedAvailability == "All" || 
          (doctor["availability"] as String).contains(selectedAvailability);
      bool matchesOnline = !showOnlineConsultation || 
          (doctor["onlineConsultation"] as bool);
      
      return matchesSpecialty && matchesRating && matchesAvailability && matchesOnline;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cardiologists"),
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
            _buildSpecialtySection(),
            _buildQuickFilters(),
            _buildStatsCard(),
            _buildCardiologistsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialtySection() {
    List<String> specialties = [
      "All",
      "Interventional",
      "Electrophysiology", 
      "Pediatric",
      "Surgery",
      "Preventive"
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cardiology Specialties",
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
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.video_call, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Online Consultation",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Switch(
                  value: showOnlineConsultation,
                  onChanged: (value) {
                    showOnlineConsultation = value;
                    setState(() {});
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
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
                  "${filteredCardiologists.length} Specialists",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Available cardiologists near you",
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
              Icons.favorite,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardiologistsList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Cardiologists",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredCardiologists.map((doctor) => _buildDoctorCard(doctor)),
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
                    Text(
                      "${doctor["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
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
              if (doctor["onlineConsultation"] as bool)
                Expanded(
                  child: QButton(
                    label: "Video Call",
                    icon: Icons.video_call,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              if (doctor["onlineConsultation"] as bool) SizedBox(width: spSm),
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
        title: Text("Filter Cardiologists"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            DropdownButtonFormField<String>(
              value: selectedRating,
              decoration: InputDecoration(labelText: "Minimum Rating"),
              items: ["All", "4.0", "4.5", "4.8"].map((rating) {
                return DropdownMenuItem(
                  value: rating,
                  child: Text(rating == "All" ? "All Ratings" : "$rating+ Stars"),
                );
              }).toList(),
              onChanged: (value) {
                selectedRating = value ?? "All";
                setState(() {});
              },
            ),
            DropdownButtonFormField<String>(
              value: selectedAvailability,
              decoration: InputDecoration(labelText: "Availability"),
              items: ["All", "Today", "Tomorrow", "Next Week"].map((availability) {
                return DropdownMenuItem(
                  value: availability,
                  child: Text(availability == "All" ? "Any Time" : "Available $availability"),
                );
              }).toList(),
              onChanged: (value) {
                selectedAvailability = value ?? "All";
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
