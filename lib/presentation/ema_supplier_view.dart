import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSupplierView extends StatefulWidget {
  const EmaSupplierView({super.key});

  @override
  State<EmaSupplierView> createState() => _EmaSupplierViewState();
}

class _EmaSupplierViewState extends State<EmaSupplierView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> suppliers = [
    {
      "id": 1,
      "companyName": "Premium Tent Rentals",
      "logo": "https://picsum.photos/80/80?random=401",
      "category": "Furniture & Equipment",
      "products": ["Event Tents", "Tables", "Chairs", "Staging Equipment"],
      "contactPerson": "Robert Mitchell",
      "email": "robert@premiumtents.com",
      "phone": "+1 555 0301",
      "rating": 4.8,
      "totalOrders": 180,
      "location": "Denver, CO",
      "minimumOrder": 500,
      "deliveryTime": "2-3 days",
      "status": "Active",
      "verified": true,
      "joinedDate": "2022-05-12",
      "description": "High-quality tent and furniture rental solutions for events of all sizes with nationwide delivery.",
      "specialOffers": ["Free delivery over \$1000", "10% discount for bulk orders"]
    },
    {
      "id": 2,
      "companyName": "Fresh Florals Wholesale",
      "logo": "https://picsum.photos/80/80?random=402",
      "category": "Decorations",
      "products": ["Fresh Flowers", "Artificial Plants", "Vases", "Centerpiece Supplies"],
      "contactPerson": "Emma Thompson",
      "email": "emma@freshflorals.com",
      "phone": "+1 555 0302",
      "rating": 4.9,
      "totalOrders": 320,
      "location": "Portland, OR",
      "minimumOrder": 200,
      "deliveryTime": "1-2 days",
      "status": "Active",
      "verified": true,
      "joinedDate": "2021-09-18",
      "description": "Fresh flower wholesale supplier specializing in wedding and event decorations with same-day delivery.",
      "specialOffers": ["Same-day delivery in metro areas", "Seasonal discount packages"]
    },
    {
      "id": 3,
      "companyName": "Tech Audio Supplies",
      "logo": "https://picsum.photos/80/80?random=403",
      "category": "Audio/Visual",
      "products": ["Sound Systems", "Microphones", "Projectors", "LED Screens"],
      "contactPerson": "Marcus Rodriguez",
      "email": "marcus@techaudiosupplies.com",
      "phone": "+1 555 0303",
      "rating": 4.6,
      "totalOrders": 95,
      "location": "Atlanta, GA",
      "minimumOrder": 1000,
      "deliveryTime": "3-5 days",
      "status": "Limited Stock",
      "verified": true,
      "joinedDate": "2023-02-28",
      "description": "Professional audio and visual equipment supplier with technical support and installation services.",
      "specialOffers": ["Free technical consultation", "Extended warranty on rentals"]
    },
    {
      "id": 4,
      "companyName": "Gourmet Catering Supplies",
      "logo": "https://picsum.photos/80/80?random=404",
      "category": "Food & Beverage",
      "products": ["Catering Equipment", "Serving Ware", "Kitchen Appliances", "Disposable Items"],
      "contactPerson": "Chef Maria Santos",
      "email": "maria@gourmetcateringsupplies.com",
      "phone": "+1 555 0304",
      "rating": 4.7,
      "totalOrders": 240,
      "location": "San Francisco, CA",
      "minimumOrder": 300,
      "deliveryTime": "1-3 days",
      "status": "Active",
      "verified": true,
      "joinedDate": "2022-11-07",
      "description": "Complete catering supply solutions with professional-grade equipment and eco-friendly options.",
      "specialOffers": ["Eco-friendly product line", "Volume pricing available"]
    },
    {
      "id": 5,
      "companyName": "Lighting Specialists Inc",
      "logo": "https://picsum.photos/80/80?random=405",
      "category": "Lighting",
      "products": ["LED Lighting", "String Lights", "Uplighting", "Dance Floor Lighting"],
      "contactPerson": "David Park",
      "email": "david@lightingspecialists.com",
      "phone": "+1 555 0305",
      "rating": 4.5,
      "totalOrders": 160,
      "location": "Phoenix, AZ",
      "minimumOrder": 400,
      "deliveryTime": "2-4 days",
      "status": "Active",
      "verified": false,
      "joinedDate": "2023-04-15",
      "description": "Innovative lighting solutions for events with custom design services and energy-efficient options.",
      "specialOffers": ["Custom lighting design", "Energy-efficient LED options"]
    },
    {
      "id": 6,
      "companyName": "Security Equipment Pro",
      "logo": "https://picsum.photos/80/80?random=406",
      "category": "Security",
      "products": ["Security Cameras", "Access Control", "Metal Detectors", "Communication Devices"],
      "contactPerson": "Officer John Davis",
      "email": "john@securityequipmentpro.com",
      "phone": "+1 555 0306",
      "rating": 4.4,
      "totalOrders": 75,
      "location": "Houston, TX",
      "minimumOrder": 800,
      "deliveryTime": "3-7 days",
      "status": "Temporarily Unavailable",
      "verified": true,
      "joinedDate": "2023-01-20",
      "description": "Professional security equipment rental and sales with 24/7 monitoring services available.",
      "specialOffers": ["24/7 monitoring services", "Professional installation included"]
    }
  ];

  List<String> categories = ["All", "Furniture & Equipment", "Decorations", "Audio/Visual", "Food & Beverage", "Lighting", "Security"];
  List<String> statusOptions = ["All", "Active", "Limited Stock", "Temporarily Unavailable"];

  List<Map<String, dynamic>> get filteredSuppliers {
    return suppliers.where((supplier) {
      bool matchesSearch = "${supplier["companyName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${supplier["contactPerson"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (supplier["products"] as List).any((product) => "$product".toLowerCase().contains(searchQuery.toLowerCase()));
      bool matchesCategory = selectedCategory == "All" || supplier["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || supplier["status"] == selectedStatus;
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Limited Stock":
        return warningColor;
      case "Temporarily Unavailable":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Furniture & Equipment":
        return Colors.brown;
      case "Decorations":
        return Colors.pink;
      case "Audio/Visual":
        return Colors.blue;
      case "Food & Beverage":
        return Colors.orange;
      case "Lighting":
        return Colors.yellow.shade700;
      case "Security":
        return Colors.red;
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
        title: Text("Supplier Network"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add supplier
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
                    label: "Search suppliers...",
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

            // Supplier Statistics
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
                    "Supplier Overview",
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
                              "${suppliers.where((s) => s["status"] == "Active").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Active",
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
                              "${suppliers.where((s) => s["verified"] == true).length}",
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
                              "${(suppliers.map((s) => s["rating"] as double).fold(0.0, (sum, rating) => sum + rating) / suppliers.length).toStringAsFixed(1)}",
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
                              "${suppliers.map((s) => s["totalOrders"] as int).fold(0, (sum, orders) => sum + orders)}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total Orders",
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

            // Featured Suppliers with Special Offers
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
                      Icon(Icons.local_offer, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Special Offers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: suppliers.where((s) => (s["specialOffers"] as List).isNotEmpty).map((supplier) {
                      final categoryColor = _getCategoryColor("${supplier["category"]}");
                      return Container(
                        width: 240,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: primaryColor.withAlpha(100)),
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
                                      "${supplier["logo"]}",
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
                                        "${supplier["companyName"]}",
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
                                          _buildRatingStars(supplier["rating"] as double),
                                          SizedBox(width: 4),
                                          Text(
                                            "${supplier["rating"]}",
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
                                "${supplier["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: categoryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (supplier["specialOffers"] as List).map((offer) => 
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.stars, size: 12, color: primaryColor),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "$offer",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Suppliers List
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
                        "All Suppliers (${filteredSuppliers.length})",
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
                    itemCount: filteredSuppliers.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final supplier = filteredSuppliers[index];
                      final categoryColor = _getCategoryColor("${supplier["category"]}");
                      final statusColor = _getStatusColor("${supplier["status"]}");
                      
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
                                      "${supplier["logo"]}",
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
                                              "${supplier["companyName"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          if (supplier["verified"] as bool)
                                            Icon(Icons.verified, size: 16, color: primaryColor),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: statusColor.withAlpha(30),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${supplier["status"]}",
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
                                              "${supplier["category"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: categoryColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          _buildRatingStars(supplier["rating"] as double),
                                          SizedBox(width: 4),
                                          Text(
                                            "${supplier["rating"]} (${supplier["totalOrders"]} orders)",
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
                                            "${supplier["contactPerson"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                          Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "${supplier["location"]}",
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
                                          Text(
                                            "Min order: \$${((supplier["minimumOrder"] as int).toDouble()).currency}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                          Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                          Text(
                                            "Delivery: ${supplier["deliveryTime"]}",
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
                                Column(
                                  children: [
                                    QButton(
                                      icon: Icons.visibility,
                                      size: bs.sm,
                                      onPressed: () {
                                        // View supplier details
                                      },
                                    ),
                                    SizedBox(height: spXs),
                                    QButton(
                                      icon: Icons.shopping_cart,
                                      size: bs.sm,
                                      onPressed: () {
                                        // Browse products
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
                                "${supplier["description"]}",
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
                              children: (supplier["products"] as List).map((product) => 
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$product",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                            
                            if ((supplier["specialOffers"] as List).isNotEmpty) ...[
                              SizedBox(height: spXs),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.local_offer, size: 12, color: primaryColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "Special Offers:",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    ...((supplier["specialOffers"] as List).map((offer) => 
                                      Text(
                                        "• $offer",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ).toList()),
                                  ],
                                ),
                              ),
                            ],
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
