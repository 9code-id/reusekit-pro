import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaNeurologistView extends StatefulWidget {
  const MhaNeurologistView({super.key});

  @override
  State<MhaNeurologistView> createState() => _MhaNeurologistViewState();
}

class _MhaNeurologistViewState extends State<MhaNeurologistView> {
  String searchQuery = "";
  String selectedSpecialty = "All";
  String selectedExperience = "All";
  String selectedLocation = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> neurologists = [
    {
      "name": "Dr. Sarah Mitchell",
      "specialization": "General Neurology",
      "experience": "15 years",
      "rating": 4.8,
      "reviews": 245,
      "hospital": "Metropolitan Medical Center",
      "location": "Downtown",
      "distance": "2.3 km",
      "consultationFee": 150.0,
      "isAvailable": true,
      "nextSlot": "Today 2:30 PM",
      "image": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "education": "MD from Harvard Medical School",
      "languages": ["English", "Spanish"],
      "conditions": ["Epilepsy", "Migraine", "Stroke", "Memory Loss"]
    },
    {
      "name": "Dr. Michael Chen",
      "specialization": "Pediatric Neurology",
      "experience": "12 years",
      "rating": 4.9,
      "reviews": 189,
      "hospital": "Children's Hospital",
      "location": "Midtown",
      "distance": "3.1 km",
      "consultationFee": 175.0,
      "isAvailable": true,
      "nextSlot": "Tomorrow 10:00 AM",
      "image": "https://picsum.photos/100/100?random=2&keyword=doctor",
      "education": "MD from Johns Hopkins",
      "languages": ["English", "Mandarin"],
      "conditions": ["Cerebral Palsy", "Autism", "ADHD", "Developmental Delays"]
    },
    {
      "name": "Dr. Emily Rodriguez",
      "specialization": "Movement Disorders",
      "experience": "18 years",
      "rating": 4.7,
      "reviews": 312,
      "hospital": "Neuroscience Institute",
      "location": "Uptown",
      "distance": "4.5 km",
      "consultationFee": 200.0,
      "isAvailable": false,
      "nextSlot": "Monday 9:00 AM",
      "image": "https://picsum.photos/100/100?random=3&keyword=doctor",
      "education": "MD from Mayo Clinic",
      "languages": ["English", "Spanish", "Portuguese"],
      "conditions": ["Parkinson's", "Tremors", "Dystonia", "Huntington's"]
    },
    {
      "name": "Dr. James Wilson",
      "specialization": "Stroke & Vascular Neurology",
      "experience": "20 years",
      "rating": 4.6,
      "reviews": 278,
      "hospital": "Stroke Center",
      "location": "West Side",
      "distance": "5.2 km",
      "consultationFee": 180.0,
      "isAvailable": true,
      "nextSlot": "Today 4:15 PM",
      "image": "https://picsum.photos/100/100?random=4&keyword=doctor",
      "education": "MD from Cleveland Clinic",
      "languages": ["English"],
      "conditions": ["Stroke", "TIA", "Aneurysm", "Vascular Dementia"]
    },
    {
      "name": "Dr. Lisa Thompson",
      "specialization": "Epilepsy & EEG",
      "experience": "14 years",
      "rating": 4.8,
      "reviews": 156,
      "hospital": "Epilepsy Center",
      "location": "East Side",
      "distance": "6.1 km",
      "consultationFee": 160.0,
      "isAvailable": true,
      "nextSlot": "Tomorrow 2:00 PM",
      "image": "https://picsum.photos/100/100?random=5&keyword=doctor",
      "education": "MD from UCLA Medical Center",
      "languages": ["English", "French"],
      "conditions": ["Epilepsy", "Seizures", "EEG Monitoring", "Brain Waves"]
    }
  ];

