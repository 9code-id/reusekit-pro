import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaClinicDetailView extends StatefulWidget {
  const MhaClinicDetailView({super.key});

  @override
  State<MhaClinicDetailView> createState() => _MhaClinicDetailViewState();
}

class _MhaClinicDetailViewState extends State<MhaClinicDetailView> {
  int currentTab = 0;
  bool isFavorite = false;

  Map<String, dynamic> clinic = {
    "id": "CLI001",
    "name": "Family Care Clinic",
    "specialty": "Family Medicine",
    "rating": 4.7,
    "reviews": 890,
    "distance": 1.2,
    "address": "456 Health Street, Medical Plaza",
    "phone": "+1 (555) 234-5678",
    "email": "info@familycareclinic.com",
    "website": "www.familycareclinic.com",
    "image": "https://picsum.photos/600/400?random=1&keyword=clinic",
    "doctors": 8,
    "openNow": true,
    "nextAvailable": "Today 3:00 PM",
    "waitTime": "15 mins",
    "establishedYear": 2010,
    "description": "Family Care Clinic has been providing comprehensive family healthcare services for over a decade. We focus on preventive care and building long-term relationships with our patients.",
    "hours": {
      "monday": "8:00 AM - 6:00 PM",
      "tuesday": "8:00 AM - 6:00 PM", 
      "wednesday": "8:00 AM - 6:00 PM",
      "thursday": "8:00 AM - 6:00 PM",
      "friday": "8:00 AM - 6:00 PM",
      "saturday": "9:00 AM - 2:00 PM",
      "sunday": "Closed"
    },
    "services": [
      {"name": "General Checkups", "price": 150, "duration": "30 mins"},
      {"name": "Vaccinations", "price": 75, "duration": "15 mins"},
      {"name": "Lab Tests", "price": 120, "duration": "20 mins"},
      {"name": "Minor Surgery", "price": 350, "duration": "60 mins"},
      {"name": "Physical Exams", "price": 200, "duration": "45 mins"},
      {"name": "Chronic Disease Management", "price": 180, "duration": "40 mins"},
    ],
    "doctors": [
      {
        "id": "DOC001",
        "name": "Dr. Sarah Johnson",
        "specialty": "Family Medicine",
        "rating": 4.8,
        "experience": 12,
        "image": "https://picsum.photos/150/150?random=11&keyword=doctor",
        "available": true,
      },
      {
        "id": "DOC002", 
        "name": "Dr. Michael Brown",
        "specialty": "Internal Medicine",
        "rating": 4.7,
        "experience": 8,
        "image": "https://picsum.photos/150/150?random=12&keyword=doctor",
        "available": false,
      },
      {
        "id": "DOC003",
        "name": "Dr. Emily Davis", 
        "specialty": "Pediatrics",
        "rating": 4.9,
        "experience": 15,
        "image": "https://picsum.photos/150/150?random=13&keyword=doctor",
        "available": true,
      },
    ],
    "insurance": ["Blue Cross", "Aetna", "Medicare", "United Health"],
    "facilities": [
      "Digital X-Ray", "Laboratory", "Pharmacy", "Minor Surgery Suite",
      "EKG Machine", "Ultrasound", "Free WiFi", "Wheelchair Accessible"
    ],
    "gallery": [
      "https://picsum.photos/400/300?random=21&keyword=clinic",
      "https://picsum.photos/400/300?random=22&keyword=reception",
      "https://picsum.photos/400/300?random=23&keyword=examination",
      "https://picsum.photos/400/300?random=24&keyword=laboratory",
      "https://picsum.photos/400/300?random=25&keyword=waiting",
    ]
  };

  List<Map<String, dynamic>> reviews = [
    {
      "id": "REV001",
      "patientName": "Jennifer Wilson",
      "rating": 5,
      "date": "2024-03-18",
      "doctor": "Dr. Sarah Johnson",
      "review": "Excellent service! Dr. Johnson was very thorough and took time to explain everything. The staff was friendly and professional.",
    },
    {
      "id": "REV002",
      "patientName": "Robert Smith",
      "rating": 4,
      "date": "2024-03-15",
      "doctor": "Dr. Emily Davis",
      "review": "Great pediatrician for my kids. Very patient and good with children. The clinic is clean and well-organized.",
    },
    {
      "id": "REV003",
      "patientName": "Lisa Martinez",
      "rating": 5,
      "date": "2024-03-12",
      "doctor": "Dr. Michael Brown",
      "review": "Professional and efficient service. Easy to book appointments and minimal wait time. Highly recommend!",
    },
  ];

