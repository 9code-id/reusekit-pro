import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaQuantitySelectionView extends StatefulWidget {
  const FdaQuantitySelectionView({super.key});

  @override
  State<FdaQuantitySelectionView> createState() => _FdaQuantitySelectionViewState();
}

class _FdaQuantitySelectionViewState extends State<FdaQuantitySelectionView> {
  int quantity = 1;
  double itemPrice = 18.99;
  bool saveAsDefault = false;
  String specialInstructions = "";
  
  Map<String, dynamic> itemDetails = {
    "name": "Margherita Pizza",
    "description": "Fresh tomatoes, mozzarella cheese, basil",
    "size": "Large (12\")",
    "customizations": ["Extra Cheese", "Thin Crust"],
    "image": "https://picsum.photos/100/100?random=pizza&keyword=pizza",
    "maxQuantity": 10,
    "preparationTime": "15-20 minutes",
    "calories": 560,
  };

  List<Map<String, dynamic>> quickQuantities = [
    {"value": 1, "label": "1", "isDefault": true},
    {"value": 2, "label": "2", "isDefault": false},
    {"value": 3, "label": "3", "isDefault": false},
    {"value": 4, "label": "4", "isDefault": false},
    {"value": 5, "label": "5", "isDefault": false},
    {"value": 10, "label": "10", "isDefault": false},
  ];

  double get totalPrice => itemPrice * quantity;
  int get totalCalories => ((itemDetails["calories"] as int) * quantity);
  String get estimatedTime {
    int baseTime = 15; // minutes
    int extraTime = ((quantity - 1) * 2); // 2 minutes per extra item
    return "${baseTime + extraTime}-${baseTime + extraTime + 5} minutes";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Quantity"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showQuantityInfo();
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
                  // Item Summary Card
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
                            "${itemDetails["image"]}",
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
                                "${itemDetails["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${itemDetails["size"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              if ((itemDetails["customizations"] as List).isNotEmpty) ...[
                                Text(
                                  (itemDetails["customizations"] as List).join(", "),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${itemPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "per item",
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

                  SizedBox(height: spLg),

                  // Quantity Selection
                  Text(
                    "Select Quantity",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),

                  // Quick Quantity Buttons
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quick Select",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        
                        Wrap(
                          spacing: spSm,
                          runSpacing: spSm,
                          children: quickQuantities.map((quick) {
                            bool isSelected = quantity == quick["value"];
                            
                            return GestureDetector(
                              onTap: () {
                                quantity = quick["value"];
                                setState(() {});
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? primaryColor 
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected 
                                        ? primaryColor 
                                        : disabledOutlineBorderColor,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${quick["label"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected 
                                          ? Colors.white 
                                          : primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Custom Quantity Input
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Custom Quantity",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        
                        Row(
                          children: [
                            // Decrease Button
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: quantity > 1 
                                    ? primaryColor.withAlpha(20) 
                                    : disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: quantity > 1 
                                      ? primaryColor 
                                      : disabledColor,
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color: quantity > 1 
                                      ? primaryColor 
                                      : disabledColor,
                                ),
                                onPressed: quantity > 1 ? () {
                                  quantity--;
                                  setState(() {});
                                } : null,
                              ),
                            ),

                            SizedBox(width: spMd),

                            // Quantity Display
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: primaryColor),
                                ),
                                child: Center(
                                  child: Text(
                                    "$quantity",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: spMd),

                            // Increase Button
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: quantity < (itemDetails["maxQuantity"] as int)
                                    ? primaryColor.withAlpha(20)
                                    : disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: quantity < (itemDetails["maxQuantity"] as int)
                                      ? primaryColor
                                      : disabledColor,
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: quantity < (itemDetails["maxQuantity"] as int)
                                      ? primaryColor
                                      : disabledColor,
                                ),
                                onPressed: quantity < (itemDetails["maxQuantity"] as int) ? () {
                                  quantity++;
                                  setState(() {});
                                } : null,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: spSm),
                        Text(
                          "Maximum ${itemDetails["maxQuantity"]} items per order",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Order Summary
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        
                        _buildSummaryRow(
                          Icons.shopping_cart,
                          "Quantity",
                          "$quantity items",
                          successColor,
                        ),
                        _buildSummaryRow(
                          Icons.attach_money,
                          "Total Price",
                          "\$${totalPrice.toStringAsFixed(2)}",
                          successColor,
                        ),
                        _buildSummaryRow(
                          Icons.local_fire_department,
                          "Total Calories",
                          "${totalCalories} cal",
                          secondaryColor,
                        ),
                        _buildSummaryRow(
                          Icons.access_time,
                          "Est. Preparation",
                          estimatedTime,
                          infoColor,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Special Instructions
                  Text(
                    "Special Instructions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Additional requests",
                    value: specialInstructions,
                    hint: "Any special preparation requests?",
                    onChanged: (value) {
                      specialInstructions = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spMd),

                  // Save as Default
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Save this quantity as my default",
                              "value": true,
                              "checked": saveAsDefault,
                            }
                          ],
                          value: [
                            if (saveAsDefault)
                              {
                                "label": "Save this quantity as my default",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            saveAsDefault = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Nutritional Info
                  if (quantity > 1) ...[
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
                                Icons.info,
                                color: infoColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Nutritional Information",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Total calories for $quantity items: ${totalCalories} cal",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                          if (quantity >= 3) ...[
                            SizedBox(height: spXs),
                            Text(
                              "💡 Consider sharing with friends for a balanced meal!",
                              style: TextStyle(
                                fontSize: 13,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Bottom Action Bar
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
                            "Quantity: $quantity",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Total: \$${totalPrice.toStringAsFixed(2)}",
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
                      label: "Add to Cart",
                      size: bs.md,
                      onPressed: () {
                        _addToCart();
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

  Widget _buildSummaryRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 18,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart() {
    if (quantity <= 0) {
      se("Please select a valid quantity");
      return;
    }
    
    if (saveAsDefault) {
      si("Quantity preference saved for future orders");
    }
    
    ss("$quantity items added to cart!");
    back();
  }

  void _showQuantityInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quantity Guidelines"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Maximum ${itemDetails["maxQuantity"]} items per order"),
            Text("• Larger quantities may increase preparation time"),
            Text("• Consider nutritional values for multiple items"),
            Text("• Special instructions apply to all quantities"),
            Text("• Save preferences for faster future ordering"),
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
