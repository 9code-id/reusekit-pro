import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaDoctorProfileView extends StatefulWidget {
  const HcaDoctorProfileView({super.key});

  @override
  State<HcaDoctorProfileView> createState() => _HcaDoctorProfileViewState();
}

class _HcaDoctorProfileViewState extends State<HcaDoctorProfileView> {
  Map<String, dynamic> doctor = {
    "id": "1",
    "name": "Dr. Sarah Johnson",
    "specialty": "Cardiologist",
    "hospital": "Metropolitan Medical Center",
    "experience": 15,
    "rating": 4.8,
    "totalReviews": 342,
    "education": "Harvard Medical School",
    "languages": ["English", "Spanish", "French"],
    "profileImage": "https://picsum.photos/150/150?random=1&keyword=doctor",
    "about": "Dr. Sarah Johnson is a board-certified cardiologist with over 15 years of experience in treating cardiovascular diseases. She specializes in preventive cardiology and has published numerous research papers.",
    "phone": "+1 (555) 123-4567",
    "email": "sarah.johnson@metropolitan.com",
    "address": "123 Medical Plaza, Suite 456, New York, NY 10001",
    "workingHours": "Mon-Fri: 8:00 AM - 6:00 PM",
    "consultationFee": 250,
    "isAvailable": true,
    "nextAvailable": "Today at 2:30 PM"
  };

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Excellence in Cardiology Award",
      "year": "2023",
      "organization": "American Heart Association"
    },
    {
      "title": "Best Doctor Award",
      "year": "2022",
      "organization": "Metropolitan Medical Center"
    },
    {
      "title": "Research Publication Award",
      "year": "2021",
      "organization": "Journal of Cardiology"
    }
  ];

  List<Map<String, dynamic>> services = [
    {
      "name": "General Consultation",
      "price": 250,
      "duration": "30 minutes",
      "icon": Icons.medical_services
    },
    {
      "name": "Heart Screening",
      "price": 400,
      "duration": "45 minutes",
      "icon": Icons.favorite
    },
    {
      "name": "Follow-up Visit",
      "price": 150,
      "duration": "20 minutes",
      "icon": Icons.assignment
    },
    {
      "name": "Emergency Consultation",
      "price": 500,
      "duration": "60 minutes",
      "icon": Icons.emergency
    }
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "id": "1",
      "patientName": "John Smith",
      "rating": 5,
      "comment": "Dr. Johnson is exceptional. She took time to explain my condition thoroughly and provided excellent care.",
      "date": "2024-01-15",
      "verified": true
    },
    {
      "id": "2",
      "patientName": "Maria Garcia",
      "rating": 5,
      "comment": "Very professional and knowledgeable. The consultation was thorough and I felt comfortable throughout.",
      "date": "2024-01-10",
      "verified": true
    },
    {
      "id": "3",
      "patientName": "David Wilson",
      "rating": 4,
      "comment": "Great doctor with excellent bedside manner. Highly recommend for cardiac issues.",
      "date": "2024-01-05",
      "verified": false
    }
  ];

  int selectedTab = 0;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Profile"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : null,
            ),
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
              ss(isFavorite ? "Added to favorites" : "Removed from favorites");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Profile shared");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorHeader(),
            SizedBox(height: spLg),
            _buildQuickActions(),
            SizedBox(height: spLg),
            _buildTabSection(),
            SizedBox(height: spLg),
            _buildTabContent(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Book Appointment",
                onPressed: () {
                  ss("Booking appointment with ${doctor["name"]}");
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.phone,
              size: bs.sm,
              onPressed: () {
                ss("Calling ${doctor["name"]}");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${doctor["profileImage"]}"),
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
                      "${doctor["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${doctor["specialty"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${doctor["hospital"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${doctor["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          " (${doctor["totalReviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem("Experience", "${doctor["experience"]} Years", Icons.work),
              _buildStatItem("Rating", "${doctor["rating"]}/5.0", Icons.star),
              _buildStatItem("Reviews", "${doctor["totalReviews"]}", Icons.reviews),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 24,
        ),
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
            fontSize: 12,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
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
            "Quick Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: doctor["isAvailable"] ? successColor : dangerColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                doctor["isAvailable"] ? "Available" : "Busy",
                style: TextStyle(
                  fontSize: 14,
                  color: doctor["isAvailable"] ? successColor : dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                " • Next: ${doctor["nextAvailable"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.attach_money,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Consultation: \$${doctor["consultationFee"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            child: Row(
              children: [
                _buildTab("About", 0),
                _buildTab("Services", 1),
                _buildTab("Reviews", 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildAboutTab();
      case 1:
        return _buildServicesTab();
      case 2:
        return _buildReviewsTab();
      default:
        return Container();
    }
  }

  Widget _buildAboutTab() {
    return Container(
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
            "About Dr. ${doctor["name"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${doctor["about"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
          SizedBox(height: spLg),
          Text(
            "Education",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.school,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "${doctor["education"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),
          Text(
            "Languages",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (doctor["languages"] as List).map((language) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(40)),
                ),
                child: Text(
                  "${language}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),
          Text(
            "Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...achievements.map((achievement) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(40)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
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
                          "${achievement["organization"]} • ${achievement["year"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return Container(
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
            "Medical Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...services.map((service) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      service["icon"],
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
                          "${service["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${service["duration"]}",
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
                          color: successColor,
                        ),
                      ),
                      QButton(
                        label: "Book",
                        size: bs.sm,
                        onPressed: () {
                          ss("Booking ${service["name"]}");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Container(
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
              QButton(
                label: "Write Review",
                size: bs.sm,
                onPressed: () {
                  ss("Writing review");
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...reviews.map((review) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: primaryColor.withAlpha(20),
                        child: Text(
                          "${review["patientName"]}".substring(0, 1),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                                Text(
                                  "${review["patientName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (review["verified"])
                                  Container(
                                    margin: EdgeInsets.only(left: spXs),
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Verified",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                ...List.generate(5, (index) {
                                  return Icon(
                                    index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                                    color: warningColor,
                                    size: 12,
                                  );
                                }),
                                SizedBox(width: spXs),
                                Text(
                                  "${review["date"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${review["comment"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
