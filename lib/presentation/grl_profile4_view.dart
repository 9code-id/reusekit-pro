import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProfile4View extends StatefulWidget {
  @override
  State<GrlProfile4View> createState() => _GrlProfile4ViewState();
}

class _GrlProfile4ViewState extends State<GrlProfile4View> {
  Map<String, dynamic> user = {
    "name": "Dr. James Wilson",
    "title": "Cardiologist",
    "specialization": "Interventional Cardiology",
    "avatar": "https://picsum.photos/100/100?random=15&keyword=doctor",
    "hospital": "Metropolitan Medical Center",
    "experience": "15+ years",
    "rating": 4.9,
    "reviews": 342,
    "patients": 1250,
    "consultationFee": 150,
    "languages": ["English", "Spanish", "French"],
    "verified": true,
    "available": true,
  };

  List<Map<String, dynamic>> achievements = [
    {
      "icon": Icons.school,
      "title": "Harvard Medical School",
      "subtitle": "MD, Cardiology",
      "year": "2008",
    },
    {
      "icon": Icons.military_tech,
      "title": "Board Certified",
      "subtitle": "American Board of Cardiology",
      "year": "2012",
    },
    {
      "icon": Icons.workspace_premium,
      "title": "Fellowship",
      "subtitle": "Interventional Cardiology",
      "year": "2014",
    },
    {
      "icon": Icons.star,
      "title": "Top Doctor Award",
      "subtitle": "Metropolitan Medical Awards",
      "year": "2023",
    },
  ];

  List<Map<String, dynamic>> services = [
    {
      "name": "General Consultation",
      "duration": "30 min",
      "price": 150,
      "available": true,
    },
    {
      "name": "Cardiac Screening",
      "duration": "45 min",
      "price": 220,
      "available": true,
    },
    {
      "name": "ECG & Stress Test",
      "duration": "60 min",
      "price": 300,
      "available": false,
    },
    {
      "name": "Follow-up Visit",
      "duration": "20 min",
      "price": 100,
      "available": true,
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"time": "09:00 AM", "available": true},
    {"time": "10:30 AM", "available": false},
    {"time": "02:00 PM", "available": true},
    {"time": "03:30 PM", "available": true},
    {"time": "05:00 PM", "available": false},
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "patientName": "Sarah M.",
      "rating": 5,
      "comment": "Dr. Wilson is exceptional! Very thorough and explains everything clearly. Highly recommended.",
      "date": "2 weeks ago",
      "verified": true,
    },
    {
      "patientName": "Robert K.",
      "rating": 5,
      "comment": "Professional and caring doctor. The best cardiologist I've ever consulted with.",
      "date": "1 month ago",
      "verified": true,
    },
    {
      "patientName": "Maria L.",
      "rating": 4,
      "comment": "Great experience overall. The doctor was very patient and answered all my questions.",
      "date": "2 months ago",
      "verified": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Doctor Header Card
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade50,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowLg],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Avatar with Status
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: primaryColor, width: 3),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                "${user["avatar"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (user["available"] == true)
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
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: spMd),
                      
                      // Doctor Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${user["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (user["verified"] == true) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              "${user["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor,
                              ),
                            ),
                            Text(
                              "${user["specialization"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.business, size: 14, color: disabledColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${user["hospital"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
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
                  
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          Icons.star,
                          "${user["rating"]}",
                          "Rating",
                          warningColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          Icons.reviews,
                          "${user["reviews"]}",
                          "Reviews",
                          infoColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          Icons.people,
                          "${user["patients"]}",
                          "Patients",
                          successColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          Icons.schedule,
                          "${user["experience"]}",
                          "Experience",
                          primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Consultation Fee
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.monetization_on, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Consultation Fee: ",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${user["consultationFee"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Languages & Availability
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Languages Spoken",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    children: (user["languages"] as List).map((language) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          language,
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Services Section
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Services Offered",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: services.map((service) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: service["available"] == true 
                              ? Colors.grey.shade50 
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: service["available"] == true 
                                ? primaryColor.withAlpha(50) 
                                : disabledColor.withAlpha(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${service["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: service["available"] == true 
                                          ? primaryColor 
                                          : disabledColor,
                                    ),
                                  ),
                                  Text(
                                    "Duration: ${service["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${service["price"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: service["available"] == true 
                                        ? primaryColor 
                                        : disabledColor,
                                  ),
                                ),
                                Text(
                                  service["available"] == true ? "Available" : "Unavailable",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: service["available"] == true 
                                        ? successColor 
                                        : dangerColor,
                                    fontWeight: FontWeight.w600,
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
            
            SizedBox(height: spMd),
            
            // Achievements Section
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Education & Achievements",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: achievements.map((achievement) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                achievement["icon"] as IconData,
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
                                    "${achievement["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${achievement["subtitle"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${achievement["year"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
            
            SizedBox(height: spMd),
            
            // Reviews Section
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: spMd),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Patient Reviews",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: reviews.take(2).map((review) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${review["patientName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                if (review["verified"] == true) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    color: successColor,
                                    size: 14,
                                  ),
                                ],
                                Spacer(),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < (review["rating"] as int) 
                                          ? Icons.star 
                                          : Icons.star_border,
                                      color: warningColor,
                                      size: 14,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${review["comment"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${review["date"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
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
            
            // Book Appointment Button
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(spMd),
              child: QButton(
                label: "Book Appointment",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }
}
