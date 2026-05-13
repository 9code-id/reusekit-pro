import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBarberDetailView extends StatefulWidget {
  const BrsBarberDetailView({super.key});

  @override
  State<BrsBarberDetailView> createState() => _BrsBarberDetailViewState();
}

class _BrsBarberDetailViewState extends State<BrsBarberDetailView> {
  int currentTab = 0;

  final Map<String, dynamic> barber = {
    "id": "1",
    "name": "Michael Rodriguez",
    "title": "Senior Barber",
    "image": "https://picsum.photos/300/300?random=1&keyword=barber",
    "rating": 4.8,
    "totalReviews": 124,
    "experience": "8 years",
    "specialty": "Classic Cuts & Beard Styling",
    "phone": "+1 (555) 123-4567",
    "email": "michael@barbershop.com",
    "workingHours": "Mon-Sat: 9:00 AM - 7:00 PM",
    "isAvailable": true,
    "nextAvailable": "Today at 2:30 PM",
  };

  final List<Map<String, dynamic>> services = [
    {
      "name": "Classic Haircut",
      "price": 35.0,
      "duration": 45,
      "description": "Traditional haircut with styling",
    },
    {
      "name": "Beard Trim",
      "price": 20.0,
      "duration": 30,
      "description": "Precise beard shaping and trimming",
    },
    {
      "name": "Hot Towel Shave",
      "price": 45.0,
      "duration": 60,
      "description": "Luxurious traditional shave experience",
    },
    {
      "name": "Hair Wash & Style",
      "price": 25.0,
      "duration": 30,
      "description": "Deep cleanse with professional styling",
    },
  ];

  final List<Map<String, dynamic>> reviews = [
    {
      "customerName": "John Smith",
      "rating": 5.0,
      "date": "2024-06-10",
      "comment": "Excellent service! Michael really knows his craft. Best haircut I've had in years.",
      "service": "Classic Haircut",
    },
    {
      "customerName": "David Wilson",
      "rating": 4.5,
      "date": "2024-06-08",
      "comment": "Great attention to detail. Very professional and friendly.",
      "service": "Beard Trim",
    },
    {
      "customerName": "Robert Brown",
      "rating": 5.0,
      "date": "2024-06-05",
      "comment": "Amazing hot towel shave! Felt like royalty. Will definitely come back.",
      "service": "Hot Towel Shave",
    },
    {
      "customerName": "Mark Davis",
      "rating": 4.8,
      "date": "2024-06-02",
      "comment": "Michael is very skilled and takes his time to get everything perfect.",
      "service": "Classic Haircut",
    },
  ];

  final List<String> portfolio = [
    "https://picsum.photos/200/200?random=10&keyword=haircut",
    "https://picsum.photos/200/200?random=11&keyword=beard",
    "https://picsum.photos/200/200?random=12&keyword=style",
    "https://picsum.photos/200/200?random=13&keyword=hair",
    "https://picsum.photos/200/200?random=14&keyword=barber",
    "https://picsum.photos/200/200?random=15&keyword=cut",
  ];

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : 
          index < rating ? Icons.star_half : Icons.star_border,
          color: warningColor,
          size: 16,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barber Profile"),
        actions: [
          QButton(
            icon: Icons.favorite_border,
            size: bs.sm,
            onPressed: () {
              ss("Added to favorites!");
            },
          ),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              ss("Profile shared!");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  spacing: spMd,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Image.network(
                        "${barber["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${barber["name"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${barber["title"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              _buildStarRating(barber["rating"] as double),
                              SizedBox(width: spXs),
                              Text(
                                "${barber["rating"]} (${barber["totalReviews"]} reviews)",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${barber["experience"]} experience",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // Status and Quick Actions
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: barber["isAvailable"] 
                              ? successColor.withAlpha(20) 
                              : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              barber["isAvailable"] ? Icons.check_circle : Icons.schedule,
                              color: barber["isAvailable"] ? successColor : dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              barber["isAvailable"] ? "Available" : "Busy",
                              style: TextStyle(
                                color: barber["isAvailable"] ? successColor : dangerColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: QButton(
                        label: "Book Appointment",
                        size: bs.md,
                        onPressed: () {
                          ss("Redirecting to booking...");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: QTabBar(
              withoutAppBar: true,
              selectedIndex: currentTab,
              tabs: [
                Tab(text: "Services", icon: Icon(Icons.content_cut)),
                Tab(text: "Reviews", icon: Icon(Icons.star)),
                Tab(text: "Portfolio", icon: Icon(Icons.photo_library)),
                Tab(text: "About", icon: Icon(Icons.info)),
              ],
              tabChildren: [
                // Services Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Available Services",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      ...services.map((service) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spMd),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${service["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(service["price"] as double).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${service["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        color: disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${service["duration"]} minutes",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  QButton(
                                    label: "Book Now",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Booking ${service["name"]}...");
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
                ),

                // Reviews Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Customer Reviews",
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
                              si("Opening review form...");
                            },
                          ),
                        ],
                      ),
                      
                      // Rating Summary
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${barber["rating"]}",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                _buildStarRating(barber["rating"] as double),
                                Text(
                                  "${barber["totalReviews"]} reviews",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                children: List.generate(5, (index) {
                                  final starCount = 5 - index;
                                  final percentage = (starCount / 5.0) * 0.8;
                                  return Row(
                                    children: [
                                      Text(
                                        "$starCount",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 12,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: disabledColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: FractionallySizedBox(
                                            widthFactor: percentage,
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: warningColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Individual Reviews
                      ...reviews.map((review) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spMd),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${review["customerName"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${review["date"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  _buildStarRating(review["rating"] as double),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${review["service"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${review["comment"]}",
                                style: TextStyle(
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

                // Portfolio Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Work Portfolio",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      ResponsiveGridView(
                        minItemWidth: 150,
                        children: portfolio.map((imageUrl) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusMd),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                height: 150,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // About Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "About ${barber["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Professional Information",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Experience",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                                Text(
                                  "${barber["experience"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Specialty",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                                Expanded(
                                  child: Text(
                                    "${barber["specialty"]}",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Working Hours",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                                Text(
                                  "${barber["workingHours"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Contact Information",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
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
                                  "${barber["phone"]}",
                                  style: TextStyle(color: disabledBoldColor),
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
                                  "${barber["email"]}",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: successColor.withAlpha(50)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Next Available",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${barber["nextAvailable"]}",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Call Now",
                              icon: Icons.phone,
                              size: bs.md,
                              onPressed: () {
                                ss("Calling ${barber["name"]}...");
                              },
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Send Message",
                              icon: Icons.message,
                              size: bs.md,
                              onPressed: () {
                                si("Opening chat...");
                              },
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
        ],
      ),
    );
  }
}