  List<Map<String, dynamic>> get filteredNeurologists {
    return neurologists.where((doctor) {
      final matchesSearch = searchQuery.isEmpty ||
          (doctor["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (doctor["specialization"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (doctor["hospital"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesSpecialty = selectedSpecialty == "All" ||
          (doctor["specialization"] as String) == selectedSpecialty;
      
      final matchesExperience = selectedExperience == "All" ||
          _matchesExperienceFilter(doctor["experience"] as String);
      
      final matchesLocation = selectedLocation == "All" ||
          (doctor["location"] as String) == selectedLocation;
      
      return matchesSearch && matchesSpecialty && matchesExperience && matchesLocation;
    }).toList();
  }

  bool _matchesExperienceFilter(String experience) {
    final years = int.tryParse(experience.split(' ')[0]) ?? 0;
    switch (selectedExperience) {
      case "0-5 years":
        return years <= 5;
      case "5-10 years":
        return years > 5 && years <= 10;
      case "10+ years":
        return years > 10;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neurologists"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search neurologists...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Filters Section
          if (showFilters)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Specialty",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "General Neurology", "value": "General Neurology"},
                            {"label": "Pediatric Neurology", "value": "Pediatric Neurology"},
                            {"label": "Movement Disorders", "value": "Movement Disorders"},
                            {"label": "Stroke & Vascular", "value": "Stroke & Vascular Neurology"},
                            {"label": "Epilepsy & EEG", "value": "Epilepsy & EEG"},
                          ],
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
                          label: "Experience",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "0-5 years", "value": "0-5 years"},
                            {"label": "5-10 years", "value": "5-10 years"},
                            {"label": "10+ years", "value": "10+ years"},
                          ],
                          value: selectedExperience,
                          onChanged: (value, label) {
                            selectedExperience = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Location",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Downtown", "value": "Downtown"},
                      {"label": "Midtown", "value": "Midtown"},
                      {"label": "Uptown", "value": "Uptown"},
                      {"label": "West Side", "value": "West Side"},
                      {"label": "East Side", "value": "East Side"},
                    ],
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

          // Stats Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredNeurologists.length} neurologists found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.verified_user,
                  size: 16,
                  color: successColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Verified doctors",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Neurologists List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredNeurologists.length,
              itemBuilder: (context, index) {
                final doctor = filteredNeurologists[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor Header
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${doctor["image"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${doctor["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: spXs / 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: doctor["isAvailable"] as bool
                                            ? successColor.withAlpha(20)
                                            : warningColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        doctor["isAvailable"] as bool ? "Available" : "Busy",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: doctor["isAvailable"] as bool
                                              ? successColor
                                              : warningColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${doctor["specialization"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs / 2),
                                    Text(
                                      "${doctor["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
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

                      SizedBox(height: spSm),

                      // Doctor Details
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_hospital,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${doctor["hospital"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${doctor["location"]} • ${doctor["distance"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.work,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${doctor["experience"]} experience",
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(doctor["consultationFee"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Consultation",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Conditions Treated
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs / 2,
                        children: (doctor["conditions"] as List).take(3).map((condition) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: spXs / 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$condition",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: spSm),

                      // Next Available Slot
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 16,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Next available: ${doctor["nextSlot"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Profile",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to doctor detail
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: doctor["isAvailable"] as bool
                                  ? "Book Now"
                                  : "Schedule",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to booking
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sort by",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Highest Rated"),
              onTap: () {
                neurologists.sort((a, b) => 
                    (b["rating"] as double).compareTo(a["rating"] as double));
                setState(() {});
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Lowest Price"),
              onTap: () {
                neurologists.sort((a, b) => 
                    (a["consultationFee"] as double).compareTo(b["consultationFee"] as double));
                setState(() {});
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Nearest"),
              onTap: () {
                neurologists.sort((a, b) {
                  final aDistance = double.tryParse((a["distance"] as String).split(' ')[0]) ?? 0;
                  final bDistance = double.tryParse((b["distance"] as String).split(' ')[0]) ?? 0;
                  return aDistance.compareTo(bDistance);
                });
                setState(() {});
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text("Most Experienced"),
              onTap: () {
                neurologists.sort((a, b) {
                  final aExp = int.tryParse((a["experience"] as String).split(' ')[0]) ?? 0;
                  final bExp = int.tryParse((b["experience"] as String).split(' ')[0]) ?? 0;
                  return bExp.compareTo(aExp);
                });
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
