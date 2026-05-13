import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaSchoolsNearbyView extends StatefulWidget {
  const ReaSchoolsNearbyView({super.key});

  @override
  State<ReaSchoolsNearbyView> createState() => _ReaSchoolsNearbyViewState();
}

class _ReaSchoolsNearbyViewState extends State<ReaSchoolsNearbyView> {
  String selectedType = "All";
  String selectedRating = "All";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> schoolTypes = [
    {"label": "All", "value": "All"},
    {"label": "Elementary", "value": "Elementary"},
    {"label": "Middle School", "value": "Middle"},
    {"label": "High School", "value": "High"},
    {"label": "Private", "value": "Private"},
    {"label": "Charter", "value": "Charter"},
    {"label": "International", "value": "International"},
  ];

  final List<Map<String, dynamic>> ratingFilters = [
    {"label": "All Ratings", "value": "All"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4+ Stars", "value": "4"},
    {"label": "3+ Stars", "value": "3"},
  ];

  final List<Map<String, dynamic>> schools = [
    {
      "name": "Greenwood Elementary School",
      "type": "Elementary",
      "distance": "0.3 km",
      "rating": 4.8,
      "reviews": 156,
      "image": "https://picsum.photos/100/100?random=1&keyword=school",
      "grades": "K-5",
      "students": 450,
      "teacherRatio": "1:18",
      "established": 1995,
      "phone": "+1 234 567 8900",
      "website": "www.greenwoodelem.edu",
      "programs": ["STEM", "Arts", "Special Needs", "ESL"],
      "facilities": ["Library", "Computer Lab", "Gymnasium", "Cafeteria"],
      "achievements": ["Blue Ribbon School", "STEM Excellence Award"],
      "fees": "Public - Free",
      "admissionStatus": "Open Enrollment",
      "principalName": "Dr. Sarah Johnson",
      "schoolHours": "8:00 AM - 3:00 PM",
      "afterSchool": true,
      "transportation": "Bus Available",
      "uniforms": false
    },
    {
      "name": "Lincoln Middle School",
      "type": "Middle",
      "distance": "0.7 km",
      "rating": 4.5,
      "reviews": 89,
      "image": "https://picsum.photos/100/100?random=2&keyword=middle-school",
      "grades": "6-8",
      "students": 320,
      "teacherRatio": "1:22",
      "established": 1988,
      "phone": "+1 234 567 8901",
      "website": "www.lincolnmiddle.edu",
      "programs": ["Advanced Math", "Foreign Languages", "Band", "Athletics"],
      "facilities": ["Science Labs", "Music Room", "Sports Field", "Theater"],
      "achievements": ["Academic Excellence", "State Music Champions"],
      "fees": "Public - Free",
      "admissionStatus": "Zoned Enrollment",
      "principalName": "Mr. Michael Davis",
      "schoolHours": "8:30 AM - 3:30 PM",
      "afterSchool": true,
      "transportation": "Bus Available",
      "uniforms": false
    },
    {
      "name": "Roosevelt High School",
      "type": "High",
      "distance": "1.2 km",
      "rating": 4.6,
      "reviews": 234,
      "image": "https://picsum.photos/100/100?random=3&keyword=high-school",
      "grades": "9-12",
      "students": 1200,
      "teacherRatio": "1:25",
      "established": 1975,
      "phone": "+1 234 567 8902",
      "website": "www.roosevelthigh.edu",
      "programs": ["AP Courses", "IB Program", "Dual Enrollment", "CTE"],
      "facilities": ["Science Wings", "Auditorium", "Stadium", "Vocational Labs"],
      "achievements": ["National Honor Society", "State Championship Football"],
      "fees": "Public - Free",
      "admissionStatus": "Open with Requirements",
      "principalName": "Dr. Jennifer Wilson",
      "schoolHours": "7:45 AM - 2:45 PM",
      "afterSchool": true,
      "transportation": "Bus & Parking Available",
      "uniforms": false
    },
    {
      "name": "St. Mary's Catholic School",
      "type": "Private",
      "distance": "0.9 km",
      "rating": 4.7,
      "reviews": 78,
      "image": "https://picsum.photos/100/100?random=4&keyword=catholic-school",
      "grades": "K-8",
      "students": 280,
      "teacherRatio": "1:15",
      "established": 1962,
      "phone": "+1 234 567 8903",
      "website": "www.stmarys.edu",
      "programs": ["Religious Studies", "Classical Education", "Fine Arts", "Latin"],
      "facilities": ["Chapel", "Art Studio", "Library", "Playground"],
      "achievements": ["Diocesan Excellence Award", "Community Service Award"],
      "fees": "Private - \$8,500/year",
      "admissionStatus": "Application Required",
      "principalName": "Sister Margaret O'Brien",
      "schoolHours": "8:00 AM - 3:15 PM",
      "afterSchool": true,
      "transportation": "Parent Pickup",
      "uniforms": true
    },
    {
      "name": "Innovation Charter Academy",
      "type": "Charter",
      "distance": "1.5 km",
      "rating": 4.4,
      "reviews": 67,
      "image": "https://picsum.photos/100/100?random=5&keyword=charter-school",
      "grades": "K-12",
      "students": 650,
      "teacherRatio": "1:20",
      "established": 2010,
      "phone": "+1 234 567 8904",
      "website": "www.innovationcharter.edu",
      "programs": ["Project-Based Learning", "Technology Integration", "Entrepreneurship"],
      "facilities": ["Innovation Lab", "Media Center", "Flex Spaces", "Outdoor Classroom"],
      "achievements": ["Innovation in Education Award", "High Tech School Recognition"],
      "fees": "Public Charter - Free",
      "admissionStatus": "Lottery System",
      "principalName": "Dr. Robert Chen",
      "schoolHours": "8:15 AM - 3:15 PM",
      "afterSchool": true,
      "transportation": "Limited Bus Service",
      "uniforms": false
    },
    {
      "name": "International Preparatory Academy",
      "type": "International",
      "distance": "2.1 km",
      "rating": 4.9,
      "reviews": 45,
      "image": "https://picsum.photos/100/100?random=6&keyword=international-school",
      "grades": "PreK-12",
      "students": 380,
      "teacherRatio": "1:12",
      "established": 2005,
      "phone": "+1 234 567 8905",
      "website": "www.ipaschool.edu",
      "programs": ["IB Program", "Multilingual Education", "Global Studies", "Exchange Programs"],
      "facilities": ["Language Labs", "Cultural Center", "International Library", "Global Café"],
      "achievements": ["IB World School", "International Award for Excellence"],
      "fees": "Private - \$15,500/year",
      "admissionStatus": "Selective Admission",
      "principalName": "Dr. Elena Ramirez",
      "schoolHours": "8:00 AM - 3:30 PM",
      "afterSchool": true,
      "transportation": "International Bus Routes",
      "uniforms": true
    },
    {
      "name": "Montessori Children's House",
      "type": "Private",
      "distance": "0.6 km",
      "rating": 4.6,
      "reviews": 92,
      "image": "https://picsum.photos/100/100?random=7&keyword=montessori",
      "grades": "PreK-6",
      "students": 120,
      "teacherRatio": "1:10",
      "established": 1998,
      "phone": "+1 234 567 8906",
      "website": "www.montessorihouse.edu",
      "programs": ["Montessori Method", "Nature Studies", "Multi-Age Classrooms", "Practical Life"],
      "facilities": ["Prepared Environment", "Nature Garden", "Peace Table", "Children's Kitchen"],
      "achievements": ["Montessori Accreditation", "Environmental Education Award"],
      "fees": "Private - \$12,000/year",
      "admissionStatus": "Open with Interview",
      "principalName": "Ms. Lisa Anderson",
      "schoolHours": "8:30 AM - 3:00 PM",
      "afterSchool": true,
      "transportation": "Parent Pickup",
      "uniforms": false
    },
    {
      "name": "Washington Elementary",
      "type": "Elementary",
      "distance": "1.1 km",
      "rating": 4.3,
      "reviews": 134,
      "image": "https://picsum.photos/100/100?random=8&keyword=elementary",
      "grades": "K-5",
      "students": 380,
      "teacherRatio": "1:20",
      "established": 1985,
      "phone": "+1 234 567 8907",
      "website": "www.washingtonelem.edu",
      "programs": ["Reading First", "Math Intervention", "Gifted Program", "Special Education"],
      "facilities": ["Media Center", "Computer Lab", "Art Room", "Music Room"],
      "achievements": ["Reading Excellence", "Math Proficiency Award"],
      "fees": "Public - Free",
      "admissionStatus": "Neighborhood School",
      "principalName": "Mrs. Patricia Brown",
      "schoolHours": "8:15 AM - 2:45 PM",
      "afterSchool": true,
      "transportation": "Bus Available",
      "uniforms": false
    }
  ];

  List<Map<String, dynamic>> get filteredSchools {
    var filtered = schools;
    
    if (selectedType != "All") {
      filtered = filtered.where((school) => school["type"] == selectedType).toList();
    }
    
    if (selectedRating != "All") {
      double minRating = double.parse(selectedRating);
      filtered = filtered.where((school) => (school["rating"] as double) >= minRating).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((school) => 
        (school["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (school["type"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Elementary": return successColor;
      case "Middle": return infoColor;
      case "High": return primaryColor;
      case "Private": return warningColor;
      case "Charter": return secondaryColor;
      case "International": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: 14, color: warningColor);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: 14, color: warningColor);
        } else {
          return Icon(Icons.star_border, size: 14, color: disabledBoldColor);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schools Nearby"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              ss("Opening schools map view");
            },
          ),
          IconButton(
            icon: Icon(Icons.compare_arrows),
            onPressed: () {
              ss("Opening school comparison tool");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Schools in Your Area",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${schools.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Schools Found",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(180),
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
                              "4.6",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Average Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(180),
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
                              "1.0 km",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Avg Distance",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(180),
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
            
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search schools...",
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
                  onPressed: () {
                    // Search functionality
                  },
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Filters Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "School Type",
                    items: schoolTypes,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Rating",
                    items: ratingFilters,
                    value: selectedRating,
                    onChanged: (value, label) {
                      selectedRating = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Quick Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.school, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "4",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Public Schools",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.account_balance, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "3",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Private Schools",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.directions_walk, color: infoColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "5",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Walking Distance",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Section Header
            Text(
              "Schools List (${filteredSchools.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Schools List
            ...filteredSchools.map((school) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${school["image"]}",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${school["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(school["type"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${school["type"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getTypeColor(school["type"]),
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
                                  SizedBox(width: 4),
                                  Text(
                                    "${school["distance"]} away",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  _buildStarRating(school["rating"]),
                                  SizedBox(width: 4),
                                  Text(
                                    "${school["rating"]} (${school["reviews"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Grades: ${school["grades"]} • ${school["students"]} students • ${school["teacherRatio"]} ratio",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // School Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
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
                                      "Principal",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${school["principalName"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
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
                                      "Hours",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${school["schoolHours"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
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
                                      "Fees",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${school["fees"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
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
                                      "Transportation",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${school["transportation"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: infoColor,
                                        fontWeight: FontWeight.w600,
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
                    
                    SizedBox(height: spSm),
                    
                    // Programs
                    Text(
                      "Programs:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (school["programs"] as List).map((program) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: primaryColor.withAlpha(30)),
                          ),
                          child: Text(
                            "$program",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Achievements
                    if ((school["achievements"] as List).isNotEmpty) ...[
                      Text(
                        "Achievements:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (school["achievements"] as List).map((achievement) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: warningColor.withAlpha(30)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, size: 12, color: warningColor),
                                SizedBox(width: 4),
                                Text(
                                  "$achievement",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spSm),
                    ],
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            icon: Icons.info,
                            size: bs.sm,
                            onPressed: () {
                              ss("Viewing details for ${school["name"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            ss("Calling ${school["name"]}");
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.language,
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening website for ${school["name"]}");
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.directions,
                          size: bs.sm,
                          onPressed: () {
                            ss("Getting directions to ${school["name"]}");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            if (filteredSchools.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No schools found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search criteria or expanding your search radius",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: spLg),
            
            // School Comparison Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Compare Selected Schools",
                icon: Icons.compare_arrows,
                size: bs.md,
                onPressed: () {
                  ss("Opening school comparison tool");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
