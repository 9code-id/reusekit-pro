import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaScienceView extends StatefulWidget {
  const NmaScienceView({super.key});

  @override
  State<NmaScienceView> createState() => _NmaScienceViewState();
}

class _NmaScienceViewState extends State<NmaScienceView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Space", "value": "Space"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Biology", "value": "Biology"},
    {"label": "Physics", "value": "Physics"},
    {"label": "Environment", "value": "Environment"},
    {"label": "Research", "value": "Research"},
  ];

  List<Map<String, dynamic>> breakingScience = [
    {
      "id": 1,
      "title": "James Webb Telescope Discovers Ancient Galaxy",
      "summary": "Astronomers detect light from galaxy formed just 400 million years after Big Bang",
      "category": "Space",
      "author": "Dr. Sarah Chen",
      "publishedAt": "2024-12-15T16:45:00Z",
      "imageUrl": "https://picsum.photos/400/250?random=1&keyword=space",
      "readTime": "6 min read",
      "isBreaking": true,
      "significance": "High",
    },
    {
      "id": 2,
      "title": "AI Breakthrough: Quantum Computing Milestone Achieved",
      "summary": "Scientists successfully demonstrate quantum advantage in real-world problem solving",
      "category": "Technology",
      "author": "Prof. Michael Rodriguez",
      "publishedAt": "2024-12-15T14:30:00Z",
      "imageUrl": "https://picsum.photos/400/250?random=2&keyword=quantum",
      "readTime": "5 min read",
      "isBreaking": false,
      "significance": "High",
    },
  ];

  List<Map<String, dynamic>> researchHighlights = [
    {
      "title": "CRISPR Gene Editing Cures Genetic Blindness",
      "institution": "Harvard Medical School",
      "field": "Biology",
      "impact": "Revolutionary treatment for inherited diseases",
      "publishedAt": "2024-12-15T13:15:00Z",
      "funding": "\$12M NIH Grant",
      "status": "Clinical Trial Phase 3",
    },
    {
      "title": "Fusion Energy Breakthrough: Net Energy Gain Achieved",
      "institution": "MIT Plasma Science Center",
      "field": "Physics",
      "impact": "Major step toward clean unlimited energy",
      "publishedAt": "2024-12-15T11:45:00Z",
      "funding": "\$8M DOE Grant",
      "status": "Peer Review Complete",
    },
    {
      "title": "Climate Change: New Carbon Capture Technology",
      "institution": "Stanford Environmental Lab",
      "field": "Environment",
      "impact": "Removes CO2 from atmosphere at scale",
      "publishedAt": "2024-12-15T10:20:00Z",
      "funding": "\$15M Private Investment",
      "status": "Patent Pending",
    },
  ];

  List<Map<String, dynamic>> spaceExploration = [
    {
      "mission": "Artemis III Moon Landing",
      "agency": "NASA",
      "launchDate": "2025-09-15",
      "duration": "14 days",
      "crew": 4,
      "objective": "First human lunar landing since Apollo 17",
      "status": "Preparation Phase",
      "budget": "\$28B",
    },
    {
      "mission": "Mars Sample Return",
      "agency": "NASA/ESA",
      "launchDate": "2026-03-10",
      "duration": "7 years",
      "crew": 0,
      "objective": "Retrieve samples collected by Perseverance rover",
      "status": "Development Phase",
      "budget": "\$11B",
    },
    {
      "mission": "Europa Clipper",
      "agency": "NASA",
      "launchDate": "2024-10-14",
      "duration": "6 years",
      "crew": 0,
      "objective": "Study Jupiter's moon Europa for signs of life",
      "status": "Launch Ready",
      "budget": "\$5.2B",
    },
  ];

  List<Map<String, dynamic>> techInnovations = [
    {
      "technology": "Neuromorphic Computing Chips",
      "company": "Intel Labs",
      "description": "Brain-inspired processors that mimic neural networks",
      "applications": ["AI Processing", "Robotics", "IoT Devices"],
      "advantage": "1000x more energy efficient than traditional chips",
      "availability": "Research Phase",
    },
    {
      "technology": "Solid-State Batteries",
      "company": "Toyota Research",
      "description": "Next-generation batteries with higher energy density",
      "applications": ["Electric Vehicles", "Grid Storage", "Electronics"],
      "advantage": "10-minute charging, 1000-mile range",
      "availability": "Prototype Testing",
    },
    {
      "technology": "Atmospheric Water Harvesting",
      "company": "MIT Water Lab",
      "description": "Extract clean water from air using solar power",
      "applications": ["Desert Regions", "Emergency Relief", "Space Missions"],
      "advantage": "Works in 10% humidity conditions",
      "availability": "Field Testing",
    },
  ];

  List<Map<String, dynamic>> environmentalNews = [
    {
      "title": "Antarctic Ice Sheet Stability Threatened",
      "impact": "Critical",
      "location": "West Antarctica",
      "findings": "Accelerating ice loss could raise sea levels by 3 meters",
      "publishedAt": "2024-12-15T12:30:00Z",
      "source": "Nature Climate Change",
    },
    {
      "title": "Coral Reef Restoration Shows Promising Results",
      "impact": "Positive",
      "location": "Great Barrier Reef",
      "findings": "Heat-resistant coral species successfully transplanted",
      "publishedAt": "2024-12-15T09:45:00Z",
      "source": "Marine Biology Journal",
    },
    {
      "title": "Amazon Rainforest Reaches Tipping Point",
      "impact": "Critical",
      "location": "Brazilian Amazon",
      "findings": "Deforestation threatens ecosystem collapse",
      "publishedAt": "2024-12-15T08:20:00Z",
      "source": "Science Magazine",
    },
  ];

  List<Map<String, dynamic>> scientificEvents = [
    {
      "event": "International Science Fair 2024",
      "date": "2024-12-20",
      "location": "Geneva, Switzerland",
      "participants": 5000,
      "focus": "Climate Solutions & Renewable Energy",
      "registration": "Open",
    },
    {
      "event": "Quantum Computing Summit",
      "date": "2025-01-15",
      "location": "Cambridge, Massachusetts",
      "participants": 1200,
      "focus": "Quantum Algorithms & Applications",
      "registration": "Invitation Only",
    },
    {
      "event": "Biomedical Research Conference",
      "date": "2025-02-10",
      "location": "San Diego, California",
      "participants": 8000,
      "focus": "Gene Therapy & Precision Medicine",
      "registration": "Early Bird",
    },
  ];

  List<Map<String, dynamic>> nobelPrize = [
    {
      "category": "Physics",
      "year": 2024,
      "recipients": ["Dr. Anne L'Huillier", "Dr. Pierre Agostini", "Dr. Ferenc Krausz"],
      "achievement": "Experimental methods for generating attosecond pulses of light",
      "significance": "Enables study of electrons in atoms and molecules",
    },
    {
      "category": "Chemistry",
      "year": 2024,
      "recipients": ["Dr. Moungi Bawendi", "Dr. Louis Brus", "Dr. Alexei Ekimov"],
      "achievement": "Discovery and synthesis of quantum dots",
      "significance": "Applications in LED displays and medical imaging",
    },
    {
      "category": "Medicine",
      "year": 2024,
      "recipients": ["Dr. Katalin Karikó", "Dr. Drew Weissman"],
      "achievement": "Discoveries enabling mRNA vaccines",
      "significance": "Foundation for COVID-19 vaccines and future treatments",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Science News"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Bookmarks
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Category Filter
            QCategoryPicker(
              label: "Science Categories",
              items: categoryItems,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Breaking Science News
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Breaking Science News",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: breakingScience.map((news) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to full article
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusSm),
                                    topRight: Radius.circular(radiusSm),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage("${news["imageUrl"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    if (news["isBreaking"])
                                      Positioned(
                                        top: spSm,
                                        left: spSm,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "BREAKING",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getSignificanceColor(news["significance"]),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${news["significance"]} Impact",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${news["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${news["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${news["summary"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "By ${news["author"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${news["readTime"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${DateTime.parse(news["publishedAt"]).dMMMy}",
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
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Research Highlights
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.science,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Research Highlights",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: researchHighlights.map((research) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getFieldColor(research["field"]),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getFieldColor(research["field"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${research["field"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getFieldColor(research["field"]),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${research["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${research["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${research["institution"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "${research["impact"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${research["funding"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${DateTime.parse(research["publishedAt"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Space Exploration
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.rocket_launch,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Space Exploration",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QHorizontalScroll(
                    children: spaceExploration.map((mission) {
                      return Container(
                        width: 280,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(mission["status"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${mission["status"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${mission["agency"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${mission["mission"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${mission["objective"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            ResponsiveGridView(
                              padding: EdgeInsets.zero,
                              minItemWidth: 200,
                              children: [
                                _buildMissionDetail("Launch", "${mission["launchDate"]}"),
                                _buildMissionDetail("Duration", "${mission["duration"]}"),
                                _buildMissionDetail("Crew", "${mission["crew"]} people"),
                                _buildMissionDetail("Budget", "${mission["budget"]}"),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Technology Innovations
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.computer,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Technology Innovations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: techInnovations.map((tech) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${tech["technology"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${tech["availability"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${tech["company"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor,
                              ),
                            ),
                            Text(
                              "${tech["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: successColor.withAlpha(30)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "Advantage: ${tech["advantage"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (tech["applications"] as List).map((app) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$app",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Environmental & Scientific Events
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                // Environmental News
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.eco,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Environmental News",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spXs,
                        children: environmentalNews.map((news) {
                          return Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: _getImpactColor(news["impact"]),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getImpactColor(news["impact"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${news["impact"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: _getImpactColor(news["impact"]),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${news["location"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${news["title"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${news["findings"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Source: ${news["source"]}",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: disabledBoldColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Scientific Events
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.event,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Upcoming Events",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spXs,
                        children: scientificEvents.map((event) {
                          return Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${event["registration"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${event["date"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${event["event"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${event["location"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Focus: ${event["focus"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${event["participants"]} participants expected",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Nobel Prize Winners
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "2024 Nobel Prize Winners",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: nobelPrize.map((prize) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: warningColor,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Nobel Prize in ${prize["category"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "${prize["achievement"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Recipients: ${(prize["recipients"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${prize["significance"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionDetail(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSignificanceColor(String significance) {
    switch (significance) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getFieldColor(String field) {
    switch (field) {
      case "Biology":
        return successColor;
      case "Physics":
        return infoColor;
      case "Environment":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Launch Ready":
        return successColor;
      case "Development Phase":
        return warningColor;
      case "Preparation Phase":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "Critical":
        return dangerColor;
      case "Positive":
        return successColor;
      case "Neutral":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
