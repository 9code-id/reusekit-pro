import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaProductComparisonView extends StatefulWidget {
  const SpaProductComparisonView({Key? key}) : super(key: key);

  @override
  State<SpaProductComparisonView> createState() => _SpaProductComparisonViewState();
}

class _SpaProductComparisonViewState extends State<SpaProductComparisonView> {
  List<Map<String, dynamic>> comparisonProducts = [
    {
      "id": 1,
      "name": "Hydrating Facial Treatment",
      "spa": "Luxury Spa & Wellness",
      "image": "https://picsum.photos/300/200?random=1&keyword=facial",
      "rating": 4.8,
      "reviews": 126,
      "price": 120.0,
      "originalPrice": 150.0,
      "duration": 60,
      "discount": 20,
      "category": "Facial",
      "benefits": ["Deep hydration", "Pore cleansing", "Anti-aging", "Brightening"],
      "ingredients": ["Hyaluronic acid", "Vitamin C", "Collagen", "Green tea extract"],
      "suitableFor": ["Dry skin", "Mature skin", "Sensitive skin"],
      "availability": "Available today",
      "therapist": "Sarah Johnson",
      "therapistRating": 4.9,
      "therapistExperience": "8 years",
      "location": "Downtown",
      "distance": "2.5 km",
      "features": {
        "organic": true,
        "crueltyFree": true,
        "hypoallergenic": true,
        "results": "Immediate",
        "painLevel": "None",
        "aftercare": "Simple",
      }
    },
    {
      "id": 2,
      "name": "Anti-Aging Facial",
      "spa": "Elite Beauty Center",
      "image": "https://picsum.photos/300/200?random=2&keyword=antiaging",
      "rating": 4.9,
      "reviews": 89,
      "price": 180.0,
      "originalPrice": 180.0,
      "duration": 90,
      "discount": 0,
      "category": "Facial",
      "benefits": ["Wrinkle reduction", "Firming", "Lifting", "Collagen boost"],
      "ingredients": ["Retinol", "Peptides", "Vitamin E", "Stem cells"],
      "suitableFor": ["Mature skin", "Fine lines", "Loss of elasticity"],
      "availability": "Available tomorrow",
      "therapist": "Maria Rodriguez",
      "therapistRating": 4.8,
      "therapistExperience": "12 years",
      "location": "Uptown",
      "distance": "4.2 km",
      "features": {
        "organic": false,
        "crueltyFree": true,
        "hypoallergenic": false,
        "results": "Progressive",
        "painLevel": "Mild",
        "aftercare": "Moderate",
      }
    },
    {
      "id": 3,
      "name": "Organic Skin Renewal",
      "spa": "Natural Spa Retreat",
      "image": "https://picsum.photos/300/200?random=3&keyword=organic",
      "rating": 4.7,
      "reviews": 203,
      "price": 95.0,
      "originalPrice": 115.0,
      "duration": 75,
      "discount": 15,
      "category": "Facial",
      "benefits": ["Natural renewal", "Detoxification", "Nourishment", "Glow enhancement"],
      "ingredients": ["Organic honey", "Aloe vera", "Chamomile", "Lavender oil"],
      "suitableFor": ["All skin types", "Sensitive skin", "Natural preference"],
      "availability": "Available now",
      "therapist": "Emma Thompson",
      "therapistRating": 4.7,
      "therapistExperience": "6 years",
      "location": "Suburbs",
      "distance": "6.8 km",
      "features": {
        "organic": true,
        "crueltyFree": true,
        "hypoallergenic": true,
        "results": "Gradual",
        "painLevel": "None",
        "aftercare": "Simple",
      }
    },
  ];

