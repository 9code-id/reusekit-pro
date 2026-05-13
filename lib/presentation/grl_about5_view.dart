import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAbout5View extends StatefulWidget {
  @override
  State<GrlAbout5View> createState() => _GrlAbout5ViewState();
}

class _GrlAbout5ViewState extends State<GrlAbout5View> {
  String selectedDepartment = 'all';
  
  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "Operations", "value": "operations"},
  ];

  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "Sarah Johnson",
      "position": "Chief Executive Officer",
      "department": "leadership",
      "image": "https://picsum.photos/120/120?random=1&keyword=woman",
      "bio": "Sarah leads our company with over 15 years of experience in tech innovation and strategic business development.",
      "email": "sarah.johnson@company.com",
      "linkedin": "linkedin.com/sarah-johnson",
      "expertise": ["Strategic Planning", "Leadership", "Innovation"],
      "joined": "2021",
    },
    {
      "name": "Michael Chen",
      "position": "Chief Technology Officer",
      "department": "engineering",
      "image": "https://picsum.photos/120/120?random=2&keyword=man",
      "bio": "Michael oversees our technical architecture and leads our engineering teams in building scalable solutions.",
      "email": "michael.chen@company.com",
      "linkedin": "linkedin.com/michael-chen",
      "expertise": ["System Architecture", "Cloud Computing", "AI/ML"],
      "joined": "2021",
    },
    {
      "name": "Emily Rodriguez",
      "position": "Head of Design",
      "department": "design",
      "image": "https://picsum.photos/120/120?random=3&keyword=woman",
      "bio": "Emily creates beautiful and intuitive user experiences that make our products accessible to everyone.",
      "email": "emily.rodriguez@company.com",
      "linkedin": "linkedin.com/emily-rodriguez",
      "expertise": ["UX Design", "Product Design", "User Research"],
      "joined": "2022",
    },
    {
      "name": "David Kim",
      "position": "Senior Software Engineer",
      "department": "engineering",
      "image": "https://picsum.photos/120/120?random=4&keyword=man",
      "bio": "David is a full-stack developer passionate about creating high-performance applications and mentoring junior developers.",
      "email": "david.kim@company.com",
      "linkedin": "linkedin.com/david-kim",
      "expertise": ["Full-Stack Development", "React", "Node.js"],
      "joined": "2022",
    },
    {
      "name": "Jessica Wu",
      "position": "Marketing Director",
      "department": "marketing",
      "image": "https://picsum.photos/120/120?random=5&keyword=woman",
      "bio": "Jessica drives our brand strategy and growth initiatives across digital and traditional marketing channels.",
      "email": "jessica.wu@company.com",
      "linkedin": "linkedin.com/jessica-wu",
      "expertise": ["Digital Marketing", "Brand Strategy", "Growth Hacking"],
      "joined": "2022",
    },
    {
      "name": "Alex Thompson",
      "position": "Sales Manager",
      "department": "sales",
      "image": "https://picsum.photos/120/120?random=6&keyword=man",
      "bio": "Alex leads our sales team and builds strong relationships with clients to drive business growth.",
      "email": "alex.thompson@company.com",
      "linkedin": "linkedin.com/alex-thompson",
      "expertise": ["B2B Sales", "Client Relations", "Business Development"],
      "joined": "2023",
    },
    {
      "name": "Maria Garcia",
      "position": "Operations Manager",
      "department": "operations",
      "image": "https://picsum.photos/120/120?random=7&keyword=woman",
      "bio": "Maria ensures our operations run smoothly and efficiently, managing processes and team coordination.",
      "email": "maria.garcia@company.com",
      "linkedin": "linkedin.com/maria-garcia",
      "expertise": ["Process Optimization", "Team Management", "Quality Assurance"],
      "joined": "2023",
    },
    {
      "name": "Robert Lee",
      "position": "Product Designer",
      "department": "design",
      "image": "https://picsum.photos/120/120?random=8&keyword=man",
      "bio": "Robert focuses on creating delightful user interfaces and ensuring our products are both beautiful and functional.",
      "email": "robert.lee@company.com",
      "linkedin": "linkedin.com/robert-lee",
      "expertise": ["UI Design", "Prototyping", "Design Systems"],
      "joined": "2023",
    },
  ];

  List<Map<String, dynamic>> companyStats = [
    {
      "title": "Team Members",
      "value": "150+",
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Countries",
      "value": "12",
      "icon": Icons.public,
      "color": successColor,
    },
    {
      "title": "Years Experience",
      "value": "3+",
      "icon": Icons.timeline,
      "color": infoColor,
    },
    {
      "title": "Projects Delivered",
      "value": "500+",
      "icon": Icons.rocket_launch,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> cultureValues = [
    {
      "title": "Innovation First",
      "description": "We embrace new ideas and cutting-edge technologies",
      "icon": Icons.lightbulb,
      "color": warningColor,
    },
    {
      "title": "Collaborative Spirit",
      "description": "We work together to achieve extraordinary results",
      "icon": Icons.handshake,
      "color": successColor,
    },
    {
      "title": "Quality Excellence",
      "description": "We maintain the highest standards in everything we do",
      "icon": Icons.star,
      "color": infoColor,
    },
    {
      "title": "Continuous Learning",
      "description": "We invest in growth and development for everyone",
      "icon": Icons.school,
      "color": primaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredMembers = selectedDepartment == 'all' 
        ? teamMembers 
        : teamMembers.where((member) => member["department"] == selectedDepartment).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Our Team"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team Header
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
                        Icons.groups,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          "Meet Our Amazing Team",
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
                    "Passionate professionals dedicated to creating exceptional experiences and driving innovation in everything we do.",
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
            
            // Company Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: companyStats.map((stat) => Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (stat["color"] as Color).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        stat["icon"] as IconData,
                        color: stat["color"] as Color,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: stat["color"] as Color,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Culture Values
            Text(
              "Our Culture",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...cultureValues.map((value) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (value["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      value["icon"] as IconData,
                      color: value["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${value["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${value["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Department Filter
            Row(
              children: [
                Text(
                  "Team Members",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${filteredMembers.length} members",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Department Tabs
            QHorizontalScroll(
              children: departments.map((dept) {
                final isSelected = selectedDepartment == dept["value"];
                return GestureDetector(
                  onTap: () {
                    selectedDepartment = dept["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      "${dept["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Team Members
            ...filteredMembers.map((member) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Member Header
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          image: DecorationImage(
                            image: NetworkImage("${member["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${member["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${member["position"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Joined ${member["joined"]}",
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
                  
                  SizedBox(height: spMd),
                  
                  // Bio
                  Text(
                    "${member["bio"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Expertise Tags
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: (member["expertise"] as List<String>).map((skill) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Contact Info
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${member["email"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spMd),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.link,
                            size: 16,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Join Our Team CTA
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
                    Icons.work,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Join Our Team",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "We're always looking for talented individuals who share our passion for innovation and excellence. Come help us build the future!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Open Positions",
                          size: bs.md,
                          onPressed: () {},
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
  }
}
