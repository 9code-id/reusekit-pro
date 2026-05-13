import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSpeakerManagementView extends StatefulWidget {
  const EcmSpeakerManagementView({super.key});

  @override
  State<EcmSpeakerManagementView> createState() => _EcmSpeakerManagementViewState();
}

class _EcmSpeakerManagementViewState extends State<EcmSpeakerManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCategory = "All";
  String sortBy = "Name";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Declined", "value": "Declined"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All"},
    {"label": "Keynote Speaker", "value": "Keynote"},
    {"label": "Workshop Leader", "value": "Workshop"},
    {"label": "Panelist", "value": "Panel"},
    {"label": "Industry Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name (A-Z)", "value": "Name"},
    {"label": "Company", "value": "Company"},
    {"label": "Session Count", "value": "Sessions"},
    {"label": "Rating", "value": "Rating"},
  ];

  List<Map<String, dynamic>> speakers = [
    {
      "id": "1",
      "name": "Dr. Sarah Johnson",
      "title": "Chief Technology Officer",
      "company": "TechCorp Solutions",
      "email": "sarah.johnson@techcorp.com",
      "phone": "+1 (555) 123-4567",
      "bio": "Dr. Johnson is a renowned technology leader with over 15 years of experience in AI and machine learning.",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=speaker",
      "category": "Keynote",
      "status": "Confirmed",
      "sessions_count": 2,
      "rating": 4.8,
      "reviews_count": 156,
      "social_linkedin": "https://linkedin.com/in/sarahjohnson",
      "social_twitter": "@sarahjohnson_ai",
      "expertise": ["Artificial Intelligence", "Machine Learning", "Leadership"],
      "languages": ["English", "Spanish"],
      "fee": 15000,
      "travel_required": true,
      "accommodation_required": true,
      "created_date": "2024-01-05",
      "last_contact": "2024-01-14"
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "title": "Senior Software Engineer",
      "company": "DevStudio",
      "email": "m.chen@devstudio.com",
      "phone": "+1 (555) 987-6543",
      "bio": "Michael is a passionate developer specializing in scalable web applications and cloud architecture.",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=speaker",
      "category": "Workshop",
      "status": "Confirmed",
      "sessions_count": 3,
      "rating": 4.6,
      "reviews_count": 89,
      "social_linkedin": "https://linkedin.com/in/michaelchen",
      "social_twitter": "@devmike",
      "expertise": ["Web Development", "Cloud Architecture", "DevOps"],
      "languages": ["English", "Mandarin"],
      "fee": 8000,
      "travel_required": false,
      "accommodation_required": false,
      "created_date": "2024-01-03",
      "last_contact": "2024-01-13"
    },
    {
      "id": "3",
      "name": "Emily Rodriguez",
      "title": "Head of Design",
      "company": "Creative Solutions",
      "email": "emily.r@creative.com",
      "phone": "+1 (555) 456-7890",
      "bio": "Emily is an award-winning designer with expertise in user experience and design thinking methodologies.",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=speaker",
      "category": "Workshop",
      "status": "Pending",
      "sessions_count": 1,
      "rating": 4.7,
      "reviews_count": 67,
      "social_linkedin": "https://linkedin.com/in/emilyrodriguez",
      "social_twitter": "@emilydesigns",
      "expertise": ["UX Design", "Design Thinking", "Product Strategy"],
      "languages": ["English", "French", "Spanish"],
      "fee": 10000,
      "travel_required": true,
      "accommodation_required": true,
      "created_date": "2024-01-07",
      "last_contact": "2024-01-12"
    },
    {
      "id": "4",
      "name": "David Wilson",
      "title": "Marketing Director",
      "company": "Growth Partners",
      "email": "d.wilson@growthpartners.com",
      "phone": "+1 (555) 321-0987",
      "bio": "David leads digital marketing initiatives and has helped numerous companies scale their online presence.",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=speaker",
      "category": "Expert",
      "status": "Confirmed",
      "sessions_count": 2,
      "rating": 4.5,
      "reviews_count": 124,
      "social_linkedin": "https://linkedin.com/in/davidwilson",
      "social_twitter": "@davidgrowth",
      "expertise": ["Digital Marketing", "Growth Strategy", "Analytics"],
      "languages": ["English"],
      "fee": 7500,
      "travel_required": false,
      "accommodation_required": false,
      "created_date": "2024-01-06",
      "last_contact": "2024-01-15"
    },
    {
      "id": "5",
      "name": "Lisa Park",
      "title": "CEO",
      "company": "Leadership Consulting",
      "email": "lisa.park@leadconsult.com",
      "phone": "+1 (555) 654-3210",
      "bio": "Lisa is a leadership coach and business strategist with a track record of transforming organizations.",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=speaker",
      "category": "Panel",
      "status": "Declined",
      "sessions_count": 0,
      "rating": 4.9,
      "reviews_count": 203,
      "social_linkedin": "https://linkedin.com/in/lisapark",
      "social_twitter": "@lisaleads",
      "expertise": ["Leadership", "Business Strategy", "Organizational Development"],
      "languages": ["English", "Korean"],
      "fee": 12000,
      "travel_required": true,
      "accommodation_required": true,
      "created_date": "2024-01-04",
      "last_contact": "2024-01-10"
    },
  ];

  List<Map<String, dynamic>> get filteredSpeakers {
    List<Map<String, dynamic>> filtered = speakers;
    
    if (selectedStatus != "All") {
      filtered = filtered.where((speaker) => speaker["status"] == selectedStatus).toList();
    }
    
    if (selectedCategory != "All") {
      filtered = filtered.where((speaker) => speaker["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((speaker) {
        return speaker["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               speaker["company"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               speaker["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               (speaker["expertise"] as List).any((skill) => skill.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Sort speakers
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Name":
          return a["name"].compareTo(b["name"]);
        case "Company":
          return a["company"].compareTo(b["company"]);
        case "Sessions":
          return (b["sessions_count"] as int).compareTo(a["sessions_count"] as int);
        case "Rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        default:
          return a["name"].compareTo(b["name"]);
      }
    });
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Declined":
        return dangerColor;
      case "Cancelled":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Keynote":
        return primaryColor;
      case "Workshop":
        return successColor;
      case "Panel":
        return infoColor;
      case "Expert":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speaker Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.record_voice_over,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Speaker Management",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Manage speaker profiles, sessions, and communications",
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
            ),

            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${speakers.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Speakers",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${speakers.where((s) => s["status"] == "Confirmed").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Confirmed",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.pending,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${speakers.where((s) => s["status"] == "Pending").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.star,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(speakers.fold(0.0, (sum, speaker) => sum + (speaker["rating"] as double)) / speakers.length).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Avg Rating",
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

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search speakers",
                    value: searchQuery,
                    hint: "Search by name, company, or expertise",
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

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Sort By",
              items: sortOptions,
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
              },
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.list,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Speaker Directory",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${filteredSpeakers.length} speakers",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (filteredSpeakers.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person_off,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No speakers found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filters",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...List.generate(filteredSpeakers.length, (index) {
                      final speaker = filteredSpeakers[index];
                      final statusColor = _getStatusColor(speaker["status"]);
                      final categoryColor = _getCategoryColor(speaker["category"]);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: statusColor.withAlpha(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${speaker["avatar"]}"),
                                      fit: BoxFit.cover,
                                    ),
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
                                              "${speaker["name"]}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: statusColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${speaker["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: statusColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${speaker["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${speaker["company"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      if (speaker["rating"] > 0) ...[
                                        SizedBox(height: spXs),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 14,
                                              color: warningColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${speaker["rating"]}/5.0",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "(${speaker["reviews_count"]} reviews)",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${speaker["bio"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${speaker["email"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: categoryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${speaker["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: categoryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${speaker["phone"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${speaker["sessions_count"]} sessions",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            if ((speaker["expertise"] as List).isNotEmpty) ...[
                              SizedBox(height: spSm),
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (speaker["expertise"] as List).take(3).map((skill) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$skill",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: infoColor,
                                      ),
                                    ),
                                  );
                                }).toList().cast<Widget>(),
                              ),
                            ],
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "Fee: \$${((speaker["fee"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Spacer(),
                                if (speaker["travel_required"])
                                  Container(
                                    margin: EdgeInsets.only(right: spXs),
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      Icons.flight,
                                      size: 10,
                                      color: warningColor,
                                    ),
                                  ),
                                if (speaker["accommodation_required"])
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      Icons.hotel,
                                      size: 10,
                                      color: infoColor,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 36,
                                    child: QButton(
                                      label: "Edit Profile",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Container(
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Contact",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 18,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
