import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSeedSuppliersView extends StatefulWidget {
  const AmaSeedSuppliersView({super.key});

  @override
  State<AmaSeedSuppliersView> createState() => _AmaSeedSuppliersViewState();
}

class _AmaSeedSuppliersViewState extends State<AmaSeedSuppliersView> {
  List<Map<String, dynamic>> suppliers = [
    {
      "id": 1,
      "name": "AgroSeeds Inc",
      "type": "Premium Seeds",
      "location": "Iowa, USA",
      "phone": "+1 515-555-0123",
      "email": "sales@agroseeds.com",
      "website": "www.agroseeds.com",
      "rating": 4.8,
      "reviews": 245,
      "yearsInBusiness": 15,
      "isVerified": true,
      "specialties": ["Corn", "Soybean", "Wheat"],
      "certifications": ["Organic", "Non-GMO", "ISO 9001"],
      "deliveryTime": "3-5 days",
      "minimumOrder": 100,
      "paymentTerms": "Net 30",
      "discount": 5,
      "image": "https://picsum.photos/80/80?random=1&keyword=agriculture",
      "description": "Leading supplier of high-quality hybrid seeds with proven genetics",
      "products": [
        {"name": "Golden Harvest Corn", "price": 285.00, "unit": "lb"},
        {"name": "Elite Soybean", "price": 165.00, "unit": "lb"},
        {"name": "Premium Wheat", "price": 95.50, "unit": "lb"}
      ],
      "lastOrder": "2024-03-15",
      "totalOrders": 24,
      "totalSpent": 12450.00
    },
    {
      "id": 2,
      "name": "GrainTech Seeds",
      "type": "Grain Specialist",
      "location": "Nebraska, USA",
      "phone": "+1 402-555-0156",
      "email": "info@graintech.com",
      "website": "www.graintech.com",
      "rating": 4.6,
      "reviews": 189,
      "yearsInBusiness": 22,
      "isVerified": true,
      "specialties": ["Wheat", "Barley", "Oats"],
      "certifications": ["Organic", "AOSCA"],
      "deliveryTime": "5-7 days",
      "minimumOrder": 250,
      "paymentTerms": "Net 15",
      "discount": 3,
      "image": "https://picsum.photos/80/80?random=2&keyword=seeds",
      "description": "Specialized in winter and spring grain varieties for all growing conditions",
      "products": [
        {"name": "Winter Wheat Elite", "price": 95.50, "unit": "lb"},
        {"name": "Spring Barley", "price": 120.00, "unit": "lb"},
        {"name": "Premium Oats", "price": 85.00, "unit": "lb"}
      ],
      "lastOrder": "2024-02-28",
      "totalOrders": 18,
      "totalSpent": 8750.00
    },
    {
      "id": 3,
      "name": "Bean Genetics Co",
      "type": "Legume Expert",
      "location": "Illinois, USA",
      "phone": "+1 217-555-0189",
      "email": "orders@beangenetics.com",
      "website": "www.beangenetics.com",
      "rating": 4.9,
      "reviews": 312,
      "yearsInBusiness": 28,
      "isVerified": true,
      "specialties": ["Soybean", "Black Bean", "Pinto Bean"],
      "certifications": ["Organic", "Non-GMO", "Fair Trade"],
      "deliveryTime": "2-4 days",
      "minimumOrder": 50,
      "paymentTerms": "Net 45",
      "discount": 8,
      "image": "https://picsum.photos/80/80?random=3&keyword=beans",
      "description": "Three generations of expertise in legume genetics and breeding",
      "products": [
        {"name": "Emerald Soybean", "price": 165.00, "unit": "lb"},
        {"name": "Premium Black Bean", "price": 195.00, "unit": "lb"},
        {"name": "Organic Pinto", "price": 175.00, "unit": "lb"}
      ],
      "lastOrder": "2024-03-20",
      "totalOrders": 31,
      "totalSpent": 15680.00
    },
    {
      "id": 4,
      "name": "VegSeeds Pro",
      "type": "Vegetable Seeds",
      "location": "California, USA",
      "phone": "+1 559-555-0234",
      "email": "contact@vegseedspro.com",
      "website": "www.vegseedspro.com",
      "rating": 4.4,
      "reviews": 156,
      "yearsInBusiness": 12,
      "isVerified": false,
      "specialties": ["Tomato", "Pepper", "Cucumber"],
      "certifications": ["Organic", "Heirloom"],
      "deliveryTime": "7-10 days",
      "minimumOrder": 25,
      "paymentTerms": "COD",
      "discount": 0,
      "image": "https://picsum.photos/80/80?random=4&keyword=vegetables",
      "description": "Specialty vegetable seeds for commercial and home growers",
      "products": [
        {"name": "Victory Tomato", "price": 425.00, "unit": "lb"},
        {"name": "Hot Pepper Mix", "price": 350.00, "unit": "lb"},
        {"name": "Garden Cucumber", "price": 280.00, "unit": "lb"}
      ],
      "lastOrder": "2024-01-15",
      "totalOrders": 8,
      "totalSpent": 3240.00
    },
    {
      "id": 5,
      "name": "Tuber Tech",
      "type": "Tuber Specialist",
      "location": "Idaho, USA",
      "phone": "+1 208-555-0167",
      "email": "sales@tubertech.com",
      "website": "www.tubertech.com",
      "rating": 4.7,
      "reviews": 98,
      "yearsInBusiness": 35,
      "isVerified": true,
      "specialties": ["Potato", "Sweet Potato", "Yam"],
      "certifications": ["Certified Seed", "Disease Free"],
      "deliveryTime": "1-3 days",
      "minimumOrder": 500,
      "paymentTerms": "Net 60",
      "discount": 10,
      "image": "https://picsum.photos/80/80?random=5&keyword=potatoes",
      "description": "Premium seed potatoes and tubers for commercial production",
      "products": [
        {"name": "Alpine Potato", "price": 315.00, "unit": "lb"},
        {"name": "Sweet Potato Slips", "price": 285.00, "unit": "lb"},
        {"name": "Purple Yam", "price": 395.00, "unit": "lb"}
      ],
      "lastOrder": "2024-03-10",
      "totalOrders": 12,
      "totalSpent": 9850.00
    }
  ];