  List<Map<String, dynamic>> appointments = [
    {
      "date": "2024-03-25",
      "time": "9:00 AM",
      "doctor": "Dr. Sarah Johnson",
      "available": true,
    },
    {
      "date": "2024-03-25", 
      "time": "10:30 AM",
      "doctor": "Dr. Emily Davis",
      "available": true,
    },
    {
      "date": "2024-03-25",
      "time": "2:00 PM",
      "doctor": "Dr. Sarah Johnson",
      "available": false,
    },
    {
      "date": "2024-03-26",
      "time": "11:00 AM",
      "doctor": "Dr. Michael Brown",
      "available": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image and Info
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    "${clinic["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(150),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: spMd,
                  child: IconButton(
                    onPressed: () => back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withAlpha(100),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: spMd,
                  child: Row(
                    spacing: spXs,
                    children: [
                      IconButton(
                        onPressed: () {
                          isFavorite = !isFavorite;
                          setState(() {});
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? dangerColor : Colors.white,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black.withAlpha(100),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.share, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black.withAlpha(100),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: spMd,
                  left: spMd,
                  right: spMd,
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${clinic["name"]}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: clinic["openNow"] ? successColor : dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              clinic["openNow"] ? "Open Now" : "Closed",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${clinic["specialty"]}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 20,
                            color: warningColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${clinic["rating"]} (${clinic["reviews"]} reviews)",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${clinic["distance"]} km away",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Actions
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Book Appointment",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      QButton(
                        icon: Icons.call,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        icon: Icons.directions,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  // Quick Info Cards
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Icon(
                                Icons.schedule,
                                color: successColor,
                                size: 24,
                              ),
                              Text(
                                "${clinic["waitTime"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Wait Time",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Icon(
                                Icons.people,
                                color: primaryColor,
                                size: 24,
                              ),
                              Text(
                                "${clinic["doctors"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Doctors",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Icon(
                                Icons.event_available,
                                color: warningColor,
                                size: 24,
                              ),
                              Text(
                                "${clinic["nextAvailable"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Next Available",
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

                  // Clinic Information
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About the Clinic",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${clinic["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Established in ${clinic["establishedYear"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Contact Information
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
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
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${clinic["address"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${clinic["phone"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${clinic["email"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Operating Hours
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Operating Hours",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ...["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"].map((day) {
                          String dayName = day[0].toUpperCase() + day.substring(1);
                          String hours = clinic["hours"][day];
                          bool isToday = DateTime.now().weekday == ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"].indexOf(day) + 1;
                          
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: spXs),
                            decoration: BoxDecoration(
                              color: isToday ? primaryColor.withAlpha(10) : null,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  dayName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                    color: isToday ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  hours,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                    color: hours == "Closed" ? dangerColor : (isToday ? primaryColor : disabledBoldColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Services & Pricing
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Services & Pricing",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ...(clinic["services"] as List).map((service) {
                          return Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(5),
                              borderRadius: BorderRadius.circular(radiusXs),
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
                                          fontWeight: FontWeight.w500,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Duration: ${service["duration"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "\$${(service["price"] as int)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Our Doctors
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Our Doctors",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ...(clinic["doctors"] as List).map((doctor) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(5),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              spacing: spSm,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${doctor["image"]}",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: spXs,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${doctor["name"]}",
                                              style: TextStyle(
                                                fontSize: 14,
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
                                              color: doctor["available"] 
                                                  ? successColor.withAlpha(20)
                                                  : dangerColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              doctor["available"] ? "Available" : "Busy",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: doctor["available"] ? successColor : dangerColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${doctor["specialty"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 14,
                                            color: warningColor,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${doctor["rating"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: warningColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${doctor["experience"]} years exp.",
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
                                QButton(
                                  label: "Book",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Facilities & Amenities
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Facilities & Amenities",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (clinic["facilities"] as List).map((facility) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$facility",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Reviews Section
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Patient Reviews",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "Write Review",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        ...reviews.map((review) {
                          return Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(5),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${review["patientName"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                                          size: 16,
                                          color: warningColor,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${review["doctor"]} • ${DateTime.parse(review["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${review["review"]}",
                                  style: TextStyle(
                                    fontSize: 13,
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
