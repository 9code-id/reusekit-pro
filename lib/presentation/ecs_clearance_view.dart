import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsClearanceView extends StatefulWidget {
  const EcsClearanceView({super.key});

  @override
  State<EcsClearanceView> createState() => _EcsClearanceViewState();
}

class _EcsClearanceViewState extends State<EcsClearanceView> {
  String selectedCategory = "All";
  String selectedDiscount = "All Discounts";
  String sortBy = "Highest Discount";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home & Garden", "value": "Home & Garden"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Beauty", "value": "Beauty"},
    {"label": "Books", "value": "Books"},
  ];

  List<Map<String, dynamic>> discountRanges = [
    {"label": "All Discounts", "value": "All Discounts"},
    {"label": "50% - 70% OFF", "value": "50% - 70% OFF"},
    {"label": "70% - 80% OFF", "value": "70% - 80% OFF"},
    {"label": "80% and above", "value": "80% and above"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Highest Discount", "value": "Highest Discount"},
    {"label": "Lowest Price", "value": "Lowest Price"},
    {"label": "Highest Price", "value": "Highest Price"},
    {"label": "Most Popular", "value": "Most Popular"},
    {"label": "Ending Soon", "value": "Ending Soon"},
  ];

  List<Map<String, dynamic>> clearanceItems = [
    {
      "id": 1,
      "name": "Last Season Designer Jacket",
      "price": 49.99,
      "originalPrice": 199.99,
      "image": "https://picsum.photos/300/300?random=1&keyword=jacket",
      "rating": 4.3,
      "reviews": 245,
      "category": "Fashion",
      "discount": 75,
      "stock": 5,
      "endDate": "2024-06-20",
      "reason": "End of Season",
      "isFinalSale": true,
      "savings": 150.00,
    },
    {
      "id": 2,
      "name": "Smartphone Previous Generation",
      "price": 299.99,
      "originalPrice": 799.99,
      "image": "https://picsum.photos/300/300?random=2&keyword=phone",
      "rating": 4.5,
      "reviews": 1892,
      "category": "Electronics",
      "discount": 63,
      "stock": 12,
      "endDate": "2024-06-25",
      "reason": "New Model Release",
      "isFinalSale": false,
      "savings": 500.00,
    },
    {
      "id": 3,
      "name": "Outdoor Furniture Set",
      "price": 199.99,
      "originalPrice": 899.99,
      "image": "https://picsum.photos/300/300?random=3&keyword=furniture",
      "rating": 4.2,
      "reviews": 76,
      "category": "Home & Garden",
      "discount": 78,
      "stock": 3,
      "endDate": "2024-06-18",
      "reason": "Warehouse Clearance",
      "isFinalSale": true,
      "savings": 700.00,
    },
    {
      "id": 4,
      "name": "Professional Camera Lens",
      "price": 399.99,
      "originalPrice": 1299.99,
      "image": "https://picsum.photos/300/300?random=4&keyword=camera",
      "rating": 4.8,
      "reviews": 145,
      "category": "Electronics",
      "discount": 69,
      "stock": 8,
      "endDate": "2024-06-22",
      "reason": "Discontinued Model",
      "isFinalSale": false,
      "savings": 900.00,
    },
    {
      "id": 5,
      "name": "Winter Sports Equipment",
      "price": 129.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/300/300?random=5&keyword=ski",
      "rating": 4.1,
      "reviews": 89,
      "category": "Sports",
      "discount": 68,
      "stock": 15,
      "endDate": "2024-06-30",
      "reason": "End of Season",
      "isFinalSale": true,
      "savings": 270.00,
    },
    {
      "id": 6,
      "name": "Luxury Skincare Collection",
      "price": 89.99,
      "originalPrice": 249.99,
      "image": "https://picsum.photos/300/300?random=6&keyword=cosmetics",
      "rating": 4.6,
      "reviews": 567,
      "category": "Beauty",
      "discount": 64,
      "stock": 22,
      "endDate": "2024-06-28",
      "reason": "Packaging Update",
      "isFinalSale": false,
      "savings": 160.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clearance Sale"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.local_offer),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Clearance Sale Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    dangerColor.withAlpha(20),
                    Colors.orange.withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.local_fire_department,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MEGA CLEARANCE SALE",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Up to 80% OFF • Limited Time Only",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Timer
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(180),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Sale ends in 6 days 14 hours",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard("80%", "Max Discount", dangerColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("${clearanceItems.length}", "Items Available", primaryColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("\$2.8K", "Total Savings", successColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Filters
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Filters",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QHorizontalScroll(
                  children: [
                    _buildQuickFilter("80% OFF", true),
                    _buildQuickFilter("Final Sale", false),
                    _buildQuickFilter("Electronics", false),
                    _buildQuickFilter("Fashion", false),
                    _buildQuickFilter("Ending Soon", false),
                  ],
                ),
              ],
            ),

            // Filter Section
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter & Sort",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Discount Range",
                        items: discountRanges,
                        value: selectedDiscount,
                        onChanged: (value, label) {
                          selectedDiscount = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Clearance Items
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Clearance Items",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${clearanceItems.length} items",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: clearanceItems.map((item) {
                    return _buildClearanceItemCard(item);
                  }).toList(),
                ),
              ],
            ),

            // Final Sale Notice
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Final Sale Notice",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Items marked as 'Final Sale' cannot be returned or exchanged. All sales are final. Please review your order carefully before purchasing.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
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

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
        ),
        boxShadow: isSelected ? [shadowSm] : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : disabledBoldColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildClearanceItemCard(Map<String, dynamic> item) {
    final discountPercent = item["discount"] as int;
    final savings = item["savings"] as double;
    final daysLeft = DateTime.parse(item["endDate"]).difference(DateTime.now()).inDays;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: discountPercent >= 70 ? dangerColor.withAlpha(100) : disabledOutlineBorderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image with Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${item["image"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Discount Badge
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$discountPercent% OFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Final Sale Badge
              if (item["isFinalSale"])
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "FINAL SALE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Stock Warning
              if ((item["stock"] as int) <= 5)
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Only ${item["stock"]} left!",
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

          // Product Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // Prices
                Row(
                  children: [
                    Text(
                      "\$${(item["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${(item["originalPrice"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                // Savings
                Text(
                  "You save \$${savings.currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${item["rating"]} (${item["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Clearance Reason
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Reason: ${item["reason"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Time Left
                if (daysLeft > 0)
                  Text(
                    "Sale ends in $daysLeft day${daysLeft > 1 ? 's' : ''}",
                    style: TextStyle(
                      fontSize: 12,
                      color: daysLeft <= 3 ? dangerColor : warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                // Add to Cart Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add to Cart",
                    size: bs.sm,
                    onPressed: () {},
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