  List<Map<String, dynamic>> filteredSuppliers = [];
  String selectedSpecialty = "All";
  String selectedCertification = "All";
  bool showVerifiedOnly = false;
  String searchQuery = "";

  List<String> specialtyOptions = ["All", "Corn", "Soybean", "Wheat", "Tomato", "Potato"];
  List<String> certificationOptions = ["All", "Organic", "Non-GMO", "ISO 9001", "AOSCA"];

  @override
  void initState() {
    super.initState();
    filteredSuppliers = suppliers;
  }

  void _filterSuppliers() {
    filteredSuppliers = suppliers.where((supplier) {
      bool matchesSpecialty = selectedSpecialty == "All" || 
          (supplier["specialties"] as List).contains(selectedSpecialty);
      bool matchesCertification = selectedCertification == "All" || 
          (supplier["certifications"] as List).contains(selectedCertification);
      bool matchesVerified = !showVerifiedOnly || supplier["isVerified"] == true;
      bool matchesSearch = searchQuery.isEmpty || 
          supplier["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          supplier["location"].toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesSpecialty && matchesCertification && matchesVerified && matchesSearch;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seed Suppliers"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add supplier
            },
          ),
          IconButton(
            icon: Icon(Icons.compare),
            onPressed: () {
              // Navigate to compare suppliers
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search suppliers",
              value: searchQuery,
              hint: "Search by name or location",
              onChanged: (value) {
                searchQuery = value;
                _filterSuppliers();
              },
            ),

            // Filters
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
                  Row(
                    children: [
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Specialty",
                          items: specialtyOptions.map((specialty) => {
                            "label": specialty,
                            "value": specialty,
                          }).toList(),
                          value: selectedSpecialty,
                          onChanged: (value, label) {
                            selectedSpecialty = value;
                            _filterSuppliers();
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Certification",
                          items: certificationOptions.map((cert) => {
                            "label": cert,
                            "value": cert,
                          }).toList(),
                          value: selectedCertification,
                          onChanged: (value, label) {
                            selectedCertification = value;
                            _filterSuppliers();
                          },
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show verified suppliers only",
                        "value": true,
                        "checked": showVerifiedOnly,
                      }
                    ],
                    value: [if (showVerifiedOnly) {"label": "Show verified suppliers only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showVerifiedOnly = values.isNotEmpty;
                      _filterSuppliers();
                    },
                  ),
                ],
              ),
            ),

            // Summary Cards
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${suppliers.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Suppliers",
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${suppliers.where((s) => s["isVerified"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${((suppliers.map((s) => (s["rating"] as double)).fold(0.0, (a, b) => a + b)) / suppliers.length).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
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
                ),
              ],
            ),

            // Suppliers List
            ...List.generate(filteredSuppliers.length, (index) {
              final supplier = filteredSuppliers[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: supplier["isVerified"] == true ? successColor.withAlpha(50) : disabledColor.withAlpha(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      spacing: spSm,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${supplier["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${supplier["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (supplier["isVerified"] == true)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.verified, size: 12, color: Colors.white),
                                          SizedBox(width: 2),
                                          Text(
                                            "Verified",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                "${supplier["type"]} • ${supplier["location"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  ...List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < (supplier["rating"] as double).floor()
                                          ? Icons.star
                                          : starIndex < (supplier["rating"] as double)
                                              ? Icons.star_half
                                              : Icons.star_border,
                                      color: warningColor,
                                      size: 16,
                                    );
                                  }),
                                  SizedBox(width: 4),
                                  Text(
                                    "${(supplier["rating"] as double).toStringAsFixed(1)} (${supplier["reviews"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${supplier["yearsInBusiness"]} years in business",
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

                    Text(
                      "${supplier["description"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Specialties
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (supplier["specialties"] as List).map((specialty) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: primaryColor.withAlpha(50)),
                          ),
                          child: Text(
                            "$specialty",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Certifications
                    if ((supplier["certifications"] as List).isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (supplier["certifications"] as List).map((cert) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: successColor.withAlpha(50)),
                            ),
                            child: Text(
                              "$cert",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    // Business Terms
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  "Delivery: ${supplier["deliveryTime"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Min Order: \$${((supplier["minimumOrder"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: infoColor.withAlpha(30),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  "Payment: ${supplier["paymentTerms"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if ((supplier["discount"] as int) > 0)
                                  Text(
                                    "Discount: ${supplier["discount"]}%",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: infoColor.withAlpha(30),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: 2,
                            children: [
                              Text(
                                "${supplier["totalOrders"]} orders",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${((supplier["totalSpent"] as double)).currency}",
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

                    // Contact Information
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: 2,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone, size: 14, color: primaryColor),
                              SizedBox(width: 4),
                              Text(
                                "${supplier["phone"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.email, size: 14, color: primaryColor),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${supplier["email"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.language, size: 14, color: primaryColor),
                              SizedBox(width: 4),
                              Text(
                                "${supplier["website"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              Spacer(),
                              if (supplier["lastOrder"] != null)
                                Text(
                                  "Last order: ${DateTime.parse(supplier["lastOrder"]).dMMMy}",
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

                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Products",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to supplier products
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Contact",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to contact supplier
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Order",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to place order
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            if (filteredSuppliers.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.business,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No suppliers found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
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
