import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAbout6View extends StatefulWidget {
  @override
  State<GrlAbout6View> createState() => _GrlAbout6ViewState();
}

class _GrlAbout6ViewState extends State<GrlAbout6View> {
  int selectedTimelineIndex = 0;
  
  List<Map<String, dynamic>> timeline = [
    {
      "year": "2021",
      "quarter": "Q1",
      "title": "Company Founded",
      "description": "Started with a vision to revolutionize the industry with innovative solutions.",
      "milestones": [
        "Incorporated as TechCorp Solutions",
        "Secured initial seed funding",
        "Assembled founding team",
        "Established headquarters in San Francisco"
      ],
      "metrics": {
        "employees": 5,
        "customers": 0,
        "revenue": 0,
      },
      "image": "https://picsum.photos/300/200?random=1&keyword=startup",
    },
    {
      "year": "2021",
      "quarter": "Q3",
      "title": "First Product Launch",
      "description": "Successfully launched our flagship platform with core features.",
      "milestones": [
        "Beta testing with select customers",
        "Product launch event",
        "First paying customers",
        "Initial market validation"
      ],
      "metrics": {
        "employees": 12,
        "customers": 50,
        "revenue": 25000,
      },
      "image": "https://picsum.photos/300/200?random=2&keyword=launch",
    },
    {
      "year": "2022",
      "quarter": "Q1",
      "title": "Series A Funding",
      "description": "Raised Series A to accelerate growth and expand our team.",
      "milestones": [
        "Closed \$5M Series A round",
        "Expanded engineering team",
        "Opened New York office",
        "Launched mobile applications"
      ],
      "metrics": {
        "employees": 25,
        "customers": 200,  
        "revenue": 150000,
      },
      "image": "https://picsum.photos/300/200?random=3&keyword=funding",
    },
    {
      "year": "2022",
      "quarter": "Q4",
      "title": "Market Expansion",
      "description": "Expanded to new markets and launched enterprise solutions.",
      "milestones": [
        "Launched in 10 new countries",
        "Enterprise product suite",
        "Strategic partnerships",
        "Industry recognition awards"
      ],
      "metrics": {
        "employees": 45,
        "customers": 1000,
        "revenue": 500000,
      },
      "image": "https://picsum.photos/300/200?random=4&keyword=expansion",
    },
    {
      "year": "2023",
      "quarter": "Q2",
      "title": "Technology Innovation",
      "description": "Introduced AI-powered features and advanced analytics.",
      "milestones": [
        "AI integration launched",
        "Advanced analytics platform",
        "Patent applications filed",
        "R&D center established"
      ],
      "metrics": {
        "employees": 75,
        "customers": 5000,
        "revenue": 1200000,
      },
      "image": "https://picsum.photos/300/200?random=5&keyword=innovation",
    },
    {
      "year": "2024",
      "quarter": "Q1",
      "title": "Global Scale",
      "description": "Achieved significant scale with worldwide presence.",
      "milestones": [
        "Reached 1M+ users globally",
        "Opened European headquarters",
        "ISO certifications achieved",
        "IPO preparation initiated"
      ],
      "metrics": {
        "employees": 150,
        "customers": 15000,
        "revenue": 2500000,
      },
      "image": "https://picsum.photos/300/200?random=6&keyword=global",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Best Innovation Award 2024",
      "organization": "Tech Excellence Summit",
      "description": "Recognized for breakthrough AI integration",
      "icon": Icons.emoji_events,
      "color": warningColor,
    },
    {
      "title": "Top Startup 2023",
      "organization": "Business Weekly",
      "description": "Featured in top 100 startups to watch",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Customer Choice Award",
      "organization": "Industry Association",
      "description": "Highest customer satisfaction rating",
      "icon": Icons.favorite,
      "color": dangerColor,
    },
    {
      "title": "Security Excellence",
      "organization": "Cybersecurity Council",
      "description": "Outstanding security implementation",
      "icon": Icons.security,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> futureGoals = [
    {
      "title": "Global Expansion",
      "description": "Expand to 100+ countries by 2025",
      "target": "2025",
      "icon": Icons.public,
      "progress": 75,
    },
    {
      "title": "AI Revolution",
      "description": "Launch next-gen AI-powered platform",
      "target": "2024 Q4",
      "icon": Icons.psychology,
      "progress": 60,
    },
    {
      "title": "Sustainability",
      "description": "Achieve carbon neutral operations",
      "target": "2025",
      "icon": Icons.eco,
      "progress": 45,
    },
    {
      "title": "Team Growth",
      "description": "Grow team to 500+ professionals",
      "target": "2026",
      "icon": Icons.groups,
      "progress": 30,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company History"),
        actions: [
          IconButton(
            icon: Icon(Icons.timeline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          "Our Journey",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "From a small startup to a global technology leader. Discover the milestones that shaped our company and the vision that drives us forward.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Timeline Navigation
            Text(
              "Timeline",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            QHorizontalScroll(
              children: List.generate(timeline.length, (index) {
                final item = timeline[index];
                final isSelected = selectedTimelineIndex == index;
                return GestureDetector(
                  onTap: () {
                    selectedTimelineIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${item["year"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                        Text(
                          "${item["quarter"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white.withAlpha(230) : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            
            SizedBox(height: spMd),
            
            // Selected Timeline Content
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline Image
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                      image: DecorationImage(
                        image: NetworkImage("${timeline[selectedTimelineIndex]["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withAlpha(100)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${timeline[selectedTimelineIndex]["year"]} ${timeline[selectedTimelineIndex]["quarter"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Timeline Content
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${timeline[selectedTimelineIndex]["title"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${timeline[selectedTimelineIndex]["description"]}",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: spMd),
                        
                        // Key Metrics
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${timeline[selectedTimelineIndex]["metrics"]["employees"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Employees",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
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
                                  color: successColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${timeline[selectedTimelineIndex]["metrics"]["customers"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "Customers",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
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
                                  color: infoColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "\$${((timeline[selectedTimelineIndex]["metrics"]["revenue"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: infoColor,
                                      ),
                                    ),
                                    Text(
                                      "Revenue",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Milestones
                        Text(
                          "Key Milestones",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...(timeline[selectedTimelineIndex]["milestones"] as List<String>).map((milestone) => 
                          Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    milestone,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Achievements
            Text(
              "Awards & Recognition",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: achievements.map((achievement) => Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (achievement["color"] as Color).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        achievement["icon"] as IconData,
                        color: achievement["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${achievement["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${achievement["organization"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: achievement["color"] as Color,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${achievement["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Future Goals
            Text(
              "Looking Ahead",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...futureGoals.map((goal) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          goal["icon"] as IconData,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${goal["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${goal["description"]}",
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
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${goal["target"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (goal["progress"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "${goal["progress"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Vision Statement
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.visibility,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Our Vision for Tomorrow",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "To be the world's leading technology company that empowers businesses and individuals to achieve their full potential through innovative, accessible, and sustainable solutions.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
