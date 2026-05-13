import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSpeakerProfileView extends StatefulWidget {
  const EmaSpeakerProfileView({super.key});

  @override
  State<EmaSpeakerProfileView> createState() => _EmaSpeakerProfileViewState();
}

class _EmaSpeakerProfileViewState extends State<EmaSpeakerProfileView> {
  bool isEditing = false;
  String name = "Dr. Sarah Johnson";
  String title = "Chief Technology Officer";
  String company = "MedTech Solutions";
  String bio = "Leading expert in healthcare technology with 15+ years of experience in developing cutting-edge AI solutions for medical diagnosis and patient care.";
  String location = "San Francisco, CA";
  String phone = "+1 (555) 123-4567";
  String email = "sarah.johnson@medtech.com";
  String website = "https://sarahjohnson.com";
  List<String> expertise = ["Artificial Intelligence", "Healthcare Technology", "Digital Transformation", "Medical Research"];
  List<String> languages = ["English", "Spanish", "French"];
  
  Map<String, dynamic> profileStats = {
    "followers": 1250,
    "following": 89,
    "sessionsCompleted": 24,
    "totalAttendees": 8500,
    "averageRating": 4.9,
    "totalReviews": 324,
  };

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Healthcare Innovation Award",
      "organization": "Medical Technology Association",
      "year": "2024",
      "description": "Recognized for outstanding contributions to AI in healthcare",
      "icon": Icons.emoji_events,
    },
    {
      "title": "Top Speaker of the Year",
      "organization": "Tech Conference Network",
      "year": "2023",
      "description": "Highest rated speaker across all technology conferences",
      "icon": Icons.record_voice_over,
    },
    {
      "title": "Research Excellence Award",
      "organization": "Stanford University",
      "year": "2023",
      "description": "Outstanding research in medical AI applications",
      "icon": Icons.science,
    },
  ];

  List<Map<String, dynamic>> certifications = [
    {
      "name": "Certified AI Professional",
      "issuer": "AI Institute",
      "date": "2024",
      "verified": true,
    },
    {
      "name": "Healthcare Technology Specialist",
      "issuer": "HealthTech Certification Board",
      "date": "2023",
      "verified": true,
    },
    {
      "name": "Digital Health Expert",
      "issuer": "Digital Health Academy",
      "date": "2022",
      "verified": false,
    },
  ];

  void _saveProfile() {
    isEditing = false;
    setState(() {});
    ss("Profile updated successfully");
  }

  void _cancelEdit() {
    isEditing = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          if (!isEditing)
            GestureDetector(
              onTap: () {
                isEditing = true;
                setState(() {});
              },
              child: Icon(
                Icons.edit,
                color: primaryColor,
              ),
            ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Avatar
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white, width: 3),
                          image: DecorationImage(
                            image: NetworkImage("https://picsum.photos/150/150?random=1&keyword=doctor"),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [shadowMd],
                        ),
                      ),
                      if (isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              ss("Change profile photo");
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Name and Title
                  if (isEditing) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: TextField(
                        controller: TextEditingController(text: name),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Your Name",
                          hintStyle: TextStyle(color: Colors.white.withAlpha(150)),
                        ),
                        onChanged: (value) => name = value,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: TextField(
                        controller: TextEditingController(text: title),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(220),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Your Title",
                          hintStyle: TextStyle(color: Colors.white.withAlpha(150)),
                        ),
                        onChanged: (value) => title = value,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: TextField(
                        controller: TextEditingController(text: company),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Your Company",
                          hintStyle: TextStyle(color: Colors.white.withAlpha(150)),
                        ),
                        onChanged: (value) => company = value,
                      ),
                    ),
                  ] else ...[
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                    Text(
                      company,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Stats Section
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildStatCard("Followers", "${profileStats["followers"]}", Icons.people, primaryColor),
                _buildStatCard("Following", "${profileStats["following"]}", Icons.person_add, infoColor),
                _buildStatCard("Sessions", "${profileStats["sessionsCompleted"]}", Icons.event, successColor),
                _buildStatCard("Rating", "${profileStats["averageRating"]}", Icons.star, warningColor),
              ],
            ),

            SizedBox(height: spLg),

            // Action Buttons (only when editing)
            if (isEditing) ...[
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.md,
                      onPressed: _cancelEdit,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Save Changes",
                      size: bs.md,
                      onPressed: _saveProfile,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spLg),
            ],

            // Bio Section
            _buildSectionCard(
              title: "About Me",
              icon: Icons.person,
              child: isEditing 
                ? TextField(
                    controller: TextEditingController(text: bio),
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radiusMd),
                        borderSide: BorderSide(color: disabledOutlineBorderColor),
                      ),
                      hintText: "Tell us about yourself...",
                    ),
                    onChanged: (value) => bio = value,
                  )
                : Text(
                    bio,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
            ),

            SizedBox(height: spMd),

            // Contact Information
            _buildSectionCard(
              title: "Contact Information", 
              icon: Icons.contact_phone,
              child: Column(
                spacing: spMd,
                children: [
                  _buildContactField(Icons.location_on, "Location", location, (value) => location = value),
                  _buildContactField(Icons.phone, "Phone", phone, (value) => phone = value),
                  _buildContactField(Icons.email, "Email", email, (value) => email = value),
                  _buildContactField(Icons.web, "Website", website, (value) => website = value),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Expertise
            _buildSectionCard(
              title: "Areas of Expertise",
              icon: Icons.lightbulb,
              child: isEditing
                ? Column(
                    children: [
                      ...expertise.asMap().entries.map((entry) => Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(text: entry.value),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    borderSide: BorderSide(color: disabledOutlineBorderColor),
                                  ),
                                  hintText: "Expertise area",
                                ),
                                onChanged: (value) => expertise[entry.key] = value,
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {
                                expertise.removeAt(entry.key);
                                setState(() {});
                              },
                              child: Icon(Icons.remove_circle, color: dangerColor),
                            ),
                          ],
                        ),
                      )).toList(),
                      QButton(
                        label: "Add Expertise",
                        size: bs.sm,
                        onPressed: () {
                          expertise.add("");
                          setState(() {});
                        },
                      ),
                    ],
                  )
                : Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: expertise.map((skill) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    )).toList(),
                  ),
            ),

            SizedBox(height: spMd),

            // Languages
            _buildSectionCard(
              title: "Languages",
              icon: Icons.language,
              child: isEditing
                ? Column(
                    children: [
                      ...languages.asMap().entries.map((entry) => Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(text: entry.value),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    borderSide: BorderSide(color: disabledOutlineBorderColor),
                                  ),
                                  hintText: "Language",
                                ),
                                onChanged: (value) => languages[entry.key] = value,
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {
                                languages.removeAt(entry.key);
                                setState(() {});
                              },
                              child: Icon(Icons.remove_circle, color: dangerColor),
                            ),
                          ],
                        ),
                      )).toList(),
                      QButton(
                        label: "Add Language",
                        size: bs.sm,
                        onPressed: () {
                          languages.add("");
                          setState(() {});
                        },
                      ),
                    ],
                  )
                : Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: languages.map((lang) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        lang,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    )).toList(),
                  ),
            ),

            SizedBox(height: spMd),

            // Achievements
            _buildSectionCard(
              title: "Achievements & Awards",
              icon: Icons.emoji_events,
              child: Column(
                children: achievements.map((achievement) => Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          achievement["icon"],
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${achievement["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "${achievement["organization"]} • ${achievement["year"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${achievement["description"]}",
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
                )).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Certifications
            _buildSectionCard(
              title: "Certifications",
              icon: Icons.verified,
              child: Column(
                children: certifications.map((cert) => Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: cert["verified"] ? successColor.withAlpha(25) : disabledColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: cert["verified"] ? successColor.withAlpha(50) : disabledColor.withAlpha(50),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        cert["verified"] ? Icons.verified : Icons.pending,
                        color: cert["verified"] ? successColor : disabledBoldColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${cert["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: cert["verified"] ? successColor : disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${cert["issuer"]} • ${cert["date"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              cert["verified"] ? "Verified" : "Pending verification",
                              style: TextStyle(
                                fontSize: 12,
                                color: cert["verified"] ? successColor : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
                icon,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spMd),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          child,
        ],
      ),
    );
  }

  Widget _buildContactField(IconData icon, String label, String value, Function(String) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 20,
        ),
        SizedBox(width: spMd),
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: isEditing
            ? TextField(
                controller: TextEditingController(text: value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radiusMd),
                    borderSide: BorderSide(color: disabledOutlineBorderColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                ),
                onChanged: onChanged,
              )
            : Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
        ),
      ],
    );
  }
}
