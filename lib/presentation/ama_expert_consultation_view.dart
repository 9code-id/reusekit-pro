import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaExpertConsultationView extends StatefulWidget {
  const AmaExpertConsultationView({super.key});

  @override
  State<AmaExpertConsultationView> createState() => _AmaExpertConsultationViewState();
}

class _AmaExpertConsultationViewState extends State<AmaExpertConsultationView> {
  List experts = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "title": "Soil Health Specialist",
      "expertise": ["Soil Chemistry", "Nutrient Management", "pH Correction"],
      "experience": "15 years",
      "rating": 4.9,
      "reviews": 127,
      "availability": "Available Today",
      "hourly_rate": 85.0,
      "location": "University of Agriculture",
      "languages": ["English", "Spanish"],
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "specializations": ["Organic Farming", "Precision Agriculture"],
      "certifications": ["Certified Crop Advisor", "Soil Scientist"],
      "color": successColor,
      "icon": Icons.science,
    },
    {
      "id": 2,
      "name": "Prof. Michael Chen",
      "title": "Crop Protection Expert",
      "expertise": ["IPM", "Disease Management", "Pest Identification"],
      "experience": "20 years",
      "rating": 4.8,
      "reviews": 89,
      "availability": "Available Tomorrow",
      "hourly_rate": 95.0,
      "location": "Agricultural Research Institute",
      "languages": ["English", "Mandarin"],
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "specializations": ["Biological Control", "Sustainable Practices"],
      "certifications": ["Plant Pathologist", "IPM Specialist"],
      "color": warningColor,
      "icon": Icons.bug_report,
    },
    {
      "id": 3,
      "name": "Dr. Emma Rodriguez",
      "title": "Water Management Consultant",
      "expertise": ["Irrigation Design", "Water Conservation", "Drainage"],
      "experience": "12 years",
      "rating": 4.7,
      "reviews": 63,
      "availability": "Busy This Week",
      "hourly_rate": 90.0,
      "location": "Irrigation Solutions LLC",
      "languages": ["English", "Spanish", "Portuguese"],
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "specializations": ["Drip Systems", "Smart Irrigation"],
      "certifications": ["Irrigation Engineer", "Water Specialist"],
      "color": infoColor,
      "icon": Icons.water_drop,
    },
    {
      "id": 4,
      "name": "James Mitchell",
      "title": "Organic Certification Advisor",
      "expertise": ["USDA Organic", "Certification Process", "Documentation"],
      "experience": "18 years",
      "rating": 4.9,
      "reviews": 145,
      "availability": "Available Today",
      "hourly_rate": 80.0,
      "location": "Organic Certification Board",
      "languages": ["English"],
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "specializations": ["Transition Planning", "Compliance Auditing"],
      "certifications": ["Organic Inspector", "Quality Assurance"],
      "color": primaryColor,
      "icon": Icons.eco,
    },
    {
      "id": 5,
      "name": "Dr. Lisa Park",
      "title": "Plant Nutrition Specialist",
      "expertise": ["Fertilizer Management", "Micronutrients", "Foliar Feeding"],
      "experience": "14 years",
      "rating": 4.6,
      "reviews": 78,
      "availability": "Available This Week",
      "hourly_rate": 75.0,
      "location": "Plant Science Center",
      "languages": ["English", "Korean"],
      "avatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "specializations": ["Precision Nutrition", "Leaf Analysis"],
      "certifications": ["Plant Nutritionist", "Research Scientist"],
      "color": secondaryColor,
      "icon": Icons.local_florist,
    },
  ];

  List consultations = [
    {
      "id": 1,
      "expert_name": "Dr. Sarah Johnson",
      "date": "2024-02-08",
      "time": "10:00 AM",
      "duration": "1 hour",
      "status": "Upcoming",
      "topic": "Soil pH adjustment strategies",
      "type": "Video Call",
      "price": 85.0,
    },
    {
      "id": 2,
      "expert_name": "Prof. Michael Chen",
      "date": "2024-02-05",
      "time": "2:00 PM",
      "duration": "45 minutes",
      "status": "Completed",
      "topic": "Aphid infestation treatment",
      "type": "Phone Call",
      "price": 71.25,
    },
  ];

  String selectedSpecialization = "All";
  String selectedAvailability = "All";
  List<String> specializations = ["All", "Soil Health", "Pest Control", "Irrigation", "Organic Farming", "Plant Nutrition"];
  List<String> availabilities = ["All", "Available Today", "Available Tomorrow", "Available This Week", "Busy This Week"];

  @override
  Widget build(BuildContext context) {
    List filteredExperts = experts.where((expert) {
      bool specializationMatch = selectedSpecialization == "All" || 
        (expert["specializations"] as List).any((spec) => "$spec".contains(selectedSpecialization));
      bool availabilityMatch = selectedAvailability == "All" || expert["availability"] == selectedAvailability;
      return specializationMatch && availabilityMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Expert Consultation"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              // View scheduled consultations
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Consultation Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Expert Consultation",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${experts.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Expert Advisors",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${consultations.where((c) => c["status"] == "Upcoming").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Upcoming",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // My Consultations Section
            if (consultations.isNotEmpty) ...[
              Text(
                "My Consultations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              ...consultations.map((consultation) => 
                Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: consultation["status"] == "Upcoming" ? successColor : infoColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${consultation["expert_name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${consultation["topic"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: consultation["status"] == "Upcoming" 
                                  ? successColor.withAlpha(20)
                                  : infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${consultation["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: consultation["status"] == "Upcoming" ? successColor : infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text("${consultation["date"]} at ${consultation["time"]}", 
                               style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          SizedBox(width: spSm),
                          Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text("${consultation["duration"]}", 
                               style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ).toList(),
              
              SizedBox(height: spLg),
            ],
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Specialization",
                    items: specializations.map((spec) => {
                      "label": spec,
                      "value": spec,
                    }).toList(),
                    value: selectedSpecialization,
                    onChanged: (value, label) {
                      selectedSpecialization = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Availability",
                    items: availabilities.map((avail) => {
                      "label": avail,
                      "value": avail,
                    }).toList(),
                    value: selectedAvailability,
                    onChanged: (value, label) {
                      selectedAvailability = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Available Experts
            Text(
              "Available Experts (${filteredExperts.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredExperts.length,
              itemBuilder: (context, index) {
                final expert = filteredExperts[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expert Header
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${expert["avatar"]}",
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
                                  Text(
                                    "${expert["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${expert["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, size: 16, color: warningColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${expert["rating"]} (${expert["reviews"]} reviews)",
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getAvailabilityColor(expert["availability"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${expert["availability"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getAvailabilityColor(expert["availability"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Expert Details
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.work, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text("${expert["experience"]}", 
                                             style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.monetization_on, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text("\$${(expert["hourly_rate"] as double).toStringAsFixed(0)}/hr", 
                                             style: TextStyle(fontSize: 12, color: disabledBoldColor, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text("${expert["location"]}", 
                                         style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Expertise Areas
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expertise:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (expert["expertise"] as List).map((skill) => 
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (expert["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$skill",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: expert["color"] as Color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Languages
                        Row(
                          children: [
                            Icon(Icons.language, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Languages: ${(expert["languages"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Book Consultation",
                                size: bs.sm,
                                onPressed: () {
                                  // Book consultation with expert
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Profile",
                              icon: Icons.person,
                              size: bs.sm,
                              onPressed: () {
                                // View expert profile
                              },
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.message,
                              size: bs.sm,
                              onPressed: () {
                                // Message expert
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvailabilityColor(String availability) {
    if (availability.contains("Available Today")) return successColor;
    if (availability.contains("Available Tomorrow")) return infoColor;
    if (availability.contains("Available This Week")) return warningColor;
    if (availability.contains("Busy")) return dangerColor;
    return disabledBoldColor;
  }
}
