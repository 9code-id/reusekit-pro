import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaTutorSearchView extends StatefulWidget {
  const ElaTutorSearchView({super.key});

  @override
  State<ElaTutorSearchView> createState() => _ElaTutorSearchViewState();
}

class _ElaTutorSearchViewState extends State<ElaTutorSearchView> {
  String searchQuery = "";
  String selectedSubject = "all";
  String selectedPriceRange = "all";
  String selectedRating = "all";
  String selectedAvailability = "all";

  List<Map<String, dynamic>> subjectItems = [
    {"label": "All Subjects", "value": "all"},
    {"label": "Mathematics", "value": "mathematics"},
    {"label": "Physics", "value": "physics"},
    {"label": "Chemistry", "value": "chemistry"},
    {"label": "Biology", "value": "biology"},
    {"label": "Computer Science", "value": "computer_science"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Economics", "value": "economics"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "Any Price", "value": "all"},
    {"label": "\$10-\$25/hr", "value": "10-25"},
    {"label": "\$25-\$50/hr", "value": "25-50"},
    {"label": "\$50-\$75/hr", "value": "50-75"},
    {"label": "\$75+/hr", "value": "75+"},
  ];

  List<Map<String, dynamic>> ratingItems = [
    {"label": "Any Rating", "value": "all"},
    {"label": "4.5+ Stars", "value": "4.5"},
    {"label": "4.0+ Stars", "value": "4.0"},
    {"label": "3.5+ Stars", "value": "3.5"},
  ];

  List<Map<String, dynamic>> availabilityItems = [
    {"label": "Any Time", "value": "all"},
    {"label": "Available Now", "value": "now"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
  ];

  List<Map<String, dynamic>> tutors = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "title": "Mathematics Professor",
      "specialties": ["Calculus", "Linear Algebra", "Statistics"],
      "education": "PhD in Mathematics, MIT",
      "experience": "10+ years",
      "rating": 4.9,
      "reviewCount": 156,
      "hourlyRate": 65,
      "profileImage": "https://picsum.photos/100/100?random=1&keyword=teacher",
      "location": "New York, NY",
      "isOnline": true,
      "responseTime": "Within 1 hour",
      "languages": ["English", "Spanish"],
      "sessionsTaught": 1250,
      "isVerified": true,
      "availability": ["Monday", "Tuesday", "Wednesday", "Thursday"],
      "bio": "Experienced mathematics professor with expertise in advanced calculus and linear algebra. I focus on building strong foundational understanding.",
    },
    {
      "id": 2,
      "name": "Prof. Michael Chen",
      "title": "Physics Researcher",
      "specialties": ["Quantum Physics", "Thermodynamics", "Mechanics"],
      "education": "PhD in Physics, Stanford",
      "experience": "8 years",
      "rating": 4.8,
      "reviewCount": 98,
      "hourlyRate": 55,
      "profileImage": "https://picsum.photos/100/100?random=2&keyword=teacher",
      "location": "San Francisco, CA",
      "isOnline": false,
      "responseTime": "Within 2 hours",
      "languages": ["English", "Mandarin"],
      "sessionsTaught": 890,
      "isVerified": true,
      "availability": ["Tuesday", "Thursday", "Saturday", "Sunday"],
      "bio": "Research physicist specializing in quantum mechanics. I make complex physics concepts accessible and engaging.",
    },
    {
      "id": 3,
      "name": "Dr. Emily Davis",
      "title": "Chemistry Expert",
      "specialties": ["Organic Chemistry", "Biochemistry", "Lab Techniques"],
      "education": "PhD in Chemistry, Harvard",
      "experience": "12 years",
      "rating": 4.9,
      "reviewCount": 203,
      "hourlyRate": 70,
      "profileImage": "https://picsum.photos/100/100?random=3&keyword=teacher",
      "location": "Boston, MA",
      "isOnline": true,
      "responseTime": "Within 30 minutes",
      "languages": ["English", "French"],
      "sessionsTaught": 1680,
      "isVerified": true,
      "availability": ["Monday", "Wednesday", "Friday", "Saturday"],
      "bio": "Passionate chemistry educator with extensive research background. I help students master complex chemical concepts through practical examples.",
    },
    {
      "id": 4,
      "name": "Alex Rodriguez",
      "title": "Computer Science Engineer",
      "specialties": ["Programming", "Data Structures", "Machine Learning"],
      "education": "MS Computer Science, UC Berkeley",
      "experience": "6 years",
      "rating": 4.7,
      "reviewCount": 142,
      "hourlyRate": 45,
      "profileImage": "https://picsum.photos/100/100?random=4&keyword=teacher",
      "location": "Seattle, WA",
      "isOnline": true,
      "responseTime": "Within 1 hour",
      "languages": ["English", "Portuguese"],
      "sessionsTaught": 750,
      "isVerified": false,
      "availability": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
      "bio": "Software engineer turned educator. I specialize in making programming concepts clear and practical for beginners and advanced students.",
    },
    {
      "id": 5,
      "name": "Dr. Lisa Thompson",
      "title": "Biology Professor",
      "specialties": ["Cell Biology", "Genetics", "Molecular Biology"],
      "education": "PhD in Biology, Yale",
      "experience": "15 years",
      "rating": 4.8,
      "reviewCount": 187,
      "hourlyRate": 60,
      "profileImage": "https://picsum.photos/100/100?random=5&keyword=teacher",
      "location": "New Haven, CT",
      "isOnline": false,
      "responseTime": "Within 3 hours",
      "languages": ["English"],
      "sessionsTaught": 1420,
      "isVerified": true,
      "availability": ["Tuesday", "Thursday", "Saturday"],
      "bio": "Experienced biology professor with research expertise in genetics. I help students understand life sciences through interactive learning.",
    },
    {
      "id": 6,
      "name": "James Wilson",
      "title": "Economics Tutor",
      "specialties": ["Microeconomics", "Macroeconomics", "Statistics"],
      "education": "MA Economics, Columbia",
      "experience": "5 years",
      "rating": 4.6,
      "reviewCount": 89,
      "hourlyRate": 40,
      "profileImage": "https://picsum.photos/100/100?random=6&keyword=teacher",
      "location": "Chicago, IL",
      "isOnline": true,
      "responseTime": "Within 2 hours",
      "languages": ["English", "German"],
      "sessionsTaught": 560,
      "isVerified": false,
      "availability": ["Monday", "Wednesday", "Friday", "Sunday"],
      "bio": "Economics graduate with practical industry experience. I focus on real-world applications of economic theory.",
    },
  ];

