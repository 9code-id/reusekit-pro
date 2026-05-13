import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaFoodDetailView extends StatefulWidget {
  const FdaFoodDetailView({super.key});

  @override
  State<FdaFoodDetailView> createState() => _FdaFoodDetailViewState();
}

class _FdaFoodDetailViewState extends State<FdaFoodDetailView> {
  Map<String, dynamic> foodData = {    "id": 1,
    "name": "Organic Avocado",
    "brand": "Fresh Farm",
    "category": "Fruits & Vegetables",
    "barcode": "1234567890123",
    "servingSize": "1 medium (150g)",
    "servingsPerContainer": 1,
    "calories": 234,
    "totalFat": 21.0,
    "saturatedFat": 3.1,
    "transFat": 0.0,
    "cholesterol": 0,
    "sodium": 7,
    "totalCarbs": 12.0,
    "dietaryFiber": 10.0,
    "totalSugars": 1.0,
    "addedSugars": 0.0,
    "protein": 2.9,
    "vitaminD": 0.0,
    "calcium": 12,
    "iron": 0.6,
    "potassium": 485,
    "ingredients": ["Organic Avocados"],
    "allergens": ["None"],
    "certifications": ["USDA Organic", "Non-GMO"],
    "image": "https://picsum.photos/400/300?random=1&keyword=avocado",
    "rating": 4.8,
    "reviews": 1247,
    "price": 2.99,
    "description": "Premium organic avocados grown in California. Rich in healthy fats and nutrients. Perfect for guacamole, salads, or eating fresh.",
    "nutritionGrade": "A+",
    "lastUpdated": "2024-01-15",
  };

  bool isFavorite = false;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Details"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : null,
            ),
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Food details shared!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Food Image and Basic Info
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                    child: Image.network(
                      "${foodData["image"]}",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "${foodData["name"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${foodData["brand"]} • ${foodData["category"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${foodData["nutritionGrade"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${foodData["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  " (${foodData["reviews"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "${foodData["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Nutrition Facts
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Nutrition Facts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Serving Size: ${foodData["servingSize"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Divider(color: primaryColor.withAlpha(20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Calories",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${foodData["calories"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: primaryColor.withAlpha(20)),
                        _buildNutritionRow("Total Fat", "${foodData["totalFat"]}g"),
                        _buildNutritionRow("  Saturated Fat", "${foodData["saturatedFat"]}g", isIndented: true),
                        _buildNutritionRow("  Trans Fat", "${foodData["transFat"]}g", isIndented: true),
                        _buildNutritionRow("Cholesterol", "${foodData["cholesterol"]}mg"),
                        _buildNutritionRow("Sodium", "${foodData["sodium"]}mg"),
                        _buildNutritionRow("Total Carbohydrates", "${foodData["totalCarbs"]}g"),
                        _buildNutritionRow("  Dietary Fiber", "${foodData["dietaryFiber"]}g", isIndented: true),
                        _buildNutritionRow("  Total Sugars", "${foodData["totalSugars"]}g", isIndented: true),
                        _buildNutritionRow("    Added Sugars", "${foodData["addedSugars"]}g", isIndented: true),
                        _buildNutritionRow("Protein", "${foodData["protein"]}g"),
                        Divider(color: primaryColor.withAlpha(20)),
                        _buildNutritionRow("Vitamin D", "${foodData["vitaminD"]}mcg"),
                        _buildNutritionRow("Calcium", "${foodData["calcium"]}mg"),
                        _buildNutritionRow("Iron", "${foodData["iron"]}mg"),
                        _buildNutritionRow("Potassium", "${foodData["potassium"]}mg"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Ingredients & Allergens
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Ingredients & Allergens",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Ingredients:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${(foodData["ingredients"] as List).join(", ")}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Allergens:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${(foodData["allergens"] as List).join(", ")}",
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

            // Certifications
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Certifications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: (foodData["certifications"] as List).map((cert) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(50)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "$cert",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
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

            // Add to Cart Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${(foodData["price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Quantity:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                quantity--;
                                setState(() {});
                              }
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "$quantity",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              quantity++;
                              setState(() {});
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  QButton(
                    label: "Add to Cart - \$${((foodData["price"] as double) * quantity).toStringAsFixed(2)}",
                    size: bs.md,
                    onPressed: () {
                      ss("Added to cart!");
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

  Widget _buildNutritionRow(String label, String value, {bool isIndented = false}) {
    return Padding(
      padding: EdgeInsets.only(left: isIndented ? spMd : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: isIndented ? FontWeight.normal : FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
