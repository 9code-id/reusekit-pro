import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaVendorView extends StatefulWidget {
  const EmaVendorView({super.key});

  @override
  State<EmaVendorView> createState() => _EmaVendorViewState();
}

class _EmaVendorViewState extends State<EmaVendorView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> vendors = [
    {
      "id": 1,
      "companyName": "Elite Audio Solutions",
      "logo": "https://picsum.photos/80/80?random=301",
      "category": "Audio/Visual",
      "services": ["Sound Systems", "Microphones", "Audio Mixing", "Live Streaming"],
      "contactPerson": "Michael Anderson",
      "email": "michael@eliteaudiosolutions.com",
      "phone": "+1 555 0201",
      "rating": 4.8,
      "totalJobs": 45,
      "location": "New York, NY",
      "price": 2500,
      "priceType": "per event",
      "status": "Available",
      "verified": true,
      "joinedDate": "2023-03-15",
      "description": "Professional audio and visual equipment rental with expert technicians for events of all sizes."
    },
    {
      "id": 2,
      "companyName": "Gourmet Catering Co",
      "logo": "https://picsum.photos/80/80?random=302",
      "category": "Catering",
      "services": ["Fine Dining", "Buffet Service", "Cocktail Hours", "Dietary Accommodations"],
      "contactPerson": "Chef Isabella Rodriguez",
      "email": "isabella@gourmetcatering.com",
      "phone": "+1 555 0202",
      "rating": 4.9,
      "totalJobs": 120,
      "location": "Los Angeles, CA",
      "price": 75,
      "priceType": "per person",
      "status": "Available",
      "verified": true,
      "joinedDate": "2022-08-20",
      "description": "Award-winning catering service specializing in gourmet cuisine and exceptional presentation."
    },
    {
      "id": 3,
      "companyName": "Bloom & Blossom Florists",
      "logo": "https://picsum.photos/80/80?random=303",
      "category": "Decoration",
      "services": ["Floral Arrangements", "Centerpieces", "Bridal Bouquets", "Venue Decoration"],
      "contactPerson": "Sarah Chen",
      "email": "sarah@bloomblossom.com",
      "phone": "+1 555 0203",
      "rating": 4.7,
      "totalJobs": 85,
      "location": "Chicago, IL",
      "price": 800,
      "priceType": "per arrangement",
      "status": "Busy",
      "verified": true,
      "joinedDate": "2023-01-10",
      "description": "Creative floral designs and comprehensive decoration services for memorable events."
    },
    {
      "id": 4,
      "companyName": "Lens Masters Photography",
      "logo": "https://picsum.photos/80/80?random=304",
      "category": "Photography",
      "services": ["Event Photography", "Videography", "Photo Booth", "Live Streaming"],
      "contactPerson": "David Kim",
      "email": "david@lensmasters.com",
      "phone": "+1 555 0204",
      "rating": 4.6,
      "totalJobs": 200,
      "location": "Austin, TX",
      "price": 1200,
      "priceType": "per day",
      "status": "Available",
      "verified": true,
      "joinedDate": "2022-11-05",
      "description": "Professional photography and videography services capturing every moment of your special event."
    },
    {
      "id": 5,
      "companyName": "Secure Events Protection",
      "logo": "https://picsum.photos/80/80?random=305",
      "category": "Security",
      "services": ["Event Security", "Crowd Control", "VIP Protection", "Emergency Response"],
      "contactPerson": "Officer James Wilson",
      "email": "james@secureevents.com",
      "phone": "+1 555 0205",
      "rating": 4.5,
      "totalJobs": 75,
      "location": "Miami, FL",
      "price": 50,
      "priceType": "per hour",
      "status": "Available",
      "verified": true,
      "joinedDate": "2023-05-18",
      "description": "Professional security services ensuring safety and peace of mind for all event types."
    },
    {
      "id": 6,
      "companyName": "Transport Plus",
      "logo": "https://picsum.photos/80/80?random=306",
      "category": "Transportation",
      "services": ["Luxury Cars", "Party Buses", "Shuttle Service", "Airport Transfer"],
      "contactPerson": "Maria Gonzalez",
      "email": "maria@transportplus.com",
      "phone": "+1 555 0206",
      "rating": 4.4,
      "totalJobs": 95,
      "location": "Las Vegas, NV",
      "price": 150,
      "priceType": "per hour",
      "status": "Unavailable",
      "verified": false,
      "joinedDate": "2023-07-22",
      "description": "Reliable transportation solutions for guests and VIPs with luxury vehicle options."
    }
  ];

  List<String> categories = ["All", "Audio/Visual", "Catering", "Decoration", "Photography", "Security", "Transportation"];
  List<String> statusOptions = ["All", "Available", "Busy", "Unavailable"];

  List<Map<String, dynamic>> get filteredVendors {
    return vendors.where((vendor) {
      bool matchesSearch = "${vendor["companyName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${vendor["contactPerson"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (vendor["services"] as List).any((service) => "$service".toLowerCase().contains(searchQuery.toLowerCase()));
      bool matchesCategory = selectedCategory == "All" || vendor["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || vendor["status"] == selectedStatus;
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Busy":
        return warningColor;
      case "Unavailable":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Audio/Visual":
        return Colors.blue;
      case "Catering":
        return Colors.orange;
      case "Decoration":
        return Colors.pink;
      case "Photography":
        return Colors.purple;
      case "Security":
        return Colors.red;
      case "Transportation":
        return Colors.green;
      default:
        return primaryColor;
    }
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: 12, color: Colors.amber);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: 12, color: Colors.amber);
        } else {
          return Icon(Icons.star_border, size: 12, color: Colors.amber);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Directory"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add vendor
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search vendors...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QCategoryPicker(
                          label: "Category",
                          items: categories.map((category) => {
                            "label": category,
                            "value": category,
                          }).toList(),
                          value: selectedCategory,
                          onChanged: (index, label, value, item) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QCategoryPicker(
                          label: "Status",
                          items: statusOptions.map((status) => {
                            "label": status,
                            "value": status,
                          }).toList(),
                          value: selectedStatus,
                          onChanged: (index, label, value, item) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Vendor Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vendor Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${vendors.where((v) => v["status"] == "Available").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Available",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${vendors.where((v) => v["verified"] == true).length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Verified",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(vendors.map((v) => v["rating"] as double).fold(0.0, (sum, rating) => sum + rating) / vendors.length).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                            Text(
                              "Avg Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${vendors.map((v) => v["totalJobs"] as int).fold(0, (sum, jobs) => sum + jobs)}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total Jobs",
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
                ],
              ),
            ),

            // Featured Vendors
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Top Rated Vendors",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: vendors.where((v) => (v["rating"] as double) >= 4.7).map((vendor) {
                      final categoryColor = _getCategoryColor("${vendor["category"]}");
                      return Container(
                        width: 200,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(color: disabledOutlineBorderColor),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    child: Image.network(
                                      "${vendor["logo"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${vendor["companyName"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          _buildRatingStars(vendor["rating"] as double),
                                          SizedBox(width: 4),
                                          Text(
                                            "${vendor["rating"]}",
                                            style: TextStyle(
                                              fontSize: 10,
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
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: categoryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${vendor["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: categoryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${vendor["totalJobs"]} jobs completed",
                              style: TextStyle(
                                fontSize: 10,
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

            // Vendors List
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Text(
                        "All Vendors (${filteredVendors.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.sort, size: 20),
                        onPressed: () {
                          // Show sort options
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredVendors.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final vendor = filteredVendors[index];
                      final categoryColor = _getCategoryColor("${vendor["category"]}");
                      final statusColor = _getStatusColor("${vendor["status"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(color: disabledOutlineBorderColor),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      "${vendor["logo"]}",
                                      fit: BoxFit.cover,
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
                                          Expanded(
                                            child: Text(
                                              "${vendor["companyName"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          if (vendor["verified"] as bool)
                                            Icon(Icons.verified, size: 16, color: primaryColor),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: statusColor.withAlpha(30),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${vendor["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: statusColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: categoryColor.withAlpha(30),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${vendor["category"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: categoryColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          _buildRatingStars(vendor["rating"] as double),
                                          SizedBox(width: 4),
                                          Text(
                                            "${vendor["rating"]} (${vendor["totalJobs"]} jobs)",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Icon(Icons.person, size: 12, color: disabledBoldColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "${vendor["contactPerson"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                          Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "${vendor["location"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "\$${((vendor["price"] as int).toDouble()).currency} ${vendor["priceType"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    QButton(
                                      icon: Icons.visibility,
                                      size: bs.sm,
                                      onPressed: () {
                                        // View vendor details
                                      },
                                    ),
                                    SizedBox(height: spXs),
                                    QButton(
                                      icon: Icons.message,
                                      size: bs.sm,
                                      onPressed: () {
                                        // Contact vendor
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${vendor["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              runSpacing: 4,
                              children: (vendor["services"] as List).map((service) => 
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$service",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ],
                        ),
                      );
                    },
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
