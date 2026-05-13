import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHospitalDetailView extends StatefulWidget {
  const MhaHospitalDetailView({super.key});

  @override
  State<MhaHospitalDetailView> createState() => _MhaHospitalDetailViewState();
}

class _MhaHospitalDetailViewState extends State<MhaHospitalDetailView> {
  int selectedTab = 0;
  String selectedDepartment = "Cardiology";
  bool isFavorite = false;

  List<Map<String, dynamic>> departments = [
    {
      "name": "Cardiology",
      "description": "Heart and cardiovascular care",
      "doctors": 12,
      "icon": Icons.favorite,
      "color": Colors.red,
      "available": true,
    },
    {
      "name": "Neurology",
      "description": "Brain and nervous system",
      "doctors": 8,
      "icon": Icons.psychology,
      "color": Colors.purple,
      "available": true,
    },
    {
      "name": "Orthopedics",
      "description": "Bone and joint treatment",
      "doctors": 15,
      "icon": Icons.accessibility,
      "color": Colors.orange,
      "available": false,
    },
  ];

  List<Map<String, dynamic>> services = [
    {
      "name": "Emergency Care",
      "price": 200.0,
      "duration": "24/7",
      "available": true,
    },
    {
      "name": "Surgery",
      "price": 5000.0,
      "duration": "2-6 hours",
      "available": true,
    },
    {
      "name": "Consultation",
      "price": 150.0,
      "duration": "30-45 mins",
      "available": true,
    },
    {
      "name": "Laboratory Tests",
      "price": 80.0,
      "duration": "1-2 hours",
      "available": true,
    },
  ];

  List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Sarah Wilson",
      "specialization": "Cardiology",
      "experience": "15 years",
      "rating": 4.8,
      "image": "https://picsum.photos/150/150?random=1&keyword=doctor",
      "available": true,
    },
    {
      "name": "Dr. Michael Chen",
      "specialization": "Neurology",
      "experience": "12 years",
      "rating": 4.7,
      "image": "https://picsum.photos/150/150?random=2&keyword=doctor",
      "available": false,
    },
    {
      "name": "Dr. Emily Rodriguez",
      "specialization": "Orthopedics",
      "experience": "10 years",
      "rating": 4.9,
      "image": "https://picsum.photos/150/150?random=3&keyword=doctor",
      "available": true,
    },
  ];

  Map<String, dynamic> hospitalData = {
    "name": "Metropolitan Health Center",
    "address": "123 Healthcare Boulevard, Medical District",
    "phone": "+1 (555) 123-4567",
    "email": "info@metrohealth.com",
    "rating": 4.6,
    "totalReviews": 2847,
    "image": "https://picsum.photos/400/200?random=1&keyword=hospital",
    "established": "1985",
    "beds": 350,
    "departments": 24,
    "accreditation": "Joint Commission",
    "website": "www.metrohealth.com",
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Hospital Details",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "Departments", icon: Icon(Icons.local_hospital)),
        Tab(text: "Services", icon: Icon(Icons.medical_services)),
        Tab(text: "Doctors", icon: Icon(Icons.person)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDepartmentsTab(),
        _buildServicesTab(),
        _buildDoctorsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hospital Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("${hospitalData["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(150),
                  ],
                ),
              ),
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${hospitalData["name"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isFavorite = !isFavorite;
                          setState(() {});
                        },
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(hospitalData["rating"] as double).toStringAsFixed(1)} (${hospitalData["totalReviews"]} reviews)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: spMd),

          // Quick Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${hospitalData["beds"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Beds",
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
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${hospitalData["departments"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Departments",
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
                    color: infoColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${hospitalData["established"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Established",
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

          // Contact Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contact Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: dangerColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${hospitalData["address"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${hospitalData["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${hospitalData["email"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${hospitalData["website"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Book Appointment",
                  size: bs.md,
                  onPressed: () {
                    ss("Appointment booking initiated");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.call,
                size: bs.md,
                onPressed: () {
                  ss("Calling hospital");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.directions,
                size: bs.md,
                onPressed: () {
                  ss("Opening directions");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: departments.map((department) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: Border.all(
                color: selectedDepartment == department["name"]
                    ? primaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (department["color"] as Color).withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    department["icon"] as IconData,
                    color: department["color"] as Color,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${department["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${department["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${department["doctors"]} doctors",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: department["available"] == true
                                  ? successColor.withAlpha(25)
                                  : dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              department["available"] == true
                                  ? "Available"
                                  : "Busy",
                              style: TextStyle(
                                fontSize: 10,
                                color: department["available"] == true
                                    ? successColor
                                    : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () {
                    selectedDepartment = department["name"];
                    setState(() {});
                    ss("Selected ${department["name"]} department");
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildServicesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: services.map((service) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${service["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
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
                        color: service["available"] == true
                            ? successColor.withAlpha(25)
                            : dangerColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        service["available"] == true ? "Available" : "Unavailable",
                        style: TextStyle(
                          fontSize: 10,
                          color: service["available"] == true
                              ? successColor
                              : dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${(service["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.access_time,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${service["duration"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Book Service",
                    size: bs.sm,
                    onPressed: service["available"] == true
                        ? () {
                            ss("Booking ${service["name"]} service");
                          }
                        : null,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDoctorsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: doctors.map((doctor) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
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
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${doctor["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${doctor["specialization"]} • ${doctor["experience"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(doctor["rating"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: doctor["available"] == true
                                  ? successColor.withAlpha(25)
                                  : dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              doctor["available"] == true ? "Available" : "Busy",
                              style: TextStyle(
                                fontSize: 10,
                                color: doctor["available"] == true
                                    ? successColor
                                    : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Book",
                  size: bs.sm,
                  onPressed: doctor["available"] == true
                      ? () {
                          ss("Booking appointment with ${doctor["name"]}");
                        }
                      : null,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
