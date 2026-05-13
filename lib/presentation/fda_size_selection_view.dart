import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaSizeSelectionView extends StatefulWidget {
  const FdaSizeSelectionView({super.key});

  @override
  State<FdaSizeSelectionView> createState() => _FdaSizeSelectionViewState();
}

class _FdaSizeSelectionViewState extends State<FdaSizeSelectionView> {
  String selectedSize = "";
  
  List<Map<String, dynamic>> sizeOptions = [
    {
      "id": "small",
      "name": "Small",
      "display": "S",
      "description": "8 inch - Perfect for 1 person",
      "basePrice": 12.99,
      "priceModifier": 0.0,
      "calories": 280,
      "servings": "1 person",
      "diameter": "8\"",
      "recommended": false,
      "popular": false,
    },
    {
      "id": "medium",
      "name": "Medium",
      "display": "M",
      "description": "10 inch - Great for 2-3 people",
      "basePrice": 12.99,
      "priceModifier": 3.00,
      "calories": 420,
      "servings": "2-3 people",
      "diameter": "10\"",
      "recommended": true,
      "popular": true,
    },
    {
      "id": "large",
      "name": "Large",
      "display": "L",
      "description": "12 inch - Best for 3-4 people",
      "basePrice": 12.99,
      "priceModifier": 6.00,
      "calories": 560,
      "servings": "3-4 people",
      "diameter": "12\"",
      "recommended": false,
      "popular": true,
    },
    {
      "id": "extra_large",
      "name": "Extra Large",
      "display": "XL",
      "description": "14 inch - Perfect for 4-6 people",
      "basePrice": 12.99,
      "priceModifier": 9.00,
      "calories": 720,
      "servings": "4-6 people",
      "diameter": "14\"",
      "recommended": false,
      "popular": false,
    },
  ];

  Map<String, dynamic> get selectedSizeData {
    if (selectedSize.isEmpty) return {};
    return sizeOptions.firstWhere(
      (size) => size["id"] == selectedSize,
      orElse: () => {},
    );
  }

  double get finalPrice {
    if (selectedSizeData.isEmpty) return 0.0;
    return (selectedSizeData["basePrice"] as num).toDouble() + 
           (selectedSizeData["priceModifier"] as num).toDouble();
  }

  @override
  void initState() {
    super.initState();
    // Set default to recommended size
    var recommended = sizeOptions.firstWhere(
      (size) => size["recommended"] as bool,
      orElse: () => sizeOptions.first,
    );
    selectedSize = recommended["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Size"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showSizeGuide();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Item Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "https://picsum.photos/80/80?random=pizza&keyword=pizza",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Margherita Pizza",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Fresh tomatoes, mozzarella, basil",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Starting from \$12.99",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Size Selection Header
                  Text(
                    "Choose Your Size",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Select the perfect size for your appetite",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Size Options
                  ...sizeOptions.map((size) {
                    bool isSelected = selectedSize == size["id"];
                    bool isRecommended = size["recommended"] as bool;
                    bool isPopular = size["popular"] as bool;
                    
                    return GestureDetector(
                      onTap: () {
                        selectedSize = size["id"];
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            // Size Circle
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected 
                                        ? primaryColor 
                                        : primaryColor.withAlpha(20),
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${size["display"]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? Colors.white : primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                if (isSelected) ...[
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: successColor,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),

                            SizedBox(width: spMd),

                            // Size Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${size["name"]} (${size["diameter"]})",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? primaryColor : primaryColor,
                                        ),
                                      ),
                                      if (isRecommended) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "RECOMMENDED",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                      if (isPopular && !isRecommended) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: warningColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                "POPULAR",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${size["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  
                                  // Stats Row
                                  Row(
                                    children: [
                                      _buildStatChip(
                                        Icons.people,
                                        "${size["servings"]}",
                                        primaryColor,
                                      ),
                                      SizedBox(width: spSm),
                                      _buildStatChip(
                                        Icons.local_fire_department,
                                        "${size["calories"]} cal",
                                        secondaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Price
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if ((size["priceModifier"] as num) > 0) ...[
                                  Text(
                                    "+\$${(size["priceModifier"] as num).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                                Text(
                                  "\$${((size["basePrice"] as num) + (size["priceModifier"] as num)).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                  SizedBox(height: spLg),

                  // Size Comparison
                  if (selectedSize.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: infoColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.compare_arrows,
                                color: infoColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Size Comparison",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          
                          // Visual Size Comparison
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: sizeOptions.map((size) {
                              bool isCurrentSelected = selectedSize == size["id"];
                              double circleSize = size["id"] == "small" ? 30 :
                                                size["id"] == "medium" ? 40 :
                                                size["id"] == "large" ? 50 : 60;
                              
                              return Column(
                                children: [
                                  Container(
                                    width: circleSize,
                                    height: circleSize,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isCurrentSelected 
                                          ? primaryColor 
                                          : primaryColor.withAlpha(50),
                                      border: Border.all(
                                        color: primaryColor,
                                        width: isCurrentSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${size["display"]}",
                                        style: TextStyle(
                                          fontSize: circleSize * 0.3,
                                          fontWeight: FontWeight.bold,
                                          color: isCurrentSelected 
                                              ? Colors.white 
                                              : primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${size["diameter"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isCurrentSelected 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                      fontWeight: isCurrentSelected 
                                          ? FontWeight.bold 
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          if (selectedSize.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${selectedSizeData["name"]} (${selectedSizeData["diameter"]})",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Price: \$${finalPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Continue",
                        size: bs.md,
                        onPressed: () {
                          _proceedWithSize();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _proceedWithSize() {
    if (selectedSize.isEmpty) {
      se("Please select a size");
      return;
    }
    
    ss("Size selected: ${selectedSizeData["name"]}");
    back();
  }

  void _showSizeGuide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Size Guide"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Small (8\"): Perfect for individual portions"),
            Text("• Medium (10\"): Great for sharing with 2-3 people"),
            Text("• Large (12\"): Best value for groups of 3-4"),
            Text("• Extra Large (14\"): Perfect for large gatherings"),
            SizedBox(height: spSm),
            Text(
              "💡 Tip: Medium size offers the best value for money!",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}
