import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsServicePackagesView extends StatefulWidget {
  const BrsServicePackagesView({super.key});

  @override
  State<BrsServicePackagesView> createState() => _BrsServicePackagesViewState();
}

class _BrsServicePackagesViewState extends State<BrsServicePackagesView> {
  int selectedPackage = 0;
  String selectedCategory = "all";

  List<Map<String, dynamic>> categories = [
    {"label": "All Packages", "value": "all"},
    {"label": "Premium", "value": "premium"},
    {"label": "Standard", "value": "standard"},
    {"label": "Basic", "value": "basic"},
  ];

  List<Map<String, dynamic>> packages = [
    {
      "id": 1,
      "name": "The Gentleman's Complete",
      "category": "premium",
      "price": 150000,
      "originalPrice": 200000,
      "duration": 120,
      "rating": 4.9,
      "reviews": 128,
      "image": "https://picsum.photos/300/200?random=1&keyword=haircut",
      "services": [
        "Premium Haircut & Styling",
        "Beard Trim & Shaping",
        "Hot Towel Treatment",
        "Hair Wash & Conditioning",
        "Face Massage",
        "Aftershave Application"
      ],
      "features": [
        "Complimentary Beverage",
        "Premium Products Used",
        "Extended Session Time",
        "Personal Grooming Consultation"
      ],
      "badge": "Most Popular",
      "badgeColor": "primary",
      "isPopular": true,
    },
    {
      "id": 2,
      "name": "Classic Barber Experience",
      "category": "standard",
      "price": 85000,
      "originalPrice": 110000,
      "duration": 75,
      "rating": 4.7,
      "reviews": 96,
      "image": "https://picsum.photos/300/200?random=2&keyword=barbershop",
      "services": [
        "Classic Haircut",
        "Beard Trim",
        "Hair Wash",
        "Basic Styling"
      ],
      "features": [
        "Quality Products",
        "Professional Service",
        "Clean Environment"
      ],
      "badge": "Best Value",
      "badgeColor": "success",
      "isPopular": false,
    },
    {
      "id": 3,
      "name": "Quick & Fresh",
      "category": "basic",
      "price": 45000,
      "originalPrice": 60000,
      "duration": 45,
      "rating": 4.5,
      "reviews": 74,
      "image": "https://picsum.photos/300/200?random=3&keyword=haircut",
      "services": [
        "Basic Haircut",
        "Hair Wash",
        "Quick Dry"
      ],
      "features": [
        "Fast Service",
        "Budget Friendly",
        "No Appointment Needed"
      ],
      "badge": "",
      "badgeColor": "",
      "isPopular": false,
    },
    {
      "id": 4,
      "name": "Executive Grooming",
      "category": "premium",
      "price": 180000,
      "originalPrice": 230000,
      "duration": 150,
      "rating": 4.8,
      "reviews": 89,
      "image": "https://picsum.photos/300/200?random=4&keyword=executive",
      "services": [
        "Executive Haircut",
        "Precision Beard Sculpting",
        "Eyebrow Trimming",
        "Nose Hair Trimming",
        "Premium Hair Treatment",
        "Scalp Massage",
        "Styling with Premium Products"
      ],
      "features": [
        "VIP Treatment",
        "Private Room Available",
        "Premium Product Selection",
        "Grooming Advice",
        "Complimentary Refreshments"
      ],
      "badge": "VIP",
      "badgeColor": "warning",
      "isPopular": false,
    },
    {
      "id": 5,
      "name": "Student Special",
      "category": "basic",
      "price": 35000,
      "originalPrice": 50000,
      "duration": 30,
      "rating": 4.3,
      "reviews": 52,
      "image": "https://picsum.photos/300/200?random=5&keyword=student",
      "services": [
        "Student Haircut",
        "Basic Wash"
      ],
      "features": [
        "Student Discount",
        "Valid Student ID Required",
        "Modern Styles"
      ],
      "badge": "Student Offer",
      "badgeColor": "info",
      "isPopular": false,
    },
    {
      "id": 6,
      "name": "Weekend Warrior",
      "category": "standard",
      "price": 95000,
      "originalPrice": 120000,
      "duration": 90,
      "rating": 4.6,
      "reviews": 67,
      "image": "https://picsum.photos/300/200?random=6&keyword=weekend",
      "services": [
        "Trendy Haircut",
        "Beard Styling",
        "Hair Wash & Condition",
        "Blow Dry & Style"
      ],
      "features": [
        "Weekend Availability",
        "Flexible Timing",
        "Modern Techniques"
      ],
      "badge": "",
      "badgeColor": "",
      "isPopular": false,
    },
  ];

  List<Map<String, dynamic>> get filteredPackages {
    if (selectedCategory == "all") return packages;
    return packages.where((package) => package["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Packages"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            child: QHorizontalScroll(
              children: List.generate(categories.length, (index) {
                final category = categories[index];
                final isSelected = selectedCategory == category["value"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? spMd : spXs,
                      right: index == categories.length - 1 ? spMd : spXs,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      "${category["label"]}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Packages List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredPackages.length,
              itemBuilder: (context, index) {
                final package = filteredPackages[index];
                return _buildPackageCard(package);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(Map<String, dynamic> package) {
    Color getBadgeColor() {
      switch (package["badgeColor"]) {
        case "primary":
          return primaryColor;
        case "success":
          return successColor;
        case "warning":
          return warningColor;
        case "info":
          return infoColor;
        default:
          return primaryColor;
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: (package["isPopular"] as bool) ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image & Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: Image.network(
                    "${package["image"]}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              
              if (package["badge"].isNotEmpty)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: getBadgeColor(),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${package["badge"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              // Discount Badge
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${(((package["originalPrice"] as int) - (package["price"] as int)) / (package["originalPrice"] as int) * 100).round()}% OFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Package Name & Rating
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${package["name"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${package["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "(${package["reviews"]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                // Duration
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${package["duration"]} minutes",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Services
                Text(
                  "Services Included:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                Column(
                  children: List.generate(
                    (package["services"] as List).length > 3 ? 3 : (package["services"] as List).length,
                    (index) {
                      final service = (package["services"] as List)[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, size: 16, color: successColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "$service",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                if ((package["services"] as List).length > 3)
                  Text(
                    "+${(package["services"] as List).length - 3} more services",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                
                SizedBox(height: spSm),
                
                // Price & Book Button
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rp ${(package["originalPrice"] as int).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          "Rp ${(package["price"] as int).currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Spacer(),
                    
                    QButton(
                      label: "Book Now",
                      size: bs.sm,
                      onPressed: () {
                        ss("Package booking initiated");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
