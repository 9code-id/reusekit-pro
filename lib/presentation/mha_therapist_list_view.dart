import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaTherapistListView extends StatefulWidget {
  const MhaTherapistListView({super.key});

  @override
  State<MhaTherapistListView> createState() => _MhaTherapistListViewState();
}

class _MhaTherapistListViewState extends State<MhaTherapistListView> {
  String searchQuery = "";
  String selectedSpecialty = "";
  String selectedLocation = "";
  String selectedAvailability = "";
  double minRating = 0.0;
  double maxPrice = 300.0;

  // Therapist specialties
  List<Map<String, dynamic>> specialtyOptions = [
    {"label": "All Specialties", "value": ""},
    {"label": "Clinical Psychology", "value": "clinical"},
    {"label": "Cognitive Behavioral Therapy", "value": "cbt"},
    {"label": "Family Therapy", "value": "family"},
    {"label": "Couples Counseling", "value": "couples"},
    {"label": "Trauma Therapy", "value": "trauma"},
    {"label": "Addiction Counseling", "value": "addiction"},
    {"label": "Child Psychology", "value": "child"},
    {"label": "Anxiety Disorders", "value": "anxiety"},
    {"label": "Depression Treatment", "value": "depression"},
  ];

  // Location options
  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": ""},
    {"label": "Downtown", "value": "downtown"},
    {"label": "Midtown", "value": "midtown"},
    {"label": "Uptown", "value": "uptown"},
    {"label": "Online Only", "value": "online"},
    {"label": "Hybrid (In-person + Online)", "value": "hybrid"},
  ];

  // Availability options
  List<Map<String, dynamic>> availabilityOptions = [
    {"label": "Any Time", "value": ""},
    {"label": "This Week", "value": "week"},
    {"label": "Next 3 Days", "value": "3days"},
    {"label": "Today", "value": "today"},
    {"label": "Weekends Only", "value": "weekends"},
    {"label": "Evenings Only", "value": "evenings"},
  ];

  // Therapists list
  List<Map<String, dynamic>> therapists = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "title": "Licensed Clinical Psychologist",
      "specialty": ["Clinical Psychology", "Anxiety Disorders", "CBT"],
      "rating": 4.9,
      "reviewCount": 156,
      "experience": "12 years",
      "price": 180,
      "location": "Downtown",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "languages": ["English", "Spanish"],
      "availability": ["Monday", "Wednesday", "Friday"],
      "nextAvailable": "Tomorrow 2:00 PM",
      "about": "Specializing in anxiety, depression, and cognitive behavioral therapy. I help clients develop coping strategies and build resilience.",
      "education": "PhD Psychology, Stanford University",
      "licenses": ["CA License #PSY12345", "APA Certified"],
      "sessionTypes": ["In-Person", "Video Call"],
      "acceptsInsurance": true,
      "isVerified": true,
      "badges": ["Top Rated", "Quick Response"],
    },
    {
      "id": 2,
      "name": "Dr. Michael Chen",
      "title": "Cognitive Behavioral Therapist",
      "specialty": ["CBT", "Depression Treatment", "Trauma Therapy"],
      "rating": 4.8,
      "reviewCount": 203,
      "experience": "15 years",
      "price": 160,
      "location": "Midtown",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=therapist",
      "languages": ["English", "Mandarin"],
      "availability": ["Tuesday", "Thursday", "Saturday"],
      "nextAvailable": "Today 4:30 PM",
      "about": "Experienced in treating depression, trauma, and helping clients overcome negative thought patterns through evidence-based CBT techniques.",
      "education": "PsyD Clinical Psychology, UCLA",
      "licenses": ["CA License #PSY67890", "CBT Certified"],
      "sessionTypes": ["In-Person", "Video Call", "Phone"],
      "acceptsInsurance": true,
      "isVerified": true,
      "badges": ["Most Booked", "Insurance Friendly"],
    },
    {
      "id": 3,
      "name": "Dr. Emily Rodriguez",
      "title": "Licensed Family Therapist",
      "specialty": ["Family Therapy", "Couples Counseling", "Child Psychology"],
      "rating": 4.7,
      "reviewCount": 89,
      "experience": "8 years",
      "price": 200,
      "location": "Uptown",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=counselor",
      "languages": ["English", "Spanish", "Portuguese"],
      "availability": ["Monday", "Tuesday", "Thursday", "Friday"],
      "nextAvailable": "Wednesday 10:00 AM",
      "about": "Dedicated to helping families and couples improve communication, resolve conflicts, and strengthen relationships.",
      "education": "MSW Social Work, USC",
      "licenses": ["CA License #LMFT11111", "Family Therapy Certified"],
      "sessionTypes": ["In-Person", "Video Call"],
      "acceptsInsurance": false,
      "isVerified": true,
      "badges": ["Family Specialist", "Multilingual"],
    },
    {
      "id": 4,
      "name": "Dr. James Wilson",
      "title": "Addiction Counselor",
      "specialty": ["Addiction Counseling", "Trauma Therapy", "Group Therapy"],
      "rating": 4.6,
      "reviewCount": 127,
      "experience": "10 years",
      "price": 140,
      "location": "Online",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=counselor",
      "languages": ["English"],
      "availability": ["Monday", "Wednesday", "Thursday", "Friday", "Sunday"],
      "nextAvailable": "Today 6:00 PM",
      "about": "Specializing in addiction recovery, trauma healing, and group therapy sessions. Committed to helping clients achieve lasting sobriety.",
      "education": "MA Counseling Psychology, Berkeley",
      "licenses": ["CA License #LAADC5555", "SUDCC Certified"],
      "sessionTypes": ["Video Call", "Phone", "Group Sessions"],
      "acceptsInsurance": true,
      "isVerified": true,
      "badges": ["Addiction Specialist", "Group Facilitator"],
    },
    {
      "id": 5,
      "name": "Dr. Lisa Park",
      "title": "Child & Adolescent Psychologist",
      "specialty": ["Child Psychology", "Anxiety Disorders", "ADHD"],
      "rating": 4.9,
      "reviewCount": 164,
      "experience": "14 years",
      "price": 190,
      "location": "Hybrid",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=psychologist",
      "languages": ["English", "Korean"],
      "availability": ["Tuesday", "Wednesday", "Thursday", "Saturday"],
      "nextAvailable": "Tomorrow 3:30 PM",
      "about": "Passionate about helping children and teenagers overcome anxiety, ADHD, and behavioral challenges through play therapy and evidence-based interventions.",
      "education": "PhD Child Psychology, Harvard",
      "licenses": ["CA License #PSY99999", "Play Therapy Certified"],
      "sessionTypes": ["In-Person", "Video Call"],
      "acceptsInsurance": true,
      "isVerified": true,
      "badges": ["Child Specialist", "Play Therapy Expert"],
    },
    {
      "id": 6,
      "name": "Dr. Robert Taylor",
      "title": "Trauma Specialist",
      "specialty": ["Trauma Therapy", "PTSD", "EMDR"],
      "rating": 4.8,
      "reviewCount": 98,
      "experience": "16 years",
      "price": 220,
      "location": "Downtown",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=doctor",
      "languages": ["English", "French"],
      "availability": ["Monday", "Tuesday", "Friday"],
      "nextAvailable": "Friday 11:00 AM",
      "about": "Expert in trauma recovery using EMDR, somatic therapy, and other evidence-based approaches to help clients heal from traumatic experiences.",
      "education": "PhD Clinical Psychology, Yale",
      "licenses": ["CA License #PSY77777", "EMDR Certified"],
      "sessionTypes": ["In-Person", "Video Call"],
      "acceptsInsurance": false,
      "isVerified": true,
      "badges": ["Trauma Expert", "EMDR Specialist"],
    },
  ];

  List<Map<String, dynamic>> get filteredTherapists {
    return therapists.where((therapist) {
      // Search query filter
      if (searchQuery.isNotEmpty) {
        final searchLower = searchQuery.toLowerCase();
        if (!therapist["name"].toString().toLowerCase().contains(searchLower) &&
            !therapist["title"].toString().toLowerCase().contains(searchLower) &&
            !(therapist["specialty"] as List).any((s) => s.toString().toLowerCase().contains(searchLower))) {
          return false;
        }
      }

      // Specialty filter
      if (selectedSpecialty.isNotEmpty) {
        if (!(therapist["specialty"] as List).any((s) => s.toString().toLowerCase().contains(selectedSpecialty))) {
          return false;
        }
      }

      // Location filter
      if (selectedLocation.isNotEmpty) {
        if (!therapist["location"].toString().toLowerCase().contains(selectedLocation)) {
          return false;
        }
      }

      // Rating filter
      if ((therapist["rating"] as double) < minRating) {
        return false;
      }

      // Price filter
      if ((therapist["price"] as int) > maxPrice) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find a Therapist"),
        actions: [
          IconButton(
            onPressed: () {
              _showFilterSheet();
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Quick Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search therapists...",
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
                        // Trigger search
                        setState(() {});
                      },
                    ),
                  ],
                ),

                // Quick Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: spSm,
                    children: [
                      _buildFilterChip("Available Today", selectedAvailability == "today", () {
                        selectedAvailability = selectedAvailability == "today" ? "" : "today";
                        setState(() {});
                      }),
                      _buildFilterChip("Online Only", selectedLocation == "online", () {
                        selectedLocation = selectedLocation == "online" ? "" : "online";
                        setState(() {});
                      }),
                      _buildFilterChip("Top Rated (4.5+)", minRating == 4.5, () {
                        minRating = minRating == 4.5 ? 0.0 : 4.5;
                        setState(() {});
                      }),
                      _buildFilterChip("Accepts Insurance", false, () {
                        // Filter by insurance
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Results Count
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Text(
              "${filteredTherapists.length} therapists found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Therapists List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredTherapists.length,
              itemBuilder: (context, index) {
                final therapist = filteredTherapists[index];
                return _buildTherapistCard(therapist);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTherapistCard(Map<String, dynamic> therapist) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: therapist["isVerified"] 
          ? Border.all(color: successColor.withAlpha(30))
          : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header with avatar and basic info
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${therapist["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (therapist["isVerified"])
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.verified,
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
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${therapist["name"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (therapist["acceptsInsurance"])
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Insurance",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${therapist["title"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) => Icon(
                            Icons.star,
                            size: 14,
                            color: index < (therapist["rating"] as double).round() 
                              ? warningColor 
                              : disabledColor,
                          )),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${therapist["rating"]} (${therapist["reviewCount"]} reviews)",
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

          // Badges
          if ((therapist["badges"] as List).isNotEmpty)
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (therapist["badges"] as List).map((badge) => Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$badge",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),

          // Specialties
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (therapist["specialty"] as List).take(3).map((specialty) => Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "$specialty",
                style: TextStyle(
                  fontSize: 11,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
          ),

          // About
          Text(
            "${therapist["about"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // Info Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${therapist["experience"]} experience",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${therapist["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.language, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${(therapist["languages"] as List).join(", ")}",
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
                spacing: spXs,
                children: [
                  Text(
                    "\$${therapist["price"]}/session",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${therapist["nextAvailable"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
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
                    _showTherapistProfile(therapist);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Book Session",
                  size: bs.sm,
                  onPressed: () {
                    // Book session with therapist
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.favorite_border,
                size: bs.sm,
                onPressed: () {
                  // Add to favorites
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
            // Filter content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Filter Therapists",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Specialty Filter
                    Text(
                      "Specialty",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QDropdownField(
                      label: "Select Specialty",
                      items: specialtyOptions,
                      value: selectedSpecialty,
                      onChanged: (value, label) {
                        selectedSpecialty = value;
                        setState(() {});
                      },
                    ),

                    // Location Filter
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QDropdownField(
                      label: "Select Location",
                      items: locationOptions,
                      value: selectedLocation,
                      onChanged: (value, label) {
                        selectedLocation = value;
                        setState(() {});
                      },
                    ),

                    // Availability Filter
                    Text(
                      "Availability",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QDropdownField(
                      label: "Select Availability",
                      items: availabilityOptions,
                      value: selectedAvailability,
                      onChanged: (value, label) {
                        selectedAvailability = value;
                        setState(() {});
                      },
                    ),

                    // Rating Filter
                    Text(
                      "Minimum Rating",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text("${minRating.toStringAsFixed(1)} stars"),
                          Expanded(
                            child: Slider(
                              value: minRating,
                              min: 0.0,
                              max: 5.0,
                              divisions: 10,
                              onChanged: (value) {
                                minRating = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Price Filter
                    Text(
                      "Maximum Price per Session",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text("\$${maxPrice.toInt()}"),
                          Expanded(
                            child: Slider(
                              value: maxPrice,
                              min: 50.0,
                              max: 300.0,
                              divisions: 25,
                              onChanged: (value) {
                                maxPrice = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Apply Filters Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Apply Filters",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ),

                    // Clear Filters Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Clear All Filters",
                        size: bs.md,
                        onPressed: () {
                          selectedSpecialty = "";
                          selectedLocation = "";
                          selectedAvailability = "";
                          minRating = 0.0;
                          maxPrice = 300.0;
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTherapistProfile(Map<String, dynamic> therapist) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
            // Profile content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("${therapist["avatar"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${therapist["name"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${therapist["title"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(5, (index) => Icon(
                                      Icons.star,
                                      size: 16,
                                      color: index < (therapist["rating"] as double).round() 
                                        ? warningColor 
                                        : disabledColor,
                                    )),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${therapist["rating"]} (${therapist["reviewCount"]})",
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

                    // About
                    _buildProfileSection("About", "${therapist["about"]}"),

                    // Specialties
                    _buildProfileSection("Specialties", (therapist["specialty"] as List).join(", ")),

                    // Education & Credentials
                    _buildProfileSection("Education", "${therapist["education"]}"),
                    _buildProfileSection("Licenses", (therapist["licenses"] as List).join(", ")),

                    // Session Info
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Session Information",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text("Price: \$${therapist["price"]}/session"),
                                    Text("Location: ${therapist["location"]}"),
                                    Text("Languages: ${(therapist["languages"] as List).join(", ")}"),
                                    Text("Session Types: ${(therapist["sessionTypes"] as List).join(", ")}"),
                                    Text("Next Available: ${therapist["nextAvailable"]}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Book Session",
                            size: bs.md,
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigate to booking
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.message,
                          size: bs.md,
                          onPressed: () {
                            // Send message
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
