import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaPharmacyDetailView extends StatefulWidget {
  const MhaPharmacyDetailView({super.key});

  @override
  State<MhaPharmacyDetailView> createState() => _MhaPharmacyDetailViewState();
}

class _MhaPharmacyDetailViewState extends State<MhaPharmacyDetailView> {
  final pharmacy = {
    "id": "ph001",
    "name": "HealthCare Pharmacy",
    "rating": 4.8,
    "reviews": 1247,
    "distance": 1.2,
    "address": "123 Health Street, Medical District, City Center 12345",
    "phone": "+1 234-567-8900",
    "email": "info@healthcarepharmacy.com",
    "hours": "Open 24/7",
    "services": [
      {"name": "Prescription Filling", "icon": Icons.medication, "available": true},
      {"name": "Online Consultation", "icon": Icons.video_call, "available": true},
      {"name": "Home Delivery", "icon": Icons.delivery_dining, "available": true},
      {"name": "Vaccination", "icon": Icons.vaccines, "available": true},
      {"name": "Health Screening", "icon": Icons.health_and_safety, "available": true},
      {"name": "Medicine Counseling", "icon": Icons.support_agent, "available": false}
    ],
    "featured_medicines": [
      {
        "name": "Paracetamol 500mg",
        "price": 12.99,
        "stock": "In Stock",
        "image": "https://picsum.photos/80/80?random=1&keyword=medicine"
      },
      {
        "name": "Vitamin D3 1000IU",
        "price": 24.99,
        "stock": "In Stock", 
        "image": "https://picsum.photos/80/80?random=2&keyword=medicine"
      },
      {
        "name": "Omega-3 Fish Oil",
        "price": 18.99,
        "stock": "Low Stock",
        "image": "https://picsum.photos/80/80?random=3&keyword=medicine"
      }
    ],
    "categories": [
      {"name": "Prescription", "count": 156, "icon": Icons.receipt},
      {"name": "Over Counter", "count": 342, "icon": Icons.shopping_cart},
      {"name": "Vitamins", "count": 89, "icon": Icons.local_pharmacy},
      {"name": "Personal Care", "count": 124, "icon": Icons.face},
      {"name": "First Aid", "count": 67, "icon": Icons.medical_services},
      {"name": "Baby Care", "count": 45, "icon": Icons.child_care}
    ],
    "reviews_list": [
      {
        "name": "Sarah Johnson",
        "rating": 5.0,
        "comment": "Excellent service and very knowledgeable pharmacists. Always available to help.",
        "date": "2024-01-15",
        "verified": true
      },
      {
        "name": "Michael Chen",
        "rating": 4.5,
        "comment": "Great pharmacy with quick service. Home delivery is very convenient.",
        "date": "2024-01-10",
        "verified": true
      }
    ],
    "images": [
      "https://picsum.photos/400/300?random=10&keyword=pharmacy",
      "https://picsum.photos/400/300?random=11&keyword=pharmacy",
      "https://picsum.photos/400/300?random=12&keyword=pharmacy"
    ]
  };

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pharmacy Details"),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pharmacy Image
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                "${(pharmacy["images"] as List)[0]}",
                fit: BoxFit.cover,
              ),
            ),

            // Basic Info
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${pharmacy["name"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "${pharmacy["rating"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "(${pharmacy["reviews"]} reviews)",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.location_on, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${pharmacy["distance"]} km",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${pharmacy["hours"]}",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Call Now",
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Get Directions",
                      icon: Icons.directions,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Services
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Services Available",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 150,
                    children: (pharmacy["services"] as List).map((service) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (service["available"] as bool) 
                              ? successColor.withAlpha(10) 
                              : disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: (service["available"] as bool) 
                                ? successColor.withAlpha(30) 
                                : disabledColor.withAlpha(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              service["icon"] as IconData,
                              size: 32,
                              color: (service["available"] as bool) 
                                  ? successColor 
                                  : disabledBoldColor,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${service["name"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (service["available"] as bool) 
                                    ? successColor 
                                    : disabledBoldColor,
                              ),
                            ),
                            if (!(service["available"] as bool))
                              Container(
                                margin: EdgeInsets.only(top: spXs),
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Not Available",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
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

            // Medicine Categories
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Medicine Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 160,
                    children: (pharmacy["categories"] as List).map((category) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                size: 20,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${category["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${category["count"]} items",
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
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Featured Medicines
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Featured Medicines",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: (pharmacy["featured_medicines"] as List).map((medicine) {
                      return Container(
                        width: 140,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusXs),
                                image: DecorationImage(
                                  image: NetworkImage("${medicine["image"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${medicine["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${medicine["price"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: medicine["stock"] == "In Stock" 
                                    ? successColor.withAlpha(20) 
                                    : warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${medicine["stock"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: medicine["stock"] == "In Stock" 
                                      ? successColor 
                                      : warningColor,
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

            // Contact Information
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
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
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${pharmacy["address"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.phone, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "${pharmacy["phone"]}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.email, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "${pharmacy["email"]}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Reviews Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Customer Reviews",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...(pharmacy["reviews_list"] as List).map((review) {
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
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: primaryColor.withAlpha(20),
                                child: Text(
                                  "${review["name"]}"[0],
                                  style: TextStyle(
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
                                          "${review["name"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (review["verified"] as bool) ...[
                                          SizedBox(width: spXs),
                                          Icon(
                                            Icons.verified,
                                            size: 16,
                                            color: successColor,
                                          ),
                                        ],
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ...List.generate(5, (index) {
                                          return Icon(
                                            index < (review["rating"] as double).floor()
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 14,
                                            color: warningColor,
                                          );
                                        }),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${review["date"]}",
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
                          SizedBox(height: spSm),
                          Text(
                            "${review["comment"]}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: spLg),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Browse Medicines",
                size: bs.md,
                onPressed: () {},
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Order Online",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
