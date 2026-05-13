import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome10View extends StatefulWidget {
  @override
  State<GrlWelcome10View> createState() => _GrlWelcome10ViewState();
}

class _GrlWelcome10ViewState extends State<GrlWelcome10View> {
  int selectedPersona = 0;
  
  final List<Map<String, dynamic>> personas = [
    {
      "title": "Creative Professional",
      "subtitle": "Designer, Artist, Content Creator",
      "description": "Perfect for creative work with advanced design tools, collaboration features, and portfolio management.",
      "icon": Icons.palette,
      "color": primaryColor,
      "features": [
        "Advanced design tools",
        "Portfolio management",
        "Creative collaboration",
        "Asset library access",
        "Template collection",
      ],
      "image": "https://picsum.photos/300/200?random=1&keyword=creative",
    },
    {
      "title": "Business Professional",
      "subtitle": "Manager, Entrepreneur, Consultant",
      "description": "Streamline your business operations with productivity tools, analytics, and team management features.",
      "icon": Icons.business,
      "color": successColor,
      "features": [
        "Productivity dashboard",
        "Team management",
        "Business analytics",
        "Project tracking",
        "Financial reporting",
      ],
      "image": "https://picsum.photos/300/200?random=2&keyword=business",
    },
    {
      "title": "Developer & Tech",
      "subtitle": "Software Developer, IT Professional",
      "description": "Built-in development tools, code management, API integrations, and technical documentation features.",
      "icon": Icons.code,
      "color": infoColor,
      "features": [
        "Code management",
        "API integrations",
        "Technical documentation",
        "Development workflows",
        "Version control",
      ],
      "image": "https://picsum.photos/300/200?random=3&keyword=technology",
    },
    {
      "title": "Student & Educator",
      "subtitle": "Student, Teacher, Researcher",
      "description": "Educational tools, research capabilities, note-taking, and collaborative learning features.",
      "icon": Icons.school,
      "color": warningColor,
      "features": [
        "Note-taking system",
        "Research tools",
        "Study planning",
        "Collaborative learning",
        "Academic resources",
      ],
      "image": "https://picsum.photos/300/200?random=4&keyword=education",
    },
    {
      "title": "Personal Use",
      "subtitle": "Individual, Family, Personal Projects",
      "description": "Simple and intuitive interface focused on personal productivity, family organization, and life management.",
      "icon": Icons.person,
      "color": dangerColor,
      "features": [
        "Personal dashboard",
        "Family organization",
        "Life planning tools",
        "Personal finance",
        "Health tracking",
      ],
      "image": "https://picsum.photos/300/200?random=5&keyword=personal",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentPersona = personas[selectedPersona];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Profile"),
        actions: [
          GestureDetector(
            onTap: () {
              // navigateTo('');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Header
            Text(
              "Tell us about yourself",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Choose the profile that best describes you. We'll customize your experience accordingly.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Persona Selector
            QHorizontalScroll(
              children: List.generate(personas.length, (index) {
                final persona = personas[index];
                final isSelected = selectedPersona == index;
                
                return GestureDetector(
                  onTap: () {
                    selectedPersona = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? persona["color"] : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [shadowMd] : [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Persona Icon
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: persona["color"].withAlpha(isSelected ? 255 : 50),
                            borderRadius: BorderRadius.circular(radiusXl),
                          ),
                          child: Icon(
                            persona["icon"],
                            size: 30,
                            color: isSelected ? Colors.white : persona["color"],
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Title and Subtitle
                        Text(
                          "${persona["title"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? persona["color"] : primaryColor,
                          ),
                        ),
                        
                        SizedBox(height: spXs),
                        
                        Text(
                          "${persona["subtitle"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Text(
                          "${persona["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        
                        if (isSelected) ...[
                          SizedBox(height: spMd),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: persona["color"].withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: persona["color"].withAlpha(100),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: persona["color"],
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Selected",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: persona["color"],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
            
            SizedBox(height: sp2xl),
            
            // Selected Persona Details
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: currentPersona["color"],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          currentPersona["icon"],
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentPersona["title"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${currentPersona["subtitle"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Image
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${currentPersona["image"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Features
                  Text(
                    "What you'll get:",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    children: (currentPersona["features"] as List).map<Widget>((feature) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: currentPersona["color"].withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.check,
                                color: currentPersona["color"],
                                size: 12,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "$feature",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
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
            
            SizedBox(height: spMd),
            
            // Benefits Preview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    currentPersona["color"].withAlpha(20),
                    currentPersona["color"].withAlpha(40),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: currentPersona["color"].withAlpha(100),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: currentPersona["color"],
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Personalized Experience",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Based on your selection, we'll customize your dashboard, recommend relevant features, and provide tailored tutorials to help you get the most out of the app.",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      height: 1.4,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: currentPersona["color"],
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Don't worry, you can change this anytime in settings",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Continue Button
            QButton(
              label: "Continue as ${currentPersona["title"]}",
              size: bs.md,
              onPressed: () {
                // navigateTo('');
              },
            ),
            
            SizedBox(height: spSm),
            
            GestureDetector(
              onTap: () {
                // navigateTo('');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                child: Text(
                  "I'll choose later",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
