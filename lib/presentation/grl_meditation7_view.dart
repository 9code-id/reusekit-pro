import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMeditation7View extends StatefulWidget {
  const GrlMeditation7View({super.key});

  @override
  State<GrlMeditation7View> createState() => _GrlMeditation7ViewState();
}

class _GrlMeditation7ViewState extends State<GrlMeditation7View> {
  String selectedFilter = "all";
  String searchQuery = "";

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Mindfulness", "value": "mindfulness"},
    {"label": "Sleep", "value": "sleep"},
    {"label": "Breathing", "value": "breathing"},
    {"label": "Focus", "value": "focus"},
  ];

  final List<Map<String, dynamic>> featuredInstructors = [
    {
      "name": "Sarah Johnson",
      "title": "Mindfulness Expert",
      "experience": "12 years",
      "sessions": 150,
      "rating": 4.9,
      "followers": 25600,
      "image": "https://picsum.photos/120/120?random=1&keyword=woman",
      "specialties": ["Mindfulness", "Stress Relief", "Anxiety"],
      "bio": "Sarah has been teaching meditation for over a decade, helping thousands find inner peace and clarity.",
      "featured": true,
    },
    {
      "name": "Michael Chen",
      "title": "Sleep Meditation Specialist",
      "experience": "8 years",
      "sessions": 95,
      "rating": 4.8,
      "followers": 18200,
      "image": "https://picsum.photos/120/120?random=2&keyword=man",
      "specialties": ["Sleep", "Deep Relaxation", "Body Scan"],
      "bio": "Michael specializes in helping people achieve better sleep through guided meditation techniques.",
      "featured": true,
    },
    {
      "name": "Emily Davis",
      "title": "Focus & Productivity Coach",
      "experience": "6 years",
      "sessions": 78,
      "rating": 4.9,
      "followers": 22100,
      "image": "https://picsum.photos/120/120?random=3&keyword=woman",
      "specialties": ["Focus", "Productivity", "Concentration"],
      "bio": "Emily combines meditation with productivity techniques to help professionals excel in their careers.",
      "featured": true,
    },
  ];

  final List<Map<String, dynamic>> allInstructors = [
    {
      "name": "David Wilson",
      "title": "Breathing Specialist",
      "experience": "10 years",
      "sessions": 120,
      "rating": 4.7,
      "followers": 15800,
      "image": "https://picsum.photos/120/120?random=4&keyword=man",
      "specialties": ["Breathing", "Anxiety", "Stress"],
      "bio": "David teaches ancient breathing techniques for modern stress relief.",
      "featured": false,
    },
    {
      "name": "Lisa Anderson",
      "title": "Healing Meditation Guide",
      "experience": "14 years",
      "sessions": 200,
      "rating": 4.9,
      "followers": 32400,
      "image": "https://picsum.photos/120/120?random=5&keyword=woman",
      "specialties": ["Healing", "Trauma Recovery", "Self-Love"],
      "bio": "Lisa guides people through healing journeys using compassionate meditation practices.",
      "featured": false,
    },
    {
      "name": "Robert Kim",
      "title": "Movement Meditation Expert",
      "experience": "9 years",
      "sessions": 85,
      "rating": 4.6,
      "followers": 12700,
      "image": "https://picsum.photos/120/120?random=6&keyword=man",
      "specialties": ["Movement", "Walking Meditation", "Energy"],
      "bio": "Robert combines gentle movement with meditation for a holistic wellness approach.",
      "featured": false,
    },
    {
      "name": "Anna Rodriguez",
      "title": "Gratitude & Joy Teacher",
      "experience": "7 years",
      "sessions": 110,
      "rating": 4.8,
      "followers": 19500,
      "image": "https://picsum.photos/120/120?random=7&keyword=woman",
      "specialties": ["Gratitude", "Joy", "Positive Thinking"],
      "bio": "Anna helps people cultivate gratitude and find joy in everyday moments through meditation.",
      "featured": false,
    },
    {
      "name": "James Foster",
      "title": "Advanced Meditation Teacher",
      "experience": "16 years",
      "sessions": 180,
      "rating": 4.9,
      "followers": 28900,
      "image": "https://picsum.photos/120/120?random=8&keyword=man",
      "specialties": ["Advanced Techniques", "Philosophy", "Spirituality"],
      "bio": "James teaches advanced meditation techniques rooted in ancient wisdom traditions.",
      "featured": false,
    },
  ];

  List<Map<String, dynamic>> getFilteredInstructors() {
    List<Map<String, dynamic>> instructors = [...featuredInstructors, ...allInstructors];
    
    if (searchQuery.isNotEmpty) {
      instructors = instructors.where((instructor) =>
        instructor["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        instructor["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        (instructor["specialties"] as List).any((specialty) =>
          specialty.toString().toLowerCase().contains(searchQuery.toLowerCase())
        )
      ).toList();
    }
    
    if (selectedFilter != "all") {
      instructors = instructors.where((instructor) =>
        (instructor["specialties"] as List).any((specialty) =>
          specialty.toString().toLowerCase().contains(selectedFilter.toLowerCase())
        )
      ).toList();
    }
    
    return instructors;
  }

  Widget _buildInstructorCard(Map<String, dynamic> instructor) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: instructor["featured"] 
          ? Border.all(color: primaryColor.withAlpha(30), width: 2)
          : Border.all(color: disabledOutlineBorderColor, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${instructor["image"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (instructor["featured"])
                    Positioned(
                      top: spXs,
                      right: spXs,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                ],
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
                            "${instructor["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXxs),
                            Text(
                              "${instructor["rating"]}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${instructor["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "${instructor["experience"]} exp",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " • ${instructor["sessions"]} sessions",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${((instructor["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Specialties
          QHorizontalScroll(
            children: (instructor["specialties"] as List).map((specialty) {
              return Container(
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: primaryColor.withAlpha(30), width: 1),
                ),
                child: Text(
                  "$specialty",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Bio
          Text(
            "${instructor["bio"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: spMd),
          
          // Action Buttons
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
                  label: "Follow",
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

  @override
  Widget build(BuildContext context) {
    final filteredInstructors = getFilteredInstructors();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Meditation Instructors"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.filter_list,
                color: primaryColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search instructors...",
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
            
            SizedBox(height: spMd),
            
            // Filter Categories
            QCategoryPicker(
              label: "Filter by Specialty",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Featured Instructors Section
            if (selectedFilter == "all" && searchQuery.isEmpty) ...[
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Featured Instructors",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              Column(
                children: featuredInstructors.map((instructor) {
                  return _buildInstructorCard(instructor);
                }).toList(),
              ),

              SizedBox(height: spLg),

              Text(
                "All Instructors",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              Column(
                children: allInstructors.map((instructor) {
                  return _buildInstructorCard(instructor);
                }).toList(),
              ),
            ] else ...[
              // Filtered Results
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Results",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${filteredInstructors.length} instructors found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              if (filteredInstructors.isEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spXl),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        color: disabledBoldColor,
                        size: 48,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No instructors found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Try adjusting your search or filter criteria",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: filteredInstructors.map((instructor) {
                    return _buildInstructorCard(instructor);
                  }).toList(),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
