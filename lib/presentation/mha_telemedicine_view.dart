import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaTelemedicineView extends StatefulWidget {
  const MhaTelemedicineView({super.key});

  @override
  State<MhaTelemedicineView> createState() => _MhaTelemedicineViewState();
}

class _MhaTelemedicineViewState extends State<MhaTelemedicineView> {
  String selectedConsultationType = "video";
  List<Map<String, dynamic>> availableDoctors = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "specialty": "General Medicine",
      "rating": 4.8,
      "experience": "8 years",
      "image": "https://picsum.photos/120/120?random=1&keyword=doctor",
      "isOnline": true,
      "consultationFee": 45.0,
      "availability": "Available now",
      "languages": ["English", "Spanish"],
      "reviews": 156
    },
    {
      "id": 2,
      "name": "Dr. Michael Chen",
      "specialty": "Cardiology",
      "rating": 4.9,
      "experience": "12 years",
      "image": "https://picsum.photos/120/120?random=2&keyword=doctor",
      "isOnline": true,
      "consultationFee": 75.0,
      "availability": "Available in 15 mins",
      "languages": ["English", "Chinese"],
      "reviews": 234
    },
    {
      "id": 3,
      "name": "Dr. Emily Davis",
      "specialty": "Dermatology",
      "rating": 4.7,
      "experience": "6 years",
      "image": "https://picsum.photos/120/120?random=3&keyword=doctor",
      "isOnline": false,
      "consultationFee": 60.0,
      "availability": "Next available: 2:30 PM",
      "languages": ["English", "French"],
      "reviews": 189
    },
    {
      "id": 4,
      "name": "Dr. James Wilson",
      "specialty": "Pediatrics",
      "rating": 4.9,
      "experience": "10 years",
      "image": "https://picsum.photos/120/120?random=4&keyword=doctor",
      "isOnline": true,
      "consultationFee": 55.0,
      "availability": "Available now",
      "languages": ["English"],
      "reviews": 312
    }
  ];

  List<Map<String, dynamic>> consultationTypes = [
    {
      "id": "video",
      "title": "Video Call",
      "description": "Face-to-face consultation with doctor",
      "icon": Icons.videocam,
      "duration": "15-30 mins",
      "price": "Standard Rate"
    },
    {
      "id": "audio",
      "title": "Voice Call",
      "description": "Audio consultation with doctor",
      "icon": Icons.phone,
      "duration": "10-20 mins",
      "price": "20% less"
    },
    {
      "id": "chat",
      "title": "Chat",
      "description": "Text-based consultation",
      "icon": Icons.chat,
      "duration": "Real-time",
      "price": "50% less"
    }
  ];

  List<Map<String, dynamic>> recentConsultations = [
    {
      "id": 1,
      "doctorName": "Dr. Sarah Johnson",
      "specialty": "General Medicine",
      "date": "Dec 10, 2024",
      "time": "2:30 PM",
      "type": "Video Call",
      "status": "Completed",
      "duration": "25 mins"
    },
    {
      "id": 2,
      "doctorName": "Dr. Michael Chen",
      "specialty": "Cardiology",
      "date": "Dec 8, 2024",
      "time": "10:15 AM",
      "type": "Chat",
      "status": "Completed",
      "duration": "45 mins"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Telemedicine"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to consultation history
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Need Immediate Care?",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Connect with doctors instantly",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: "Emergency Consultation",
                          color: Colors.white,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to emergency consultation
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.emergency,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Consultation Types
            Text(
              "Choose Consultation Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: consultationTypes.map((type) {
                bool isSelected = selectedConsultationType == type["id"];
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedConsultationType = type["id"];
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(50) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            type["icon"],
                            size: 32,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${type["title"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: spXxs),
                          Text(
                            "${type["price"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected ? primaryColor : disabledColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Available Doctors
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Doctors",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to all doctors
                  },
                  child: Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            ...availableDoctors.take(3).map((doctor) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${doctor["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: doctor["isOnline"] 
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 12,
                              height: 12,
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: successColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          )
                        : null,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${doctor["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXxs),
                          Text(
                            "${doctor["specialty"]} • ${doctor["experience"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXxs),
                          Row(
                            children: [
                              Icon(Icons.star, size: 14, color: warningColor),
                              SizedBox(width: 2),
                              Text(
                                "${doctor["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " (${doctor["reviews"]} reviews)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXxs),
                          Text(
                            "${doctor["availability"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: doctor["isOnline"] ? successColor : warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${(doctor["consultationFee"] as double).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: doctor["isOnline"] ? "Consult Now" : "Schedule",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to consultation
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),

            // Recent Consultations
            if (recentConsultations.isNotEmpty) ...[
              Text(
                "Recent Consultations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...recentConsultations.map((consultation) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          consultation["type"] == "Video Call" 
                            ? Icons.videocam 
                            : consultation["type"] == "Voice Call"
                              ? Icons.phone
                              : Icons.chat,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${consultation["doctorName"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXxs),
                            Text(
                              "${consultation["specialty"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXxs),
                            Text(
                              "${consultation["date"]} • ${consultation["time"]}",
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXxs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${consultation["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${consultation["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],

            SizedBox(height: spLg),

            // Features Grid
            Text(
              "Telemedicine Features",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildFeatureCard(
                  "Prescription",
                  "Get digital prescriptions",
                  Icons.description,
                  primaryColor,
                ),
                _buildFeatureCard(
                  "Health Records",
                  "Access your medical history",
                  Icons.folder_shared,
                  infoColor,
                ),
                _buildFeatureCard(
                  "Lab Reports",
                  "View test results online",
                  Icons.science,
                  successColor,
                ),
                _buildFeatureCard(
                  "Follow-up",
                  "Schedule follow-up appointments",
                  Icons.event_repeat,
                  warningColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String title, String subtitle, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Navigate to feature
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spXs),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
