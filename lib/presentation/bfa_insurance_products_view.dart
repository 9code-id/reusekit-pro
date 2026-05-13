import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaInsuranceProductsView extends StatefulWidget {
  const BfaInsuranceProductsView({super.key});

  @override
  State<BfaInsuranceProductsView> createState() => _BfaInsuranceProductsViewState();
}

class _BfaInsuranceProductsViewState extends State<BfaInsuranceProductsView> {
  String selectedCategory = "All";
  List<Map<String, dynamic>> insuranceProducts = [
    {
      "id": 1,
      "name": "Life Insurance Plus",
      "category": "Life",
      "coverage": "Up to \$1,000,000",
      "premium": 250.0,
      "period": "Monthly",
      "rating": 4.8,
      "icon": Icons.favorite,
      "color": Colors.red,
      "features": ["Family Protection", "Investment Returns", "Tax Benefits"],
      "description": "Comprehensive life insurance with investment benefits"
    },
    {
      "id": 2,
      "name": "Health Shield Pro",
      "category": "Health",
      "coverage": "Up to \$500,000",
      "premium": 180.0,
      "period": "Monthly",
      "rating": 4.9,
      "icon": Icons.local_hospital,
      "color": Colors.blue,
      "features": ["Hospital Coverage", "Outpatient Care", "Dental & Vision"],
      "description": "Complete health protection for you and your family"
    },
    {
      "id": 3,
      "name": "Auto Protect 360",
      "category": "Car",
      "coverage": "Up to \$100,000",
      "premium": 120.0,
      "period": "Monthly",
      "rating": 4.7,
      "icon": Icons.directions_car,
      "color": Colors.green,
      "features": ["Collision Coverage", "Theft Protection", "Roadside Assistance"],
      "description": "Comprehensive car insurance with 24/7 support"
    },
    {
      "id": 4,
      "name": "Travel Guardian",
      "category": "Travel",
      "coverage": "Up to \$250,000",
      "premium": 45.0,
      "period": "Per Trip",
      "rating": 4.6,
      "icon": Icons.flight,
      "color": Colors.orange,
      "features": ["Medical Emergency", "Trip Cancellation", "Baggage Loss"],
      "description": "Complete travel protection for domestic and international trips"
    },
    {
      "id": 5,
      "name": "Home Secure Plus",
      "category": "Home",
      "coverage": "Up to \$800,000",
      "premium": 300.0,
      "period": "Monthly",
      "rating": 4.8,
      "icon": Icons.home,
      "color": Colors.purple,
      "features": ["Property Damage", "Personal Belongings", "Liability Coverage"],
      "description": "Protect your home and belongings with comprehensive coverage"
    },
    {
      "id": 6,
      "name": "Business Shield",
      "category": "Business",
      "coverage": "Up to \$2,000,000",
      "premium": 500.0,
      "period": "Monthly",
      "rating": 4.7,
      "icon": Icons.business,
      "color": Colors.teal,
      "features": ["General Liability", "Property Coverage", "Workers Compensation"],
      "description": "Comprehensive business insurance for small to medium enterprises"
    },
  ];

  List<String> categories = ["All", "Life", "Health", "Car", "Travel", "Home", "Business"];

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == "All") {
      return insuranceProducts;
    }
    return insuranceProducts.where((product) => product["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Products"),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Find Your Perfect",
                          style: TextStyle(
                            fontSize: fsH5,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Insurance Plan",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Protect what matters most with our comprehensive insurance solutions",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(230),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.security,
                    size: 60,
                    color: Colors.white.withAlpha(180),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QHorizontalScroll(
              children: List.generate(categories.length, (index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: spLg),

            // Products Grid
            Text(
              "Available Products (${filteredProducts.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredProducts.map((product) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Header
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: (product["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: product["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                product["icon"] as IconData,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${product["category"]} Insurance",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${product["rating"]}",
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
                      ),

                      // Product Details
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),

                            // Coverage Amount
                            Row(
                              children: [
                                Icon(
                                  Icons.shield,
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Coverage: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${product["coverage"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),

                            // Premium Amount
                            Row(
                              children: [
                                Icon(
                                  Icons.payments,
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Premium: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((product["premium"] as double).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "/${product["period"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),

                            // Features
                            Text(
                              "Key Features:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(product["features"] as List).take(2).map((feature) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: successColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "$feature",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),

                            SizedBox(height: spMd),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Learn More",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Navigate to product details
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: primaryColor,
                                      size: 18,
                                    ),
                                    onPressed: () {},
                                    padding: EdgeInsets.all(spXs),
                                    constraints: BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Bottom CTA Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    size: 48,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Need Help Choosing?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Our insurance experts are here to help you find the perfect coverage for your needs",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Chat with Expert",
                          icon: Icons.chat,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.phone,
                              color: primaryColor,
                              size: 18,
                            ),
                            label: Text(
                              "Call Us",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {},
                          ),
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
    );
  }
}