  int selectedComparison = 0;
  bool showFullComparison = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compare Treatments"),
        actions: [
          QButton(
            icon: Icons.bookmark_add,
            size: bs.sm,
            onPressed: () {
              ss("Comparison saved to favorites");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Comparison Toggle
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                QButton(
                  label: showFullComparison ? "Quick View" : "Full Comparison",
                  size: bs.sm,
                  color: secondaryColor,
                  icon: showFullComparison ? Icons.visibility : Icons.compare,
                  onPressed: () {
                    showFullComparison = !showFullComparison;
                    setState(() {});
                  },
                ),
                Spacer(),
                Text(
                  "${comparisonProducts.length} treatments",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: showFullComparison 
                ? _buildFullComparison()
                : _buildQuickComparison(),
          ),

          // Bottom Action Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add More",
                    size: bs.md,
                    color: secondaryColor,
                    icon: Icons.add,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Book Selected",
                    size: bs.md,
                    onPressed: () {
                      _showBookingDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullComparison() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Products Header
          _buildProductsHeader(),
          
          // Basic Information
          _buildComparisonSection(
            title: "Basic Information",
            children: [
              _buildComparisonRow("Price", (product) {
                if ((product["discount"] as int) > 0) {
                  return Column(
                    children: [
                      Text(
                        "\$${(product["originalPrice"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        "\$${(product["price"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  );
                }
                return Text(
                  "\$${(product["price"] as double).toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                );
              }),
              _buildComparisonRow("Duration", (product) {
                return Text(
                  "${product["duration"]} min",
                  style: TextStyle(fontSize: 14),
                );
              }),
              _buildComparisonRow("Rating", (product) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${product["rating"]} (${product["reviews"]})",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                );
              }),
              _buildComparisonRow("Availability", (product) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${product["availability"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ],
          ),

          // Therapist Information
          _buildComparisonSection(
            title: "Therapist",
            children: [
              _buildComparisonRow("Name", (product) {
                return Text(
                  "${product["therapist"]}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                );
              }),
              _buildComparisonRow("Experience", (product) {
                return Text(
                  "${product["therapistExperience"]}",
                  style: TextStyle(fontSize: 14),
                );
              }),
              _buildComparisonRow("Rating", (product) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${product["therapistRating"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                );
              }),
            ],
          ),

          // Location
          _buildComparisonSection(
            title: "Location",
            children: [
              _buildComparisonRow("Area", (product) {
                return Text(
                  "${product["location"]}",
                  style: TextStyle(fontSize: 14),
                );
              }),
              _buildComparisonRow("Distance", (product) {
                return Text(
                  "${product["distance"]}",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                );
              }),
            ],
          ),

          // Benefits
          _buildComparisonSection(
            title: "Key Benefits",
            children: [
              _buildComparisonRow("Benefits", (product) {
                return Column(
                  children: (product["benefits"] as List<String>).map((benefit) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, color: successColor, size: 14),
                          SizedBox(width: spXs),
                          Flexible(
                            child: Text(
                              benefit,
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),

          // Features
          _buildComparisonSection(
            title: "Features",
            children: [
              _buildComparisonRow("Organic", (product) {
                bool isOrganic = product["features"]["organic"] as bool;
                return Icon(
                  isOrganic ? Icons.check_circle : Icons.cancel,
                  color: isOrganic ? successColor : dangerColor,
                  size: 20,
                );
              }),
              _buildComparisonRow("Cruelty Free", (product) {
                bool isCrueltyFree = product["features"]["crueltyFree"] as bool;
                return Icon(
                  isCrueltyFree ? Icons.check_circle : Icons.cancel,
                  color: isCrueltyFree ? successColor : dangerColor,
                  size: 20,
                );
              }),
              _buildComparisonRow("Hypoallergenic", (product) {
                bool isHypoallergenic = product["features"]["hypoallergenic"] as bool;
                return Icon(
                  isHypoallergenic ? Icons.check_circle : Icons.cancel,
                  color: isHypoallergenic ? successColor : dangerColor,
                  size: 20,
                );
              }),
              _buildComparisonRow("Pain Level", (product) {
                String painLevel = product["features"]["painLevel"];
                Color color = painLevel == "None" ? successColor : 
                             painLevel == "Mild" ? warningColor : dangerColor;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    painLevel,
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ],
          ),

          // Suitable For
          _buildComparisonSection(
            title: "Suitable For",
            children: [
              _buildComparisonRow("Skin Types", (product) {
                return Column(
                  children: (product["suitableFor"] as List<String>).map((type) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickComparison() {
    return SingleChildScrollView(
      child: Column(
        children: comparisonProducts.map((product) {
          return Container(
            margin: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Product Image and Basic Info
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(radiusMd),
                      ),
                      child: Image.network(
                        "${product["image"]}",
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${product["spa"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${product["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  " (${product["reviews"]})",
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
                                if ((product["discount"] as int) > 0) ...[
                                  Text(
                                    "\$${(product["originalPrice"] as double).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                ],
                                Text(
                                  "\$${(product["price"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${product["duration"]} min",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Quick Features
                Container(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickFeature(
                        Icons.eco,
                        "Organic",
                        product["features"]["organic"] as bool,
                      ),
                      _buildQuickFeature(
                        Icons.favorite,
                        "Cruelty Free",
                        product["features"]["crueltyFree"] as bool,
                      ),
                      _buildQuickFeature(
                        Icons.health_and_safety,
                        "Hypoallergenic",
                        product["features"]["hypoallergenic"] as bool,
                      ),
                    ],
                  ),
                ),

                // Action Button
                Container(
                  padding: EdgeInsets.all(spSm),
                  child: QButton(
                    label: "Book This Treatment",
                    size: bs.sm,
                    onPressed: () {
                      _bookTreatment(product);
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductsHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Row(
        children: comparisonProducts.map((product) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: spXs),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${product["image"]}",
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${product["name"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${product["spa"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildComparisonSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, Widget Function(Map<String, dynamic>) builder) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          ...comparisonProducts.map((product) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: spXs),
                child: builder(product),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildQuickFeature(IconData icon, String label, bool isAvailable) {
    return Column(
      children: [
        Icon(
          icon,
          color: isAvailable ? successColor : disabledColor,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isAvailable ? successColor : disabledColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showBookingDialog() {
    // Show booking dialog
    si("Select a treatment to book from the comparison");
  }

  void _bookTreatment(Map<String, dynamic> product) {
    ss("Booking ${product["name"]} at ${product["spa"]}");
  }
}