  List<Map<String, dynamic>> get filteredTutors {
    return tutors.where((tutor) {
      bool matchesSearch = tutor["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          tutor["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (tutor["specialties"] as List).any((specialty) => 
              specialty.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesSubject = selectedSubject == "all" || 
          (tutor["specialties"] as List).any((specialty) => 
              specialty.toString().toLowerCase().contains(selectedSubject.replaceAll("_", " ")));
      
      bool matchesPrice = selectedPriceRange == "all" || _matchesPriceRange(tutor["hourlyRate"] as int);
      bool matchesRating = selectedRating == "all" || (tutor["rating"] as double) >= double.parse(selectedRating);
      bool matchesAvailability = selectedAvailability == "all" || _matchesAvailability(tutor);
      
      return matchesSearch && matchesSubject && matchesPrice && matchesRating && matchesAvailability;
    }).toList();
  }

  bool _matchesPriceRange(int hourlyRate) {
    switch (selectedPriceRange) {
      case "10-25":
        return hourlyRate >= 10 && hourlyRate <= 25;
      case "25-50":
        return hourlyRate >= 25 && hourlyRate <= 50;
      case "50-75":
        return hourlyRate >= 50 && hourlyRate <= 75;
      case "75+":
        return hourlyRate >= 75;
      default:
        return true;
    }
  }

  bool _matchesAvailability(Map<String, dynamic> tutor) {
    switch (selectedAvailability) {
      case "now":
        return tutor["isOnline"] as bool;
      case "today":
        return (tutor["availability"] as List).contains(_getCurrentDay());
      case "week":
        return (tutor["availability"] as List).isNotEmpty;
      default:
        return true;
    }
  }

  String _getCurrentDay() {
    List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    return days[DateTime.now().weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find a Tutor"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showAdvancedFilters();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search tutors",
              value: searchQuery,
              hint: "Search by name, subject, or specialty",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Quick Filters
            QHorizontalScroll(
              children: [
                _buildFilterChip("Mathematics", () {
                  selectedSubject = selectedSubject == "mathematics" ? "all" : "mathematics";
                  setState(() {});
                }),
                _buildFilterChip("Physics", () {
                  selectedSubject = selectedSubject == "physics" ? "all" : "physics";
                  setState(() {});
                }),
                _buildFilterChip("Chemistry", () {
                  selectedSubject = selectedSubject == "chemistry" ? "all" : "chemistry";
                  setState(() {});
                }),
                _buildFilterChip("Available Now", () {
                  selectedAvailability = selectedAvailability == "now" ? "all" : "now";
                  setState(() {});
                }),
                _buildFilterChip("High Rated", () {
                  selectedRating = selectedRating == "4.5" ? "all" : "4.5";
                  setState(() {});
                }),
              ],
            ),

            // Results Header
            Row(
              children: [
                Text(
                  "Available Tutors",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredTutors.length} tutors found",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // Tutors List
            ...filteredTutors.map((tutor) {
              return Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    // Tutor Header
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage("${tutor["profileImage"]}"),
                            ),
                            if (tutor["isOnline"] as bool)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${tutor["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (tutor["isVerified"] as bool) ...[
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.verified,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${tutor["title"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, size: 14, color: warningColor),
                                  SizedBox(width: 2),
                                  Text(
                                    "${tutor["rating"]} (${tutor["reviewCount"]} reviews)",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
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
                              "\$${tutor["hourlyRate"]}/hr",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: tutor["isOnline"] as bool ? successColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                tutor["isOnline"] as bool ? "Online" : "Offline",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Bio
                    Text(
                      "${tutor["bio"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Specialties
                    Wrap(
                      spacing: spXs,
                      children: (tutor["specialties"] as List).map((specialty) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$specialty",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Stats Row
                    Row(
                      children: [
                        Icon(Icons.school, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${tutor["experience"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.book, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${tutor["sessionsTaught"]} sessions",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${tutor["responseTime"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    // Languages
                    Row(
                      children: [
                        Icon(Icons.language, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "Languages: ${(tutor["languages"] as List).join(", ")}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Profile",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo('TutorProfileView')
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Book Session",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo('BookTutorView')
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.message,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('ChatView')
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onTap) {
    bool isSelected = false;
    if (label == "Mathematics") isSelected = selectedSubject == "mathematics";
    if (label == "Physics") isSelected = selectedSubject == "physics";
    if (label == "Chemistry") isSelected = selectedSubject == "chemistry";
    if (label == "Available Now") isSelected = selectedAvailability == "now";
    if (label == "High Rated") isSelected = selectedRating == "4.5";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        margin: EdgeInsets.only(right: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
          ),
          boxShadow: [shadowSm],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Row(
              children: [
                Text(
                  "Advanced Filters",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => back(),
                ),
              ],
            ),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: spMd,
                  children: [
                    QDropdownField(
                      label: "Subject",
                      items: subjectItems,
                      value: selectedSubject,
                      onChanged: (value, label) {
                        selectedSubject = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Price Range",
                      items: priceRangeItems,
                      value: selectedPriceRange,
                      onChanged: (value, label) {
                        selectedPriceRange = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Minimum Rating",
                      items: ratingItems,
                      value: selectedRating,
                      onChanged: (value, label) {
                        selectedRating = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Availability",
                      items: availabilityItems,
                      value: selectedAvailability,
                      onChanged: (value, label) {
                        selectedAvailability = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset Filters",
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        selectedSubject = "all";
                        selectedPriceRange = "all";
                        selectedRating = "all";
                        selectedAvailability = "all";
                      });
                      back();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Filters",
                    size: bs.sm,
                    onPressed: () {
                      back();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
